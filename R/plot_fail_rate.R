utils::globalVariables(
  c("RAA", "PF", "FR", "PFR")
)
#' plot_fail_rate
#'
#' Plots a line plot of the fail rate
#' @param mark_obj standard mark tibble
#' @param course_id course-id
#' @param term term of latest results
#' @param year year of latest results
#' @param MS number of medical supps
#' @param MSPR medical supp pass rate
#' @param ASPR academic supp pass rate
#'
#' @return line-plot
#' @export
plot_fail_rate <- function(
  mark_obj, course_id, year, term, 
  MS, MSPR, ASPR
){
  df <- mark_obj |>
  dplyr::filter(.data$course_id %in% .env$course_id) |> 
  dplyr::filter(.data$term %in% .env$term) |> 
  dplyr::summarise(
    N = dplyr::n(), 
    F = sum(grade == "F", na.rm = TRUE), 
    RAA = sum(dplyr::between(mark, 45, 49), na.rm = TRUE), 
    .by = c(course_id, year, term)
  ) |> 
  dplyr::mutate(FR = F / N)
  this_year <- df |> 
  dplyr::filter(.data$year == .env$year) |> 
  dplyr::mutate(
    PF = predict_fail_rate(NF = F, MS = MS, AS = RAA, MSPR, ASPR), 
    PFR = PF / N
  )
  df |> 
  ggplot2::ggplot(ggplot2::aes(year, FR, fill = course_id)) + 
  ggplot2::geom_line() + 
  ggplot2::geom_segment(
    ggplot2::aes(x = year, y = FR, xend = year + 0.1, 
      yend = PFR, group = course_id
    ), 
    linetype = "dashed",
    data = this_year
  ) + 
  ggplot2::geom_point(size = 3, pch = 21) + 
  ggplot2::scale_y_continuous(labels = scales::percent) + 
  ggplot2::scale_x_continuous(breaks = min(df$year):max(df$year)) + 
  ggplot2::theme_bw() + 
  harrypotter::scale_fill_hp_d("Ravenclaw") + 
  ggplot2::geom_hline(yintercept = 0.2) + 
  ggplot2::geom_point(
    ggplot2::aes(x = year + 0.1, y = PFR), 
    data = this_year, pch = 22, size = 3
  )
}
# pacman::p_load(tidyverse, targets)
# data(mark_obj)
# plot_fail_rate(
#   mark_obj, 
#   course_id = c("DISCP-1001"),
#   year = 2022, term = "Sem 1", 
#   MS = 0, MSPR = 0.8, ASPR = 0.5
# ) |> print()
