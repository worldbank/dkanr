context("test-as-dkan_list.R")

# start_capturing(path = './tests/testthat')
# res <- dkan_GET(url = "https://data.louisvilleky.gov", query = NULL)
# stop_capturing()

# set-up
dkanr_setup(url = 'https://data.louisvilleky.gov')

httptest::with_mock_api({
  test_that("dkan_list class functions work as expected", {
    res <- dkan_GET(url = "https://data.louisvilleky.gov", query = NULL)
    dk <- as_dk(jsl(res), "dkan_list")
    expect_equal(class(dk), "dkan_list")
    expect_true(is.dkan_list(dk))
  })
})

