#' mark_obj
#'
#' A simulated tibble showing the standard mark-object form
#'
#' @format A data frame with 24,431 rows and 8 variables
#' \describe{
#' \item{id}{Student ID}
#' \item{name}{Student Name}
#' \item{course_name}{Course Name}
#' \item{course_id}{Course ID of form DISPLINE-CAT_NO}
#' \item{year}{Year of offering}
#' \item{term}{Term of offering}
#' \item{mark}{Mark for course NA for WNF etc.}
#' \item{grade}{Grade}
#' \item{raa}{RAA note}
#' \item{source}{where the data comes from: peoplesoft, GR, etc}
#' }
#' @source "Simulated data"
"mark_obj"
#' examiners_reports
#'
#' A simulated tibble showing the standard mark-object form
#'
#' @format A data frame with 1 row and 13 variables
#' \describe{
#' \item{course_cc}{Course coordinator}
#' \item{course_name}{Course Name}
#' \item{assessment}{Assessment structure}
#' \item{audit}{Audit done}
#' \item{hurdle}{Course hurdle}
#' \item{hurdle_details}{Hurdle details}
#' \item{stack}{Co-taught courses}
#' \item{scaling}{Course scaling}
#' \item{scaling_details}{Course scaling details}
#' \item{student}{Student to discuss}
#' \item{comments}{Comments}
#' \item{changes}{Proposed changes}
#' \item{course_id}{Course ID of form DISPLINE-CAT_NO}
#' }
#' @source "Simulated data"
"examiners_reports"
#' assessment_obj
#'
#' A simulated tibble showing the standard assessment-object form
#'
#' @format A data frame with 1,600 rows and 11 variables
#' \describe{
#' \item{id}{Student ID}
#' \item{name}{Student Name}
#' \item{course_id}{Course ID of form DISPLINE-CAT_NO}
#' \item{year}{Year of offering}
#' \item{term}{Term of offering}
#' \item{mark}{Mark for course NA for WNF etc.}
#' \item{grade}{Grade}
#' \item{assessment}{Assessment piece}
#' \item{value}{Assessment mark}
#' \item{total}{Assessment total marks}
#' \item{p}{Proportion}
#' }
#' @source "Simulated data"
"assessment_obj"
#' augmented_mark_obj
#'
#' A simulated tibble showing the standard mark-object form
#'
#' @format A data frame with 24,431 rows and 11 variables
#' \describe{
#' \item{id}{Student ID}
#' \item{name}{Student Name}
#' \item{course_name}{Course Name}
#' \item{course_id}{Course ID of form DISPLINE-CAT_NO}
#' \item{year}{Year of offering}
#' \item{term}{Term of offering}
#' \item{mark}{Mark for course NA for WNF etc.}
#' \item{grade}{Grade}
#' \item{raa}{RAA note}
#' \item{N}{Number of exams with a mark for a student}
#' \item{mean}{Mean exam mark}
#' \item{diff}{Difference of mark from mean of all over marks for a given student}
#' \item{source}{Source of data}
#' }
#' @source "Simulated data"
"augmented_mark_obj"
#' term_codes
#'
#' A dataset containing term codes for peoplesoft
#'
#' @format A data frame with 300 rows and 2 variables:
#' \describe{
#' \item{term}{Term code}
#' \item{name}{Term name}
#' }
#' @source "University of Adelaide"
"term_codes"
#' mark_dist
#'
#' A dataset containing empirical mark distribution based on
#' UoA results
#'
#' @format A data frame with 101 rows and 2 variables:
#' \describe{
#' \item{mark}{Number of students}
#' \item{n}{Number of observations}
#' }
#' @source "University of Adelaide"
"marks_dist"
#' decision obj
#'
#' A dataset containing decisions from examiners' meeting
#'
#' @format A data frame with 21 rows and 6 variables:
#' \describe{
#' \item{time}{Time of decision}
#' \item{course_id}{Course ID}
#' \item{year}{Year of offering}
#' \item{term}{Term of offering}
#' \item{decision}{Final decision}
#' \item{notes}{Notes}
#' }
#' @source "Simulated"
"decision_obj"