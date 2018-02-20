#' ds_is_available
#'
#' Returns TRUE is a data file has been imported in the DKAN datastore, returns FALSE otherwise
#'
#' @param metadata list: Resource level metadata
#'
#' @return logical vector
#' @export
#'
#' @examples
#' \dontrun{
#' metadata <- retrieve_node(nid ='140366', as = 'list')
#' ds_is_available(metadata)
#' }
#'

ds_is_available <- function(metadata) {

  # CHECK input
  assertthat::assert_that(
    is.list(metadata) == TRUE,
    msg = "metadata must be a list"
  )
  assertthat::assert_that(
    metadata$type == "resource",
    msg = 'This node is not of type "resource". Resource links are only available in resource nodes'
  )

  out <- if (metadata[["field_datastore_status"]][["und"]][[1]][["value"]] == "1") {
    return(TRUE)
  } else {
    return(FALSE)
  }
}
