context("get_resource_nids")

load('metadata.rda')
metadata_res <- metadata
metadata_res$type <- "resource"



test_that("Non valid arguments generate an error", {
  expect_error(get_resource_nids("metadata"))
  expect_error(get_resource_nids(metadata_res))
})

test_that("Resource nodes ids are correctly extracted", {
  expect_true(is.atomic(get_resource_nids(metadata)))
  expect_true(class(get_resource_nids(metadata)) == "character")
  expect_true(sum(is.na(as.numeric(get_resource_nids(metadata)))) == 0)
})
