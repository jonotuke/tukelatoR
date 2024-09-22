utils::globalVariables(
  c("outlier")
)
#' plot assessment box-plot
#'
#' @param assessment_obj assessment object
#' @param assessment_list list of assessments to display
#'
#' @return plot of marks
#' @export
#'
#' @examples
#' assessment_obj <- assessment_obj |> filter_assessment("STATS-3022", 2023, "Sem 2")
#' AL <- assessment_obj |> get_assessment_list() 
#' plot_assessment_bp(assessment_obj, AL)
plot_assessment_bp <- function(assessment_obj, assessment_list){
  df <- assessment_obj |> 
  dplyr::filter(assessment %in% assessment_list) |> 
  dplyr::mutate(
    assessment = forcats::fct_reorder(assessment, p, .na_rm = TRUE)
  )
  
  df |> 
  ggplot2::ggplot(ggplot2::aes(assessment, p, fill = assessment)) + 
  ggplot2::geom_boxplot(show.legend = FALSE) + 
  ggplot2::coord_flip() + 
  ggplot2::theme_minimal() + 
  harrypotter::scale_fill_hp_d("Ravenclaw") + 
  ggplot2::scale_y_continuous(labels = scales::percent) + 
  ggplot2::labs(x = NULL, y = "Marks")
}
# pacman::p_load(conflicted, tidyverse, targets)
# data(assessment_obj)
# assessment_obj |> count(course_id, year, term)
# assessment_obj <- assessment_obj |> filter_assessment("STATS-3022", 2023, "Sem 2")
# assessment_obj |> count(course_id, year, term)
# AL <- assessment_obj |> get_assessment_list() |> keep(\(x) str_detect(x, "test|exam"))
# plot_assessment_bp(assessment_obj, AL) |> print()
