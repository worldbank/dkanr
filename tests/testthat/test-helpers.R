context("helpers")

trail <- "string with trail////"

test_that("helpers functions return expectd values", {
  expect_equal(dk(), "api/dataset/node")
  expect_equal(dkfiles(), "sites//default//files")
  expect_equal(notrail(trail), "string with trail")
})
