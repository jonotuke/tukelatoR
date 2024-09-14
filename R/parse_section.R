#' parse section
#'
#' @param x gradebook section column
#' @param which which to return, term or course_id
#'
#' @return term or course
#' @export
#'
#' @examples
#' section <- c(
#'   "Workshop WR01 Class 4320_STATS_3022", 
#'   "Workshop WR01 Class 4320_APP MTH_3022",
#'   "Workshop WR01 Class 4320_APP-MTH_3022"
#' )
#' parse_section(section, "term")
#' parse_section(section, "course_id")
parse_section <- function(x, which = "term"){
  term <- stringr::str_match(x, "(\\d{4})_(.*?_\\d{4})")[, 2]
  course_id <- stringr::str_match(x, "(\\d{4})_(.*?_\\d{4})")[, 3]
  if(which == "term"){
    return(term)
  } else {
    return(course_id)
  }
}