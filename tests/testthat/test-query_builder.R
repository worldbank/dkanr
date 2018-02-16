context("query_builder")

# Define constant values
demo_url <- "http://demo.getdkan.com/"
node_title <- "U.S. Adult Smoking Rate"
node_type <- "resource"
node_lang <- "und"
node_field <- c("nid")
node_fields <- c("nid", "uri", "type")
node_page <- 1
node_pagesize <- 10

# Test filters_to_text_query
test_that("Single filters are correctly built", {
  expect_equal(
    filters_to_text_query(
      filters = c(title = node_title),
      text = "parameters"
    ),
    "parameters[title]=U.S. Adult Smoking Rate"
  )
})


test_that("Multiple filters are correctly built", {
  expect_equal(
    filters_to_text_query(
      filters = c(
        title = node_title,
        type = node_type,
        language = node_lang
      ),
      text = "parameters"
    ),
    "parameters[title]=U.S. Adult Smoking Rate&parameters[type]=resource&parameters[language]=und"
  )
})

# this string seems to be building fine, hasn't broken yet
test_that("Numeric titles can pass", {
  expect_equal(
    filters_to_text_query(
      filters = c(title = 12301230),
      text = "parameters"
    ),
    "parameters[title]=12301230"
  )
})

test_that("Parameters with empty strings", {
  expect_equal(
    filters_to_text_query(
      filters = c(title = ""),
      text = "parameters"
    ),
    "parameters[title]="
  )
})


# Test build_search_query
test_that("Spaces are correctly handled", {
  expect_equal(
    build_search_query(
      fields = NULL,
      filters = c(title = node_title),
      pagesize = NULL,
      page = NULL
    ),
    "parameters[title]=U.S.%20Adult%20Smoking%20Rate"
  )
})

test_that("Single fields are correctly built", {
  expect_equal(
    build_search_query(
      fields = node_field,
      filters = NULL,
      pagesize = NULL,
      page = NULL
    ),
    "fields=nid"
  )
})

test_that("Multiple fields are correctly built", {
  expect_equal(
    build_search_query(
      fields = node_fields,
      filters = NULL,
      pagesize = NULL,
      page = NULL
    ),
    "fields=nid,uri,type"
  )
})

test_that("Single field & single filter are correctly built", {
  expect_equal(
    build_search_query(
      fields = node_field,
      filters = c(title = node_title),
      pagesize = NULL,
      page = NULL
    ),
    "fields=nid&parameters[title]=U.S.%20Adult%20Smoking%20Rate"
  )
})

test_that("Multiple fields & multiple filters are correctly built", {
  expect_equal(
    build_search_query(
      fields = node_fields,
      filters = c(
        title = node_title,
        type = node_type,
        language = node_lang
      ),
      pagesize = NULL,
      page = NULL
    ),
    "fields=nid,uri,type&parameters[title]=U.S.%20Adult%20Smoking%20Rate&parameters[type]=resource&parameters[language]=und"
  )
})

test_that("Page size is built correctly", {
  expect_equal(
    build_search_query(
      fields = NULL,
      filters = NULL,
      pagesize = node_pagesize,
      page = NULL
    ),
    "pagesize=10"
  )
})

test_that("Page size is built correctly", {
  expect_equal(
    build_search_query(
      fields = NULL,
      filters = NULL,
      pagesize = NULL,
      page = node_page
    ),
    "page=1"
  )
})

test_that("All parameters combined build correctly", {
  expect_equal(
    build_search_query(
      fields = node_fields,
      filters = c(
        title = node_title,
        type = node_type,
        language = node_lang
      ),
      pagesize = node_pagesize,
      page = node_page
    ),
    "fields=nid,uri,type&parameters[title]=U.S.%20Adult%20Smoking%20Rate&parameters[type]=resource&parameters[language]=und&pagesize=10&page=1"
  )
})

# test for different types
test_that("Integer parameters can pass strings as well", {
  expect_equal(
    build_search_query(
      fields = NULL,
      filters = NULL,
      pagesize = "10",
      page = "1"
    ),
    "pagesize=10&page=1"
  )
})

# special characters
test_that("Parameter can build properly with special characters", {
  expect_equal(
    build_search_query(
      fields = node_fields,
      filters = c(
        title = "??????????",
        type = node_type,
        language = node_lang
      ),
      pagesize = node_pagesize,
      page = node_page
    ),
    "fields=nid,uri,type&parameters[title]=??????????&parameters[type]=resource&parameters[language]=und&pagesize=10&page=1"
  )
})

# empty string
test_that("Empty string for parameters", {
  expect_equal(
    build_search_query(
      fields = "",
      filters = "",
      pagesize = node_pagesize,
      page = node_page
    ),
    "fields=&pagesize=10&page=1"
  )
})

# tailing/leading white space
#  test_that('Leading, tailing, double white space is removed', {
#    expect_equal(
#      build_search_query(fields = node_fields,
#                         filters = c(title = ' Florida  Bike Lanes '),
#                         pagesize = node_pagesize,
#                         page = node_page),
#     'fields=nid,uri,type&parameters[title]=Florida%20Bike%20Lanes&pagesize=10&page=1')
# })

# NULLs as arg
test_that("Empty string for parameters are built correctly", {
  expect_equal(
    build_search_query(
      fields = NULL,
      filters = NULL,
      pagesize = node_pagesize,
      page = node_page
    ),
    "pagesize=10&page=1"
  )
})

test_that("Empty string for parameters", {
  expect_equal(
    build_search_query(
      fields = node_fields,
      filters = NULL,
      pagesize = NULL,
      page = NULL
    ),
    "fields=nid,uri,type"
  )
})

# formal argument "filters" matched by multiple actual arguments
#  test_that('Repeat parameters is not building correctly.', {
#    expect_equal(
#      build_search_query(fields = node_fields,
#                         filters = c(title = ' Florida  Bike Lanes '),
#                         filters = c(title = ' Florida  Bike Path '),
#                         pagesize = node_pagesize,
#                         page = node_page),
#      'error$message')
#  })

# need to include this functionality?
#  test_that('Ampersands in strings are replaced correctly', {
#    expect_equal(
#      build_search_query(fields = node_fields,
#                        filters = c(title = "World Bank Projects & Operations"),
#                            pagesize = node_pagesize,
#                            page = node_page),
#      "fields=nid,uri,type&parameters[title]=World%20Bank%20Projects%20&amp%20Operations&pagesize=10&page=1")
#  })
