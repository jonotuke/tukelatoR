#' move example
#'
#' @param folder folder to move template to
#' @param file name of new file
#'
#' @return NULL
#' @export
move_example <- function(folder, file){
  file_path <- fs::path(folder, file)
  if(fs::file_exists(file_path)){
    cat(stringr::str_glue("{file} already exists\n\n"))
  } else {
    cat(stringr::str_glue("Moving {file} across to {folder}\n\n"))
    example_path <- fs::path_package("examples", file, package = "tukelatoR")
    fs::file_copy(example_path, file_path)
  }
}
# fs::dir_create("example-folder")
# move_example("example-folder/", "test-grade-roster.xlsx")
