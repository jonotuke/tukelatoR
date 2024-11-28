#' order_grade
#'
#' @param x vector of grades 
#'
#' @return grades in standard order
#' @export
order_grade <- function(x){
  grade <- factor(
    x,
    levels = c(
      "Unknown", "NFE", "RP",
      "PNG", "WF", "WNF",
      "FNS", "F", "P", "NGP",
      "C", "D", "HD", "2A", "2B", "1ST"
    )
  )
  return(grade)
}