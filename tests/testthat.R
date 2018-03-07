# Workaround https://github.com/hadley/testthat/issues/144
Sys.setenv(R_TESTS="")

library(testthat)
library(httptest)
library(dkanr)


test_check("dkanr")
