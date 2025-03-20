#' create running list
#'
#' @param mark_obj mark object
#' @param year year of examiners meeting
#' @param term term of examiners meeting
#'
#' @return list of running list
#' @export
create_running_list <- function(mark_obj, year, term){
  mark_obj |> 
    dplyr::filter(.data$year == .env$year) |> 
    dplyr::filter(.data$term == .env$term) |> 
    dplyr::count(year, term, course_id) |> 
    dplyr::select(-n) |> 
    dplyr::mutate(
      decision = "TBD"
    )
}
# pacman::p_load(conflicted, tidyverse, targets)
# data(mark_obj, package = "tukelatoR")
# create_running_list(mark_obj, 2020, "Sem 1") |> print()