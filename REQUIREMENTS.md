# Requirements

## Functional requirements

### FR-1: Configurable simulation graph
- System SHALL allow defining a network of nodes that produce events over ticks/time.
- Each node SHALL expose a uniform interface (inputs, params, state access, output events).

### FR-2: Shared state and local state
- System SHALL support persistent simulation state across ticks.
- Nodes SHALL be able to read scoped state and write outputs/state updates through controlled APIs.

### FR-3: Multiple interaction patterns
System SHALL support (at minimum):
- push-style event propagation,
- pull/on-demand reads,
- periodic/repeated emissions,
- stateful behavior across ticks,
- hierarchical instantiation (one-to-many entity creation).

### FR-4: Full per-node state logging
- System SHALL record each node's full state at every tick.
- Logs SHALL include node identifier, tick index, and serialized state payload.

### FR-5: Configurable capture/export
- Users SHALL configure output destinations/formats for state logs.
- Captures SHALL support full-run export for deterministic replay and inspection.

### FR-6: Reproducibility
- Scenario runs SHALL be reproducible from seed + config + code version.

### FR-7: Scenario packaging
- System SHALL support named scenarios with metadata and execution parameters.

### FR-8: Export
- System SHALL export outputs to common formats (CSV minimum).
- Parquet support SHOULD be optional and implementation-driven (not required for MVP).

### FR-9: Orchestrator-first runtime boundary
- Custom engine code SHALL be limited to orchestration concerns: dependency ordering, context assembly, deterministic execution, config validation, and logging/export.
- Node business logic SHALL be expression-configured rather than per-node bespoke imperative code.

### FR-10: Inter-node communication contract
- Inter-node communication SHALL default to declared access to upstream node log-table columns.
- Additional communication mechanisms are out of MVP scope unless approved by ADR.

### FR-11: Single evaluator path
- Runtime SHALL use one expression evaluation path for configured node expressions.
- Preferred evaluator stack: `rlang` tidy-eval + `dplyr` data-masking semantics.

### FR-12: Scalar output contract
- Each configured expression SHALL produce exactly one scalar value per tick.
- Non-scalar outputs MUST fail with actionable diagnostics.

### FR-13: Canonical symbol registry
- Config validator and runtime context builder SHALL share one canonical symbol registry per node/tick.
- Symbol resolution rules SHALL not be duplicated across independent code paths.

## Non-functional requirements
- NFR-1: Deterministic replay under fixed seed/config.
- NFR-2: Observability (run metadata, timing, version stamps).
- NFR-3: Extensibility for new node types/domains.
- NFR-4: Testability via unit + scenario regression tests.
- NFR-5: Reasonable performance for classroom-scale runs.
- NFR-7: Dependency-over-custom preference (prefer mature libraries over bespoke utility code when behavior is equivalent).

- NFR-6: Language and dependency baseline
  - Implementation SHALL use **R** as the primary language.
  - Project SHALL require **dplyr** and **rio**.
  - Additional libraries SHOULD be preferred when they replace substantial custom utility code and improve maintainability.

## Recommended dependency set (initial)
- Data manipulation: `dplyr`, `tidyr`, `purrr`, `tibble`
- IO/config: `rio`, `jsonlite`, `yaml`, `arrow`
- Utilities: `stringr`, `lubridate`, `glue`, `cli`
- Validation/testing: `checkmate`, `testthat`, `withr`

## Acceptance criteria (MVP)
- Define and execute at least one complete scenario via config.
- Emit per-tick full-state logs for every node in the scenario.
- Run replay yields identical outputs under same seed.
- Exported logs can be used to inspect node evolution tick-by-tick.
- MVP implementation demonstrates a single evaluator path for configured expressions.
- Inter-node data access uses declared log-table input mappings.
- Scalar-output violations fail with actionable errors.
