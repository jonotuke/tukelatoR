utils::globalVariables(
  c("ability")
)
#' Simulate marks
#'
#' @param students students object
#' @param start_year year started degree
#'
#' @return mark object
#' @export
#'
#' @examples
#' sim_students(2) |> sim_marks(2000)
sim_marks <- function(students, start_year) {
  courses <-
    tibble::tibble(
      course_id = stringr::str_c(
        "DISCP-",
        c(1001, 2001, 2002, 3001, 3002, 3003, 3004)
      ),
      course_name = stringr::str_c(
        "course-", 1:7
      ),
      year = c(
        start_year,
        start_year + 1,
        start_year + 1,
        start_year + 2,
        start_year + 2,
        start_year + 2,
        start_year + 2
      ),
      term = c(
        "Sem 1",
        "Sem 1",
        "Sem 2",
        "Sem 1",
        "Sem 1",
        "Sem 2",
        "Sem 2"
      )
    )
  degree <-
    students |>
    tidyr::expand_grid(courses)
  degree$mark <- pmin(
    100,
    pmax(
      0,
      round(degree$ability + stats::rnorm(n = nrow(degree), 0, 4))
    )
  )
  degree <- degree |> 
    dplyr::mutate(
      grade = calc_grade(mark), 
      raa = NA,
      source = "simulation"
    ) |> 
    dplyr::select(!ability)
  degree
}
# students <- sim_students(n = 2)
# sim_marks(students, start_year = 2001) |> print()
