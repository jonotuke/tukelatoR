#' is outlier
#'
#' @param x vector of proportions 
#'
#' @return boolean if any of values are outliers
#' @export
#'
#' @examples
#' is_outlier(c(runif(10, 0.9, 1), 0, NA))
is_outlier <- function(x){
  m <- mean(x, na.rm = TRUE)
  sd <- sd(x, na.rm = TRUE)
  n <- length(x[!is.na(x)])
  lwr <- m - 3 * sd
  upr <- m + 3 * sd
  any(x <= lwr | x >= upr) 
}
# pacman::p_load(conflicted, tidyverse, targets)
# p <- runif(10, 0.9, 1)
# p <- c(0, p, NA)
# is_outlier(p) |> print()