#'@title Get all OSI-listed licenses
#'@description \code{license_list} retrieves a list of
#'all the metadata associated with every license that the Open Source Initiative
#'has coverage of.
#'
#'@param ... arguments to pass to httr's GET.
#'
#'@return a list of licenses and their metadata (themselves in the form of
#'lists) which can be provided to other functions such as \code{\link{license_text}}
#'
#'@examples
#'# Get licenses
#'list_of_all_licenses <- license_list()
#'
#'@export
license_list <- function(...){
  return(lapply(query_osi("licenses/", ...), clean_license))
}

#'@title Get OSI-listed licenses with a particular keyword
#'@description \code{license_by_keyword} retrieves a list of
#'all the metadata associated with OSI-listed licenses that contain
#'a particular, user-provided keyword.
#'
#'@param keyword. Acceptable keywords are:
#'\itemize{
#'  \item{osi-approved}{ This license has been OSI Approved.}
#'  \item{redundant}{	This license is redundant with a more widely used license.}
#'  \item{permissive}{ }
#'  \item{copyleft}{ This license requires derived works remain Open Source.}
#'  \item{obsolete}{ This license is considered obsolete by its authors.}
#'  \item{miscellaneous}{ }
#'  \item{popular}{ This license is widely used.}
#'  \item{discouraged}{ This license's use is actively discouraged.}
#'  \item{non-reusable}{ This license isn't generally usable outside of the authoring organization.}
#'  \item{special-purpose}{ This license suits a very special purpose.}
#'  \item{retired}{ This license has been retired by the issuer.}
#'}
#'
#'@param ... arguments to pass to httr's GET.
#'
#'@return a list of licenses and their metadata (themselves in the form of
#'lists) which can be provided to other functions such as \code{\link{license_text}}
#'
#'@examples
#'# Get copyleft licenses
#'copyleft_licenses <- license_by_keyword("copyleft")
#'
#'@seealso \code{\link{license_text}}, which can consume the results of this
#'function, as well as
#'\code{\link{license_by_id}} and \code{\link{license_by_scheme}} for alternate
#'ways of looking up particular licenses.
#'
#'@export
license_by_keyword <- function(keyword, ...){
  return(lapply(query_osi(paste0("licenses/", keyword), ...), clean_license))
}

#'@title Get license metadata by license ID
#'@description \code{license_by_id} retrieves the metadata for a set of licenses
#'with particular license IDs.
#'
#'@param license_ids the ID (or IDs! It's vectorised!) to retrieve metadata for.
#'IDs can be extracted from existing data with \code{\link{extract_ids}}.
#'
#'@param ... arguments to pass to httr's GET.
#'
#'@return a list of licenses and their metadata (themselves in the form of
#'lists) which can be provided to other functions such as \code{\link{license_text}}
#'
#'@examples
#'# Get the GPL's metadata
#'gpl_2_metadata <- license_by_id("GPL-2.0")
#'
#'@seealso \code{\link{license_text}}, which can consume the results of this
#'function, and \code{\link{extract_ids}}, to retrieve the IDs, as well as
#'\code{\link{license_by_keyword}} and \code{\link{license_by_scheme}} for alternate
#'ways of looking up particular licenses.
#'
#'@export
license_by_id <- function(license_ids, ...){
  return(lapply(license_ids, function(id, ...){
    return(clean_license(query_osi(paste0("license/", id), ...)))
  }, ...))
}

#'@title Retrieve license text
#'@description \code{license_text} grabs the actual plaintext of a set of
#'licenses within the provided metadata, wherever possible.
#'
#'@param license_metadata metadata returned from \code{\link{license_by_id}},
#'\code{\link{license_by_keyword}} or \code{\link{license_list}} which covers
#'the licenses you want the text of.
#'
#'@param ... further arguments to pass to httr's GET.
#'
#'@return a data.frame of 3 columns; "license" containing the license IDs,
#'"content" containing the actual text, and "retrieved_from" indicating the
#'URL the content was returned from. In the event that the plaintext of a license
#'is not available (because a URL for it was not in the metadata), \code{content}
#'and \code{retrieved_from} will be NAs.
#'
#'@examples
#'gpl_2_text <- license_text(license_by_id("GPL-2.0"))
#'
#'@export
license_text <- function(license_metadata, ...){
  output <- do.call("rbind", lapply(license_metadata, function(metadata, ...){
    plaintext_entry <- metadata$text$url[metadata$text$media_type == "text/plain"]
    if(!is.null(plaintext_entry) && length(plaintext_entry)){
      content <- query_other(plaintext_entry[1], ...)
      retrieved_from <- plaintext_entry[1]
    } else {
      content <- NA
      retrieved_from <- NA
    }
    return(data.frame(license = metadata$id,
                      content = content,
                      retrieved_from = retrieved_from,
                      stringsAsFactors = FALSE))
  }))
  return(output)
}