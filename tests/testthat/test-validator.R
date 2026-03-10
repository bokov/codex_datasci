test_that("validator passes valid config", {
  cfg <- easter_egg_factory_v0_config()
  v <- validate_config_symbols(cfg)
  expect_true(v$ok)
  expect_length(v$errors, 0)
})

test_that("validator reports unknown symbols with actionable fields", {
  cfg <- invalid_easter_egg_config()
  v <- validate_config_symbols(cfg)
  expect_false(v$ok)
  expect_gt(length(v$errors), 0)

  err <- v$errors[[1]]
  expect_true(all(c("node_id", "expression", "symbol", "reason", "suggestion") %in% names(err)))
})
