context("dkanr_logout")

# Set up
dkanr_setup(url = 'https://datacatalog.worldbank.org/')
credentials <- list(cookie = "SSESSea72a4c978dd1670e2b2d8df72f13a23=eFbT3WYrttAtQnTvnaVoLZt-lEZFKryrSYD5PVVj7cI",
                    token = "ePn5xx1_nN-qPbvO5W6FclEyVuuoIlaZkldfcKfcTlA")

# start_capturing(path = './tests/testthat')
# dkanr_logout(url = get_url(), credentials = credentials)
# stop_capturing()

httptest::with_mock_api({
  test_that("Logout is working as expected", {
    resp <- dkanr_logout(url = get_url(), credentials = credentials)
    expect_is(resp[[1]], "logical")
    expect_true(resp[[1]])
  })
})
