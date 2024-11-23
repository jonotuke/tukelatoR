utils::globalVariables(
  c("email", "last_modified_time", "cat_no", "subject_area")
)
#' parse examiners report
#'
#' @param file examiners report
#'
#' @return tibble of examiners reports
#' @export
parse_examiners_report <- function(file){
  file |> 
    readxl::read_excel() |> 
    janitor::clean_names() |> 
    dplyr::select(-c(id:email), -last_modified_time) |> 
    dplyr::rename(
      course_cc = name,
      cat_no = dplyr::starts_with("course_number_e_g_1011"),
      assessment = dplyr::starts_with("assessment_summary"),
      audit = dplyr::starts_with("an_audit_of_10_percent"),
      hurdle = dplyr::starts_with("is_there_a_hurdle"),
      hurdle_details = dplyr::starts_with("if_there_is_a_hurdle"),
      stack = dplyr::starts_with("is_this_course_stacked"),
      scaling = dplyr::starts_with("do_you_propose_any"),
      scaling_details = dplyr::starts_with("if_an_adjustment_"),
      student = dplyr::starts_with("particular_students_to"),
      comments = dplyr::starts_with("are_there_any_factors"),
      changes = dplyr::starts_with("are_there_any_significant")
    ) |> 
    dplyr::mutate(
      course_id = stringr::str_glue(
        "{subject_area}-{cat_no}"
      )
    ) |> 
    dplyr::select(!subject_area) |> 
    dplyr::select(!cat_no)
}
# pacman::p_load(conflicted, tidyverse, targets)
# file <- "~/Dropbox/01-projects/2024-exam-marks/raw-data/examiner-reports/2024-s2-examiners-report.xlsx"
# parse_examiners_report(file) |> print()