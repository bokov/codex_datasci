\name{validate_config_shape}
\alias{validate_config_shape}
\title{Validate configuration structural shape}
\description{Checks required top-level keys and node expression/input structure.}
\usage{
validate_config_shape(config)
}
\arguments{
  \item{config}{A simulation config list.}
}
\value{Invisible TRUE when valid; otherwise an error is thrown.}
\examples{
cfg <- easter_egg_factory_v0_config()
validate_config_shape(cfg)
}
