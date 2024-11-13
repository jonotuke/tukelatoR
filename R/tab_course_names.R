#' tab course names
#'
#' @param mark_obj mark-object
#'
#' @return list of course_ids and latest name
#' @export
tab_course_names <- function(mark_obj){
  mark_obj |> 
    dplyr::select(year, course_id, course_name) |> 
    dplyr::distinct() |> 
    dplyr::filter(!is.na(course_name)) |> 
    dplyr::group_by(course_id) |> 
    dplyr::filter(year == max(year))
}
# pacman::p_load(conflicted, tidyverse, targets)
# data(mark_obj)
# tab_course_names(mark_obj) |> print()