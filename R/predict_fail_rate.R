#' predict_fail_rate
#'
#' @param NF number of fails based on grades
#' @param MS number of medical supps
#' @param AS number of academic supps
#' @param MSPR medical supp expected pass rate
#' @param ASPR academic supp expected pass rate
#'
#' @return Predicted number of fails post supps. 
#' @export
#'
#' @examples
#' predict_fail_rate(10, 2, 2)
predict_fail_rate <- function(NF, MS, AS, MSPR = 0.8, ASPR = 0.5){
  AF <- NF - MS - AS
  PF <- MS * (1 - MSPR) + 
    AS * (1 - ASPR) + AF
  PF <- round(PF)
  PF
}
# library(tidyverse)
# library(tukelatoR)
# predict_fail_rate(5, 3, 2) |> print()
# predict_fail_rate(10, 0, 0) |> print()