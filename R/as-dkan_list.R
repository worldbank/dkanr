#' dkan_list class helpers
#'
#' @export
#' @param x Variety of things, character, list, or dkan_list class object
#' @param ... Further args passed on to \code{\link{retrieve_node}} if character given

as.dkan_list <- function(x, ...) UseMethod("as.dkan_list")

#' @export
as.dkan_list.character <- function(x, ...) retrieve_node(x, ...)

#' @export
as.dkan_list.dkan_list <- function(x, ...) x

#' @export
as.dkan_list.list <- function(x, ...) structure(x, class = "dkan_list")

#' @export
#' @rdname as.dkan_list
is.dkan_list <- function(x) inherits(x, "dkan_list")

#' @export
print.dkan_list <- function(x, ...) {
  cat(paste0("<DKAN List> containing ", length(x), " nodes"), "\n")
  cat("  First node: ", x[[1]]$nid, "\n", sep = "")
  cat("  Last node: ", x[[length(x)]]$nid, "\n", sep = "")
}
