# Agent Instructions for This Repository

## Mission
Help implement a realistic synthetic data training simulator with strong documentation, reproducibility, and incremental delivery.

## Operating rules
1. Read `README.md`, `PROJECT_CHARTER.md`, and `REQUIREMENTS.md` before large changes.
2. Keep changes small and reviewable.
3. Update docs when behavior changes.
4. Prefer deterministic behavior and seed-aware tests.
5. Record significant architecture choices in `DECISIONS/` ADRs.

## Coding expectations
- Favor clear interfaces over clever abstractions.
- Keep node API uniform unless an ADR approves change.
- Add or update tests for any behavioral change.
- Avoid introducing hidden global state.

## PR expectations
- Explain what changed and why.
- Include validation commands and outcomes.
- Call out risks, assumptions, and follow-up tasks.

## Safety / boundaries
- Do not delete planning docs without replacing them.
- Do not break reproducibility guarantees without explicit notice.
