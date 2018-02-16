#' get_resource_url
#'
#' Returns the download link or external page URL for a specific resource
#'
#' @param metadata list: Resource level metadata
#'
#' @return character vector
#' @export
#'

get_resource_url <- function(metadata) {

  # CHECK input
  assertthat::assert_that(is.list(metadata) == TRUE,
                          msg = 'metadata must be a list')
  assertthat::assert_that(metadata$type == "resource",
                          msg = 'This node is not of type "resource". Resource links are only available in resource nodes')

  path <- c(metadata[['field_upload']][['und']][[1]][['uri']],
                 metadata[['field_link_api']][['und']][[1]][['url']],
                 metadata[['field_link_remote_file']][['und']][[1]][['url']])
  path <- unname(unlist(path))


  path <- fix_download_url(path)

  return(path)
}
