#' dkan_node class helpers
#'
#' @export
#' @param x Variety of things, character, list, or dkan_node class object
#' @param ... Further args passed on to \code{\link{retrieve_node}} if character given
#' # create item class from only an item ID
#' as.dkan_node("22")
#'
#' # gives back itself
#' (x <- as.dkan_node("22"))
#' as.dkan_node(x)

as.dkan_node <- function(x, ...) UseMethod("as.dkan_node")

#' @export
as.dkan_node.character <- function(x, ...) retrieve_node(x, ...)

#' @export
as.dkan_node.dkan_node <- function(x, ...) x

#' @export
as.dkan_node.list <- function(x, ...) structure(x, class = "dkan_node")

#' @export
#' @rdname as.dkan_node
is.dkan_node <- function(x) inherits(x, "dkan_node")

#' @export
print.dkan_node <- function(x, ...) {
  cat(paste0("<DKAN Node> #", x$nid), "\n")
  cat("  Type: ", x$type, "\n", sep = "")
  cat("  Title: ", x$title, "\n", sep = "")
  cat("  UUID: ", x$uuid, "\n", sep = "")
  cat("  Created/Modified: ", x$created, " / ", x$changed, "\n", sep = "")
}
