base_global_state <- function() {
  list(reorder_threshold = 10, base_rate = 3)
}

base_node_state <- function() {
  list(
    supplier_batches = list(n_suppliers = 3, n_ingredients = 3),
    inventory = list(start_qty = 20),
    reorder_policy = list(reorder_buffer = 6),
    operator_shifts = list(n_operators = 3),
    machine_config = list(n_machines = 3),
    staffing = list(max_ops_per_machine = 3),
    production = list(quality_floor = 0.75)
  )
}

test_that("runner is deterministic for same seed/config", {
  cfg <- easter_egg_factory_v0_config()

  a <- run_simulation(cfg, init_global_state = base_global_state(), init_node_state = base_node_state())
  b <- run_simulation(cfg, init_global_state = base_global_state(), init_node_state = base_node_state())

  expect_equal(a, b)
})

test_that("different seeds produce divergent stochastic-like outputs", {
  cfg_a <- easter_egg_factory_v0_config()
  cfg_b <- easter_egg_factory_v0_config()
  cfg_b$seed <- 99

  a <- run_simulation(cfg_a, init_global_state = base_global_state(), init_node_state = base_node_state())
  b <- run_simulation(cfg_b, init_global_state = base_global_state(), init_node_state = base_node_state())

  expect_false(identical(a$supplier_batches$batch_quality, b$supplier_batches$batch_quality))
})

test_that("non-scalar expression fails at runtime", {
  cfg <- easter_egg_factory_v0_config()
  cfg$nodes$production$expressions$eggs_produced <- "c(1,2)"

  expect_error(
    run_simulation(
      cfg,
      init_global_state = base_global_state(),
      init_node_state = base_node_state()
    ),
    "Non-scalar expression result"
  )
})
