context("get_resource_url")

load('metadata.rda')
load('metadata_rs_dkan.rda')
load('metadata_rs_api.rda')
metadata_rs_dkan2 <- metadata_rs_dkan
metadata_rs_dkan2$field_upload$und[[1]]$uri <- ""

test_that("Non valid arguments generate an error", {
  expect_error(get_resource_url("metadata"))
  expect_error(get_resource_url(metadata))
})

test_that("field_resource URLs are correctly extracted", {
  expect_equal(get_resource_url(metadata_rs_dkan),
               "https://datacatalog.worldbank.org//sites//default//files//dataset_resources/ddhfiles/public/ARG-CrowdsourcedPDCPilot02_final_obs_all_clean.csv")
  expect_equal(get_resource_url(metadata_rs_dkan2), "")
  expect_equal(get_resource_url(metadata_rs_api),
               "https://datacatalog.worldbank.org/sites/default/files/dataset_resources/ddhfiles/public/AllPilotCountries(15)-CrowdsourcedPDCPilot02_final_obs_all_clean.zip")
  expect_true(class(get_resource_url(metadata_rs_dkan)) == "character")
  expect_true(is.atomic(class(get_resource_url(metadata_rs_dkan))))
})
