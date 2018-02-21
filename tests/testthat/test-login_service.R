context("login_service")

# Set up
dkanr_setup(url = 'https://datacatalog.worldbank.org/')

# start_capturing(path = './tests/testthat')
# login_service(root_url = get_url(),
#               system_connect_sessid = "Ea9b4qskV0cAxyYTO9WOVTGdLlz66wXn2U7p10eiX6I",
#               username = Sys.getenv("ddh_username"),
#               password = Sys.getenv("ddh_prod_password"))
# stop_capturing()

httptest::with_mock_api({
  test_that("Login service is working as expected", {
    resp <- login_service(root_url = get_url(),
                          system_connect_sessid = "Ea9b4qskV0cAxyYTO9WOVTGdLlz66wXn2U7p10eiX6I",
                          username = Sys.getenv("ddh_username"),
                          password = Sys.getenv("ddh_prod_password"))
    expect_is(resp, "character")
    expect_equal(nchar(resp), 81)
    expect_equal(substr(resp, start = 38, stop = 38), "=")
  })
})
