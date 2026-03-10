# v0 Implementation Checkpoint (Pre-Implementation Alignment)

## Purpose
Freeze the exact acceptance target for the full Easter egg factory v0 implementation before expanding runtime behavior.

## Required v0 nodes
The full scenario implementation must include these nodes:
1. `supplier_batches`
2. `inventory`
3. `reorder_policy`
4. `operator_shifts`
5. `machine_config`
6. `staffing`
7. `production`

## Required ID-bearing entities
Every run must model unique IDs for:
- suppliers (`supplier_id`)
- ingredients (`ingredient_id`)
- operators (`operator_id`)
- machines (`machine_id`)
- recipes / egg types (`recipe_id` or `egg_type`)

## Required availability and staffing semantics
- Operators follow explicit availability windows (e.g., 20 ticks on / 80 ticks off, staggerable by operator).
- An operator cannot be assigned to more than one machine in a tick.
- If a machine has zero available unassigned operators in a tick, machine output is zero.

## Required per-node minimum outputs
- `supplier_batches`: includes `supplier_id`, `ingredient_id`, quantity and quality fields.
- `inventory`: includes `ingredient_id`, on-hand/incoming/consumed quantities and reorder signal.
- `reorder_policy`: includes `ingredient_id` and reorder/target quantity outputs.
- `operator_shifts`: includes `operator_id`, availability, quality, and shift window indicators.
- `machine_config`: includes `machine_id`, `egg_type`/`recipe_id`, machine quality, ingredient requirements.
- `staffing`: includes `machine_id`, assigned operator IDs, assigned count, staffing validity.
- `production`: includes `machine_id`, recipe/egg type, eggs produced, and quality outputs.

## Gate before feature expansion
Before implementing new realism features, ensure:
1. Schema/docs represent the required IDs and nodes.
2. Tests exist for ID presence + staffing/availability invariants.
3. Runtime implementation work is tracked against these tests.
