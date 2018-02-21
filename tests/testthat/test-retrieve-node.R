context("test-retrieve-node.R")

# start_capturing(path = './tests/testthat')
# retrieve_node(nid ='140177', as = 'list')
# stop_capturing()

# Set up
dkanr_setup(url = 'https://datacatalog.worldbank.org/')
keys <- c("title", "status", "type", "uuid", "created", "changed", "body")

with_mock_api({
  test_that("JSON node is correctly returned", {
    metadata <- retrieve_node(nid ='140177', as = 'list')
    expect_true(is.list(metadata))
    expect_true(all(keys %in% names(metadata)))
  })
})
