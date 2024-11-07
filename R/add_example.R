#' add example
#'
#' @param folder folder to place example
#' @param type type of example file 
#'
#' @return NULL
#' @export
add_example <- function(folder, type){
  file <- dplyr::case_when(
    type == "GR" ~ "grade-roster-example.xlsx", 
    type == "GB" ~ "grade-book-example.csv", 
    TRUE ~ NA
  )
  move_example(folder, file)
}
# pacman::p_load(conflicted, tidyverse, targets)
# fs::dir_create("example-folder")
# add_example("example-folder/", "GR")