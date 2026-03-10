# Tasks

## Now
- [ ] Confirm MVP domain (e.g., supply chain, clinical trials, e-commerce).
- [x] Choose implementation language/runtime (R).
- [ ] Define v0 scenario config schema.
- [ ] Create dependency lock strategy (e.g., `renv`) and base project scaffold.
- [ ] Add baseline package imports (`dplyr`, `rio`, `tidyr`, `purrr`, `testthat`).
- [ ] Define v0 state-log schema and run manifest schema.
- [ ] Implement minimal runner skeleton.
- [ ] Implement expression-configured node runtime (no bespoke per-node imperative classes).
- [ ] Implement declared inter-node log-table input mapping as the only MVP communication mode.
- [ ] Implement single evaluator path using `rlang` tidy-eval.
- [ ] Implement canonical symbol registry shared by validator and runtime.
- [ ] Enforce scalar-per-expression outputs with actionable errors.
- [ ] Implement first three nodes with full-state logging support.

## Next
- [ ] Add reproducibility test harness (seed replay tests).
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
