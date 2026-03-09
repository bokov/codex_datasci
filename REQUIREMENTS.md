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

### FR-4: Data capture points
- Users SHALL configure where observations/logs are captured.
- Captures SHALL support raw events and transformed datasets.

### FR-5: Realism knobs
- Users SHALL tune noise, missingness, delay, corruption, and drift parameters.
- Config SHALL permit per-node and global defaults.

### FR-6: Reproducibility
- Scenario runs SHALL be reproducible from seed + config + code version.

### FR-7: Scenario packaging
- System SHALL support named scenarios with metadata and expected learning outcomes.

### FR-8: Export
- System SHALL export outputs to common formats (CSV/Parquet minimum).

## Non-functional requirements
- NFR-1: Deterministic replay under fixed seed/config.
- NFR-2: Observability (run metadata, timing, version stamps).
- NFR-3: Extensibility for new node types/domains.
- NFR-4: Testability via unit + scenario regression tests.
- NFR-5: Reasonable performance for classroom-scale runs.

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
- Produce at least three linked datasets with intentional quality issues.
- Run replay yields identical outputs under same seed.
- At least one built-in exercise with rubric and reference solution outline.
