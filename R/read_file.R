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
#' @return json, list or dataframe
#' @export
#'
#' @examples
#' read_file(resource_id = '622875ae-76a5-4a9b-9859-a3f13001993c', fields = NULL, 
#'           filters = NULL, num_records = 108, root_url = 'https://newdatacatalogstg.worldbank.org/')

read_file <- function(resource_id = '10c578a6-63c4-40bd-a55d-0c27bf276283',
                      fields = c('Country','City','Region','Population'),
                      filters = list('Country'=c('co','my'), 'Region'=c('04','09','22')),
                      offset = 0,
                      num_records = 20,
                      limit = 100,
                      sort_by = c('Country'='asc'),
                      q = "puertica",
                      root_url = get_url(),
                      as = 'dataframe',
                      ...) {
  
  cookie = Sys.getenv("DKANR_COOKIE")
  token = Sys.getenv("DKANR_TOKEN")
  
  path = 'api/action/datastore/search.json'
  DKAN_PAGE_LIMIT = 100
  if(limit > DKAN_PAGE_LIMIT){
    limit = DKAN_PAGE_LIMIT
  }
  
  iterations <- ceiling(num_records / limit)
  out <- vector(mode = 'list', length = num_records)
  
  for (i in 1:iterations) {
    query <- build_read_query(resource_id,
                              fields,
                              filters,
                              offset,
                              limit,
                              sort_by,
                              q)
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
    
    offset <- offset + limit
  }

  df = do.call(rbind, out)
  return(df)

}
