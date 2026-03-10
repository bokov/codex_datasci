# Reproducibility Workflow (renv + package dependencies)

## Why both DESCRIPTION and renv matter
- `DESCRIPTION` defines package dependencies for users/CI/package checks.
- `renv.lock` defines the *exact* development environment for this repo.

Use both:
1. Add package dependencies intentionally in `DESCRIPTION`.
2. Install/update only what is needed.
3. Snapshot with `renv::snapshot(type = "explicit")` to avoid accidental lockfile bloat.

## Recommended renv workflow for this project
1. Initialize once:
   - `renv::init(bare = TRUE)`
2. Add package dependencies explicitly:
   - update `DESCRIPTION` (`Imports`, `Suggests`) first.
3. Install only missing dependencies:
   - `renv::install()`
4. Run tests/checks.
5. Snapshot explicitly:
   - `renv::snapshot(type = "explicit")`
6. In CI/new machine:
   - `renv::restore()`

## Avoiding brittle/unnecessary dependencies
- Prefer `snapshot(type = "explicit")`.
- Keep `Suggests` for test/dev-only packages.
- Periodically run `renv::status()` and prune unused packages.
- Do not add packages to `DESCRIPTION` unless code/docs/examples require them.
