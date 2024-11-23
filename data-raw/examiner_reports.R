## code to prepare `examiner_reports` dataset goes here
file <- "inst/examples/examiners-report-example.xlsx"
examiners_reports <- parse_examiners_report(file)
examiners_reports
usethis::use_data(examiners_reports, overwrite = TRUE)
