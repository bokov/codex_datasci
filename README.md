# codex_datasci

Synthetic data science training platform that simulates realistic, messy, multi-source data-generating systems.

## Why this exists
Most training datasets are too clean and too small. This project focuses on the part of data science practitioners actually spend time on:
- cleaning and normalization,
- cross-system joins,
- temporal alignment,
- granularity mismatches,
- lineage/provenance uncertainty,
- and modeling under imperfect observations.

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

## Source of truth (planning docs)
- `PROJECT_CHARTER.md` — problem framing, goals, non-goals, success criteria.
- `REQUIREMENTS.md` — functional/non-functional requirements and acceptance criteria.
- `ARCHITECTURE.md` — proposed system design.
- `DATA_MODEL.md` — event and entity schema conventions.
- `SIMULATION_SPEC.md` — simulation semantics (nodes, ticks, state, reproducibility).
- `ROADMAP.md` — phase-by-phase delivery plan.
- `TASKS.md` — actionable to-do list.
- `AGENTS.md` — instructions for coding agents working in this repo.
- `DECISIONS/` — architecture decision records (ADRs).
- `PROMPTS/` — reusable prompt templates for agent workflows.

## Working agreements
- Keep docs in sync with implementation.
- Record major architecture choices as ADRs before or during implementation.
- Prefer small, testable milestones over large speculative rewrites.
