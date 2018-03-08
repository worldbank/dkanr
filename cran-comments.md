## Test environments
* local OS X install, R 3.4.3
* ubuntu 14.04 (on travis-ci), R 3.4.3
* Rhub
  * Windows Server 2008 R2 SP1, R-devel, 32/64 bit
  * Ubuntu Linux 16.04 LTS, R-release, GCC
  * Debian Linux, R-devel, GCC ASAN/UBSAN

## R CMD check results

There were no ERRORs or WARNINGs. 

There was 1 NOTE:

* checking for portable file names ... NOTE
Found the following non-portable file paths:
dkanr/tests/testthat/newdatacatalogstg.worldbank.org/api/dataset/node/126574/attach_file-552d9f-POST.json
... 152 lines ...
dkanr/tests/testthat/tests/testthat/newdatacatalogstg.worldbank.org/api/dataset/node/126574/attach_file-552d9f-POST.json

These files are used for unit testing functions that make API calls.

* This is a new release.
