#' count_acad_supps
#'
#' @param mark_obj mark obj
#' @param course_id course id
#' @param year year
#' @param term term 
#'
#' @return number of students with mark between 45 and 49
#' @export
count_acad_supps <- function(mark_obj, course_id, year, term){
  mark_obj |> 
    dplyr::filter(.data$course_id %in% .env$course_id) |> 
    dplyr::filter(.data$term %in% .env$term) |> 
    dplyr::filter(.data$year == .env$year) |> 
    dplyr::filter(dplyr::between(mark, 45, 49)) |> 
    nrow()
}
# pacman::p_load(conflicted, tidyverse, targets)
# count_acad_supps(example_marks, "MATHS-1008", 2016, "Sem 2") |> print()
