#' is_peoplesoft_valid
#' 
#' Checks that XLSX has correct column names
#'
#' @param file peoplesoft-file
#'
#' @return boolean
#' @export
is_peoplesoft_valid <- function(file){
  df <- readxl::read_excel(file, skip = 1)
  colnames(df)
  if(
    all(c(
      "ID", "Name", "Subject", "Catalog", 
      "Descr", "Term", "Acad Year", "Grade In", 
      "Grade"
    ) %in% colnames(df))
  ){
    stringr::str_glue("{file} is valid") |> cat("\n")
    return(TRUE)
    } else {
    stringr::str_glue("{file} is invalid") |> cat("\n")
    return(FALSE)
  }
}
# pacman::p_load(conflicted, tidyverse, targets)
# file <- "inst/extdata/peoplesoft/2016-peoplesoft.xlsx"
# is_peoplesoft_valid(file) |> print()
# file <- "inst/extdata/peoplesoft/false-peoplesoft.xlsx"
# is_peoplesoft_valid(file) |> print()

