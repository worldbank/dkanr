---
title: "Getting started with dkanr - retrieving information"
date: "2018-02-20"
output: 
 rmarkdown::html_document:
    toc: true
    keep_md: yes
 rmarkdown::md_document:
    toc: true
    variant: markdown_github
vignette: >
  %\VignetteIndexEntry{Introduction to dkanr}
  %\VignetteEncoding{UTF-8}
  %\VignetteEngine{knitr::rmarkdown}
---

## Introduction to dkanr

The `dkanr` package is an R client to the [DKAN REST API](https://dkan.readthedocs.io/en/latest/apis/rest-api.html). Through the DKAN REST API, `dkanr` accesses the available catalog while providing CRUD functionalities.

This brief introduction shows you how to:

* Locate a dataset
* Access its metadata
* Download a .csv file of the data


## Setting Up Your Connection

### Connection without authentication

To set-up a connection without authentication, you just need the site URL. 


```r
library(purrr)
library(dkanr)
library(dplyr)
dkanr_setup(url = 'https://datacatalog.worldbank.org/')
```

### Authenticated connection
If authentication is required, you will also need to specify your username and password.


```r
dkanr_setup(url = 'http://demo.getdkan.com',
            username = 'my_username',
            password = 'my_password')
```

You can verify that you are successfully connected by printing your connection information.


```r
dkanr_settings()
```

```
## <dkanr settings>
##   Base URL:  https://datacatalog.worldbank.org/ 
##   Cookie:  
##   Token:
```

## STEP 1: List all available datasets with `list_all_nodes()`

While exploring the offerings of the catalog, you can retrieve all the available datasets with a simple query.

```r
resp <- list_all_nodes(filters = c(type = 'dataset'), as = 'df')
resp %>%
  select(nid, title, uri, type) %>%
  head(n = 10)
```

```
## # A tibble: 10 x 4
##    nid    title                           uri                        type 
##    <chr>  <chr>                           <chr>                      <chr>
##  1 140493 Nicaragua - Enterprise Survey ~ https://datacatalog.world~ data~
##  2 140492 Bolivia - Enterprise Survey 20~ https://datacatalog.world~ data~
##  3 140491 Ecuador - Enterprise Survey 20~ https://datacatalog.world~ data~
##  4 140490 Honduras - Enterprise Survey 2~ https://datacatalog.world~ data~
##  5 140489 Ecuador - Enterprise Survey 20~ https://datacatalog.world~ data~
##  6 140450 India - National Family Health~ https://datacatalog.world~ data~
##  7 140442 Ethiopia - Women Agribusiness ~ https://datacatalog.world~ data~
##  8 140359 World - Global Financial Inclu~ https://datacatalog.world~ data~
##  9 140353 Congo, Rep. - Skills Developme~ https://datacatalog.world~ data~
## 10 140324 Ukraine - Household Living Con~ https://datacatalog.world~ data~
```

## STEP 2: Access metadata for a specific dataset node

Say we are interested in the following dataset: "Crowdsourced Price Data Collection Pilot". The metadata for this node can be retrieved as follows: 
1. Identify the dataset node ID
2. Use the node ID to retrieve the dataset metadata

### Identify the dataset node ID  


```r
resp %>%
  filter(title == 'Crowdsourced Price Data Collection Pilot') %>%
  select(nid, title, uri, type)
```

```
## # A tibble: 1 x 4
##   nid    title                                    uri                type 
##   <chr>  <chr>                                    <chr>              <chr>
## 1 140177 Crowdsourced Price Data Collection Pilot https://datacatal~ data~
```

### Use the node ID to retrieve the dataset metadata  


```r
metadata <- retrieve_node(nid ='140177', as = 'list')
metadata
```

```
## <DKAN Node> #140177 
##   Type: dataset
##   Title: Crowdsourced Price Data Collection Pilot
##   UUID: f374e519-6710-45ab-82fd-e5bb9efe35a8
##   Created/Modified: 1512685256 / 1517266177
```


```r
# All metadata fields
names(metadata)[1:30]
```

```
##  [1] "vid"                       "uid"                      
##  [3] "title"                     "log"                      
##  [5] "status"                    "comment"                  
##  [7] "promote"                   "sticky"                   
##  [9] "vuuid"                     "nid"                      
## [11] "type"                      "language"                 
## [13] "created"                   "changed"                  
## [15] "tnid"                      "translate"                
## [17] "uuid"                      "revision_timestamp"       
## [19] "revision_uid"              "body"                     
## [21] "field_additional_info"     "field_author"             
## [23] "field_contact_name"        "field_data_dictionary"    
## [25] "field_frequency"           "field_granularity"        
## [27] "field_license"             "field_public_access_level"
## [29] "field_related_content"     "field_resources"
```




```r
# Access specific metadata fields
metadata$title
```

```
## [1] "Crowdsourced Price Data Collection Pilot"
```

## STEP 3: Access data for a specific resource node
Retrieving data file attached your dataset follows a similar logic:
1. Identify the resource node IDs
2. Use the resource node IDs to access metadata and URLs

### Retrieve the resource Node IDs

17 resources are attached to this dataset


```r
get_resource_nids(metadata)
```

```
##  [1] "140366" "140367" "140368" "140369" "140370" "140371" "140372"
##  [8] "140385" "140388" "140389" "140396" "140397" "140399" "140400"
## [15] "140413" "140417" "140420"
```

### Use the resource node ID to retrieve its metadata  


```r
metadata_rs <- retrieve_node(nid ='140366', as = 'list')
metadata_rs
```

```
## <DKAN Node> #140366 
##   Type: resource
##   Title: Argentina Crowdsourced Price Data
##   UUID: e9362e88-33ef-4435-9c22-ec857684e425
##   Created/Modified: 1516734237 / 1517266177
```



```r
# All metadata fields
names(metadata_rs)[1:30]
```

```
##  [1] "vid"                       "uid"                      
##  [3] "title"                     "log"                      
##  [5] "status"                    "comment"                  
##  [7] "promote"                   "sticky"                   
##  [9] "vuuid"                     "nid"                      
## [11] "type"                      "language"                 
## [13] "created"                   "changed"                  
## [15] "tnid"                      "translate"                
## [17] "uuid"                      "revision_timestamp"       
## [19] "revision_uid"              "field_datastore_status"   
## [21] "body"                      "field_dataset_ref"        
## [23] "field_format"              "field_link_api"           
## [25] "field_link_remote_file"    "field_upload"             
## [27] "og_group_ref"              "field_wbddh_api_format"   
## [29] "field_wbddh_data_class"    "field_wbddh_resource_type"
```

### Retrieve the resource URL from the resource metadata


```r
get_resource_url(metadata_rs)
```

```
## [1] "https://datacatalog.worldbank.org//sites//default//files//dataset_resources/ddhfiles/public/ARG-CrowdsourcedPDCPilot02_final_obs_all_clean.csv"
```


## Querying data
Some data files may be directly queried through the API. Only data files that have been imported into the DKAN datastore can be queried through the API. 

### Check if a data file is available on the DKAN datastore


```r
ds_is_available(metadata_rs)
```

```
## [1] TRUE
```

### Retrieve data from the datastore via the API


```r
ds_search_all(resource_id = metadata_rs$uuid, as = 'df') %>%
  select(item_name, item_code, price)
```


```
## # A tibble: 100 x 3
##    item_name                                          item_code price
##    <chr>                                              <chr>     <chr>
##  1 Men's haircut, barber shop                         111211101 50   
##  2 Sardines, tinned, with skin, in vegetable oil, WKB 110113201 29.3 
##  3 Broken rice, 25%, BNR                              110111106 12.49
##  4 Men's shirt, WKB-M                                 110312103 349  
##  5 Vacuum cleaner, WKB-M                              110531111 1799 
##  6 "Instant coffee, NESCAFE Classic "                 110121102 112  
##  7 Petrol, Superplus                                  110722103 19.99
##  8 Football (soccer ball), WKB                        110931110 499  
##  9 Men's haircut, barber shop                         111211101 70   
## 10 Bath towel, large, WKB                             110521103 171  
## # ... with 90 more rows
```
