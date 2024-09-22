## code to prepare `assessment_obj` dataset goes here
file1 <- fs::path_package("tukelatoR", "inst/extdata/grade-book/2023-ds.csv")
file2 <- fs::path_package("tukelatoR", "inst/extdata/grade-book/2024-sc.csv")
assessment_obj <- bind_rows(
  parse_gradebook_ao(file1, 2023), 
  parse_gradebook_ao(file2, 2024)
)



## Get ids
ids <- assessment_obj |> 
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
    sim_name = randomNames::randomNames(N),
    sim_id = 1:N |> map_chr(\(x)sim_id(7))
  )
names

assessment_obj <- 
  assessment_obj |> 
  left_join(names, by = "id") |> 
  select(-id, -name) |> 
  rename(id = sim_id, name = sim_name)
assessment_obj <- 
  assessment_obj |> 
  select(id, name, everything())
usethis::use_data(assessment_obj, overwrite = TRUE)
