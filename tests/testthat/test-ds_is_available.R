context("ds_is_available")

# Set up
dkanr_setup(url = 'https://datacatalog.worldbank.org/')

# start_capturing(path = './tests/testthat')
# retrieve_node(nid ='140366', as = 'list')
# stop_capturing()

httptest::with_mock_api({
  test_that("Datastore status correctly detected", {
    resp <- retrieve_node(nid ='140366', as = 'list')
    expect_true(ds_is_available(resp))
    resp$field_datastore_status$und[[1]]$value <- 0
    expect_false(ds_is_available(resp))

  })
})

httptest::with_mock_api({
  test_that("Bad input is correctly detected", {
    resp <- retrieve_node(nid ='140366', as = 'list')
    expect_true(is.list(resp))
    resp$type <- "dataset"
    expect_error(ds_is_available(resp),
                 'This node is not of type "resource". Resource links are only available in resource nodes')

  })
})
