# Data Model (Draft)

## Modeling approach
Use a state-log-first model for MVP, with optional event/derived tables in later phases.

## Core concepts
- **Entity**: persistent object (e.g., customer, order, supplier).
- **Event**: immutable fact at time `t` (e.g., order_placed).
- **Snapshot**: materialized state view at a time boundary.
- **StateLog**: full serialized node state captured at each tick for deterministic inspection.

## State log schema baseline (MVP)
Required fields:
- `run_id`, `scenario_id`, `seed`
- `tick`
- `node_id`
- `state` (serialized full node state)
- `logged_at`

## Event schema (later phase)
Event-first outputs are planned after state-log MVP stabilization.

## ID conventions
- Stable entity IDs where appropriate.
- Optional imperfect linkage keys to simulate real joins.
- Versioned schemas for compatibility.

## Time semantics
- Distinguish event occurrence time vs arrival/ingestion time.
- Support late-arriving and out-of-order data.

## Data quality simulation primitives (later roadmap phase)
- Missingness (MCAR/MAR-style approximations).
- Corruption/noise injection.
- Duplication and de-dup challenges.
- Schema drift and definition drift.
