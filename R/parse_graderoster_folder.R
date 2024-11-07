#' parse graderoster folder
#'
#' @param folder folder of grade-rosters
#' @param year year of grade-rosters
#'
#' @return mark-obj
#' @export
parse_graderoster_folder <- function(folder, year){
  fs::dir_ls(folder) |> 
    purrr::map(parse_graderoster, year) |> 
    purrr::list_rbind()
}
# pacman::p_load(conflicted, tidyverse)
# parse_graderoster_folder("inst/extdata/grade-rosters/", 2024) |> print()