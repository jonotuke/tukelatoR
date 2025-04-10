utils::globalVariables(
  c(".data", ".env", "course_name", "n", "N", "p", "raa")
)
#' get_mark_tab
#'
#' Gives a table of marks
#' @param augmented_mark_obj augmented-mark-obj
#' @param course_id course-id
#' @param term term
#' @param year year of offering
#' @param hurdle show only 49s
#'
#' @return DT-obj
#' @export
#'
#' @examples
#' get_mark_tab(augmented_mark_obj, course_id = "DISCP-3001", term = "Sem 1", 2022)
get_mark_tab <- function(augmented_mark_obj, course_id, term, year, hurdle = FALSE){
  df <-
  augmented_mark_obj |>
  dplyr::filter(.data$course_id %in% .env$course_id) |>
  dplyr::filter(.data$year %in% .env$year) |>
  dplyr::filter(.data$term %in% .env$term)
  if(hurdle){
    df <- df |> 
      dplyr::filter(mark == 49)
  }
  # Set up colours for table
  col_back <- c(
    "#832424", "#C89089",
    "#FFFFFF", "#88A97D",
    "#005800"
  )
  # Use datatable to show table in shiny
  dt_obj <- df |> 
  dplyr::select(
    ID = id,
    Name = name,
    mark = mark,
    grade = grade,
    raa = raa,
    mean = mean,
    diff = diff
  ) |>
  dplyr::arrange(-mark) |>
  dplyr::mutate(
    mean = round(mean, 2),
    diff = round(diff, 2)
  ) 
  dt_obj |> 
  DT::datatable(
    options = list(
      pageLength = 1000,
      lengthMenu = c(20, 50, 100, 200, 1000)
    ),
    rownames = FALSE
  ) |> 
  DT::formatStyle(
    "diff",
    backgroundColor = DT::styleInterval(
      c(-5, -1, 1, 5),
      col_back
    ),
    color = DT::styleInterval(
      c(-5, -1, 1, 5),
      c("white", "white", "black", "white", "white")
    )
  ) |>
  DT::formatStyle(
    "grade",
    backgroundColor = DT::styleEqual(
      unique(df$grade),
      harrypotter::hp(length(unique(df$grade)), house = "Ravenclaw")
    ),
    color = "white"
  )
}
