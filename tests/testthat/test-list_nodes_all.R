context("list_nodes_all")

# Set up
dkanr_setup(url = 'http://demo.getdkan.com/')

# start_capturing(path = './tests/testthat')
# list_nodes_all(as = 'df')
# stop_capturing()

httptest::with_mock_api({
  test_that("List all nodes function is working as expected", {
    resp <- list_nodes_all(as = 'df')
    expect_is(resp, "data.frame")
    expect_equal(nrow(resp), 40)
    resp <- list_nodes_all(as = 'list')
    expect_true(is.list(resp))
  })

  test_that("data.frame is returned by default", {
    resp <- list_nodes_all()
    expect_is(resp, "data.frame")
  })
})
