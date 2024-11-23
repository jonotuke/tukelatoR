utils::globalVariables(
  c(".data", ".env", "course_name", "n", "N", "p", "raa")
)
#' get_mark_summary
#'
#' Gives a table of marks
#' @param augmented_mark_obj augmented-mark-obj
#' @param course_id course-id
#' @param term term
#' @param year year of offering
#'
#' @return gt summary table
#' @export
get_mark_summary_gt <- function(augmented_mark_obj, course_id, term, year){
  df <-
  augmented_mark_obj |>
  dplyr::filter(.data$course_id %in% .env$course_id) |>
  dplyr::filter(.data$year %in% .env$year) |>
  dplyr::filter(.data$term %in% .env$term)
  tibble::tibble(
    mean_diff = mean(df$diff, na.rm = TRUE), 
    sd_diff = stats::sd(df$diff, na.rm = TRUE), 
    prop_neg_diff = mean(df$diff < 0, na.rm = TRUE), 
    n_49 = sum(df$mark==49, na.rm = TRUE),
    p_49 = mean(df$mark==49, na.rm = TRUE)
  ) |> 
    gt::gt() |> 
    gt::fmt_number()
}
# pacman::p_load(conflicted, tidyverse, gt, DT)
# conflicts_prefer(dplyr::filter)
# data(augmented_mark_obj)
# get_mark_summary_gt(augmented_mark_obj, course_id = "STATS-3001", term = "Sem 1", 2016) |> print()
# get_mark_summary_gt(augmented_mark_obj, course_id = "STATS-1234", term = "Sem 2", 2018) |> print()
