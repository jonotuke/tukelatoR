utils::globalVariables(
  c("section", "term_course", "displ")
)
parse_gradebook <- function(file){
  gb <- file |> 
  readr::read_csv() |> 
  janitor::clean_names()
  # term and course_id
  gb <- 
  gb |> 
  dplyr::mutate(
    term_course = stringr::str_extract(
      section, "\\d{4}_.*?_\\d{4}"
    )
  ) |> 
  tidyr::separate(term_course, into = c("term", "displ", "catalog")) |> 
  dplyr::mutate(
    course_id = stringr::str_glue("{displ}-{catalog}")
  ) |> 
  dplyr::select(
    -displ, 
    -catalog
  )
}
# Use clean-gradebook from Pearson
# pacman::p_load(conflicted, tidyverse, targets)
# parse_gradebook("inst/extdata/grade-book/2023-ds.csv") |> 
# print()
