# Example config for the Easter egg factory v0 scenario.

easter_egg_factory_v0_config <- function() {
  list(
    seed = 42,
    ticks = 10,
    node_order = c("supplier_batches", "inventory", "operator_shifts", "staffing", "production"),
    global_state_fields = c("reorder_threshold", "base_rate"),
    node_state_fields = list(
      supplier_batches = c("supplier_bias"),
      inventory = c("start_qty"),
      operator_shifts = c("shift_length"),
      staffing = c("max_ops_per_machine"),
      production = c("machine_quality")
    ),
    nodes = list(
      supplier_batches = list(
        expressions = list(
          batch_qty = "ifelse(tick %% 3 == 0, 10, 0)",
          batch_quality = "ifelse(batch_qty > 0, 0.9, 0.0)"
        ),
        inputs = list()
      ),
      inventory = list(
        expressions = list(
          incoming_qty = "supplier_qty",
          on_hand_qty = "ifelse(tick == 1, node_state$start_qty + incoming_qty, tail(node_log_history$on_hand_qty, 1) + incoming_qty - consumed_qty)",
          reorder_flag = "on_hand_qty < global_state$reorder_threshold"
        ),
        inputs = list(
          supplier_qty = list(node = "supplier_batches", column = "batch_qty"),
          consumed_qty = list(node = "production", column = "ingredient_used")
        )
      ),
      operator_shifts = list(
        expressions = list(
          active_ops = "ifelse((tick %% 5) <= 1, 2, 1)",
          operator_quality = "0.8"
        ),
        inputs = list()
      ),
      staffing = list(
        expressions = list(
          n_assigned = "pmin(inputs$active_ops, node_state$max_ops_per_machine)",
          staffing_valid = "n_assigned >= 1 && n_assigned <= 3"
        ),
        inputs = list(
          active_ops = list(node = "operator_shifts", column = "active_ops")
        )
      ),
      production = list(
        expressions = list(
          ingredient_used = "ifelse(inputs$inventory_on_hand > 0, 2, 0)",
          eggs_produced = "ifelse(inputs$staff_n > 0, global_state$base_rate * inputs$staff_n, 0)",
          egg_quality = "(inputs$batch_q + node_state$machine_quality + inputs$op_q) / 3"
        ),
        inputs = list(
          inventory_on_hand = list(node = "inventory", column = "on_hand_qty"),
          staff_n = list(node = "staffing", column = "n_assigned"),
          batch_q = list(node = "supplier_batches", column = "batch_quality"),
          op_q = list(node = "operator_shifts", column = "operator_quality")
        )
      )
    )
  )
}

# Intentionally invalid (unknown symbol) example for validator tests.
invalid_easter_egg_config <- function() {
  cfg <- easter_egg_factory_v0_config()
  cfg$nodes$production$expressions$eggs_produced <- "global_state$base_rate * mystery_symbol"
  cfg
}

# Alignment-only target shape for full v0 implementation planning.
# This is not yet used by package tests; it documents the intended full node/ID model.
easter_egg_factory_v0_target_shape_config <- function() {
  list(
    seed = 42,
    ticks = 100,
    node_order = c(
      "supplier_batches", "inventory", "reorder_policy",
      "operator_shifts", "machine_config", "staffing", "production"
    ),
    global_state_fields = c("reorder_threshold", "base_rate"),
    node_state_fields = list(
      supplier_batches = c("supplier_id", "ingredient_id"),
      inventory = c("ingredient_id", "start_qty"),
      reorder_policy = c("ingredient_id", "target_batch_qty"),
      operator_shifts = c("operator_id", "shift_start", "shift_length", "quality"),
      machine_config = c("machine_id", "egg_type", "required_ingredients", "machine_quality"),
      staffing = c("machine_id"),
      production = c("machine_id", "egg_type")
    ),
    nodes = list(
      supplier_batches = list(expressions = list(), inputs = list()),
      inventory = list(expressions = list(), inputs = list()),
      reorder_policy = list(expressions = list(), inputs = list()),
      operator_shifts = list(expressions = list(), inputs = list()),
      machine_config = list(expressions = list(), inputs = list()),
      staffing = list(expressions = list(), inputs = list()),
      production = list(expressions = list(), inputs = list())
    )
  )
}
