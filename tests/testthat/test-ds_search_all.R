context("ds_search_all")

# Set up
dkanr_setup(url = "https://data.louisvilleky.gov")

# start_capturing(path = "./tests/testthat")
# ds_search_all(resource_id = "65c4458b-1804-4bf2-b647-b2744648f647", as = "list")
# stop_capturing()


httptest::with_mock_api({
  test_that("ds_search_all returns list when as = 'list'", {
    resp <- ds_search_all(resource_id = "65c4458b-1804-4bf2-b647-b2744648f647",
                          as = "list")
    expect_true(is.list(resp))
  })

    test_that("ds_search_all returns character when as = 'json'", {
      resp <- ds_search_all(resource_id = "65c4458b-1804-4bf2-b647-b2744648f647",
                            as = "json")
      expect_true(class(resp) == "character")
    })

  test_that("data.frame is returned by default", {
    resp <- ds_search_all(resource_id = "65c4458b-1804-4bf2-b647-b2744648f647")
    expect_is(resp, "data.frame")
  })
})
