#' sim assessment
#'
#' @param students students object
#'
#' @return assessment object
#' @export
#'
#' @examples
#' sim_students(2) |> sim_assessment()
sim_assessment <- function(students){
  students |> 
    tidyr::expand_grid(
      tibble::tibble(
        year = 2024, 
        term = "Sem 1", 
        course_id = "DISCP-1234", 
        assessment = stringr::str_c("A", 1:5)
      )
    ) |> 
    dplyr::rowwise() |> 
    dplyr::mutate(
      value = stats::rbinom(1, size = 20, prob = ability/100), 
      total = 20, 
      p = value / total
    ) |> 
    dplyr::group_by(id) |> 
    dplyr::mutate(
      mark = sum(value), 
      grade = calc_grade(mark)
    ) |> 
    dplyr::select(!ability) |> 
    dplyr::relocate(mark, grade, .after = name)
}
# sim_students(2) |> sim_assessment() |> print()
# assessment_obj |> print()