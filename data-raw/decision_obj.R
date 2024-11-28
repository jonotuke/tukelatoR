## code to prepare `decision_obj` dataset goes here
possible_decisions <- c(
  "Approve",
  "Approve with scale",
  "Approve with review",
  "Flagged for discussion"
)
set.seed(2024)
decision_obj <- 
  mark_obj |> 
  count(course_id, year, term) |> 
  mutate(
    time = now(), 
    decision = sample(possible_decisions, 21, replace = TRUE), 
    notes = c(rep("", 20), "CC not present")
  ) |> 
  relocate(time) |> 
  select(!n) |> 
  print()

usethis::use_data(decision_obj, overwrite = TRUE)
