
utils::globalVariables(
  c(".data", ".env", "course_name", "n", "N", "p")
)
#' get_grade_tab
#'
#' Gives a table of grades
#' @param mark_obj standard mark tibble
#' @param course_id course-id
#' @param term term
#'
#' @return gt-table
#' @export
#'
#' @examples
#' get_grade_tab(mark_obj, course_id = "STATS-3001", term = "Sem 1")
get_grade_tab <- function(mark_obj, course_id, term){
  df <- mark_obj |>
  dplyr::filter(.data$course_id %in% .env$course_id) |>
  dplyr::filter(.data$term %in% .env$term) |>
  dplyr::count(course_name, year, term, grade) |>
  dplyr::group_by(course_name, year, term) |>
  dplyr::mutate(
    N = sum(n),
    p = n / N,
    grade = order_grade(grade),
    p = stringr::str_glue("{round(p, 2)} [{n}]")) |>
    dplyr::select(-n) |>
    dplyr::arrange(grade) |>
    tidyr::pivot_wider(names_from = grade, values_from = p) |>
    dplyr::group_by(course_name) |>
    dplyr::mutate(term = forcats::fct_rev(factor(term))) |>
    dplyr::relocate(N, .after = dplyr::last_col()) |>
    dplyr::arrange(-year, term)
    n_col <- ncol(df)
    cols <- seq(4, n_col, 2)
    df |>
    gt::gt() |>
    gt::sub_missing(col = -c(year, term)) |>
    gt::cols_align(col = -c(year, term), align = "right") |>
    gt::tab_style(
      style = list(
        gt::cell_fill(color = "grey80")
      ),
      location = gt::cells_body(columns = cols)
    ) |> 
    gt::tab_style(
      style = list(
        gt::cell_borders("left", weight = gt::px(3))
      ), 
      location = gt::cells_body(columns = N)
    )
  }
  # pacman::p_load(conflicted, tidyverse, gt)
  # get_grade_tab(example_marks, course_id = "STATS-3001", term = "Sem 1") |> print()