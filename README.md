
<!-- README.md is generated from README.Rmd. Please edit that file -->

# tukelatoR

<!-- badges: start -->

[![R-CMD-check](https://github.com/jonotuke/tukelatoR/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/jonotuke/tukelatoR/actions/workflows/R-CMD-check.yaml)
<!-- badges: end -->

The goal of tukelatoR is to give code to moderate exams at the
University of Adelaide.

## Installation

You can install the development version of tukelatoR from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("jonotuke/tukelatoR")
```

## Data

There are three main data sources for the Tukelator:

- peoplesoft data,
- grade-rosters, and
- grade-books.

For each of these is a function that will parse these into the correct
form that is needed for the Tukelator app. The form need is a
rectangular dataset with one row for each mark. The variables recorded
are
