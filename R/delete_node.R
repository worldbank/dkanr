#' delete_node
#'
#' Delete an exisiting DAKN node
#'
#' @param nid character: DKAN node ID
#' @param url character: The DKAN site URL
#' @param as character: Output format. Options are: 'json' or 'list'
#' @param ... Other optional parameters passed to the underlying GET request
#'
#' @return character or dkan_node object
#' @export
#'
#' @examples
#' \dontrun{
#' delete_node(nid = 1, url = "http://demo.getdkan.com")
#' }

delete_node <- function(nid, url = get_url(), as = "json", ...) {
  # CHECK: input validity
  assertthat::assert_that(!is.null(nid),
                          msg = "The Node ID (nid) argument must be specified")
  res <- dkan_DELETE(url = url, nid = nid, ...)
  switch(as, json = res, list = as_dk(jsl(res), "dkan_node"))
}
