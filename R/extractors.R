extract_base <- function(metadata, element, unlist = TRUE){
  output <- lapply(metadata, function(entry, element){
    return(entry[element])
  }, element = element)
  if(unlist){
    return(unlist(output))
  }
  return(output)
}

#'@title Extract components from OSI metadata
#'@description Elements of the metadata returned from other functions - such as
#'\code{\link{license_list}} or \code{\link{license_by_keyword}} - can be
#'extracted from the overarching metadata using this collection of functions,
#'which (respectively) pull out the license ID, license name,
#'what superseded the license, and what keywords the license has.
#'
#'@aliases extractors
#'@rdname extractors
#'
#'@param metadata a metadata object returned from \code{\link{license_by_keyword}},
#'\code{\link{license_by_id}} or \code{\link{license_list}}.
#'
#'@return a vector of the appropriate metadata element for each entry
#'(or a list of vectors in the case of \code{extract_keywords}, since
#'there can be multiple keywords per license).
#'
#'@examples
#'
#'#Get the names of all licenses
#'all_license_metadata <- license_list()
#'license_names <- extract_name(all_license_metadata)
#'@export
extract_id <- function(metadata){
  return(extract_base(metadata, "id"))
}

#'@rdname extractors
#'@export
extract_name <- function(metadata){
  return(extract_base(metadata, "name"))

}

#'@rdname extractors
#'@export
extract_superseded <- function(metadata){
  return(extract_base(metadata, "superseded_by"))
}

#'@rdname extractors
#'@export
extract_keywords <- function(metadata){
  return(extract_base(metadata, "keywords", FALSE))
}
