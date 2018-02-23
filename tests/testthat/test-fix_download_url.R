context("fix_download_url")

# Set up
dkanr_setup(url = 'https://datacatalog.worldbank.org/')
download_url <- "public:my_file.pdf"

test_that("URL is correctly fixed", {
  expect_equal(
    fix_download_url(download_url),
    "https://datacatalog.worldbank.org//sites//default//filesmy_file.pdf"
  )
})
