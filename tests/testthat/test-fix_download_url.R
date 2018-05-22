context("fix_download_url")

# Set up
dkanr_setup(url = 'https://datacatalog.worldbank.org/')
download_url <- "public:my_file.pdf"

test_that("URL is correctly fixed", {
  expect_equal(
    fix_download_url("public://my_file.pdf"),
    "https://datacatalog.worldbank.org//sites//default//files//my_file.pdf"
  )

  expect_equal(
    fix_download_url("https://datacatalog.worldbank.org//sites//default//files//my file with spaces.pdf"),
    "https://datacatalog.worldbank.org//sites//default//files//my%20file%20with%20spaces.pdf"
  )
})
