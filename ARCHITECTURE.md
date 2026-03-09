# Architecture (Draft)

## High-level components
1. **Scenario Loader**
   - Parses scenario config and validates schema.
2. **Runner**
   - Owns simulation loop over ticks/time.
   - Orchestrates node invocation and event routing.
3. **Node Runtime**
   - Executes node logic via uniform interface.
4. **State Store**
   - Holds shared simulation state and node-local state.
5. **Event Bus / Routing Layer**
   - Handles push/pull routing semantics.
6. **Capture Layer**
   - Configurable observation taps for logs/tables.
7. **Transformation Layer**
   - Derives downstream “analytics-facing” datasets.
8. **Export & Metadata**
   - Persists outputs and run manifest.

## Proposed node interface
- Inputs:
  - `params` (node configuration),
  - `state_view` (read-only snapshot/scoped accessor),
  - `tick` or timestamp,
  - optional inbound events.
- Outputs:
  - emitted events,
  - optional state update intents.

## Simulation loop (conceptual)
1. Initialize run context from scenario + seed.
2. For each tick:
   - Determine active nodes.
   - Resolve pull dependencies.
   - Execute nodes in deterministic order.
   - Route and persist events.
   - Apply state updates.
   - Record capture taps.
3. Finalize outputs + run manifest.

## Design principles
- Keep node API uniform; let wiring/patterns encode behavior differences.
- Prefer explicit configuration over hidden defaults.
- Separate “world truth” from “what is observed by analysts.”


## R package conventions
- Use `dplyr`/`tidyr`/`purrr` pipelines for node and transformation logic before writing custom helper frameworks.
- Use `rio` for import/export adapters and `arrow` for Parquet outputs to reduce bespoke IO code.
- Use `jsonlite`/`yaml` for scenario and manifest serialization.
- Use `checkmate` for runtime input validation and `cli`/`glue` for consistent diagnostics.
- Use `withr` and explicit seeding patterns for deterministic run behavior.
