## code to prepare `augmented_mark_obj` dataset goes here
augmented_mark_obj <- augment_mark_obj(mark_obj)
usethis::use_data(augmented_mark_obj, overwrite = TRUE)
