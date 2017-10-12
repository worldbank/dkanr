#' ds_search
#'
#' Search csv resource file stored in the datastore.
#'
#' @param resource_id character: DKAN resource ID
#' @param fields character vector: fields to be returned by the request
#' @param filters named character vector: filters to be applied when retrieving records
#' @param num_records numeric: Number of records to retrieve
#' @param offset numeric: Number of results to skip in the beginning
#' @param limit numeric: Number of results to retrieve per page
#' @param sort_by named character vector: field to be sorted by and the order of sorting
#' @param q character: full text query filter
#' @param url character: The DKAN site URL
#' @param as character: output format - json or df
#'
#' @return data.frame or character
#' @export
#'
#' @examples
#' ds_search(resource_id = '10c578a6-63c4-40bd-a55d-0c27bf276283',
#           fields = c('Country','City','Region','Population'),
#           filters = list('Country'=c('co','my'), 'Region'=c('04','09','22')),
#           num_records = 20,
#           offset = 0,
#           limit = 100,
#           sort_by = c('Country'='asc'),
#           q = "puertica",
#           url = get_url(),
#           as = 'df')

ds_search <- function(resource_id = '10c578a6-63c4-40bd-a55d-0c27bf276283',
                      fields = NULL,
                      filters = NULL,
                      num_records = NULL,
                      offset = 0,
                      sort_by = NULL,
                      q = NULL,
                      url = get_url(),
                      credentials = list(cookie = dkanr::get_cookie(), token = dkanr::get_token()),
                      as = 'df') {
  # authentication
  cookie = credentials$cookie
  token = credentials$token

  # DKAN settings
  path = 'api/action/datastore/search.json'
  DKAN_PAGE_LIMIT = 100

  # get the total number of records if user has not specified num_records
  if(is.null(num_records)) {
    query <- build_ds_search_query(resource_id, fields, filters, sort_by, q)
    query <- paste0(query, '&offset=', offset)
    url <- httr::modify_url(url, path = path, query = query)
    res <- httr::GET(url = url,
                     httr::add_headers(.headers = c('Content-Type' = 'application/json',
                                                    'charset' = 'utf-8',
                                                    'Cookie' =  cookie,
                                                    'X-CSRF-Token' = token)),
                     encode = 'json')
    ds_err_handler(res)
    num_records <- as.numeric(httr::content(res)$result$total)
  }

  # get the data
  iterations <- ceiling(num_records / DKAN_PAGE_LIMIT)
  out <- vector(mode = 'list', length = num_records)
  num_records_covered = 0

  # build the url
  query <- build_ds_search_query(resource_id, fields, filters, sort_by, q)

  for (i in 1:iterations) {
    # reset the limit based on number of records left
    limit <- min(num_records-num_records_covered, DKAN_PAGE_LIMIT)
    query <- paste0(query, '&offset=', offset)
    query <- paste0(query, '&limit=', limit)
    url <- httr::modify_url(url, path = path, query = query)
    # execute the query
    res <- httr::GET(url = url,
                     httr::add_headers(.headers = c('Content-Type' = 'application/json',
                                                    'charset' = 'utf-8',
                                                    'Cookie' =  cookie,
                                                    'X-CSRF-Token' = token)),
                     encode = 'json')
    err_handler(res)
    records = httr::content(res)$result$records
    index <- (1 + offset):(offset + length(records))
    out[index] <- purrr::map(records, function(x) x)
    offset <- offset + limit
    num_records_covered <- num_records_covered + limit
  }

  # return the data in specified format
  switch(as, json = as.character(jsonlite::toJSON(out)), df = dplyr::bind_rows(out))
}
