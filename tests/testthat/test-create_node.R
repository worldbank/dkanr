context("test-create_node.R")

# Set up
# dkanr_setup(url = 'https://newdatacatalogstg.worldbank.org/',
#             username = Sys.getenv("ddh_username"),
#             password = Sys.getenv("ddh_stg_password"))
dkanr_setup(url = 'https://newdatacatalogstg.worldbank.org/')

# meta <- jsonlite::read_json('tests/testthat/metadata.json', simplifyVector = FALSE)
meta <- jsonlite::read_json('metadata.json', simplifyVector = FALSE)
meta$title <- jsonlite::unbox(meta$title)
meta$type <- jsonlite::unbox(meta$type)
meta$body$und[[1]]$value <- jsonlite::unbox(meta$body$und[[1]]$value)
meta$field_wbddh_acronym$und[[1]]$value <- jsonlite::unbox(meta$field_wbddh_acronym$und[[1]]$value)
meta <- jsonlite::toJSON(meta, pretty = TRUE)

# start_capturing(path = './tests/testthat')
# create_node(body = meta)
# stop_capturing()


httptest::with_mock_api({
  test_that("Node is correctly created and returned", {
    resp <- create_node(body = meta, as = "json")
    expect_is(resp, "character")
    resp <- create_node(body = meta, as = "list")
    expect_true(is.list(resp))
  })

  test_that("JSON is returned by default", {
    resp <- create_node(body = meta)
    expect_is(resp, "character")
  })
})
