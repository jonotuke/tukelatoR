#' convert term
#'
#' convert the term codes to term names
#' @param x vector of term codes
#'
#' @return vector of term names
#' @export
#'
#' @examples
#' convert_term(4320)
convert_term <- function(x){
  x <- as.character(x)
  lookup <- term_codes$name
  names(lookup) <- term_codes$term
  lookup[x]
}
