# Example config builders for the Easter egg factory v0 scenario.

#' Build a valid Easter egg factory v0 config
#'
#' @return A list configuration compatible with [validate_config_shape()],
#'   [validate_config_symbols()], and [run_simulation()].
#' @examples
#' cfg <- easter_egg_factory_v0_config()
#' validate_config_shape(cfg)
#' v <- validate_config_symbols(cfg)
#' v$ok
#' @export
easter_egg_factory_v0_config <- function() {
  list(
    seed = 42,
    ticks = 120,
    node_order = c(
      "supplier_batches", "inventory", "reorder_policy",
      "operator_shifts", "machine_config", "staffing", "production"
    ),
    global_state_fields = c("reorder_threshold", "base_rate"),
    node_state_fields = list(
      supplier_batches = c("n_suppliers", "n_ingredients"),
      inventory = c("start_qty"),
      reorder_policy = c("reorder_buffer"),
      operator_shifts = c("n_operators"),
      machine_config = c("n_machines"),
      staffing = c("max_ops_per_machine"),
      production = c("quality_floor")
    ),
    nodes = list(
      supplier_batches = list(
        expressions = list(
          supplier_id = "paste0('SUP', ((tick - 1) %% node_state$n_suppliers) + 1)",
          ingredient_id = "paste0('ING', ((tick - 1) %% node_state$n_ingredients) + 1)",
          batch_qty = "ifelse((tick %% 3) == 0, 12, 8)",
          batch_price = "ifelse(supplier_id == 'SUP1', 1.2, ifelse(supplier_id == 'SUP2', 1.1, 1.0))",
          batch_quality = "ifelse(supplier_id == 'SUP1', 0.95, ifelse(supplier_id == 'SUP2', 0.90, 0.86)) + runif(1, -0.01, 0.01)",
          arrival_flag = "batch_qty > 0"
        ),
        inputs = list()
      ),
      inventory = list(
        expressions = list(
          ingredient_id = "inputs$incoming_ingredient_id",
          incoming_qty = "inputs$incoming_qty",
          consumed_qty = "ifelse(is.na(inputs$consumed_qty), 0, inputs$consumed_qty)",
          on_hand_qty = "ifelse(tick == 1, pmax(0, node_state$start_qty + incoming_qty - consumed_qty), pmax(0, tail(node_log_history$on_hand_qty, 1) + incoming_qty - consumed_qty))",
          reorder_flag = "on_hand_qty < global_state$reorder_threshold"
        ),
        inputs = list(
          incoming_ingredient_id = list(node = "supplier_batches", column = "ingredient_id"),
          incoming_qty = list(node = "supplier_batches", column = "batch_qty"),
          consumed_qty = list(node = "production", column = "ingredient_used")
        )
      ),
      reorder_policy = list(
        expressions = list(
          ingredient_id = "inputs$inventory_ingredient_id",
          reorder_flag = "inputs$inventory_reorder_flag",
          target_batch_qty = "ifelse(reorder_flag, global_state$reorder_threshold + node_state$reorder_buffer, 0)"
        ),
        inputs = list(
          inventory_ingredient_id = list(node = "inventory", column = "ingredient_id"),
          inventory_reorder_flag = list(node = "inventory", column = "reorder_flag")
        )
      ),
      operator_shifts = list(
        expressions = list(
          operator_id = "paste0('OP', ((tick - 1) %% node_state$n_operators) + 1)",
          shift_id = "paste0('SHIFT', ((tick - 1) %% node_state$n_operators) + 1)",
          is_available = "((tick + (ifelse(operator_id == 'OP1', 0, ifelse(operator_id == 'OP2', 30, 60))) - 1) %% 100) < 20",
          operator_quality = "ifelse(operator_id == 'OP1', 0.92, ifelse(operator_id == 'OP2', 0.88, 0.84))"
        ),
        inputs = list()
      ),
      machine_config = list(
        expressions = list(
          machine_id = "paste0('M', ((tick - 1) %% node_state$n_machines) + 1)",
          egg_type = "ifelse(machine_id == 'M1', 'dark_truffle', ifelse(machine_id == 'M2', 'milk_hazelnut', 'white_berry'))",
          machine_quality = "ifelse(machine_id == 'M1', 0.93, ifelse(machine_id == 'M2', 0.89, 0.87))",
          required_ingredients = "ifelse(egg_type == 'dark_truffle', 'ING1+ING2', ifelse(egg_type == 'milk_hazelnut', 'ING2+ING3', 'ING1+ING3'))"
        ),
        inputs = list()
      ),
      staffing = list(
        expressions = list(
          machine_id = "inputs$machine_id",
          assigned_operator_ids = "ifelse(inputs$is_available, inputs$operator_id, '')",
          n_assigned = "ifelse(assigned_operator_ids == '', 0, pmin(1, node_state$max_ops_per_machine))",
          staffing_valid = "(n_assigned >= 1 && n_assigned <= 3) || n_assigned == 0"
        ),
        inputs = list(
          machine_id = list(node = "machine_config", column = "machine_id"),
          operator_id = list(node = "operator_shifts", column = "operator_id"),
          is_available = list(node = "operator_shifts", column = "is_available")
        )
      ),
      production = list(
        expressions = list(
          machine_id = "inputs$machine_id",
          egg_type = "inputs$egg_type",
          ingredient_quality_index = "inputs$batch_quality",
          operator_quality_index = "inputs$operator_quality",
          eggs_produced = "ifelse(inputs$n_assigned > 0 && inputs$inventory_on_hand > 0, global_state$base_rate * inputs$n_assigned, 0)",
          ingredient_used = "ifelse(eggs_produced > 0, pmin(inputs$inventory_on_hand, eggs_produced), 0)",
          egg_quality = "pmax(node_state$quality_floor, (ingredient_quality_index + inputs$machine_quality + operator_quality_index) / 3)"
        ),
        inputs = list(
          machine_id = list(node = "machine_config", column = "machine_id"),
          egg_type = list(node = "machine_config", column = "egg_type"),
          machine_quality = list(node = "machine_config", column = "machine_quality"),
          inventory_on_hand = list(node = "inventory", column = "on_hand_qty"),
          n_assigned = list(node = "staffing", column = "n_assigned"),
          batch_quality = list(node = "supplier_batches", column = "batch_quality"),
          operator_quality = list(node = "operator_shifts", column = "operator_quality")
        )
      )
    )
  )
}

#' Build an intentionally invalid Easter egg factory config
#'
#' @return A config list with an unresolved symbol for validator testing.
#' @examples
#' cfg <- invalid_easter_egg_config()
#' v <- validate_config_symbols(cfg)
#' v$ok
#' @export
invalid_easter_egg_config <- function() {
  cfg <- easter_egg_factory_v0_config()
  cfg$nodes$production$expressions$eggs_produced <- "global_state$base_rate * mystery_symbol"
  cfg
}
