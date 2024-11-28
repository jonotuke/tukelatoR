#' get decision datatable
#'
#' @param decision_obj decision object
#' @param year year to show
#' @param term term to show
#'
#' @return datatable
#' @export
get_decision_dt <- function(decision_obj, year, term){
  decision_obj |> 
    dplyr::filter(.data$year == .env$year) |> 
    dplyr::filter(.data$term %in% .env$term) |> 
    DT::datatable(
      options = list(
        pageLength = 1000,
        lengthMenu = c(20, 50, 100, 200, 1000)
      ),
      rownames = FALSE
    ) |> 
    DT::formatStyle(
      "decision",
      backgroundColor = DT::styleEqual(
        unique(decision_obj$decision),
        harrypotter::hp(length(unique(decision_obj$decision)), house = "Ravenclaw")
      ),
      color = "white"
    )
}
# pacman::p_load(conflicted, tidyverse, targets)
# get_decision_dt(decision_obj, 2024, c("Sem 1","Sem 2")) |> print()