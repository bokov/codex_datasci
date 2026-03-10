\name{invalid_easter_egg_config}
\alias{invalid_easter_egg_config}
\title{Create an invalid Easter egg config for validator tests}
\description{Returns a config with an unresolved symbol in one expression.}
\usage{
invalid_easter_egg_config()
}
\value{A configuration list that should fail symbol validation.}
\examples{
bad <- invalid_easter_egg_config()
validate_config_symbols(bad)$ok
}
