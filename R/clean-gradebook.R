utils::globalVariables(
  c("Student", "unposted_current_score", "sis_login_id", "sis_user_id")
)
#' clean gradebook
#'
#' @param file gradebook CSV
#'
#' @return cleaned gradebook
#' @export
clean_gradebook <- function(file){
  df <- readr::read_csv(file, show_col_types = FALSE)
  
  # First row is sometimes about manual posting so remove
  df <- df |> dplyr::filter(!is.na(Student))
  
  # Remove test student
  df <- df |> dplyr::filter(Student != "student, Test")
  
  # Clean column names
  df <- df |> dplyr::rename_with(.fn = clean_names)
  df <- df |> janitor::clean_names()
  
  # Remove columns with name Score or Grade
  df <- df |> dplyr::rename(total = unposted_current_score)
  df <- df |> dplyr::select(-tidyselect::matches("score"))
  df <- df |> dplyr::select(-tidyselect::matches("grade"))
  
  # get student id
  df <- df |> dplyr::rename(student_id = sis_login_id)
  
  # remove other id columns
  df <- df |> dplyr::select(-id, -sis_user_id)

  # add term
  df <- df |> 
    dplyr::mutate(
      term = parse_section(section, "term")
    )
  
  # course id
  df <- df |> 
    dplyr::mutate(
      course_id = parse_section(section, "course_id")
    )
  
  # Deal with missing values and EX
  df <- df |>
  dplyr::mutate(
    dplyr::across(
      -c("student", "student_id", "term", "course_id"),
      .fns = deal_ex
    )
  )
  df
}
# pacman::p_load(tidyverse, targets)
# clean_gradebook("inst/extdata/grade-book/2023-ds.csv") |> glimpse()

