context("get_resource_url")

# start_capturing(path = './tests/testthat')
# dkanr_setup(url = "https://www.statistics.digitalresources.jisc.ac.uk/")
# metadata <- retrieve_node(nid = 2400, as = 'list')
# get_resource_url(metadata)
# stop_capturing()


# Set up
dkanr_setup(url = "https://datacatalog.worldbank.org")
load("metadata.rda")
load("metadata_rs_dkan.rda")
load("metadata_rs_api.rda")
metadata_rs_dkan2 <- metadata_rs_dkan
metadata_rs_dkan2$field_upload$und[[1]]$uri <- ""

test_that("Non valid arguments generate an error", {
  expect_error(get_resource_url("metadata"))
  expect_error(get_resource_url(metadata))
})

test_that("field_resource URLs are correctly extracted", {
  expect_equal(
    get_resource_url(metadata_rs_dkan),
    "https://datacatalog.worldbank.org/sites//default//files//dataset_resources/ddhfiles/public/ARG-CrowdsourcedPDCPilot02_final_obs_all_clean.csv"
  )
  expect_equal(get_resource_url(metadata_rs_dkan2), "")
  expect_equal(
    get_resource_url(metadata_rs_api),
    "https://datacatalog.worldbank.org/sites/default/files/dataset_resources/ddhfiles/public/AllPilotCountries(15)-CrowdsourcedPDCPilot02_final_obs_all_clean.zip"
  )
  expect_true(class(get_resource_url(metadata_rs_dkan)) == "character")
  expect_true(is.atomic(class(get_resource_url(metadata_rs_dkan))))

})

httptest::with_mock_api({
  dkanr_setup(url = "https://www.statistics.digitalresources.jisc.ac.uk/")
  metadata <- retrieve_node(nid = 2400, as = 'list')
  expect_equal(
    get_resource_url(metadata),
    "http://s3-eu-west-1.amazonaws.com/statistics.digitalresources.jisc.ac.uk/dkan/files/AGE_LANENG/AGE_LANENG_Database-FriendlyFormat.zip"
  )
})
