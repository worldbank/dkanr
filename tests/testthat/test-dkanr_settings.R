context("test-dkanr_settings.R")

# start_capturing(path = './tests/testthat')
# dkanr_setup(url = 'https://data.louisvilleky.gov/')
# stop_capturing()

httptest::with_mock_api({
  test_that("dkanr_settings functions work as expected", {
    dkanr_setup(url = 'https://data.louisvilleky.gov/')

    expect_equal(get_url(), "https://data.louisvilleky.gov/")
    # expect_equal(get_cookie(), "SSESSea72a4c978dd1670e2b2d8df72f13a23=mEJC8EiseCDIjWzfkuFCszFQqPnyfDadUfgMuSmtwro")
    # expect_equal(get_token(), "pc6cosYE12tR4hW-8WspXiNzm1yH1igFMhV2lNU4Zm4")

    expect_true(is.list(dkanr_settings()))
  })
})
