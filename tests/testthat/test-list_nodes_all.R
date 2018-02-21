context("list_nodes_all")

# Set up
dkanr_setup(url = 'http://demo.getdkan.com/')

# start_capturing(path = './tests/testthat')
# list_all_nodes(as = 'df')
# stop_capturing()

with_mock_api({
  test_that("List all nodes function is working as expected", {
    resp <- list_all_nodes(as = 'df')
    expect_is(resp, "data.frame")
    expect_equal(nrow(resp), 40)
  })
})
