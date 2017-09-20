#' retrieve_node
#'
#' Returns metadata associated with an exisiting DKAN Node ID.
#'
#' @param nid character: DKAN node ID
#' @param url character: The DKAN site URL
#' @param ... Other optional parameters to be passed to the underlying GET request
#'
#' @return dkan_node object
#' @export
#'
#' @examples
#' retrieve_node(nid = 1, url = "http://demo.getdkan.com")
retrieve_node <- function(nid, url = get_url(), ...) {
  # CHECK: input validity
  assertthat::assert_that(!is.null(nid), msg = 'The Node ID (nid) argument must be specified')
  res <- dkan_GET(url = url, nid = nid, ...)
  as_dk(jsl(res), "dkan_node")
}
