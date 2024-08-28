#' tukelator app
#'
#' @param mark_obj mark object tibble
#' @param term selected term
#'
#' @return shiny app
#' @export
#'
#' @examples
#' \dontrun{tukelatorApp(example_marks)}
tukelatorApp <- function(mark_obj, term = "Sem 1"){
  year <- max(mark_obj$year)
  ui <- shiny::fluidPage(
    shiny::titlePanel("Tukelator"),
    shiny::sidebarLayout(
      shiny::sidebarPanel(
        shiny::selectizeInput(
          inputId = 'course_id',
          label = 'Course_ID',
          choices = unique(mark_obj$course_id), multiple = TRUE
        ),
        shiny::radioButtons(
          inputId = "year",
          label = "Year", 
          choices = unique(mark_obj$year),
          selected = year
        ),
        shiny::checkboxGroupInput(
          inputId = "term",
          label = "Term", 
          choices = c("Sem 1", "Sem 2", "Tri 1", "Tri 2", "Tri 3"), 
          selected = term
        )
      ),
      shiny::mainPanel(
        shiny::tabsetPanel(
          shiny::tabPanel("Grades",shiny::plotOutput("grade_bc")),
          shiny::tabPanel("Marks"),
          shiny::tabPanel("Debugging")
        )
      )
    )
  )
  
  server <- function(input, output, session) {
    output$grade_bc <- shiny::renderPlot({
      shiny::req(input$course_id)
      plot_grade_bc(mark_obj, input$course_id, input$term)
    })
  }
  
  shiny::shinyApp(ui, server)
  
}
# pacman::p_load(conflicted, tidyverse, shiny)
# library(tukelatoR)
# tukelatorApp(example_marks) |> print()
