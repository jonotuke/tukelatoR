#' get ids
#'
#' @param  augmented_mark_obj augmented mark obj
#' @param course_id course id
#' @param year year of offering
#' @param term term of offering
#' @param rows selected rows
#'
#' @return IDs selected
#' @export
get_ids <- function(augmented_mark_obj, course_id, year, term, rows){
  ids <-
    augmented_mark_obj |>
    dplyr::filter(.data$course_id %in% .env$course_id) |>
    dplyr::filter(.data$year %in% .env$year) |>
    dplyr::filter(.data$term %in% .env$term) |> 
    dplyr::arrange(-mark) |> 
    dplyr::slice(rows) |> 
    dplyr::pull(id)
  ids
}
# pacman::p_load(conflicted, tidyverse, targets, tukelatoR)
# data(mark_obj)
# augmented_mark_obj <- augment_mark_obj(mark_obj)
# get_ids(augmented_mark_obj, "STATS-3001", 2017, "Sem 1", rows = c(1, 3))
