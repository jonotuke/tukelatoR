#' parse xlsx folder
#'
#' @param folder folder of xlsx
#' @param year year of xlsx
#' @param term term of offering
#'
#' @return mark-obj or assessment-obj
#' @export
parse_xlsx_folder <- function(folder, year, term) {
      fs::dir_ls(folder) |>
      purrr::map(parse_xlsx, year, term) |>
      purrr::list_rbind()
}
# pacman::p_load(conflicted, tidyverse)
# parse_xlsx_folder("inst/extdata/xlsx/", 2024, "Sem 2") |> print()
