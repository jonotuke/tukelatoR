test_that("get_mark works", {
  expect_equal(get_mark(0:100), 0:100)
  expect_equal(
    get_mark(c(0:100, "CN", "F", "FNS", "NFE", "RP", "WF", "WNF", "NGP")), 
    c(0:100, rep(NA, 8))
  )
})
