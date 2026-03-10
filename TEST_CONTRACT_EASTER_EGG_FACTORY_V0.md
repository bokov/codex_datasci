# Test Contract: Easter Egg Factory (v0)

## Purpose
Define test obligations before and during runner/validator implementation.

## Test categories

### A) Determinism and replay
1. **Seed replay equivalence**
   - Same seed + config + ticks -> identical node logs.
2. **Seed divergence sanity**
   - Different seeds -> at least one expected stochastic column differs.

### B) Expression/runtime contract
3. **Scalar-expression enforcement**
   - Any expression yielding length != 1 fails with actionable error.
4. **Single evaluator path smoke test**
   - Expression execution path uses one evaluator implementation (`rlang` tidy-eval).

### C) Config validator behavior
5. **Unknown symbol failure**
   - Undefined symbol in expression returns error with node id + expression name + symbol + suggestion.
6. **Unknown inter-node alias failure**
   - Reference to undeclared input alias fails with actionable message.
7. **Known symbols pass**
   - Expressions referencing declared global/node/history/input symbols pass validation.

### D) Domain invariants
8. **Operator exclusivity**
   - One operator cannot be assigned to multiple machines in same tick.
9. **Machine staffing bounds**
   - Active machine staffing count is in [1, 3].
10. **Inventory nonnegativity**
   - Inventory levels stay >= 0 in v0.
11. **Reorder threshold trigger**
   - Reorder flag follows threshold rule.

## Step-level done criteria

### Step 2 (node contract table)
- all v0 nodes have explicit output columns and declared inputs.
- dependency direction is unambiguous for each node.

### Step 3 (validation + invariants contract)
- all tests listed in A-D are specified with pass/fail conditions.
- at least 2 invalid-config tests are included.

### Step 4 (config schema)
- schema supports expression lists, declared inputs, state fields, and init values.
- schema examples exist for at least 2 nodes.

### Step 5 (validator skeleton)
- symbol registry is built and reused in validation.
- validator returns actionable diagnostics with required fields.
- minimal test harness is present for validator checks.

### Step 6 (runner skeleton)
- deterministic tick loop implemented.
- declared inter-node input mapping implemented.
- full per-node state logging implemented.
- minimal test harness validates deterministic replay and scalar enforcement.

### Step 7 (first scenario + tests)
- one reproducible scenario runs end-to-end.
- all A-D tests implemented and passing (or documented with rationale if deferred).

### Step 8 (review + tighten plan)
- completed steps marked done.
- oversized steps split or re-scoped.
- plan closed or replaced with next-phase plan.
