# Project Charter

## Vision
Create a configurable node-based simulation engine with deterministic tick execution and full per-node state logging.

## Problem statement
The project needs a stable simulation core first: configurable node wiring, explicit state evolution, and complete per-node state logs per tick for traceability.

## Target users
- Self-learners in data science/statistics.
- Instructors building applied exercises.
- Teams practicing analytics engineering and ML pipeline robustness.

## Goals
1. Simulate multiple interacting data-generating processes (DGPs).
2. Log each node's full state at each tick.
3. Support configurable observation and export of run artifacts.
4. Enable repeatable scenarios with seed control and scenario configs.
5. Establish an extensible base for medium-term realism features.

## Non-goals (initially)
- Photorealistic domain simulation.
- Full enterprise-scale distributed systems.
- Perfectly faithful reproduction of any one real-world domain.
- Building a full teaching LMS.

## Success criteria
- Users can generate at least 3 distinct training scenarios from config files.
- Node state logs are emitted for every node at every tick.
- Scenarios are reproducible from seed + config.
- At least one end-to-end scenario can be inspected tick-by-tick from logs.

## Risks
- Overengineering before first runnable MVP.
- Scope creep into realism features before the core loop is validated.
- Excess complexity reducing debuggability in early iterations.

## Mitigations
- MVP-first roadmap with explicit scope caps.
- ADR process for major design choices.
- Scenario validation checklist and regression tests.
