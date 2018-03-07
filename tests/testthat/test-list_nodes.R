context("list_nodes")

# Set up
dkanr_setup(url = 'http://demo.getdkan.com/')

# start_capturing(path = './tests/testthat')
# list_nodes(as = 'df')
# stop_capturing()

httptest::with_mock_api({
  test_that("List nodes function is working as expected", {
    resp <- list_nodes(as = 'df')
    expect_is(resp, "data.frame")
    expect_equal(nrow(resp), 20)
  })

  test_that("JSON is returned by default", {
    resp <- list_nodes()
    expect_is(resp, "character")
  })
})
