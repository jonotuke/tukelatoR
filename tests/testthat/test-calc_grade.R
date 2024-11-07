test_that("calc grade works", {
  marks <- c("FNS", "WNF", "RP", "WF", 0:100)
  ans <- c(
    "FNS", "WNF", "RP", "WF", "FNS",
    rep("F", 49), rep("P", 15), rep("C", 10), rep("D", 10), 
    rep("HD", 16)
  )
  table(calc_grade(marks))
  expect_equal(as.character(calc_grade(marks)), ans)
  expect_equal(as.character(calc_grade(c("RP"))), "RP")
})
