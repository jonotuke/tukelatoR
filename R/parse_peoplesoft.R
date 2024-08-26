utils::globalVariables(
  c("id", "name", "subject", "catalog", "term", 
"acad_year", "grade_in", "grade", "mark")
)
#' parse_peoplesoft
#'
#' @param file a peoplesoft file
#'
#' @return mark tibble
#' @export
parse_peoplesoft <- function(file){
  df <- readxl::read_excel(file, skip = 1)
  df |> 
    janitor::clean_names() |> 
    dplyr::select(
      id, name, 
      subject, catalog, 
      term, year = acad_year, 
      mark = grade_in, 
    grade
  ) |> 
    dplyr::mutate(
      course = stringr::str_glue("{subject}-{catalog}"),
      mark = readr::parse_number(mark)
    ) |> 
    dplyr::select(-subject, -catalog)
}
# pacman::p_load(conflicted, tidyverse, targets)
# parse_peoplesoft("inst/extdata/2016-peoplesoft.xlsx") |> glimpse()
