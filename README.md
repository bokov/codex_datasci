# codex_datasci

Synthetic data science training platform for configurable node-based simulation networks.

## Why this exists
The immediate goal is to build a deterministic simulation core that is easy to reason about and extend:
- configurable node-based network definitions,
- deterministic tick-based execution,
- shared + node-local state,
- and full per-node state logging at every tick.

Data quality perturbations (noise, missingness, corruption, etc.) remain on the medium-term roadmap after the core loop is stable.

## Current status
Planning and specification phase.


## Implementation stack
Primary language: **R**. Core required packages: **dplyr** and **rio**.

Recommended additional packages to minimize custom code:
- **purrr** and **tidyr** for iteration and reshaping workflows,
- **tibble** for clean tabular structures,
- **stringr** and **lubridate** for robust string/time handling,
- **jsonlite** and **yaml** for scenario/config interchange,
- **arrow** for low-friction Parquet support,
- **testthat** for deterministic tests,
- **withr** for scoped seed/runtime state management.

## Maintenance-minimizing implementation strategy
To minimize maintained code volume, implementation should be orchestration-first:
- custom code handles dependency ordering, context assembly, deterministic execution, validation, and logging/export,
- node computation remains config-driven (mutate-like expressions),
- inter-node communication defaults to declared access to other nodes' log-table columns,
- runtime uses a single expression evaluator path (`rlang` tidy-eval),
- each expression must produce one scalar per tick,
- CSV export is required for MVP (Parquet is optional),
- validator/runtime share one canonical symbol registry.


## Active execution plan context
The current MVP execution plan is grounded in the Easter egg factory v0 domain contract and its paired test contract.

## Source of truth (planning docs)
- `PROJECT_CHARTER.md` — problem framing, goals, non-goals, success criteria.
- `REQUIREMENTS.md` — functional/non-functional requirements and acceptance criteria.
- `ARCHITECTURE.md` — proposed system design.
- `DATA_MODEL.md` — event and entity schema conventions.
- `SIMULATION_SPEC.md` — simulation semantics (nodes, ticks, state, reproducibility).
- `ROADMAP.md` — phase-by-phase delivery plan.
- `TASKS.md` — actionable to-do list.
- `DOMAIN_EASTER_EGG_FACTORY_V0.md` — fixed v0 domain boundaries and node contract table.
- `TEST_CONTRACT_EASTER_EGG_FACTORY_V0.md` — step-linked test obligations and done criteria.
- `CONFIG_SCHEMA_EASTER_EGG_FACTORY_V0.md` — v0 configuration schema and valid/invalid examples.
- `AGENTS.md` — instructions for coding agents working in this repo.
- `DECISIONS/` — architecture decision records (ADRs).
- `PROMPTS/` — reusable prompt templates for agent workflows.


## Package usage (current scaffold)
Build/check commands from repo root:
- `R CMD build .`
- `R CMD check --no-manual codexdatasci_0.1.0.tar.gz`

Run test suite directly:
- `Rscript tests/testthat.R`

## Working agreements
- Keep docs in sync with implementation.
- Record major architecture choices as ADRs before or during implementation.
- Prefer small, testable milestones over large speculative rewrites.
