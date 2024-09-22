utils::globalVariables(
  c(
    "empl_id", "X1", "X2", "last_name", "first_name", 
    "middle_name", "mark_grade_input", "transcript_note_id"
  )
)
#' parse_graderoster
#'
#' @param filename CSV or XLSX grade-roster
#' @param year year of offering
#'
#' @return mark-obj
#' @export
parse_graderoster <- function(filename, year){
  # Export filename for debugging
  cat("Filename: ", filename, "\n\n")
  # Find if XLSX or CSV
  EXT <- ifelse(stringr::str_detect(filename, ".csv$"), "CSV", "XLSX")
  # Read in data
  false_names = stringr::str_c("X", 1:12)
  if(EXT == 'XLSX'){
    df <- readxl::read_excel(filename, na = "NA", col_names = false_names)
  } else {
    df <- readr::read_csv(filename, col_names = false_names, show_col_types = FALSE)
  }
  # Find position of first line of marks
  index <- which(df[, 1] == "EmplID")
  # Read in marks
  if(EXT == "XLSX"){
    marks <- readxl::read_excel(filename, skip = index-1)
  } else {
    marks <- readr::read_csv(filename, skip = index-1,show_col_types = FALSE)
  }
  # clean colnames
  marks <- marks |> janitor::clean_names()
  # Get meta-info
  meta <- df |> 
  dplyr::slice(1:(index - 1)) |> 
  dplyr::select(key = X1, value = X2) |> 
  stats::na.omit()
  # Get course_id
  discipline <- meta$value[meta$key == "Subject:"]
  cat_no <- meta$value[meta$key == "Catalog Nbr:"]
  course_id <- stringr::str_glue("{discipline}-{cat_no}")
  marks <- marks |> 
  dplyr::mutate(
    course_id = course_id
  ) 
  # Get id and name
  marks <- marks |> 
  dplyr::mutate(
    name = stringr::str_glue("{last_name},{first_name} {middle_name}",
    .na = "") |> 
    stringr::str_remove_all("NA$") |> 
    stringr::str_trim(),
    
    id = as.character(empl_id)
  ) |> 
  dplyr::select(-empl_id, -last_name, -first_name, -middle_name)
  # Get grade
  marks <- marks |> 
  dplyr::mutate(
    grade = calc_grade(mark_grade_input), 
    mark = readr::parse_number(mark_grade_input, na = c("CN", "F", "FNS", "NFE", "RP", "WF", "WNF"))
  )
  # Add year
  marks <- marks |> 
  dplyr::mutate(
    year = year
  )
  # Add term
  marks <- marks |> 
    dplyr::mutate(term = convert_term(term))
  # Clean columns
  marks <- marks |> 
  dplyr::select(id, name = name, course_id, year, term, mark, grade, raa = transcript_note_id)
  # Add source
  marks <- marks |> 
    dplyr::mutate(source = "graderoster")
  marks
}
# pacman::p_load(tidyverse, targets)
# xlsx_file <- "inst/extdata/grade-rosters/test-grade-roster.xlsx"
# csv_file <- "inst/extdata/grade-rosters/test-grade-roster.csv"
# parse_graderoster(xlsx_file, 2024) |> print()
# parse_graderoster(csv_file, 2024) |> print()
