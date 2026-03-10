\name{validate_config_symbols}
\alias{validate_config_symbols}
\title{Validate expression symbols against available context}
\description{Builds per-node symbol registries and reports unresolved symbols with actionable fields.}
\usage{
validate_config_symbols(config)
}
\arguments{
  \item{config}{A simulation config list.}
}
\value{A list with elements \code{ok}, \code{errors}, and \code{registry}.}
\examples{
cfg <- easter_egg_factory_v0_config()
validate_config_symbols(cfg)$ok

bad <- invalid_easter_egg_config()
validate_config_symbols(bad)$ok
}
