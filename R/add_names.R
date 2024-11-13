add_names <- function(df, x, y){
  df <- df |> 
    dplyr::select(
      course_id, course_name,
    ) |> 
    dplyr::distinct() |> 
    dplyr::group_by(course_id) |> 
    dplyr::slice(1)
  look_up <- df$course_name
  names(look_up) <- df$course_id
  look_up
  y <- ifelse(is.na(y), look_up[x], y)
}
# pacman::p_load(conflicted, tidyverse, targets)
# data(mark_obj)
# test_df <- tribble(
#   ~x, ~y, 
#   "STATS-3001", "BOB", 
#   "STATS-3001", NA
# )
# add_names(mark_obj, test_df$x, test_df$y) |> print()