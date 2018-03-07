context("test-retrieve-node.R")

# start_capturing(path = './tests/testthat')
# retrieve_node(nid ='140177', as = 'list')
# stop_capturing()

# Set up
dkanr_setup(url = 'https://datacatalog.worldbank.org/')
keys <- c("title", "status", "type", "uuid", "created", "changed", "body")

httptest::with_mock_api({
  test_that("JSON node is correctly returned", {
    resp <- retrieve_node(nid ='140177', as = 'list')
    expect_true(is.list(resp))
    expect_true(all(keys %in% names(resp)))
  })

  test_that("JSON is returned by default", {
    resp <- retrieve_node(nid ='140177')
    expect_is(resp, "character")
  })
})
