# Changelog

All notable changes to this project will be documented in this file.

## [Unreleased]
### Added
- Implemented full v0 scenario node set in runnable config and examples (`supplier_batches`, `inventory`, `reorder_policy`, `operator_shifts`, `machine_config`, `staffing`, `production`) with required ID-bearing outputs.
- Activated and expanded domain invariant tests for staffing and inventory policies (operator exclusivity, staffing bounds, zero-output-without-staff, inventory nonnegativity, reorder threshold behavior).
- Added seed divergence replay test and unknown inter-node source-column validator test.
- Added dependency-workflow guidance and documented v0 state-log/run-manifest schemas.
- Added a v0 implementation checkpoint defining required node/ID/invariant acceptance before full feature build-out.
- Added pending (skipped) domain invariant/ID tests to drive test-first implementation of the full v0 scenario.
- Added weekly GitHub Actions test workflow to run package tests against latest dependencies.

### Changed
- Switched reproducibility guidance to latest-only dependency management (no `renv` lockfile workflow).
- Removed minimum-version constraint for `testthat` in `DESCRIPTION`.
- Converted runtime scaffold into an installable R package (`codexdatasci`) with public help files and runnable package tests.
- Implemented v0 schema/validator/runner skeleton and end-to-end Easter egg scenario tests.
- Added explicit maintenance-minimizing constraints (orchestrator-first runtime, single evaluator path, log-table-only inter-node communication, scalar contract, and shared symbol registry).
- Initial planning and governance docs for agent-assisted development.
- R-first language and dependency references across planning docs, including required `dplyr` and `rio` and recommended maintenance-reducing packages.
- Narrowed near-term scope to deterministic node-network + full per-node state logging each tick.
