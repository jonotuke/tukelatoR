test_that("add-name works", {
  data(mark_obj)
test_df <- tibble::tribble(
  ~x, ~y, 
  "STATS-3001", "BOB", 
  "STATS-3001", NA
)
expect_equal(
  add_names(mark_obj, test_df$x, test_df$y), 
  c("BOB", "Statistical Modelling III")
)
})
