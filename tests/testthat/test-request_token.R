context("request_token")

# Set up
dkanr_setup(url = 'https://datacatalog.worldbank.org/')

# start_capturing(path = './tests/testthat')
# request_token(root_url = get_url(), cookie = "SSESSea72a4c978dd1670e2b2d8df72f13a23=eFbT3WYrttAtQnTvnaVoLZt-lEZFKryrSYD5PVVj7cI")
# stop_capturing()

httptest::with_mock_api({
  test_that("request token is working as expected", {
    resp <- request_token(root_url = get_url(),
                          cookie = "SSESSea72a4c978dd1670e2b2d8df72f13a23=eFbT3WYrttAtQnTvnaVoLZt-lEZFKryrSYD5PVVj7cI")
    expect_is(resp, "character")
    expect_equal(nchar(resp), 43)
  })
})
