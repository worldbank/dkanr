context("test-dkanr_settings.R")

# start_capturing(path = './tests/testthat')
# dkanr_setup(url = 'https://data.louisvilleky.gov/')
# stop_capturing()

httptest::with_mock_api({
  test_that("dkanr_settings functions work as expected", {
    temp <- dkanr_setup(url = 'https://data.louisvilleky.gov/')

    expect_true(temp)

    expect_equal(get_url(), "https://data.louisvilleky.gov/")
    expect_equal(get_cookie(), "")
    expect_equal(get_token(), "")

    expect_true(is.list(dkanr_settings()))
  })
})
