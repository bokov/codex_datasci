test_that("full v0 scenario emits required ID columns", {
  skip("Pending full v0 implementation: ID-rich node outputs not implemented yet")

  cfg <- easter_egg_factory_v0_config()
  logs <- run_simulation(
    cfg,
    init_global_state = list(reorder_threshold = 5, base_rate = 3),
    init_node_state = list(
      supplier_batches = list(supplier_bias = 1),
      inventory = list(start_qty = 8),
      operator_shifts = list(shift_length = 2),
      staffing = list(max_ops_per_machine = 3),
      production = list(machine_quality = 0.9)
    )
  )

  expect_true(all(c("supplier_id", "ingredient_id") %in% names(logs$supplier_batches)))
  expect_true(all(c("operator_id", "is_available") %in% names(logs$operator_shifts)))
  expect_true(all(c("machine_id", "assigned_operator_ids") %in% names(logs$staffing)))
  expect_true(all(c("machine_id", "egg_type") %in% names(logs$production)))
})

test_that("machine with no available unassigned operator produces zero eggs", {
  skip("Pending full v0 implementation: per-operator availability/staffing not implemented yet")

  cfg <- easter_egg_factory_v0_config()
  logs <- run_simulation(
    cfg,
    init_global_state = list(reorder_threshold = 5, base_rate = 3),
    init_node_state = list(
      supplier_batches = list(supplier_bias = 1),
      inventory = list(start_qty = 8),
      operator_shifts = list(shift_length = 2),
      staffing = list(max_ops_per_machine = 3),
      production = list(machine_quality = 0.9)
    )
  )

  merged <- merge(logs$staffing, logs$production, by = "tick")
  expect_true(all(merged$eggs_produced[merged$n_assigned == 0] == 0))
})
