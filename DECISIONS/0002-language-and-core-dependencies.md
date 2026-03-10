# ADR 0002: Language and Core Dependencies

## Status
Accepted

## Context
The project needs an explicit implementation language and baseline dependency set so contributors and coding agents can make consistent tooling and architecture decisions.

## Decision
- Primary implementation language: **R**.
- Required core libraries:
  - **dplyr** for data manipulation workflows.
  - **rio** for import/export of tabular artifacts.
- Additional libraries are encouraged **when they reduce custom maintenance burden**, improve readability, and remain aligned with reproducibility requirements.

## Guidance for dependency additions
When adding a new package:
1. Prefer widely used, well-maintained libraries.
2. Prefer packages that replace significant custom utility code.
3. Document why the package is needed and what maintenance it removes.
4. Keep reproducibility deterministic (e.g., seed behavior and stable outputs).

## Consequences
- Project examples, interfaces, and tests should assume an R-first workflow.
- Existing planning docs should be updated in review to reflect this decision where language/runtime is referenced.

## Preferred maintenance-minimizing stack for expression runtime
- `dplyr` + `rlang` for expression evaluation and data-masked execution.
- `purrr` for deterministic node iteration.
- `checkmate` + `cli`/`glue` for validator and error reporting.
- `jsonlite`/`yaml` for config ingestion.
- `rio` for export (CSV required; additional formats optional).
