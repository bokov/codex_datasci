# Config Schema (v0): Easter Egg Factory

## Purpose
Define the v0 configuration shape for expression-driven node execution.

## Top-level keys
- `seed` (integer): RNG seed for deterministic replay.
- `ticks` (integer): number of simulation ticks.
- `node_order` (character vector): deterministic execution order.
- `global_state_fields` (character vector): allowed global state symbols.
- `node_state_fields` (named list): allowed node-local symbols by node id.
- `nodes` (named list): node definitions keyed by node id.

## Node definition shape
Each `nodes[[node_id]]` must include:
- `expressions` (named list of character)
  - key = output column name,
  - value = literal R expression text producing one scalar per tick.
- `inputs` (named list)
  - key = alias used in expressions,
  - value = `{ node: <source_node_id>, column: <source_column_name> }`.


## Required v0 node set (full scenario target)
The full Easter egg factory v0 scenario is expected to define these nodes:
- `supplier_batches`
- `inventory`
- `reorder_policy`
- `operator_shifts`
- `machine_config`
- `staffing`
- `production`

## Required ID fields in node outputs
At minimum, scenario outputs should include stable unique IDs for:
- `supplier_id`
- `ingredient_id`
- `operator_id`
- `machine_id`
- `recipe_id` or `egg_type`

## Evaluation context symbols
Expressions may reference:
- `tick`
- `global_state$<field>` where `<field>` is in `global_state_fields`
- `node_state$<field>` where `<field>` is in `node_state_fields[[node_id]]`
- input aliases declared in `inputs`
- `node_log_history` for prior rows
- prior expression values in same row via direct expression-name references and `prev`

## Valid example (minimal)
```r
list(
  seed = 42,
  ticks = 10,
  node_order = c("supplier_batches", "inventory"),
  global_state_fields = c("reorder_threshold"),
  node_state_fields = list(
    supplier_batches = c("supplier_bias"),
    inventory = c("start_qty")
  ),
  nodes = list(
    supplier_batches = list(
      expressions = list(
        batch_qty = "ifelse(tick %% 3 == 0, 10, 0)"
      ),
      inputs = list()
    ),
    inventory = list(
      expressions = list(
        on_hand_qty = "ifelse(tick == 1, node_state$start_qty + supplier_qty, tail(node_log_history$on_hand_qty, 1) + supplier_qty)"
      ),
      inputs = list(
        supplier_qty = list(node = "supplier_batches", column = "batch_qty")
      )
    )
  )
)
```

## Invalid example (unknown symbol)
```r
list(
  # ...
  nodes = list(
    production = list(
      expressions = list(
        eggs_produced = "global_state$base_rate * mystery_symbol"
      ),
      inputs = list()
    )
  )
)
```
Expected validator outcome:
- `ok = FALSE`
- error includes `node_id`, `expression`, `symbol = mystery_symbol`, and actionable `suggestion`.
