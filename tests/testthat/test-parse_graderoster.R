test_that("parse-graderoster", {
  file <- fs::path_package("tukelatoR", "examples", "grade-roster-example.xlsx")
  gr <- parse_graderoster(file, 2024)
  expect_equal(
    gr$mark, 
    c(0, 1, 44, 45, 49, 50, 64, 65, 74, 74, 75, 84, 85, 100, NA)
  )
  expect_equal(
    as.character(gr$grade),
    c("FNS", "F", "F", "F", "F", "P", "P", "C", "C", "C", "D", "D", 
"HD", "HD", "RP")
  )
})
