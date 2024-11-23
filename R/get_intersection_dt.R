#' get_intersection DT
#'
#' Gives a table of marks
#' @param intersection_obj intersection object
#'
#' @return tibble of marks for students in first course
#' @export
get_intersection_dt <- function(intersection_obj){
  intersection_obj |> 
    DT::datatable(
  options = list(
    pageLength = 1000,
    lengthMenu = c(20, 50, 100, 200, 1000)
  ),
  rownames = FALSE
)
}
# pacman::p_load(tidyverse, targets)
# data(mark_obj)
# get_intersection(mark_obj, "MATHS-2202", "Sem 2", 2017, c("MATHS-1012")) |> 
#   get_intersection_dt() |> print()
