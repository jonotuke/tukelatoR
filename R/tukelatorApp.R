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
  # Get latest year
  year <- max(mark_obj$year)
  # Augment mark_obj
  augmented_mark_obj <- augment_mark_obj(mark_obj)
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
          shiny::tabPanel(
            "Grades",
            shiny::plotOutput("grade_bc"), 
            gt::gt_output("grade_gt")
          ),
          shiny::tabPanel(
            "Marks", 
            DT::dataTableOutput("marks_dt")
          ),
          shiny::tabPanel(
            "Fail rate", 
            shiny::plotOutput("fail_plot"), 
            shiny::numericInput("MS", "Number of medical supps", value = 0),
            shiny::sliderInput("ASPR","Expected academic pass rate",0, 1, 0.5, 0.1),
            shiny::sliderInput("MSPR","Expected medical pass rate",0, 1, 0.8, 0.1)
          ), 
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
    output$grade_gt <- gt::render_gt({
      shiny::req(input$course_id)
      get_grade_tab(mark_obj, input$course_id, input$term)
    })
    output$marks_dt <- DT::renderDataTable({
      shiny::req(input$course_id)
      get_mark_tab(augmented_mark_obj, input$course_id, input$term, input$year)
    })
    output$fail_plot <- shiny::renderPlot({
      shiny::req(input$course_id)
      plot_fail_rate(
        mark_obj, input$course_id, 
        input$year, input$term, 
        input$MS, input$MSPR, input$ASPR
      )
    })
  }
  
  shiny::shinyApp(ui, server)
  
}
# pacman::p_load(conflicted, tidyverse, shiny)
# library(tukelatoR)
# tukelatorApp(example_marks) |> print()
