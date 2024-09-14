#' clean names
#'
#' code to clean names of gradebook
#' 
#' @param x vector of column names
#'
#' @return clean vector of names
#' @export
#'
#' @examples
#' clean_names("Assignment (123)")
clean_names <- function(x){
  stringr::str_remove(x, " \\(\\d*\\)")
}