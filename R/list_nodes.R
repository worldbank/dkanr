#' list_nodes
#'
#' Returns list of nodes
#'
#' @param url character: The DKAN site URL
#' @param fields character vector: fields to be returned by the request
#' @param filters named character vector: filters to be applied to the search
#' @param pagesize numeric: Number of records to get per page (max = 20).
#' @param page numeric: The zero-based index of the page to get, defaults to 0.
#' @param as character: Output format. Options are: 'json' or 'list'
#' @param ... Other optional parameters to be passed to the underlying GET request
#'
#' @return dkan_node object
#' @export
#'
#' @examples
#' \dontrun{
#' list_nodes(url = "http://demo.getdkan.com")
#' list_nodes(url = "http://demo.getdkan.com",
#'                fields = c('nid', 'type', 'uri'),
#'                filters = c(type='resource'))
#'                }

list_nodes <- function(url = get_url(), fields = NULL, filters = NULL, pagesize = NULL, page = NULL, as = 'json', ...) {
  # Build query
  query = NULL
  if (any(!is.null(fields), !is.null(filters), !is.null(pagesize), !is.null(page))) {

    query = build_search_query(fields = fields,
                               filters = filters,
                               pagesize = pagesize,
                               page = page)
  }


  res <- dkan_GET(url = url, query = query, ...)
  switch(as, json = res, list = as_dk(jsl(res), "dkan_list"))
}
