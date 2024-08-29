## code to prepare `augmented_example_marks` dataset goes here
augmented_example_marks <- augment_mark_obj(example_marks)
usethis::use_data(augmented_example_marks, overwrite = TRUE)
