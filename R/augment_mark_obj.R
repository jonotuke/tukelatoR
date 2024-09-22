#' augment_mark_obj
#'
#' @param mark_obj mark-obj
#'
#' @return augmented-mark-obj
#' @export
#'
#' @examples
#' augment_mark_obj(mark_obj)
augment_mark_obj <- function(mark_obj){
  df <- mark_obj |> 
  dplyr::mutate(
    N = sum(!is.na(mark)),
    mean = mean(mark, na.rm = TRUE), 
    diff = N * (mark - mean) / (N - 1), 
    .by = id
  ) 
  df
  
} 
# pacman::p_load(conflicted, tidyverse, targets)
# data(example_marks)
# augment_mark_obj(example_marks) |> print()