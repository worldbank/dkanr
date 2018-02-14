context('build_ds_search_query')

resource_id <- '10c578a6-63c4-40bd-a55d-0c27bf276283'

test_that("single field works", {
  expect_equal(build_ds_search_query(resource_id = resource_id, fields = 'Country'),
               "resource_id=10c578a6-63c4-40bd-a55d-0c27bf276283&fields=Country")
})

test_that("multiple fields work", {
  expect_equal(build_ds_search_query(resource_id = resource_id, fields = c('Country', 'City', 'Population')),
               "resource_id=10c578a6-63c4-40bd-a55d-0c27bf276283&fields=Country,City,Population")
})

test_that("single filter works", {
  expect_equal(build_ds_search_query(resource_id = resource_id, filters = list('Country'=c('co','my'))),
               "resource_id=10c578a6-63c4-40bd-a55d-0c27bf276283&filters[Country]=co,my")
})

test_that("multiple filters work", {
  expect_equal(build_ds_search_query(resource_id = resource_id, filters = list('Country'=c('co','my'), 'Region'=c('04','09','22'))),
               "resource_id=10c578a6-63c4-40bd-a55d-0c27bf276283&filters[Country]=co,my&filters[Region]=04,09,22")
})

test_that("single sort works", {
  expect_equal(build_ds_search_query(resource_id = resource_id, sort_by = c('Country'='asc')),
               "resource_id=10c578a6-63c4-40bd-a55d-0c27bf276283&sort[Country]=asc")
})

test_that("multiple sorts work", {
  expect_equal(build_ds_search_query(resource_id = resource_id, sort_by = c('Country'='asc','Region'='desc')),
               "resource_id=10c578a6-63c4-40bd-a55d-0c27bf276283&sort[Country]=asc&sort[Region]=desc")
})

test_that("text search works", {
  expect_equal(build_ds_search_query(resource_id = resource_id, q="puertica"),
               "resource_id=10c578a6-63c4-40bd-a55d-0c27bf276283&query=puertica")
})

test_that("combination of fields, filters, sort and query work", {
  expect_equal(build_ds_search_query(resource_id = resource_id,
                                     fields = c('Country', 'City', 'Region'),
                                     filters = list('Country'=c('co','my'), 'Region'=c('04','09','22')),
                                     sort_by = c('Country'='asc','Region'='desc'),
                                     q="puertica"),
               "resource_id=10c578a6-63c4-40bd-a55d-0c27bf276283&fields=Country,City,Region&filters[Country]=co,my&filters[Region]=04,09,22&sort[Country]=asc&sort[Region]=desc&query=puertica")
})
