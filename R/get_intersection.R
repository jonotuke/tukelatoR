#' get_intersection
#'
#' Gives a table of marks
#' @param mark_obj mark-obj
#' @param course_id course-id
#' @param term term
#' @param year year of offering
#' @param other_course_ids course to compare with
#'
#' @return tibble of marks for students in first course
#' @export
get_intersection <- function(mark_obj, course_id, term, year, other_course_ids) {
  first_course <-
    mark_obj |>
    dplyr::filter(.data$course_id %in% .env$course_id) |>
    dplyr::filter(.data$year %in% .env$year) |>
    dplyr::filter(.data$term %in% .env$term)
  other_course <- 
    mark_obj |>
    dplyr::filter(.data$course_id %in% .env$other_course_ids) |>
    dplyr::filter(.data$id %in% first_course$id)
  marks <- dplyr::bind_rows(
    first_course,
    other_course
  ) |> 
    dplyr::select(id, name, course_name, mark) |> 
    tidyr::pivot_wider(
      names_from = course_name, 
      values_from = mark, 
      values_fn = \(x)mean(x, na.rm = TRUE)
    )
}
# pacman::p_load(tidyverse, targets)
# data(mark_obj)
# get_intersection(mark_obj, "MATHS-2202", "Sem 2", 2017, c("MATHS-1012")) |> print()
