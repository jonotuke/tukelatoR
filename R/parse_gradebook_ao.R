utils::globalVariables(
  c("assessment", "value", "total", "sis_login_id")
)
#' parse gradebook ao
#'
#' @param file gradebook CSV
#' @param year year of offering
#'
#' @return assessment-object
#' @export
parse_gradebook_ao <- function(file, year){
  df <- readr::read_csv(file, show_col_types = FALSE)
  
  # First row is sometimes about manual posting so remove
  df <- df |> dplyr::filter(!is.na(Student))
  
  # Remove test student
  df <- df |> dplyr::filter(Student != "student, Test")
  
  # Clean column names
  df <- df |> dplyr::rename_with(.fn = clean_names)
  df <- df |> janitor::clean_names()
  
  # Add name and id
  df <- df |> 
    dplyr::select(!id) |> 
    dplyr::select(!sis_login_id) |> 
    dplyr::rename(id = sis_user_id, name = student)
  
  # add term
  df <- df |> 
  dplyr::mutate(
    term = parse_section(section, "term")
  ) |> 
    dplyr::mutate(
      term = convert_term(term)
    )
  
  # add year
  df <- df |> 
  dplyr::mutate(
    year = year
  )

  # course id
  df <- df |> 
  dplyr::mutate(
    course_id = parse_section(section, "course_id")
  )

  # Remove section
  df <- df |> 
    dplyr::select(!section)

  # add mark
  df <- df |> 
    dplyr::rename(
      mark = unposted_final_score, 
      grade = unposted_final_grade
    )
  
  # Remove score columns
  df <- df |> 
    dplyr::select(!dplyr::matches("score")) |> 
    dplyr::select(!dplyr::matches("_grade")) 
  
  # Clean cols
  df <- df |> 
    dplyr::mutate(
      dplyr::across(
        -c("name", "id", "year", "course_id", "mark", "grade", "term"), 
        deal_ex
      )
    )
  
  # Pivot longer
  df <- df |> 
    tidyr::pivot_longer(
      -c("name", "id", "year", "course_id", "mark", "grade", "term"), 
      names_to = "assessment"
    )
  
  # Get total
  totals <- df |> 
    dplyr::filter(name == "Points Possible") |> 
    dplyr::select(assessment, total = value)
  df <- df |> dplyr::filter(name != "Points Possible")
  
  # Add totals
  df <- df |> 
    dplyr::left_join(totals, by = "assessment")

  # Add prop
  df <- df |> 
    dplyr::mutate(p = value / total)
}
# pacman::p_load(conflicted, tidyverse, targets)
# parse_gradebook_ao("inst/extdata/grade-book/2023-ds.csv", 2023) |> print()
# parse_gradebook_ao("inst/extdata/grade-book/2024-sc.csv", 2024) |> print()