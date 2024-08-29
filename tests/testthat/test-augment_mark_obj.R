library(tibble)
library(testthat)
library(tukelatoR)
df <- tibble::tibble(id = c(1, 1, 1, 2, 2, 2), mark = c(1:5, NA))
augmented_mark_obj <- augment_mark_obj(df)
test_that("augment_mark_obj works", {
  expect_equal(augmented_mark_obj$N[1], 3)
  expect_equal(augmented_mark_obj$mean[1], 2)
  expect_equal(augmented_mark_obj$diff[1], -1.5)

  expect_equal(augmented_mark_obj$N[4], 2)
  expect_equal(augmented_mark_obj$mean[4], 4.5)
  expect_equal(augmented_mark_obj$diff[4], -1)
})
