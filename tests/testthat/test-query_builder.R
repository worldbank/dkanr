context("query_builder")

# Define constant values

# test filters_to_text_query
  test_that("Single filters are correctly built", {
    expect_equal(
      filters_to_text_query(filters = c(title = "U.S. Adult Smoking Rate")),
      "parameters[title]=U.S. Adult Smoking Rate")
  })

  test_that("Multiple filters are correctly built", {

  })



# test build_search_query
  test_that("Spaces are correctly handled", {
    expect_equal(
      build_search_query(fields = NULL,
                         filters = c(title = "U.S. Adult Smoking Rate"),
                         pagesize = NULL,
                         page = NULL),
      "parameters[title]=U.S.%20Adult%20Smoking%20Rate")
  })
