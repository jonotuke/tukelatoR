#' plot intersection
#'
#' @param intersection_obj intersection object
#'
#' @return plots of pairwise scatter
#' @export
plot_intersection <- function(intersection_obj){
  intersection_obj |> 
    dplyr::select(dplyr::where(is.numeric)) |> 
    GGally::ggpairs() + 
    ggplot2::theme_bw()
}
# pacman::p_load(conflicted, tidyverse, targets)
# intersection <- get_intersection(
#   mark_obj, 
#   "DISCP-3001", 
#   "Sem 1", 
#   2024, 
#   c("DISCP-1001")
# )
# plot_intersection(intersection) |> print()