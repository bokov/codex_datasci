# Data Model (Draft)

## Modeling approach
Use an event-first model with derived tables.

## Core concepts
- **Entity**: persistent object (e.g., customer, order, supplier).
- **Event**: immutable fact at time `t` (e.g., order_placed).
- **Snapshot**: materialized state view at a time boundary.
- **Observation**: what a downstream system actually sees (can be delayed/noisy/incomplete).

## Event schema baseline
Required fields:
- `event_id` (globally unique)
- `event_type`
- `event_time` (source time)
- `ingest_time` (observation time)
- `source_node`
- `entity_keys` (one or more IDs)
- `payload` (domain-specific attributes)
- `quality_flags` (missing/corrupt/imputed/etc.)
- `run_id`, `scenario_id`, `seed`

## ID conventions
- Stable entity IDs where appropriate.
- Optional imperfect linkage keys to simulate real joins.
- Versioned schemas for compatibility.

## Time semantics
- Distinguish event occurrence time vs arrival/ingestion time.
- Support late-arriving and out-of-order data.

## Data quality simulation primitives
- Missingness (MCAR/MAR-style approximations).
- Corruption/noise injection.
- Duplication and de-dup challenges.
- Schema drift and definition drift.
