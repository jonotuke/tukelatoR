## code to prepare `assessment_obj` dataset goes here
assessment_obj <- sim_students(30) |> sim_assessment()
assessment_obj <- assessment_obj |> ungroup()
usethis::use_data(assessment_obj, overwrite = TRUE)
