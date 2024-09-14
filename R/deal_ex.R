#' deal with EX
#' 
#' converts missing to 0, and EX to missing
#'
#' @param x vector of marks
#'
#' @return cleaned vector of marks
#' @export
#'
#' @examples
#' deal_ex(c(1, NA, "EX"))
deal_ex <- function(x){
  x[is.na(x)] <- 0
  if(is.numeric(x)){
    return(x)
  }
  x[x == "EX"] <- NA
  x <- readr::parse_number(x, na = "(read only)")
  x
}