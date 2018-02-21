# context("ds_search_all")
#
# # Set up
# dkanr_setup(url = 'https://datacatalog.worldbank.org/')
#
# # start_capturing(path = './tests/testthat')
# # ds_search_all(resource_id = "e9362e88-33ef-4435-9c22-ec857684e425")
# # stop_capturing()
#
# httptest::with_mock_api({
#   test_that("Data is correctly retrieved from the datastore", {
#     resp <- ds_search_all(resource_id = "e9362e88-33ef-4435-9c22-ec857684e425")
#     expect_is(resp, "list")
#     expect_equal(length(resp), 100)
#   })
# })
