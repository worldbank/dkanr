#' ds_search_all
#'
#' Search csv resource file stored in the datastore.
#'
#' @param resource_id character: DKAN resource ID
#' @param fields character vector: fields to be returned by the request
#' @param filters named character vector: filters to be applied when retrieving records
#' @param num_records numeric: Number of records to retrieve
#' @param offset numeric: Number of results to skip in the beginning
#' @param sort named character vector: field to be sorted by and the order of sorting
#' @param q character: full text query filter
#' @param url character: The DKAN site URL
#' @param credentials Optional list parameter. Default values are Cookie and Token generated by dkan_setup()
#' @param as character: output format - json, list or data frame
#'
#' @return character, list, or data frame
#' @export
#'
#' @examples
#' \dontrun{
#' ds_search_all(resource_id = '10c578a6-63c4-40bd-a55d-0c27bf276283',
#'           fields = c('Country','City','Region','Population'),
#'           filters = list('Country'=c('co','my'), 'Region'=c('04','09','22')),
#'           num_records = 20,
#'           offset = 0,
#'           limit = 100,
#'           sort = c('Country'='asc'),
#'           q = "puertica",
#'           url = get_url(),
#'           as = 'df')
#' }

ds_search_all <- function(resource_id,
                          fields = NULL,
                          filters = NULL,
                          num_records = NULL,
                          offset = 0,
                          sort = NULL,
                          q = NULL,
                          url = get_url(),
                          credentials = list(cookie = dkanr::get_cookie(),
                                             token = dkanr::get_token()),
                          as = "df") {
  # authentication
  cookie <- credentials$cookie
  token <- credentials$token

  # DKAN settings
  path <- "api/action/datastore/search.json"
  DKAN_PAGE_LIMIT <- 100

  # get the total number of records if user has not specified num_records
  if (is.null(num_records)) {
    query <- build_ds_search_query(resource_id, fields, filters, sort, q, offset, limit = DKAN_PAGE_LIMIT)
    url <- httr::modify_url(url, path = path, query = query)
    res <- httr::GET(
      url = url,
      httr::add_headers(.headers = c(
        "Content-Type" = "application/json",
        "charset" = "utf-8",
        "Cookie" = cookie,
        "X-CSRF-Token" = token
      )),
      encode = "json"
    )
    ds_err_handler(res)
    num_records <- as.numeric(httr::content(res)$result$total)
  }

  # number of iterations required
  iterations <- ceiling(num_records / DKAN_PAGE_LIMIT)
  out <- vector(mode = "list", length = num_records)
  num_records_remaining <- num_records

  for (i in 1:iterations) {
    limit <- min(num_records_remaining, DKAN_PAGE_LIMIT)
    records <- ds_search(
      resource_id = resource_id, fields = fields, filters = filters,
      limit = limit, offset = offset, sort = sort, q = q,
      url = get_url(), credentials = list(token = get_token(), cookie = get_cookie())
    )
    index <- (1 + offset):(offset + length(records))
    out[index] <- purrr::map(records, function(x) x)
    offset <- offset + limit
    num_records_remaining <- num_records_remaining - limit
  }

  # return the data in specified format
  switch(as,
         json = as.character(jsonlite::toJSON(out)),
         list = res,
         df = dplyr::bind_rows(out))
}
