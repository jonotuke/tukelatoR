utils::globalVariables(
  c(".data", ".env", "course_name", "n", "N", "p")
)
#' plot_grade_bc
#'
#' Plots a bar-chart of grades for mark-obj
#' @param mark_obj standard mark tibble
#' @param course_id course-id
#' @param term term
#' @param all_grades Show all grades 
#'
#' @return bar-chart
#' @export
#'
#' @examples
#' plot_grade_bc(mark_obj, course_id = "DISCP-1001", term = "Sem 1")
#' plot_grade_bc(mark_obj, course_id = c("DISCP-1001", "DISCP-2001"), term = "Sem 1")
plot_grade_bc <- function(mark_obj, course_id, term, all_grades = FALSE){
  df <- mark_obj |>
  dplyr::filter(.data$course_id %in% .env$course_id) |>
    dplyr::filter(.data$term %in% .env$term) |>
      dplyr::count(
    course_id, course_name, year, term, grade
  )  |>
    dplyr::group_by(course_id, course_name, year, term) |>
      dplyr::mutate(
     N = sum(n),
     p = n / N,
     grade = order_grade(grade))
  if(!all_grades){
    df <- df |> 
      dplyr::filter(grade %in% c("F", "P", "C", "D", "HD"))
  }
    df |>
      ggplot2::ggplot(
        ggplot2::aes(grade, p, fill = factor(year))) +
      ggplot2::geom_col(position = ggplot2::position_dodge2(
        width = 1, preserve = "single"
      ),
      col = "black"
      ) +
      ggplot2::facet_wrap(~course_name, ncol = 1) +
      harrypotter::scale_fill_hp_d("Ravenclaw") +
      ggplot2::theme(
        legend.position = "bottom"
      ) +
      ggplot2::labs(
        x = "Grade",
        y = "Proportion",
        fill = NULL
      ) + 
      ggplot2::theme_bw()
}
# pacman::p_load(conflicted, tidyverse, targets)
# conflicts_prefer(dplyr::filter)
# library(tukelatoR)
# mark_obj
# plot_grade_bc(mark_obj, course_id = "STATS-3001", term = "Sem 1")
# plot_grade_bc(mark_obj, course_id = c("STATS-3001", "STATS-3006"), term = "Sem 1")
# cs7211_file <- "~/Dropbox/01-projects/2024-exam-marks/raw-data/graderosters/2024-s2/COMP SCI 7211_4420_FIN.xlsx"
# cs7211 <- parse_graderoster(cs7211_file, 2024)
# cs7211 <- cs7211 |> 
#   mutate(
#     course_name = "TEST"
#   )
# plot_grade_bc(cs7211, course_id = "COMP SCI-7211", term = "Sem 2", all_grades = TRUE)
