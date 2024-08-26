## code to prepare `term-codes` dataset goes here
term_codes_file <- fs::path_package("tukelatoR", 
  "inst/extdata/term-codes.xlsx")
term_codes <- term_codes_file |> 
  readxl::read_excel()
usethis::use_data(term_codes, overwrite = TRUE)
