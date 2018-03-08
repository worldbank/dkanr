context("test-attach_file_to_node.R")

# Set up
# dkanr_setup(url = 'https://newdatacatalogstg.worldbank.org/',
#             username = Sys.getenv("ddh_username"),
#             password = Sys.getenv("ddh_stg_password"))
dkanr_setup(url = 'https://newdatacatalogstg.worldbank.org/')

node_id <- 126574

# start_capturing(path = './tests/testthat')
# setwd('./tests/testthat')
# attach_file_to_node(nid = node_id, file_path = 'test_file.csv')
# setwd('../..')
# stop_capturing()


# httptest::with_mock_api({
#  test_that("File is correctly attached and node is returned", {
#    resp <- attach_file_to_node(nid = node_id, file_path = "test_file.csv")
#    expect_is(resp, "character")
#  })
# })

test_that("Incorrect paths are correctly handled", {
  expect_error(attach_file_to_node(nid = node_id,
                                   file_path = "incorrect/path/file.csv"),
               regexp = "file.exists(path)*")
})

