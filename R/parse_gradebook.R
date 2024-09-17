utils::globalVariables(
  c("student","section", "unposted_final_score", 
  "unposted_final_grade", "Student", "sis_user_id"
)
)
#' parse gradebook
#'
#' @param file gradebook CSV
#' @param year year of offering
#'
#' @return mark-object
#' @export
parse_gradebook <- function(file, year){
  df <- readr::read_csv(file, show_col_types = FALSE)
  
  # First row is sometimes about manual posting so remove
  df <- df |> dplyr::filter(!is.na(Student))
  
  # Remove test student
  df <- df |> dplyr::filter(Student != "student, Test")

  # Remove points possible row
  df <- df |> dplyr::filter(Student != "Points Possible")
  
  # Clean column names
  df <- df |> dplyr::rename_with(.fn = clean_names)
  df <- df |> janitor::clean_names()

  # Select columns
  df <- df |> 
    dplyr::select(
      id = sis_user_id, name = student, 
    section, 
    mark = unposted_final_score, 
    grade = unposted_final_grade)
    # add term
    df <- df |> 
      dplyr::mutate(
    term = parse_section(section, "term")
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
  
    df <- df |> 
      dplyr::mutate(
        mark = deal_ex(mark), 
        mark = round(mark)
      )
  return(df)

}
# pacman::p_load(tidyverse, targets)
# parse_gradebook("inst/extdata/grade-book/2023-ds.csv", 2023) |> 
#   glimpse()

