#' add decision
#'
#' @param decision_obj decision in object
#' @param course_id course ID
#' @param year offering year
#' @param term offering term
#' @param decision final decision
#' @param notes any notes
#'
#' @return decision object
#' @export
add_decision <- function(decision_obj, course_id, year, term, decision, notes){
  decision_obj |> 
    tibble::add_row(
      tibble::tibble(
        time = lubridate::now(), 
        course_id, 
        year, 
        term, 
        decision, 
        notes
      )
    )
}
# decision_obj <- create_decision_obj("inst/examples/decision.csv")
# decision_obj |> add_decision("DISCP-1001", 2022, "Sem 1", "Approved", "All fine") |> print()