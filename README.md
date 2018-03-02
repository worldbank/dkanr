[![Travis-CI Build Status](https://travis-ci.org/tonyfujs/dkanr.svg?branch=master)](https://travis-ci.org/tonyfujs/dkanr)
[![AppVeyor Build Status](https://ci.appveyor.com/api/projects/status/github/tonyfujs/dkanr?branch=master&svg=true)](https://ci.appveyor.com/project/tonyfujs/dkanr)
[![Coverage status](https://codecov.io/gh/tonyfujs/dkanr/branch/master/graph/badge.svg)](https://codecov.io/github/tonyfujs/dkanr?branch=master)
[![CRAN status](https://www.r-pkg.org/badges/version/dkanr)](https://cran.r-project.org/package=dkanr)
[![Binder](http://mybinder.org/badge.svg)](https://mybinder.org/v2/gh/tonyfujs/dkanr/master)
[![Licence](https://img.shields.io/badge/licence-MIT+-lightgrey.svg)](http://choosealicense.com/)
[![Project Status: WIP – Initial development is in progress, but there has not yet been a stable, usable release suitable for the public.](http://www.repostatus.org/badges/latest/wip.svg)](http://www.repostatus.org/#wip)


# dkanr

## Overview

The `dkanr` package is an R client to the [DKAN REST API](https://dkan.readthedocs.io/en/latest/apis/rest-api.html). Through the DKAN REST API, `dkanr` accesses the available catalog while providing CRUD functionalities.

Some features of this package include:

* Uploading content
* Authorized access to catalog
* Updating data

## Installation

You may install the package directly from GitHub:
```r
devtools::install_github("tfujs/dkanr")
```

Once you have downloaded the package, select the package and load. 
```r
library(dkanr)
```

## Getting started with dkanr

To learn more about the features and functionalities of the package, view the Getting Started with dkanr [vignette](https://github.com/tonyfujs/dkanr/blob/master/vignettes/getting_started_with_dkanr.Rmd) for basic guidelines on how to use the package.

```r
browseVignettes(package = "dkanr")
```
