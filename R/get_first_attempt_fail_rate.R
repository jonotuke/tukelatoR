get_first_attempt_fail_rate <- function(mark_obj, course_id, year, term){
  mark_obj |> 
    dplyr::filter(.data$course_id %in% .env$course_id)
}
# pacman::p_load(conflicted, tidyverse, targets)
# tar_load(mark_obj, store = "~/Dropbox/01-projects/2024-exam-marks/_targets/")
# get_first_attempt_fail_rate(
#   mark_obj, 
#   "MATHS-1011",
#   2024
# ) |> print()

