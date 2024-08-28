## code to prepare `example_marks` dataset goes here
## LIBS
pacman::p_load(randomNames, tidyverse)

## Files
peoplesoft_2016_file <- fs::path_package("tukelatoR", "inst/extdata/peoplesoft/2016-peoplesoft.xlsx")
peoplesoft_2017_file <- fs::path_package("tukelatoR", "inst/extdata/peoplesoft/2017-peoplesoft.xlsx")

## Get mark object
example_marks <- bind_rows(
  parse_peoplesoft(peoplesoft_2016_file),
  parse_peoplesoft(peoplesoft_2017_file)
)
example_marks
## Get ids
ids <- example_marks |> 
  select(id) |> 
  distinct()
ids

## sim new ids
sim_id <- function(length = 7){
  sample(0:9, size = length, replace = TRUE) |> str_c(collapse = "")
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

example_marks <- 
  example_marks |> 
  left_join(names, by = "id") |> 
  select(-id, -name) |> 
  rename(id = sim_id, name = sim_name) |> 
  select(id, name, course_id, course_name, year, term, mark, grade)

usethis::use_data(example_marks, overwrite = TRUE)
