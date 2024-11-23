#' add names
#'
#' @param gr graderosters
#' @param course_names tibble with course id and course names from peoplesoft
#'
#' @return graderosters with added names
#' @export
add_names <- function(gr, course_names){
  gr |> dplyr::left_join(course_names, by = "course_id")
}
# pacman::p_load(conflicted, tidyverse, targets, tukelatoR)
# data(mark_obj)
# names_tab <- tab_course_names(mark_obj) |> 
#   bind_rows(tibble(course_id = "STATS-1234", course_name = "Test course"))
# gr <- tukelatoR::parse_graderoster("inst/examples/grade-roster-example.xlsx", 2024)
# add_names(gr, names_tab)
