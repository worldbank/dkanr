context("dkan_REQUEST")

# Set up
dkanr_setup(url = 'https://datacatalog.worldbank.org/')

# start_capturing(path = './tests/testthat')
# dkan_REQUEST('GET', url = get_url(), nid ='140177', body = NULL)
# stop_capturing()

# Set up
dkanr_setup(url = 'https://datacatalog.worldbank.org/')

httptest::with_mock_api({
  test_that("JSON node is correctly returned", {
    metadata <- dkan_REQUEST('GET', url = get_url(), nid ='140177', body = NULL)
    expect_true(is.character(metadata))
  })
})

