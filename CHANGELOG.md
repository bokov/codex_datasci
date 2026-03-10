# Changelog

All notable changes to this project will be documented in this file.

## [Unreleased]
### Added
- Added explicit renv workflow guidance and documented v0 state-log/run-manifest schemas.
- Converted runtime scaffold into an installable R package (`codexdatasci`) with public help files and runnable package tests.
- Implemented v0 schema/validator/runner skeleton and end-to-end Easter egg scenario tests.
- Added explicit maintenance-minimizing constraints (orchestrator-first runtime, single evaluator path, log-table-only inter-node communication, scalar contract, and shared symbol registry).
- Initial planning and governance docs for agent-assisted development.
- R-first language and dependency references across planning docs, including required `dplyr` and `rio` and recommended maintenance-reducing packages.
- Narrowed near-term scope to deterministic node-network + full per-node state logging each tick.
