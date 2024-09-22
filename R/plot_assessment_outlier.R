utils::globalVariables(
  c("outlier")
)
plot_assessment_outlier <- function(assessment_obj, course_id, year, term){
  df <- assessment_obj |> 
  dplyr::filter(.data$course_id %in% .env$course_id) |> 
  dplyr::filter(.data$year == .env$year) |> 
  dplyr::filter(.data$term %in% .env$term) |> 
  dplyr::mutate(
    name = forcats::fct_reorder(name, readr::parse_number(mark)), 
    grade = forcats::fct_rev(order_grade(grade))
  ) |> 
  dplyr::mutate(outlier = is_outlier(p), .by = id) |> 
  dplyr::filter(outlier == TRUE)
  df |> 
  ggplot2::ggplot(ggplot2::aes(p, name, fill = assessment)) + 
  ggplot2::geom_point(pch = 21, size = 3) + 
  ggplot2::facet_grid(grade ~ ., scales = "free", space = "free") + 
  ggplot2::geom_point(ggplot2::aes(readr::parse_number(mark) / 100), 
  col = "black", pch = 18, size = 3) + 
  ggplot2::theme_minimal() + 
  ggplot2::theme(legend.position = "none") + 
  harrypotter::scale_colour_hp_d("Ravenclaw") + 
  harrypotter::scale_fill_hp_d("Ravenclaw")
}
# pacman::p_load(conflicted, tidyverse, targets)
# data(assessment_obj)
# assessment_obj |> count(course_id, year, term)
# assessment_obj <- assessment_obj |> 
#   filter(assessment != "raa_exam") |> 
#   filter(!str_detect(assessment, "pg|ug|sample"))
# plot_assessment_outlier(assessment_obj, "STATS-3022", 2023, "Sem 2") |> print()
