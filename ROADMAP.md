# Roadmap

## Phase 0: Foundations (Now)
- Finalize requirements and architecture docs.
- Set up R scaffolding (`renv`, package structure, lint/test config).
- Choose initial domain for first scenario.
- Define schema and run manifest format.

## Phase 1: MVP engine
- Implement minimal runner + state + uniform node interface.
- Implement configurable node network loading and deterministic execution order.
- Add full per-node state logging at each tick + CSV export (Parquet optional).
- Implement single evaluator path (`rlang` tidy-eval) + canonical symbol registry.
- Deliver one end-to-end reproducible scenario with tick-by-tick state inspection.

## Phase 2: Realism features
- Add delay, missingness, corruption, and drift knobs.
- Add imperfect key/linkage simulation.
- Add derived “analytics” datasets and quality reports.

## Phase 3: Training package
- Add curated exercises + rubric.
- Add reference solutions and failure mode walkthroughs.
- Add scenario comparison benchmarks.

## Phase 4: Scale and ecosystem
- Performance improvements.
- Additional domains/scenarios.
- Optional UI and interactive scenario controls.
