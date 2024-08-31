library(testthat)
test_that("predict fail rate", {
  expect_equal(predict_fail_rate(10, 0, 0), 10)
  expect_equal(predict_fail_rate(10, 5, 5), 4)
  expect_equal(predict_fail_rate(10, 1, 1, 1, 1), 8)
  expect_equal(predict_fail_rate(10, 1, 1, 0, 0), 10)
})
