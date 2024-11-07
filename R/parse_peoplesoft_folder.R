#' parse peoplesoft folder
#'
#' @param folder folder of peoplesoft files
#'
#' @return mark-obj
#' @export
parse_peoplesoft_folder <- function(folder){
  fs::dir_ls(folder) |> 
    purrr::map(parse_peoplesoft) |> 
    purrr::list_rbind()
}
# pacman::p_load(conflicted, tidyverse)
# parse_peoplesoft_folder("inst/extdata/peoplesoft/") |> print()