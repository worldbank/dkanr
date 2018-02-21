context("err_handler")

# Set up
dkanr_setup(url = 'https://datacatalog.worldbank.org/')

# start_capturing(path = './tests/testthat')
# retrieve_node(nid ='00000', as = 'list')
# stop_capturing()

with_mock_api({
  test_that("Errors from REST API are handled correctly", {
    expect_error(retrieve_node(nid ='00000', as = 'list'),
                 "[\"Node 00000 could not be found\"]")
  })
})
