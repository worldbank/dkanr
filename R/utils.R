dkan_VERB <- function(verb, url, method, body, cookie, token, ...) {
  VERB <- getExportedValue("httr", verb)
  url <- notrail(url)
  if (is.null(token)) {
    # no authentication
    if (is.null(body) || length(body) == 0) {
      res <- VERB(file.path(url, dk(), method), ctj(), ...)
    } else {
      res <- VERB(file.path(url, dk(), method), body = body, ...)
    }
  } else {
    # authentication
    api_auth_header <- httr::add_headers(.headers = c("Cookie" =  cookie,
                                                       "X-CSRF-Token" = token))
    if (is.null(body) || length(body) == 0) {
      res <- VERB(file.path(url, dk(), method), ctj(), api_auth_header, ...)
    } else {
      res <- VERB(file.path(url, dk(), method), body = body, api_auth_header, ...)
    }
  }
  err_handler(res)
  content(res, "text", encoding = "UTF-8")
}

# Helpers
dk <- function() 'api/dataset/node'
ctj <- function() httr::content_type_json()



err_handler <- function(x) {
  if (x$status_code > 201) {
    obj <- try({
      err <- jsonlite::fromJSON(content(x, "text", encoding = "UTF-8"))$error
      #err <- content(x, encoding = "UTF-8")$error
      tmp <- err[names(err) != "__type"]
      errmsg <- paste(names(tmp), unlist(tmp[[1]]))
      list(err = err, errmsg = errmsg)
    }, silent = TRUE)
    if (class(obj) != "try-error") {
      stop(sprintf("%s - %s\n  %s",
                   x$status_code,
                   obj$err$`__type`,
                   obj$errmsg),
           call. = FALSE)
    } else {
      obj <- {
        err <- httr::http_condition(x, "error")
        errmsg <- httr::content(x, "text", encoding = "UTF-8")
        list(err = err, errmsg = errmsg)
      }
      stop(sprintf("%s - %s\n  %s",
                   x$status_code,
                   obj$err[["message"]],
                   obj$errmsg),
           call. = FALSE)
    }
  }
}


notrail <- function(x) {
  gsub("/+$", "", x)
}
