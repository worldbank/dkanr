context("test-update_node.R")

# Set up
# dkanr_setup(url = 'https://newdatacatalogstg.worldbank.org/',
#             username = Sys.getenv("ddh_username"),
#             password = Sys.getenv("ddh_stg_password"))
dkanr_setup(url = 'https://newdatacatalogstg.worldbank.org/')

meta <- list()
meta$title <- jsonlite::unbox("NEW title")
meta <- jsonlite::toJSON(meta, pretty = TRUE)

node_id <- 126571

# start_capturing(path = './tests/testthat')
# update_node(nid = node_id, body = meta)
# stop_capturing()


httptest::with_mock_api({
  test_that("Node is correctly created and returned", {
    resp <- update_node(nid = node_id, body = meta, as = "json")
    expect_is(resp, "character")
    resp <- update_node(nid = node_id, body = meta, as = "list")
    expect_true(is.list(resp))
  })

  test_that("JSON is returned by default", {
    resp <- update_node(nid = node_id, body = meta)
    expect_is(resp, "character")
  })
})
