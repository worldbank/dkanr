context("test-as-dkan_node.R")

# start_capturing(path = './tests/testthat')
# res <- dkan_GET(url = "https://data.louisvilleky.gov", nid = "8216")
# stop_capturing()

# set-updf
dkanr_setup(url = 'https://data.louisvilleky.gov')

httptest::with_mock_api({
  test_that("dkan_node class functions work as expected", {
    res <- dkan_GET(url = "https://data.louisvilleky.gov", nid = "8216")
    dk <- as_dk(jsl(res), "dkan_node")
    expect_equal(class(dk), "dkan_node")
    expect_true(is.dkan_node(dk))
  })
})
