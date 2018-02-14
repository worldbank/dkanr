context("test-ds_search_all.R")

test_that("correct number of records retrieved", {
  fields = c('Country','City','Region','Population')
  expect_equal(colnames(ds_search_all(resource_id = '10c578a6-63c4-40bd-a55d-0c27bf276283',
                                      fields = fields)), fields)
  expect_equal(nrow(ds_search_all(resource_id = '10c578a6-63c4-40bd-a55d-0c27bf276283', num_records = 45)), 45)
})
