library(testthat)
test_that("peoplesoft-validator", {
  expect_equal(is_peoplesoft_valid("2017-peoplesoft.xlsx"), TRUE)
  expect_equal(is_peoplesoft_valid("false-peoplesoft.xlsx"), FALSE)
})
