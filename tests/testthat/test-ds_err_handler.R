context("test-ds_err_handler.R")

# Set up
dkanr_setup(url = 'https://data.louisvilleky.gov')

# start_capturing(path = './tests/testthat')
# ds_search(resource_id = "0000")
# stop_capturing()

httptest::with_mock_api({
  test_that("Errors from datastore API are handled correctly", {
    expect_error(ds_search(resource_id = "0000"),
                 regexp = "*503 - Service Unavailable (HTTP 503)*")
  })
})
