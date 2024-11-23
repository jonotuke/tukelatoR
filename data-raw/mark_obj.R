## code to prepare `mark_obj` dataset goes here

cohort2020 <- sim_students(100) |> sim_marks(2020)
cohort2021 <- sim_students(100) |> sim_marks(2021)
cohort2022 <- sim_students(100) |> sim_marks(2022)

mark_obj <- 
  bind_rows(
    cohort2020,
    cohort2021,
    cohort2022
  )

usethis::use_data(mark_obj, overwrite = TRUE)
