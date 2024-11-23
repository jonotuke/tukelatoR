utils::globalVariables(
  c("marks_dist")
)
#' sim_student
#'
#' @param id_length length of ID 
#'
#' @return student object
#' @export
#'
#' @examples
#' sim_student(id_length = 5)
sim_student <- function(id_length = 7){
  utils::data(marks_dist, package = "tukelatoR")
  tibble::tibble(
    id = sim_id(id_length), 
    name = randomNames::randomNames(1), 
    ability = sample(marks_dist$mark, size = 1, prob = marks_dist$n)
  )
}
#' sim students
#'
#' @param n_students number of students to simulate
#' @param ... extra variables
#'
#' @return students object
#' @export
#'
#' @examples
#' sim_students(id_length = 3)
sim_students <- function(n_students = 10, ...){
  1:n_students |> 
    purrr::map(\(x) sim_student(...)) |> 
    purrr::list_rbind()
}