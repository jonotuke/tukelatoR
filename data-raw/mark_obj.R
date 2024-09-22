## code to prepare `mark_obj` dataset goes here
## LIBS
pacman::p_load(randomNames, tidyverse)

## Files
peoplesoft_2016_file <- fs::path_package("tukelatoR", "inst/extdata/peoplesoft/2016-peoplesoft.xlsx")
peoplesoft_2017_file <- fs::path_package("tukelatoR", "inst/extdata/peoplesoft/2017-peoplesoft.xlsx")
graderoster_file <- fs::path_package("tukelatoR", "inst/extdata/grade-rosters/test-grade-roster.xlsx")
gradebook_2023_ds_file <- fs::path_package("tukelatoR", "inst/extdata/grade-book/2023-ds.csv")
gradebook_2024_sc_file <- fs::path_package("tukelatoR", "inst/extdata/grade-book/2024-sc.csv")

## Get mark object
mark_obj <- bind_rows(
  parse_peoplesoft(peoplesoft_2016_file),
  parse_peoplesoft(peoplesoft_2017_file), 
  parse_graderoster(grade_roster_file, 2018), 
  parse_gradebook(gradebook_2023_ds_file, 2023),
  parse_gradebook(gradebook_2024_sc_file, 2024)
)

## Get ids
ids <- mark_obj |> 
  select(id) |> 
  distinct()
ids

## sim new ids
sim_id <- function(length = 7){
  sample(0:9, size = length, replace = TRUE) |> 
    str_c(collapse = "")
}
sim_id(7)

## Sim names and ids
N <- nrow(ids)
names <- ids |> 
  mutate(
    sim_name = randomNames(N),
    sim_id = 1:N |> map_chr(\(x)sim_id(7))
  )
names

mark_obj <- 
  mark_obj |> 
  left_join(names, by = "id") |> 
  select(-id, -name) |> 
  rename(id = sim_id, name = sim_name) |> 
  select(
    id, name, 
    course_id, course_name, 
    year, term, mark, grade, raa, 
    source
  )
usethis::use_data(mark_obj, overwrite = TRUE)
