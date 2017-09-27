#' Get or set dkanr DKAN settings
#'
#' @export
#' @return \code{dkanr_settings} prints your base url, API cookie and token (if used)
#' \code{dkanr_setup} sets your production settings
#' @seealso  \code{\link{dkanr_setup}},
#' \code{\link{get_default_url}}, \code{\link{get_default_username}},
#' \code{\link{get_default_password}}
#' @family dkanr settings
#' @examples
#' dkanr_settings()
dkanr_settings <- function() {
  ops <- list(url = Sys.getenv("DKANR_DEFAULT_URL", ""),
              cookie = Sys.getenv("DKANR_DEFAULT_COOKIE", ""),
              token = Sys.getenv("DKANR_DEFAULT_TOKEN", "")
  )
  structure(ops, class = "dkanr_settings")
}

#' @export
print.dkanr_settings <- function(x, ...) {
  cat("<dkanr settings>", sep = "\n")
  cat("  Base URL: ", x$url, "\n")
  cat("  Cookie:", x$cookie, "\n")
  cat("  Token:", x$token, "\n")
}

# Setters -----------------------------------------------------------------
#
#' Configure default DKAN settings
#'
#' @export
#' @param url A DKAN URL (optional), default: "http://demo.getdkan.com"
#' @param username Username (optional, character)
#' @param password Password (optional, character)

#' @details
#' \code{dkanr_setup} sets DKAN connection details. \code{dkanr} functions
#' default to use the default URL and API key unless specified explicitly.
#'
#' @examples
#' DKAN users without admin/editor privileges could run:
#' dkanr_setup(url = "http://demo.getdkan.com")
#'
#' Privileged DKAN editor/admin users can run:
#' dkanr_setup(url = "http://demo.getdkan.com", username = "your-username", password = "your-password")
#'
#' Not specifying the default DKAN URL will reset the DKAN URL to its default
#' "http://demo.getdkan.com":
#' dkanr_setup()
dkanr_setup <- function(url = "http://demo.getdkan.com",
                        username = NULL,
                        password = NULL) {

  Sys.setenv("DKANR_URL" = url)
  if (!is.null(username) & !is.null(password)) {
    message('Opening anonymous session')
    sessid <- connect_system(root_url = url)
    message('Requesting session cookie')
    cookie <- login_service(system_connect_sessid = sessid,
                            username = username,
                            password = password,
                            root_url = url)
    message('Requesting session token')
    token <- request_token(cookie = cookie,
                           root_url = url)
    Sys.setenv("DKANR_COOKIE" = cookie)
    Sys.setenv("DKANR_TOKEN" = token)
  } else {
    Sys.setenv("DKANR_COOKIE" = '')
    Sys.setenv("DKANR_TOKEN" = '')
  }
}


#------------------------------------------------------------------------------#
# Getters
#
#' @export
#' @rdname dkanr_settings
get_url <- function(){ Sys.getenv("DKANR_URL") }

#' @export
#' @rdname dkanr_settings
get_cookie <- function(){ Sys.getenv("DKANR_COOKIE") }

#' @export
#' @rdname dkanr_settings
get_token <- function(){ Sys.getenv("DKANR_TOKEN") }
