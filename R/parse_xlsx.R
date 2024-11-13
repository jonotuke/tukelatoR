utils::globalVariables(
  c(
    "empl_id", "X1", "X2", "last_name", "first_name",
    "middle_name", "mark_grade_input", "transcript_note_id"
  )
)
#' parse_xlsx
#'
#' @param filename xlsx spreadsheet
#' @param year year of offering
#' @param term  term of offering
#'
#' @return mark-obj
#' @export
parse_xlsx <- function(filename, year, term) {
  # Export filename for debugging
  cat("Filename: ", filename, "\n\n")
  marks <- readxl::read_excel(filename, na = "NA")
  # Clean names
  marks <-
    marks |>
    janitor::clean_names()
  # Get meta-info
  marks <- marks |>
    dplyr::mutate(
      course_id = stringr::str_glue("{discipline}-{cat_no}")
    )
  # Get id and name
  marks <- marks |>
    dplyr::mutate(
      name = stringr::str_glue("{last_name},{first_name}",
        .na = ""
      ) |>
        stringr::str_remove_all("NA$") |>
        stringr::str_trim(),
    ) |>
    dplyr::select(-last_name, -first_name) |> 
    dplyr::mutate(
      id = as.character(id)
    )
  # Get grade
  marks <- marks |>
    dplyr::mutate(
      grade = calc_grade(mark),
      mark = readr::parse_number(
        as.character(mark),
        na = c("CN", "F", "FNS", "NFE", "RP", "WF", "WNF")
      )
    )
  # Add year
  marks <- marks |>
    dplyr::mutate(
      year = year
    )
    # Add term
    marks <- marks |>
      dplyr::mutate(term = term)
  # Clean columns
  marks <- marks |>
    dplyr::select(
      id, name = name, 
      course_id, 
      year, 
      term, mark, 
      grade, raa)
  # Add source
  marks <- marks |>
    dplyr::mutate(source = "xlsx")
  marks
}
# pacman::p_load(tidyverse, targets)
# xlsx_file <- "inst/extdata/xlsx/xlsx-example.xlsx"
# parse_xlsx(xlsx_file, 2024, "Sem 2") |> print()
