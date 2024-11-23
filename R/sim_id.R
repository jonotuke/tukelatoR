#' sim ID
#'
#' @param length length of simulated ID
#'
#' @return simulated ID
#' @export
#'
#' @examples
#' sim_id(7)
sim_id <- function(length = 7){
  sample(0:9, size = length, replace = TRUE) |> 
    stringr::str_c(collapse = "")
}

