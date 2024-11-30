#' plot marks
#'
#' @param mark_obj mark object
#' @param course_id course ID
#' @param year year of offering
#' @param term term of offering
#'
#' @return ggplot plot
#' @export
plot_marks <- function(mark_obj, course_id, year, term){
  mark_obj |> 
    dplyr::filter(.data$course_id == .env$course_id) |> 
    dplyr::filter(.data$year == .env$year) |> 
    dplyr::filter(.data$term %in% .env$term) |> 
    ggplot2::ggplot(ggplot2::aes(mark, fill = grade)) + 
    ggplot2::geom_bar(col = "black", show.legend = FALSE) + 
    ggplot2::theme_bw() + 
      harrypotter::scale_fill_hp_d("Ravenclaw")
}
# pacman::p_load(conflicted, tidyverse, targets)
# data(mark_obj)
# plot_marks(mark_obj, "DISCP-1001", 2020, c("Sem 2", "Sem 1")) |> print()
