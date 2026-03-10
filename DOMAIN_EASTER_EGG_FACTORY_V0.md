# Easter Egg Factory Domain Contract (v0)

## Purpose
Define the fixed MVP domain boundaries and node contracts for the first end-to-end scenario.

## Fixed v0 scope
Included:
- raw material inventory by ingredient,
- supplier-specific batch shipment price and quality,
- threshold-based reorder policy for low stock,
- multiple machines configurable to egg type,
- operator assignment constraints,
- contiguous shift availability windows,
- per-tick output quantity and quality.

Excluded from v0:
- machine breakdown/maintenance,
- multi-factory logistics,
- dynamic recipe re-optimization,
- downstream sales/demand systems,
- noise/corruption/missingness injection (later phase).

## Tick semantics (deterministic order)
At each tick:
1. Update operator availability from shift schedule.
2. Process inbound shipments and update ingredient inventory.
3. Trigger/record reorder decisions when inventory is below threshold.
4. Resolve machine staffing (1-3 operators; each operator at most one machine).
5. Produce eggs per machine and update inventory consumption.
6. Write one full-state log row per node.

## Node contract table (v0)
| Node | Per-tick output columns (minimum) | Depends on | Declared inputs from other logs |
|---|---|---|---|
| `supplier_batches` | `tick`, `ingredient_id`, `supplier_id`, `batch_qty`, `batch_price`, `batch_quality`, `arrival_flag` | global config, RNG seed | none |
| `inventory` | `tick`, `ingredient_id`, `on_hand_qty`, `incoming_qty`, `consumed_qty`, `reorder_flag` | prior inventory state | `supplier_batches.batch_qty`, `production.consumed_*` |
| `reorder_policy` | `tick`, `ingredient_id`, `reorder_flag`, `target_batch_qty` | policy params | `inventory.on_hand_qty` |
| `operator_shifts` | `tick`, `operator_id`, `is_available`, `shift_id`, `operator_quality` | shift schedule | none |
| `machine_config` | `tick`, `machine_id`, `egg_type`, `machine_quality`, `required_ingredients` | static config | none |
| `staffing` | `tick`, `machine_id`, `assigned_operator_ids`, `n_assigned`, `staffing_valid` | staffing rules | `operator_shifts.is_available`, `machine_config.machine_id` |
| `production` | `tick`, `machine_id`, `egg_type`, `eggs_produced`, `egg_quality`, `ingredient_quality_index`, `operator_quality_index` | production expressions | `inventory.on_hand_qty`, `supplier_batches.batch_quality`, `staffing.n_assigned`, `operator_shifts.operator_quality`, `machine_config.machine_quality` |

## Canonical invariants (v0)
1. No operator is assigned to more than one machine in the same tick.
2. Each machine has 1-3 operators when active; otherwise production is 0.
3. Inventory does not go negative (unless explicitly enabled later).
4. Reorder flag must be TRUE when `on_hand_qty < reorder_threshold`.

## Step-1 done criteria
- v0 scope and exclusions are explicitly documented.
- deterministic tick order is documented.
- node contract table exists with outputs/dependencies/declared inputs.
- at least 4 domain invariants are written and testable.
