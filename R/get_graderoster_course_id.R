#' get GR course id
#'
#' @param file graderoster file
#'
#' @return course id
#' @export
get_graderoster_course_id <- function(file){
  df <- 
    file |> 
    readxl::read_excel()
  discipline_index <- which(stringr::str_detect(df[[1]], "Subject:"))
  discipline <- df[[2]][discipline_index]
  cat_no_index <- which(stringr::str_detect(df[[1]], "Catalog Nbr:"))
  cat_no <- df[[2]][cat_no_index]
  course_id <- stringr::str_glue("{discipline}-{cat_no}")
}
# pacman::p_load(conflicted, tidyverse, targets)
# get_graderoster_course_id("inst/examples/empty-grade-roster-example.xlsx") |> print()