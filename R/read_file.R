#' read_file
#'
#' Reads the file associated with a given resource id.
#'
#' @param resource_id character: DKAN resource ID
#' @param fields character vector: fields to be returned by the request
#' @param filters named character vector: filters to be applied when retrieving records
#' @param max_records numeric: Number of records to retrieve
#' @param credentials list: API authentication credentials
#' @param url character: The DKAN site URL
#'
#' @return dataframe
#' @export
#'
#' @examples
#' retrieve_node(nid = 1, url = "http://demo.getdkan.com")

read_file <- function(resource_id = '10c578a6-63c4-40bd-a55d-0c27bf276283',
                      fields = c('Country','City','Region','Population'),
                      filters = list('Country'=c('co','my'), 'Region'=c('04','09','22')),
                      num_records = 20,
                      root_url = production_root_url,
                      ...) {
  
  cookie = Sys.getenv("DKANR_COOKIE")
  token = Sys.getenv("DKANR_TOKEN")
  
  path = 'api/action/datastore/search.json'
  DKAN_PAGE_LIMIT = 100
  offset = 0
  
  iterations <- ceiling(num_records / DKAN_PAGE_LIMIT)
  out <- vector(mode = 'list', length = num_records)
  
  for (i in 1:iterations) {
    query <- build_read_query(resource_id,
                              fields,
                              filters,
                              offset)
    url <- httr::modify_url(root_url, path = path, query = query)
    # execute the query
    res <- httr::GET(url = url,
                     httr::add_headers(.headers = c('Content-Type' = 'application/json',
                                                    'charset' = 'utf-8',
                                                    'Cookie' =  cookie,
                                                    'X-CSRF-Token' = token)),
                     encode = 'json')
    records = httr::content(res)$result$records
    index <- (1 + offset):(offset + length(records))
    out[index] <- purrr::map(records, function(x) x)
    
    offset <- offset + DKAN_PAGE_LIMIT
  }

  for(field in fields) {
    
  }

  df = do.call(rbind, out)
  return(df)

}
