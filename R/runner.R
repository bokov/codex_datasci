# Minimal deterministic runner skeleton.

resolve_node_inputs <- function(config, logs_by_node, node_id, tick) {
  node <- config$nodes[[node_id]]
  out <- list()
  if (is.null(node$inputs) || length(node$inputs) == 0) return(out)

  for (alias in names(node$inputs)) {
    spec <- node$inputs[[alias]]
    src_node <- spec$node
    src_col <- spec$column

    src_log <- logs_by_node[[src_node]]
    if (is.null(src_log) || nrow(src_log) == 0) {
      out[[alias]] <- NA
      next
    }

    candidate <- src_log[src_log$tick <= tick, , drop = FALSE]
    if (nrow(candidate) == 0 || !(src_col %in% names(candidate))) {
      out[[alias]] <- NA
      next
    }

    out[[alias]] <- utils::tail(candidate[[src_col]], 1)
  }

  out
}

eval_node_row <- function(config, node_id, tick, global_state, node_state, logs_by_node) {
  node <- config$nodes[[node_id]]
  history <- logs_by_node[[node_id]]
  if (is.null(history)) history <- data.frame()
  inputs <- resolve_node_inputs(config, logs_by_node, node_id, tick)

  row <- list(tick = tick)

  for (expr_name in names(node$expressions)) {
    expr_text <- node$expressions[[expr_name]]

    eval_env <- new.env(parent = baseenv())
    eval_env$tick <- tick
    eval_env$global_state <- global_state
    eval_env$node_state <- node_state[[node_id]]
    eval_env$node_log_history <- history
    eval_env$inputs <- inputs
    eval_env$prev <- row
    eval_env$tail <- utils::tail
    eval_env$runif <- stats::runif

    # expose inputs as top-level aliases for concise expressions
    if (length(inputs) > 0) {
      for (nm in names(inputs)) eval_env[[nm]] <- inputs[[nm]]
    }
    # expose prior expression values in same row (takes precedence over inputs aliases)
    if (length(row) > 0) {
      for (nm in names(row)) eval_env[[nm]] <- row[[nm]]
    }

    val <- eval(parse(text = expr_text), envir = eval_env)

    if (length(val) != 1) {
      stop(sprintf(
        "Non-scalar expression result in node `%s`, expression `%s`, tick %s",
        node_id, expr_name, tick
      ))
    }

    row[[expr_name]] <- val
  }

  as.data.frame(row, stringsAsFactors = FALSE)
}

run_simulation <- function(config, init_global_state = list(), init_node_state = list()) {
  v <- validate_config_symbols(config)
  if (!v$ok) {
    stop(sprintf("Config validation failed with %s unresolved symbols", length(v$errors)))
  }

  set.seed(config$seed)

  logs_by_node <- stats::setNames(vector("list", length(config$nodes)), names(config$nodes))
  node_state <- init_node_state
  for (node_id in names(config$nodes)) {
    if (is.null(node_state[[node_id]])) node_state[[node_id]] <- list()
  }

  for (tick in seq_len(config$ticks)) {
    for (node_id in config$node_order) {
      row <- eval_node_row(config, node_id, tick, init_global_state, node_state, logs_by_node)

      if (is.null(logs_by_node[[node_id]])) {
        logs_by_node[[node_id]] <- row
      } else {
        logs_by_node[[node_id]] <- dplyr::bind_rows(logs_by_node[[node_id]], row)
      }
    }
  }


  if (!is.null(config$export_dir)) {
    purrr::iwalk(logs_by_node, function(df, node_nm) {
      rio::export(df, file = file.path(config$export_dir, paste0(node_nm, ".csv")))
    })
  }

  if (isTRUE(config$emit_long_log)) {
    logs_by_node$long_log <- purrr::imap_dfr(logs_by_node, function(df, node_nm) {
      df$node_id <- node_nm
      tidyr::pivot_longer(df, cols = -c(tick, node_id), names_to = "field", values_to = "value")
    })
  }

  logs_by_node
}
