context("connect_system")

# Set up
dkanr_setup(url = 'https://datacatalog.worldbank.org/')

# start_capturing(path = './tests/testthat')
# connect_system(root_url = get_url())
# stop_capturing()

httptest::with_mock_api({
  test_that("Connect system is working as expected", {
    resp <- connect_system(root_url = get_url())
    expect_is(resp, "character")
    expect_equal(nchar(resp), 43)
  })
})
