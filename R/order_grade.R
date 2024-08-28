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
      "Unknown", "NFE", "RP","NGP",
      "PNG", "WF", "WNF",
      "FNS", "F", "P",
      "C", "D", "HD"
    )
  )
  return(grade)
}