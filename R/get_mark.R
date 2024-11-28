#' get mark
#'
#' @param x vector of marks 
#'
#' @return numeric vector of marks
#' @export
#'
#' @examples
#' get_mark(c(0:100, "CN", "F", "FNS", "NFE", "RP", "WF", "WNF", "NGP"))
get_mark <- function(x){
  non_mark_grades <- c("CN", "F", "FNS", "NFE", "RP", "WF", "WNF", "NGP")
  if(is.numeric(x)){
    return(x)
  } else {
    readr::parse_number(
      x, 
      na = non_mark_grades
    )
  }
}
# pacman::p_load(conflicted, tidyverse, targets)
# get_mark(
#   c(0:100, "CN", "F", "FNS", "NFE", "RP", "WF", "WNF", "NGP")
# ) |> print()