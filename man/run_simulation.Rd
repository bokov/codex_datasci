\name{run_simulation}
\alias{run_simulation}
\title{Run deterministic tick-based node simulation}
\description{Executes configured nodes in deterministic order and returns per-node log tables.}
\usage{
run_simulation(config, init_global_state = list(), init_node_state = list())
}
\arguments{
  \item{config}{A validated simulation config list.}
  \item{init_global_state}{Named list of global state values.}
  \item{init_node_state}{Named list of node-local state lists.}
}
\value{Named list of data frames (one log table per node).}
\examples{
cfg <- easter_egg_factory_v0_config()
logs <- run_simulation(
  cfg,
  init_global_state = list(reorder_threshold = 10, base_rate = 3),
  init_node_state = list(
    supplier_batches = list(n_suppliers = 3, n_ingredients = 3),
    inventory = list(start_qty = 20),
    reorder_policy = list(reorder_buffer = 6),
    operator_shifts = list(n_operators = 3),
    machine_config = list(n_machines = 3),
    staffing = list(max_ops_per_machine = 3),
    production = list(quality_floor = 0.75)
  )
)
head(logs$production)
}
