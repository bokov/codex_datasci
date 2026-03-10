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


## Logging contract (current scope)
- At every tick, each node MUST emit a full-state log record.
- Log record minimum fields: `run_id`, `scenario_id`, `tick`, `node_id`, `state`.
- State logs are append-only and ordered deterministically by tick, then node order.
- Partial or sampled logging is out of current scope.

## Out of current scope
- Noise/missingness/corruption injection.
- Imperfect linkage and schema drift simulation.
- Partial-observability capture modes.

## Evaluator and communication constraints (MVP)
- Inter-node communication is limited to declared log-table input references.
- A separate event bus mechanism is out of MVP scope.
- Runtime uses a single expression evaluator path for configured R expressions.
- Each expression result must be scalar at each tick.

## Canonical symbol registry
- Before execution, build a per-node registry of resolvable symbols from:
  - global state,
  - node-local state,
  - node log history aliases,
  - declared inter-node input aliases,
  - approved built-in functions/namespaces.
- Use this same registry for both load-time validation and runtime context hydration.
