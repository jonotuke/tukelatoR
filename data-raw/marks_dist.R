## code to prepare `marks_dist` dataset goes here
pacman::p_load(tidyverse)
marks_dist <- readxl::read_excel("inst/extdata/mark.xlsx")
marks_dist <- 
  marks_dist |> 
  mutate(
    mark = round(mark)
  ) |> 
  group_by(mark) |> 
  summarise(n = sum(n)) |> 
  filter(!is.na(mark))
marks_dist$n[51] = (marks_dist$n[50] + marks_dist$n[52]) / 2
marks_dist |> ggplot(aes(mark, n)) + 
  geom_col()
usethis::use_data(marks_dist, overwrite = TRUE)
