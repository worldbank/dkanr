#' update_node
#'
#' Update an exisiting DAKN node
#'
#' @param nid character: DKAN node ID
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
#' update_node(nid = 1, url = "http://demo.getdkan.com")
#' }

update_node <- function(nid, url = get_url(), body, as = "json", ...) {
  # CHECK: input validity
  assertthat::assert_that(!is.null(nid),
                          msg = "The Node ID (nid) argument must be specified")
  res <- dkan_PUT(url = url, nid = nid, body, ...)
  switch(as, json = res, list = as_dk(jsl(res), "dkan_node"))
}
