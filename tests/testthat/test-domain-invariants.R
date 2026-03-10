scenario_states <- function() {
  list(
    global = list(reorder_threshold = 10, base_rate = 3),
    node = list(
      supplier_batches = list(n_suppliers = 3, n_ingredients = 3),
      inventory = list(start_qty = 20),
      reorder_policy = list(reorder_buffer = 6),
      operator_shifts = list(n_operators = 3),
      machine_config = list(n_machines = 3),
      staffing = list(max_ops_per_machine = 3),
      production = list(quality_floor = 0.75)
    )
  )
}

test_that("full v0 scenario emits required IDs and node columns", {
  cfg <- easter_egg_factory_v0_config()
  st <- scenario_states()
  logs <- run_simulation(cfg, init_global_state = st$global, init_node_state = st$node)

  expect_setequal(names(logs), cfg$node_order)

  expect_true(all(c("tick", "ingredient_id", "supplier_id", "batch_qty", "batch_price", "batch_quality", "arrival_flag") %in% names(logs$supplier_batches)))
  expect_true(all(c("tick", "ingredient_id", "on_hand_qty", "incoming_qty", "consumed_qty", "reorder_flag") %in% names(logs$inventory)))
  expect_true(all(c("tick", "ingredient_id", "reorder_flag", "target_batch_qty") %in% names(logs$reorder_policy)))
  expect_true(all(c("tick", "operator_id", "is_available", "shift_id", "operator_quality") %in% names(logs$operator_shifts)))
  expect_true(all(c("tick", "machine_id", "egg_type", "machine_quality", "required_ingredients") %in% names(logs$machine_config)))
  expect_true(all(c("tick", "machine_id", "assigned_operator_ids", "n_assigned", "staffing_valid") %in% names(logs$staffing)))
  expect_true(all(c("tick", "machine_id", "egg_type", "eggs_produced", "egg_quality", "ingredient_quality_index", "operator_quality_index") %in% names(logs$production)))
})

test_that("operator exclusivity invariant holds", {
  cfg <- easter_egg_factory_v0_config()
  st <- scenario_states()
  logs <- run_simulation(cfg, init_global_state = st$global, init_node_state = st$node)

  assigned <- logs$staffing$assigned_operator_ids
  tick <- logs$staffing$tick
  non_empty <- assigned[assigned != ""]
  non_empty_tick <- tick[assigned != ""]
  key <- paste(non_empty_tick, non_empty)

  expect_equal(any(duplicated(key)), FALSE)
})

test_that("staffing bounds and zero-staffing production invariant hold", {
  cfg <- easter_egg_factory_v0_config()
  st <- scenario_states()
  logs <- run_simulation(cfg, init_global_state = st$global, init_node_state = st$node)

  expect_true(all(logs$staffing$n_assigned >= 0 & logs$staffing$n_assigned <= 3))

  merged <- merge(logs$staffing[, c("tick", "machine_id", "n_assigned")],
                  logs$production[, c("tick", "machine_id", "eggs_produced")],
                  by = c("tick", "machine_id"))

  expect_true(all(merged$eggs_produced[merged$n_assigned == 0] == 0))
})

test_that("inventory nonnegativity and reorder threshold trigger hold", {
  cfg <- easter_egg_factory_v0_config()
  st <- scenario_states()
  logs <- run_simulation(cfg, init_global_state = st$global, init_node_state = st$node)

  expect_true(all(logs$inventory$on_hand_qty >= 0))

  threshold <- st$global$reorder_threshold
  expected_flag <- logs$inventory$on_hand_qty < threshold
  expect_equal(logs$inventory$reorder_flag, expected_flag)

  expect_true(all(logs$reorder_policy$target_batch_qty[logs$reorder_policy$reorder_flag] > 0))
})
