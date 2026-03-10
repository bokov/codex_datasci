test_that("runner is deterministic for same seed/config", {
  cfg <- easter_egg_factory_v0_config()
  g <- list(reorder_threshold = 5, base_rate = 3)
  n <- list(
    supplier_batches = list(supplier_bias = 1),
    inventory = list(start_qty = 8),
    operator_shifts = list(shift_length = 2),
    staffing = list(max_ops_per_machine = 3),
    production = list(machine_quality = 0.9)
  )

  a <- run_simulation(cfg, init_global_state = g, init_node_state = n)
  b <- run_simulation(cfg, init_global_state = g, init_node_state = n)

  expect_equal(a, b)
})

test_that("non-scalar expression fails at runtime", {
  cfg <- easter_egg_factory_v0_config()
  cfg$nodes$production$expressions$eggs_produced <- "c(1,2)"

  expect_error(
    run_simulation(
      cfg,
      init_global_state = list(reorder_threshold = 5, base_rate = 3),
      init_node_state = list(
        supplier_batches = list(supplier_bias = 1),
        inventory = list(start_qty = 8),
        operator_shifts = list(shift_length = 2),
        staffing = list(max_ops_per_machine = 3),
        production = list(machine_quality = 0.9)
      )
    ),
    "Non-scalar expression result"
  )
})
