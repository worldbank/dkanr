dkan_DELETE <- function(url, nid, body = NULL, ...){
  dkan_REQUEST("DELETE", url, nid, body = body, ...)
}

dkan_PUT <- function(url, nid, body = NULL, ...){
  dkan_REQUEST("PUT", url, nid, body = body, ...)
}

dkan_POST <- function(url, body = NULL, query = NULL, ...){
  dkan_REQUEST("POST", url, nid = NULL, body = body, query = query, ...)
}

dkan_GET <- function(url, nid = NULL, query = NULL, ...){
  dkan_REQUEST("GET", url, nid = nid, body = NULL, query = query, ...)
}

dkan_REQUEST <- function(verb, url, nid = NULL, body, ...) {
  REQUEST <- getExportedValue("httr", verb)
  url <- notrail(url)
  url <- if (is.null(nid)) {
    url <- file.path(url, dk())
  } else {
    url <- file.path(url, dk(), nid)
  }
  cookie <- Sys.getenv("DKANR_COOKIE")
  token <- Sys.getenv("DKANR_TOKEN")
  if (token == "") {
    # no authentication
    if (is.null(body) || length(body) == 0) {
      res <- REQUEST(url, aj(), ...)
    } else {
      res <- REQUEST(url, body = body, ctj(), ...)
    }
  } else {
    # authentication
    api_auth_header <- httr::add_headers(.headers = c("Cookie" = cookie,
                                                      "X-CSRF-Token" = token))
    if (is.null(body) || length(body) == 0) {
      res <- REQUEST(url, aj(), api_auth_header, ...)
    } else {
      res <- REQUEST(url, body = body, ctj(), aj(), api_auth_header, ...)
    }
  }
  err_handler(res)
  httr::content(res, "text", encoding = "UTF-8")
}

# Helpers
cc <- function(l) Filter(Negate(is.null), l)
dk <- function() "api/dataset/node"
jsl <- function(x) jsonlite::fromJSON(x, simplifyVector = FALSE)
ctj <- function() httr::content_type_json()
aj <- function() httr::accept_json()

# function to attach classes
as_dk <- function(x, class) {
  structure(x, class = class)
}

err_handler <- function(x) {
  if (x$status_code > 201) {
    obj <- try({
      err <- jsonlite::fromJSON(httr::content(x, "text", encoding = "UTF-8"))$form_errors
      errmsg <- paste("error:", err[[1]])
      list(err = err, errmsg = errmsg)
    },
    silent = TRUE)
    if (class(obj) != "try-error") {
      stop(sprintf("%s - %s",
                   httr::http_status(x)$message,
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


# Authentication ----------------------------------------------------------

connect_system <- function(root_url) {
  # Build url
  path <- "api/dataset/system/connect"
  url <- httr::modify_url(root_url, path = path)

  body <- system_connect_json
  body$SystemConnect <- jsonlite::unbox(body$SystemConnect)
  body <- jsonlite::toJSON(body, pretty = TRUE)

  out <- httr::POST(url,
                    httr::accept_json(),
                    httr::content_type_json(),
                    body = body)
  httr::stop_for_status(out, task = "connect to DDH")
  out <- httr::content(out)
  out <- out$sessid

  return(out)
}

login_service <- function(system_connect_sessid, username, password, root_url) {
  # Build url
  path <- "api/dataset/user/login"
  url <- httr::modify_url(root_url, path = path)

  body <- login_service_json
  body$sessid <- jsonlite::unbox(system_connect_sessid)
  body$username <- jsonlite::unbox(username)
  body$password <- jsonlite::unbox(password)
  body <- jsonlite::toJSON(body, pretty = TRUE)
  

  out <- httr::POST(url,
                    httr::accept_json(),
                    httr::content_type_json(),
                    body = body)
  httr::stop_for_status(out, task = "retrieve session ID via login service")
  out <- httr::content(out)
  login_sessid <- out$sessid
  login_sessname <- out$session_name
  cookie <- paste0(login_sessname, "=", login_sessid)

  return(cookie)
}


request_token <- function(cookie, root_url) {

  # Build url
  path <- "services/session/token"
  url <- httr::modify_url(root_url, path = path)

  out <- httr::POST(url,
                    httr::accept_json(),
                    httr::add_headers("Cookie" =  cookie))
  httr::stop_for_status(out, task = "retrieve token")

  out <- httr::content(out)

  return(out)
}


filters_to_text_query <- function(filters) {
  out <- purrr::map2_chr(filters, names(filters),
                         function(x, y) {
                           paste0("parameters[", y, "]=", x)
                           })
  out <- paste(out, collapse = "&")

  return(out)
}


build_search_query <- function(fields,
                               filters,
                               pagesize,
                               page) {
  # fields
  if (!is.null(fields)) {
    fields_text <- paste(fields, collapse = ",")
    fields_text <- paste0("fields=", fields_text)
  } else {
    fields_text <- NULL
  }
  # filters
  if (!is.null(filters)) {
    filters_text <- filters_to_text_query(filters)
  } else {
    filters_text <- NULL
  }
  # pagesize
  if (!is.null(pagesize)) {
    pagesize_text <- paste0("pagesize=", pagesize)
  } else {
    pagesize_text <- NULL
  }
  # page
  if (!is.null(page)) {
    page_text <- paste0("page=", page)
  } else {
    page_text <- NULL
  }

  out <- paste(fields_text, filters_text, pagesize_text, page_text, sep = "&")
  out <- stringr::str_trim(out)
  out <- stringr::str_replace_all(out, pattern = " ", replacement = "%20")
  out <- stringr::str_replace_all(out, pattern = "&+", replacement = "&")
  out <- stringr::str_replace_all(out, pattern = "^&|&$", replacement = "")

  return(out)
}

filters_to_text_query_datastore <- function(filters, text) {
  out <- purrr::map2_chr(filters, names(filters),
                         function(x, y) {
                           paste0(text, '[', y, ']=', paste(x, collapse=','))})
  out <- paste(out, collapse = '&')
  
  return(out)
}

build_read_query <- function(resource_id,
                             fields,
                             filters,
                             offset,
                             limit,
                             sort_by,
                             q) {
  # resource_id
  resource_id_text <- paste0('resource_id=', resource_id)
  # fields
  if (!is.null(fields)) {
    fields_text <- paste(fields, collapse = ',')
    fields_text <- paste0('fields=', fields_text)
  } else {
    fields_text <- NULL
  }
  # filters
  if (!is.null(filters)) {
    filters_text <- filters_to_text_query_datastore(filters, 'filter')
  } else {
    filters_text <- NULL
  }
  # offset
  offset_text <- paste0('offset=', offset)
  # limit
  limit_text <- paste0('limit=', limit)
  # sort
  if (!is.null(sort_by)) {
    sort_text <- filters_to_text_query_datastore(sort_by, 'sort')
  } else {
    sort_text <- NULL
  }
  # text query
  if (!is.null(q)){
    query_text <- paste0('query=', q)
  }
  else{
    query_text <- NULL
  }
  
  out <- paste(resource_id_text, fields_text, filters_text, offset_text, limit_text, sort_text, query_text, sep = '&')
  out <- stringr::str_replace_all(out, pattern = " ", replacement = "_")
  out <- stringr::str_replace_all(out, pattern = '&+', replacement = '&')
  out <- stringr::str_replace_all(out, pattern = "^&|&$", replacement = "")
  
  return(out)
}