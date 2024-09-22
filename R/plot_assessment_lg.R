#' plot assessment line graph
#'
#' @param assessment_obj assessment object
#' @param assessment_list list of assessments to display
#'
#' @return plot of assessment
#' @export
#'
#' @examples
#' assessment_obj <- assessment_obj |> filter_assessment("STATS-3022", 2023, "Sem 2")
#' AL <- assessment_obj |> get_assessment_list()
#' plot_assessment_lg(assessment_obj, AL)
plot_assessment_lg <- function(assessment_obj, assessment_list){
  assessment_obj |> 
  dplyr::filter(assessment %in% assessment_list) |>
  dplyr::summarise(p = mean(p), .by = c(grade, assessment)) |> 
  dplyr::mutate(grade = order_grade(grade)) |> 
  dplyr::mutate(assessment = stringr::str_sub(assessment, 1, 15)) |> 
  ggplot2::ggplot(ggplot2::aes(assessment, p)) + 
  ggplot2::geom_line(ggplot2::aes(group = grade, col = grade)) + 
  ggplot2::geom_point(pch = 21, size = 3, ggplot2::aes(fill = grade), col = "white") + 
  harrypotter::scale_colour_hp_d("Ravenclaw") + 
  harrypotter::scale_fill_hp_d("Ravenclaw") + 
  ggplot2::theme_bw() + 
  ggplot2::theme(axis.text.x = ggplot2::element_text(angle = -90, hjust=0)) + 
  ggplot2::labs(x = NULL, y = "Average grade mark", fill = "Grade", col = "Grade") + 
  ggplot2::scale_y_continuous(labels = scales::percent)
}
# pacman::p_load(conflicted, tidyverse, targets)
# data(assessment_obj)
# assessment_obj |> count(year, term, course_id)
# assessment_obj <- assessment_obj |> filter_assessment("STATS-3022", 2023, "Sem 2")
# assessment_obj |> count(term, course_id)
# AL <- assessment_obj |> get_assessment_list() |> keep(\(x) str_detect(x, "prac"))
# plot_assessment_lg(assessment_obj, AL) |> print()
