utils::globalVariables(
  c("id", "name", "subject", "catalog", "term", 
    "acad_year", "grade_in", "grade", "mark", "descr", 
    "year", "name.x", "name.y", "term_codes"
)
)
#' parse_peoplesoft
#'
#' @param file a peoplesoft file
#'
#' @return mark tibble
#' @export
parse_peoplesoft <- function(file){
  df <- readxl::read_excel(file, skip = 1)
  utils::data(term_codes, package = "tukelatoR")
  df |> 
  janitor::clean_names() |> 
  dplyr::select(
    id, name, 
    subject, catalog, course_name = descr,
    term, year = acad_year, 
    mark = grade_in, 
    grade
  ) |> 
  dplyr::mutate(
    course_id = stringr::str_glue("{subject}-{catalog}"),
    # Some marks are CN etc - set as NA
    mark = get_mark(mark), 
    year = readr::parse_number(year), 
    term = readr::parse_number(term)
  ) |> 
  dplyr::select(-subject, -catalog) |> 
  dplyr::distinct() |> 
    dplyr::mutate(term = convert_term(term)) |> 
    dplyr::mutate(source = "peoplesoft") |> 
    dplyr::filter(!is.na(mark))
}
# pacman::p_load(conflicted, tidyverse, targets)
# parse_peoplesoft("~/Dropbox/01-projects/2024-exam-marks/raw-data/peoplesoft/maths/2024-peoplesoft.xlsx") |> glimpse()
