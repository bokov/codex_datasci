# ADR 0001: Adopt Lightweight ADR Process

## Status
Accepted

## Context
The project has many design decisions (node interface, state model, event schema, reproducibility guarantees). Without written rationale, contributors and agents may repeatedly revisit the same questions.

## Decision
Use short Architecture Decision Records in `DECISIONS/` with this structure:
- Status
- Context
- Decision
- Consequences

## Consequences
- Better continuity across contributors.
- Slight overhead for major changes.
