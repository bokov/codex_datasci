# Simulation Spec (Draft)

## Purpose
Define execution semantics for scenario simulation.

## Execution model
- Discrete ticks (or discretized time windows).
- Deterministic node ordering within each tick.
- Explicit state persistence across ticks.

## Interaction patterns
1. Push: upstream emits and downstream subscribes.
2. Pull: downstream queries upstream/state when needed.
3. Periodic: nodes emit on schedule.
4. Stateful: behavior depends on prior ticks.
5. Hierarchical instantiation: nodes spawn child entities/processes.

## State model
- **Global shared state** for cross-node coordination.
- **Node-local state** for internal memory.
- Controlled update phase to avoid nondeterministic races.

## Reproducibility
- Every run records:
  - code version,
  - scenario config hash,
  - RNG seed,
  - runtime metadata.

## Validation hooks
- Invariants at tick boundaries (e.g., no negative inventory unless explicitly allowed).
- Optional sanity checks for event volume, null rates, key uniqueness.
