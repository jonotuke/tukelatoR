% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/parse_section.R
\name{parse_section}
\alias{parse_section}
\title{parse section}
\usage{
parse_section(x, which = "term")
}
\arguments{
\item{x}{gradebook section column}

\item{which}{which to return, term or course_id}
}
\value{
term or course
}
\description{
parse section
}
\examples{
section <- c(
  "Workshop WR01 Class 4320_STATS_3022", 
  "Workshop WR01 Class 4320_APP MTH_3022",
  "Workshop WR01 Class 4320_APP-MTH_3022"
)
parse_section(section, "term")
parse_section(section, "course_id")
}
