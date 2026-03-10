# Schema helpers for the node-expression simulation config.

required_top_level_fields <- function() {
  c("seed", "ticks", "node_order", "nodes", "global_state_fields", "node_state_fields")
}

validate_config_shape <- function(config) {
  missing <- setdiff(required_top_level_fields(), names(config))
  if (length(missing) > 0) {
    stop(sprintf("Config missing required top-level fields: %s", paste(missing, collapse = ", ")))
  }

  if (!is.list(config$nodes) || length(config$nodes) == 0) {
    stop("`nodes` must be a non-empty named list")
  }

  if (is.null(names(config$nodes)) || any(names(config$nodes) == "")) {
    stop("`nodes` must be a named list keyed by node id")
  }

  if (!is.character(config$node_order) || length(config$node_order) == 0) {
    stop("`node_order` must be a non-empty character vector")
  }

  if (!setequal(config$node_order, names(config$nodes))) {
    stop("`node_order` must contain exactly the same node ids as `nodes`")
  }

  if (!is.list(config$node_state_fields)) {
    stop("`node_state_fields` must be a named list keyed by node id")
  }

  for (node_id in names(config$nodes)) {
    node <- config$nodes[[node_id]]
    if (is.null(node$expressions) || !is.list(node$expressions) || length(node$expressions) == 0) {
      stop(sprintf("Node `%s` must define non-empty `expressions`", node_id))
    }
    if (is.null(names(node$expressions)) || any(names(node$expressions) == "")) {
      stop(sprintf("Node `%s` expressions must be named", node_id))
    }
    if (!all(vapply(node$expressions, is.character, logical(1)))) {
      stop(sprintf("Node `%s` expressions must be character strings", node_id))
    }

    fields <- config$node_state_fields[[node_id]]
    if (is.null(fields) || !is.character(fields)) {
      stop(sprintf("`node_state_fields[[%s]]` must be a character vector", node_id))
    }

    if (is.null(node$inputs)) node$inputs <- list()
    if (!is.list(node$inputs)) {
      stop(sprintf("Node `%s` inputs must be a named list", node_id))
    }

    config$nodes[[node_id]] <- node
  }

  invisible(TRUE)
}
