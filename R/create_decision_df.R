#' create decision obj
#'
#' @param file file of decision CSV
#' @param term term to start with
#'
#' @return decision_obj
#' @export
create_decision_obj <- function(file, term){
  if(fs::file_exists(file)){
    decision_df <- readr::read_csv(file)
  } else {
    decision_df <- tibble::tibble(
      time = lubridate::now(),
      course_id="TEST-1000", 
      year = lubridate::year(lubridate::today()), 
      term = term, 
      decision = "TBD", 
      notes = ""
    )
  }
  readr::write_csv(decision_df, file)
  decision_df
}
# pacman::p_load(conflicted, tidyverse, targets)
# create_decision_obj("inst/examples/decision.csv", "Sem 2") |> print()