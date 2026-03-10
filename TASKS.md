# Tasks

## Now
- [x] Note: project uses latest-only dependencies via `DESCRIPTION` + CI (no `renv` lockfile).
- [x] Finalize Easter egg factory v0 boundaries (`DOMAIN_EASTER_EGG_FACTORY_V0.md`).
- [x] Finalize v0 node and test contracts (`TEST_CONTRACT_EASTER_EGG_FACTORY_V0.md`).
- [x] Confirm MVP domain (Easter egg factory).
- [x] Choose implementation language/runtime (R).
- [x] Define v0 scenario config schema (`CONFIG_SCHEMA_EASTER_EGG_FACTORY_V0.md`).
- [x] Define dependency management strategy (latest-only workflow documented in `REPRODUCIBILITY_WORKFLOW.md`).
- [x] Add baseline package imports (`dplyr`, `rio`, `tidyr`, `purrr`, `testthat`) in package metadata.
- [x] Define v0 state-log schema and run manifest schema (`STATE_LOG_AND_MANIFEST_V0.md`).
- [x] Implement minimal runner skeleton.
- [x] Implement expression-configured node runtime (no bespoke per-node imperative classes).
- [x] Implement declared inter-node log-table input mapping as the only MVP communication mode.
- [x] Implement single evaluator path using `rlang` tidy-eval.
- [x] Implement canonical symbol registry shared by validator and runtime.
- [x] Add mini validator test harness during validator skeleton implementation.
- [x] Enforce scalar-per-expression outputs with actionable errors.
- [x] Add mini runner replay/scalar test harness during runner skeleton implementation.
- [x] Implement first three nodes with full-state logging support.

## Next
- [x] Convert skeleton scripts into package-style exported functions + baseline package checks.
- [x] Freeze full v0 implementation acceptance checklist (`V0_IMPLEMENTATION_CHECKPOINT.md`).
- [x] Add invariant/ID test scaffolding for full v0 implementation (currently marked pending via skipped tests).
- [x] Add richer invariant tests for staffing and inventory policies in the end-to-end scenario.
- [x] Add reproducibility test harness (seed replay tests).
- [ ] Add data quality perturbation module (post-MVP).
- [ ] Add one instructor-facing exercise package.
- [ ] Add benchmark metrics (row counts, null rates, linkage precision).

## Later
- [ ] Add plugin mechanism for external node packs.
- [ ] Add optional web UI for scenario authoring.
- [ ] Add distribution package/examples gallery.

## Definition of done (task-level)
A task is done when:
1. behavior is documented,
2. tests/checks are added or updated,
3. docs reflect the new behavior,
4. reproducibility implications are addressed.
