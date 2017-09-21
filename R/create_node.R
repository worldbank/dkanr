#' create_node
#'
#' Create a DKAN node
#'
#' @param url character: The DKAN site URL
#' @param body json: A JSON object to be passed to the body of the request
#' @param as character: Output format. Options are: 'json' or 'list'
#' @param ... Other optional parameters passed to the underlying GET request
#'
#' @return dkan_node object
#' @export
#'
#' @examples
#' \dontrun{
#' create_node(url = "http://demo.getdkan.com", body = {"title": "TEST DATASET"})
#' }
create_node <- function(url = get_url(), body, as = 'json', ...) {
  res <- dkan_POST(url = url, body = body, ...)
  switch(as, json = res, list = as_dk(jsl(res), "dkan_node"))
}
