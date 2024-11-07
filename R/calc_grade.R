#' calc_grade
#' 
#' Based on https://www.adelaide.edu.au/policies/700/all/?dsn=policy.version;field=data;id=34226;m=view
#'
#' @param x vector of marks.  
#'
#' @return vector of grades
#' @export
#'
#' @examples
#' calc_grade(c("FNS", "WNF", "RP", "WF", 0:100))
calc_grade <- function(x){
  if(is.character(x)){
    y <- readr::parse_integer(x, na = c("CN", "F", "FNS", "NFE", "RP", "WF", "WNF"))
  } else {
    y <- x
    x <- as.character(x)
  }
  grade <- dplyr::case_when(
    x == "WNF" ~ "WNF",
    x == "WF" ~ "WF",
    x == "PNG" ~ "PNG",
    x == "NFE" ~ "NFE",
    x == "RP" ~ "RP",
    x == "2A" ~ "2A",
    x == "2B" ~ "2B",
    x == "CN" ~ "CN",
    x == "NGP" ~ "NGP",
    stringr::str_detect(x, "\\*") ~ "WNF",
    y == 0 ~ "FNS",
    dplyr::between(y, 1, 49) ~ "F",
    dplyr::between(y, 50, 64) ~ "P",
    dplyr::between(y, 65, 74) ~ "C",
    dplyr::between(y, 75, 84) ~ "D",
    dplyr::between(y, 85, 100) ~ "HD",
    TRUE ~ x
  )
  grade <- order_grade(grade)
  grade
}
# Based on https://www.adelaide.edu.au/policies/700/all/?dsn=policy.version;field=data;id=34226;m=view
# pacman::p_load(tidyverse)
# df <- tibble(
#   mark = c("FNS", "WNF", "RP", "WF", 0:100)
# )
# df <- df |> 
# mutate(
#   grade = calc_grade(mark), 
#   number = parse_number(mark)
# )
# df |> 
# ggplot(aes(number, grade)) + 
# geom_point() 
# df
# calc_grade(c("RP", 1:10))
