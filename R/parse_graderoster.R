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
parse_graderoster <- function(filename, year) {
  # Export filename for debugging
  cat("Filename: ", filename, "\n\n")
  # Find if XLSX or CSV
  EXT <- ifelse(stringr::str_detect(filename, ".csv$"), "CSV", "XLSX")
  # Read in data
  false_names <- stringr::str_c("X", 1:12)
  if (EXT == "XLSX") {
    suppressMessages(df <- readxl::read_excel(filename, na = "NA"))
  } else {
    df <- readr::read_csv(filename, show_col_types = FALSE)
  }
  colnames(df) <- stringr::str_c("X", 1:ncol(df))
  # Find position of first line of marks
  index <- which(df[, 1] == "EmplID")
  # Read in marks
  if (EXT == "XLSX") {
    suppressMessages(marks <- readxl::read_excel(filename, skip = index))
  } else {
    marks <- readr::read_csv(filename, skip = index - 1, show_col_types = FALSE)
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
        .na = ""
      ) |>
        stringr::str_remove_all("NA$") |>
        stringr::str_trim(),
      id = as.character(empl_id)
    ) |>
    dplyr::select(-empl_id, -last_name, -first_name, -middle_name)
  # Get grade
  marks <- marks |>
    dplyr::mutate(
      grade = calc_grade(mark_grade_input),
      mark = get_mark(mark_grade_input)
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
  # Clean course ids
  marks <- marks |>
    dplyr::mutate(
      course_id = stringr::str_replace(course_id, "COMP-SCI ", "COMP SCI-")
    )
  marks
}
# pacman::p_load(tidyverse, targets)
# file <- "~/Dropbox/01-projects/2024-exam-marks/raw-data/graderosters/2024-t3/grade-roster-example.xlsx"
# parse_graderoster(file, 2024) |> print()
