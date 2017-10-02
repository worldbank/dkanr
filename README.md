# dkanr

## Overview

The `dkanr` package is an R client to the [DKAN REST API](https://dkan.readthedocs.io/en/latest/apis/rest-api.html). Through the DKAN REST API, `dkanr` accesses the available catalog while providing CRUD functionalities.

Some features of this package include:

* Uploading content
* Authorized access to catalog
* Updating data

## Installation

You may install the package directly from CRAN.
```r
install.packages("dkanr")
```

Or download directly it from GitHub to access the latest developmental version.
```r
install.packages("dkanr")
devtools::install_github("tfujs/dkanr")
```

Once you have downloaded the package, select the package and load. 
```r
library(dkanr)
```

## Vignettes

To learn more about the features and functionalities of the package, there are a few [vignettes](https://github.com/tonyfujs/dkanr/tree/master/vignettes) available to provide basic guidelines to the package.

``r
browseVignettes(package = "dkanr")
```
