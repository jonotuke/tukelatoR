#' get assessment list
#'
#' @param assessment_obj assessment object
#'
#' @return list of assessments
#' @export
#'
#' @examples
#' get_assessment_list(assessment_obj)
get_assessment_list <- function(assessment_obj) {
  unique(assessment_obj$assessment)
}
# pacman::p_load(conflicted, tidyverse, targets)
# get_assessment_list(assessment_obj) |> print()