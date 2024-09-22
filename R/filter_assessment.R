#' filter assessment
#'
#' @param assessment_obj assessment object
#' @param course_id course_id
#' @param year year of offering
#' @param term year of offering
#'
#' @return filtered assessment object
#' @export
#'
#' @examples
#' filter_assessment(assessment_obj, "STATS-3022", 2023, "Sem 2")
filter_assessment <- function(assessment_obj, course_id, year, term){
  assessment_obj |> 
    dplyr::filter(.data$course_id %in% .env$course_id) |> 
    dplyr::filter(.data$year == .env$year) |> 
    dplyr::filter(.data$term %in% .env$term)
}
# data(assessment_obj)
# assessment_obj |> count(course_id, year, term) |> print()
# assessment_obj |> 
# filter_assessment("STATS-3022", 2023, "Sem 2") |> 
# count(course_id, year, term) |> print()