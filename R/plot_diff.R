#' plot difference
#'
#' @param augmented_mark_obj augmented mark object
#' @param course_id course ID
#' @param year year of offering
#' @param term term of offering
#'
#' @return ggplot plot
#' @export
plot_diff <- function(augmented_mark_obj, course_id, year, term){
  augmented_mark_obj |> 
    dplyr::filter(.data$course_id == .env$course_id) |> 
    dplyr::filter(.data$year == .env$year) |> 
    dplyr::filter(.data$term %in% .env$term) |> 
    ggplot2::ggplot(ggplot2::aes(mark, diff)) + 
    ggplot2::geom_point() + 
    ggplot2::geom_hline(yintercept = 0, linetype = "dashed", size = 1) + 
    ggplot2::theme_bw()
}
# pacman::p_load(conflicted, tidyverse, targets)
# data(augmented_mark_obj)
# plot_diff(augmented_mark_obj, "DISCP-1001", 2020, c("Sem 2", "Sem 1")) |> print()
