utils::globalVariables(
  c("course_cc", "type")
)
#' get examiners report
#'
#' @param examiners_reports examiners report tibble
#' @param examiner course coordinator
#'
#' @return table of report
#' @export
get_examiners_report <- function(examiners_reports, examiner) {
  reports <- examiners_reports |>
    dplyr::filter(
      stringr::str_detect(course_cc, stringr::regex(examiner, ignore_case = TRUE)) | 
      stringr::str_detect(course_name, stringr::regex(examiner, ignore_case = TRUE)) | 
      stringr::str_detect(course_id, stringr::regex(examiner, ignore_case = TRUE))
    ) |>
    tidyr::pivot_longer(-course_name) |>
    tidyr::pivot_wider(
      names_from = course_name,
      values_from = value
    ) |> 
    dplyr::mutate(
      type = dplyr::case_when(
        stringr::str_detect(name, "hurdle") ~ "Hurdle",
        stringr::str_detect(name, "scal|audit") ~ "Scaling",
        stringr::str_detect(name, "assess") ~ "Assessment",
        stringr::str_detect(name, "comm|chan|stud") ~ "Comments",
      TRUE~ "Course"
      )
    ) |> 
    dplyr::mutate(
      type = factor(type, levels = c("Course", "Assessment", "Scaling", "Hurdle", "Comments"))
    ) |> 
  dplyr::arrange(type)
  # reports |> 
  #   gt::gt() |> 
  #     gt::tab_style(
  #       style = list(
  #         gt::cell_fill(color = "grey80"),
  #         gt::cell_text(weight = "bold")
  #       ),
  #       locations = gt::cells_row_groups()
  #     ) |> 
  #   gt::sub_missing()
  reports |> 
    DT::datatable(
      options = list(
        pageLength = 1000,
        lengthMenu = c(20, 50, 100, 200, 1000)
      ),
      rownames = FALSE
    ) |> 
    DT::formatStyle(
      "type",
      target = "row",
      backgroundColor = DT::styleEqual(
        unique(reports$type),
        harrypotter::hp(length(unique(reports$type)), house = "Ravenclaw", alpha = 0.5)
      ),
      color = "black"
    )
}
# pacman::p_load(conflicted, tidyverse, targets, tukelatoR)
# conflicts_prefer(dplyr::filter)
# file <- "~/Dropbox/01-projects/2024-exam-marks/raw-data/examiner-reports/2024-s2-examiners-report.xlsx"
# examiners_reports <- parse_examiners_report(file)
# get_examiners_report(examiners_reports, "dan") |> print()
