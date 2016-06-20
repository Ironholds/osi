list_to_df <- function(input){
  if(!length(input)){
    return(NA)
  }
  input <- unlist(input)
  new_names <- unique(names(input))
  output = vector("list", length(new_names))

  # I cannot believe I am using a for loop please nobody judge me
  for(i in seq_along(new_names)){
    output[[i]] <- unname(input[names(input) == new_names[i]])
  }
  output <- as.data.frame(output, stringsAsFactors = FALSE)
  names(output) <- new_names
  return(output)
}

clean_license <- function(license){
  return(list(
    id = license$id,
    identifiers = list_to_df(license$identifiers),
    links = list_to_df(license$links),
    name = license$name,
    other_names = ifelse(length(license$other_names), license$other_names, NA),
    superseded_by = ifelse(is.null(license$superseded_by), NA, license$superseded_by),
    keywords = unname(unlist(license$keywords)),
    text = list_to_df(license$text)
  ))
}

#'@importFrom httr GET stop_for_status user_agent content
query_osi <- function(params, ...){
  results <- httr::GET(paste0("https://api.opensource.org/", params),
                       httr::user_agent("R API connector - https://www.github.com/Ironholds/osi"),
                       ...)
  httr::stop_for_status(results)
  return(httr::content(results))
}

query_other <- function(url, ...){
  results <- httr::GET(url,
                       httr::user_agent("R API connector - https://www.github.com/Ironholds/osi"),
                       ...)
  httr::stop_for_status(results)
  return(suppressWarnings({httr::content(results, as = "text", encoding = "UTF-8")}))
}