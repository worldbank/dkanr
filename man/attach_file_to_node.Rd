% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/attach_file_to_node.R
\name{attach_file_to_node}
\alias{attach_file_to_node}
\title{attach_file_to_node}
\usage{
attach_file_to_node(nid, url = get_url(), credentials = list(cookie =
  dkanr::get_cookie(), token = dkanr::get_token()), file_path,
  attach = 1)
}
\arguments{
\item{nid}{character: DKAN resource node ID}

\item{url}{character: The DKAN site URL}

\item{credentials}{Optional list parameter. Default values are Cookie and Token generated by dkan_setup()}

\item{file_path}{character: path to file on local machine}

\item{attach}{numeric: Setting the attach parameter to 0 ensures that the file will replace any existing file on the resource. Setting it to 1 will result in a rejected request if the resource already has an attached file (but it will work if the resource file upload field is empty).}
}
\description{
Attach a file to an existing resource node
}
