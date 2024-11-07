#' parse gradebook folder
#'
#' @param folder folder of gradebooks
#' @param year year of gradebooks
#' @param type type of object assessment or mark
#'
#' @return mark-obj or assessment-obj
#' @export
parse_gradebook_folder <- function(folder, year, type = "mark-obj") {
  if (type == "mark-obj") {
    df <-
      fs::dir_ls(folder) |>
      purrr::map(parse_gradebook, year) |>
      purrr::list_rbind()
  } else if (type == "ass-obj") {
    df <-
      fs::dir_ls(folder) |>
      purrr::map(parse_gradebook_ao, year) |>
      purrr::list_rbind()
  }
  df
}
# pacman::p_load(conflicted, tidyverse)
# parse_gradebook_folder("inst/extdata/grade-book/", 2024) |> print()
# parse_gradebook_folder("inst/extdata/grade-book/", 2024, type = "ass-obj") |> print()
