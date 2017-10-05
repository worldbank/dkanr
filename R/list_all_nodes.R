#' list_all_nodes
#'
#' Returns list of nodes
#'
#' @param url character: The DKAN site URL
#' @param fields character vector: fields to be returned by the request
#' @param filters named character vector: filters to be applied to the search
#' @param as character: Output format. Options are: 'json' or 'list'
#' @param ... Other optional parameters to be passed to the underlying GET request
#'
#' @return dkan_node object
#' @export
#'
#' @examples
#' list_all_nodes(url = "http://demo.getdkan.com")
#' list_all_nodes(url = "http://demo.getdkan.com",
#' fields = c('nid', 'type', 'uri'),
#' filters = c(type='resource'))

list_all_nodes <- function(url = get_url(), credentials = list(cookie = dkanr::get_cookie(), token = dkanr::get_token()), fields = NULL, filters = NULL, as = 'json', ...) {
  # Initialize looping parameters
  out <- vector(mode = "list", length = 1000)
  p <- 0
  n <- 1

  repeat {
    resp <- list_nodes(url = url,
                       credentials = credentials,
                       fields = fields,
                       filters = filters,
                       pagesize = 20,
                       page = p,
                       as = 'json')

    n <- length(jsl(resp)) # get the number of records returned

    if (n > 0) {
      out[[p + 1]] <- resp   # Assigned response (base 0 index for DKAN pages)
      p <- p + 1             # Go to next page

      # Manage growth of output list
      if (p == length(out)) {
        out <- c(out, vector(mode = "list", length = 1000))
      }
      # Print number of pages retrieved
      if (p%%10 == 0) {
        m <- paste0(p * 20, ' records (DKAN nodes) have been retrieved')
        message(m)
      }
    } else {
      break
    }
  }

  # Turn list into valid json
  out <- purrr::map(out, stringr::str_replace_all, pattern = '^\\[|\\]$', replace = '')
  out <- unlist(out)
  out <- paste(out, collapse = ',')
  out <- paste0('[', out, ']')


  switch(as, json = out, list = as_dk(jsl(out), "dkan_list"))
}
