# Reproducibility Workflow (latest-only dependencies)

## Policy for this project
- This repository does **not** use `renv` lockfiles.
- `DESCRIPTION` is the source of truth for package dependencies.
- CI runs regularly against latest available package versions.

## Day-to-day workflow
1. Add package dependencies intentionally in `DESCRIPTION` (`Imports`/`Suggests`).
2. Install or update packages from standard repositories.
3. Run tests/checks locally.
4. Rely on CI (including weekly scheduled runs) to catch upstream dependency regressions quickly.

## Guardrails without version pinning
- Prefer deterministic tests with explicit seed control.
- Keep `Suggests` for test/dev-only packages.
- Do not add package version constraints unless a concrete compatibility issue requires it.
- If a latest-package break occurs, document the issue and then decide whether code changes or a targeted version floor is warranted.
