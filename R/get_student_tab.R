#' get student tab
#'
#' @param mark_obj mark object
#' @param ids ids
#'
#' @return gt table of student marks
#' @export
get_student_tab <- function(mark_obj, ids){
  mark_obj |> 
    dplyr::filter(id %in% ids) |> 
    dplyr::select(name, course_id, course_name, mark) |> 
    tidyr::pivot_wider(names_from = name, values_from = mark) |> 
    gt::gt() |> 
    gt::sub_missing()
}
# pacman::p_load(conflicted, tidyverse, targets, gt)
# data(mark_obj)
# mark_obj
# get_student_tab(mark_obj, c("3798786", "4476745"))