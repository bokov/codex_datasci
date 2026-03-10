# v0 State-Log Schema and Run Manifest

## State-log schema (per node, per tick)
Minimum required columns:
- `run_id`
- `scenario_id`
- `seed`
- `tick`
- `node_id`
- `state` (serialized full node row/state)
- `logged_at`

Optional convenience columns:
- `validation_ok`
- `error_flag`
- `error_message`

## Run manifest schema (one per run)
Minimum required fields:
- `run_id`
- `scenario_id`
- `seed`
- `ticks`
- `node_order`
- `config_hash`
- `package_version`
- `start_time`
- `end_time`
- `status` (`ok` / `failed`)

Optional fields:
- `warnings`
- `error_summary`
- `artifact_paths`

## Purpose
- State logs support tick-by-tick debugging and downstream exercise data.
- Run manifest supports reproducibility and traceability.
