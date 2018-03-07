context("test-delete_node.R")

test_that("delete_node handles bad inputs correctly", {
  expect_error(delete_node(), regexp = "argument \"nid\" is missing")
})
