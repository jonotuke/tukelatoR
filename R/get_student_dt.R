#' get student dt
#'
#' @param mark_obj mark object
#' @param ids ids
#'
#' @return gt table of student marks
#' @export
#' @examples
#' get_student_dt(mark_obj, c("2082983", "4547752"))
get_student_dt <- function(mark_obj, ids){
  mark_obj |> 
    dplyr::filter(id %in% ids) |> 
    dplyr::select(name, course_id, course_name, mark) |> 
    tidyr::pivot_wider(names_from = name, values_from = mark) |> 
      DT::datatable(
        options = list(
          pageLength = 1000,
          lengthMenu = c(20, 50, 100, 200, 1000)
        ),
        rownames = FALSE
      )
}
# pacman::p_load(conflicted, tidyverse, targets, gt)
# data(mark_obj)
# mark_obj
# get_student_dt(mark_obj, c("2082983", "4547752")) |> print()