# Validator for expression symbols and config contracts.

builtin_symbols <- function() {
  c(
    # context symbols
    "tick", "global_state", "node_state", "inputs", "node_log_history", "prev",
    # logical constants
    "TRUE", "FALSE", "NA",
    # utility/base functions commonly used in expressions
    "ifelse", "pmax", "pmin", "round", "min", "max", "mean", "sum",
    "length", "as.numeric", "as.integer", "as.character", "abs",
    "is.na", "paste", "paste0", "c"
  )
}

extract_symbols <- function(expr_text) {
  unique(all.names(parse(text = expr_text), functions = FALSE))
}

build_symbol_registry <- function(config, node_id) {
  node <- config$nodes[[node_id]]
  node_state_fields <- config$node_state_fields[[node_id]]
  if (is.null(node_state_fields)) node_state_fields <- character(0)

  input_aliases <- names(node$inputs)
  if (is.null(input_aliases)) input_aliases <- character(0)

  unique(c(
    builtin_symbols(),
    config$global_state_fields,
    node_state_fields,
    input_aliases
  ))
}

suggestion_for_symbol <- function(sym, registry, node) {
  if (length(grep("^input_", sym)) > 0 || (!(sym %in% registry) && length(node$inputs) > 0)) {
    return("Declare this symbol as an input alias under node$inputs or fix alias spelling")
  }
  "Add symbol to global/node state fields, declare as input alias, or correct expression spelling"
}

validate_input_contracts <- function(config) {
  errors <- list()

  for (node_id in config$node_order) {
    node <- config$nodes[[node_id]]
    if (is.null(node$inputs) || length(node$inputs) == 0) next

    for (alias in names(node$inputs)) {
      spec <- node$inputs[[alias]]
      src_node <- spec$node
      src_col <- spec$column

      if (is.null(config$nodes[[src_node]])) {
        errors[[length(errors) + 1]] <- list(
          node_id = node_id,
          expression = alias,
          symbol = src_node,
          reason = "unknown_input_source_node",
          suggestion = "Declare an existing source node id under node$inputs[[alias]]$node"
        )
        next
      }

      src_expr_names <- names(config$nodes[[src_node]]$expressions)
      if (!(src_col %in% src_expr_names)) {
        errors[[length(errors) + 1]] <- list(
          node_id = node_id,
          expression = alias,
          symbol = src_col,
          reason = "unknown_input_source_column",
          suggestion = "Reference an output expression name produced by the source node"
        )
      }
    }
  }

  errors
}

validate_config_symbols <- function(config) {
  validate_config_shape(config)

  errors <- list()
  registry_by_node <- list()

  input_contract_errors <- validate_input_contracts(config)
  if (length(input_contract_errors) > 0) {
    errors <- c(errors, input_contract_errors)
  }

  for (node_id in config$node_order) {
    node <- config$nodes[[node_id]]
    registry <- build_symbol_registry(config, node_id)
    registry_by_node[[node_id]] <- registry

    defined_so_far <- c()
    for (expr_name in names(node$expressions)) {
      expr_text <- node$expressions[[expr_name]]
      symbols <- extract_symbols(expr_text)

      allowed <- unique(c(registry, defined_so_far))
      unknown <- setdiff(symbols, allowed)

      if (length(unknown) > 0) {
        for (sym in unknown) {
          errors[[length(errors) + 1]] <- list(
            node_id = node_id,
            expression = expr_name,
            symbol = sym,
            reason = "unresolved_symbol",
            suggestion = suggestion_for_symbol(sym, registry, node)
          )
        }
      }

      defined_so_far <- c(defined_so_far, expr_name)
    }
  }

  list(ok = length(errors) == 0, errors = errors, registry = registry_by_node)
}
