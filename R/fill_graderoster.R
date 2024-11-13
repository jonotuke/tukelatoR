utils::globalVariables(
  c("student_id", "X13")
)
#' fill grade roster
#'
#' @param mark_obj mark object
#' @param infile empty graderoster
#' @param RAA marks to give RAA
#' @param year offering year
#' @param term offering term
#'
#' @return nothing
#' @export
fill_graderoster <- function(mark_obj, infile, year, term, RAA = 45:49) {
  outfile <- stringr::str_c(
    stringr::str_remove(infile, "\\.xlsx|\\.XLSX"),
    "-final.xlsx"
  )
  # Convert XLSX to CSV temp
  csv_infile <- fs::file_temp(ext = "csv")
  csv_outfile <- fs::file_temp(ext = "csv")
  infile |>
    readxl::read_excel(col_names = FALSE) |>
    readr::write_csv(csv_infile, na = "", col_names = FALSE)
  # Read in the grade roster
  grade_roster <- readr::read_lines(csv_infile)
  # Find start of data
  i <- which(stringr::str_detect(grade_roster, "EmplID"))
  # Get header
  header <- grade_roster[1:(i - 1)]
  # Write out header
  readr::write_lines(header, csv_outfile)
  # data
  data <- readr::read_csv(csv_infile,
    skip = i - 1,
    show_col_types = FALSE
  )

  # Get course id
  course_id <- get_graderoster_course_id(infile)
  # Filter mark_obj based on course id and offering
  mark_obj <- 
    mark_obj |> 
    dplyr::filter(
      .data$course_id == .env$course_id, 
      .data$year == .env$year, 
      .data$term == .env$term
    )
  # Get IDs
  IDs <- mark_obj |> dplyr::pull(id)
  # Convert to no-a version
  IDs <- as.numeric(stringr::str_remove(IDs, "a"))
  # Get totals
  total <- mark_obj |> dplyr::pull(mark)
  # round totals
  total <- round(total)
  # Add totals
  for (i in 1:nrow(data)) {
    ID <- data$EmplID[i]
    index <- which(IDs == ID)
    if (length(index) > 0) {
      # Add total
      data$`Mark/Grade Input`[i] <- total[index]
      # Add supp code
      if (total[index] %in% RAA) {
        data$`Transcript Note ID`[i] <- "US10"
      }
      # Add RPs - show as NA in marks
      if (is.na(total[index])) {
        data$`Mark/Grade Input`[i] <- "RP"
      }
      # Add FNS
      if (!is.na(total[index]) & total[index] == 0) {
        data$`Mark/Grade Input`[i] <- "FNS"
      }
    }
  }
  # Remove extra column if needed
  if ("X13" %in% colnames(data)) {
    data <-
      data |>
      dplyr::select(-X13)
  }
  readr::write_csv(data, csv_outfile,
    append = TRUE, na = "", col_names = TRUE
  )
  csv_outfile |>
    readr::read_csv(col_names = FALSE) |>
    writexl::write_xlsx(outfile, col_names = FALSE)
  outfile
}
# pacman::p_load(conflicted, tidyverse, targets)
# marks <- bind_rows(
#   parse_xlsx("inst/examples/xlsx-example.xlsx", year = 2024, "Sem 2"),
#   parse_xlsx("inst/examples/xlsx-example-2.xlsx", year = 2024, "Sem 2")
# )
# fill_graderoster(
#   marks,
#   infile = "inst/examples/empty-grade-roster-example.xlsx", 
#   year = 2024, 
#   term = "Sem 2"
# ) |> print()
# fill_graderoster(
#   marks,
#   infile = "inst/examples/empty-grade-roster-example-2.xlsx", 
#   year = 2024, 
#   term = "Sem 2"
# ) |> print()
