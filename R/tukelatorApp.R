utils::globalVariables(
  c("course_id")
)
#' tukelator app
#'
#' @param mark_obj mark object tibble
#' @param term selected term
#' @param assessment_obj assessment object tibble
#'
#' @return shiny app
#' @export
#'
#' @examples
#' \dontrun{tukelatorApp(example_marks)}
tukelatorApp <- function(mark_obj, assessment_obj, term = "Sem 1"){
  # Get years
  years <- unique(c(mark_obj$year, assessment_obj$year))
  # Get latest year
  year <- max(years)
  # Courses 
  courses <- unique(c(mark_obj$course_id, assessment_obj$course_id))
  # Augment mark_obj
  augmented_mark_obj <- augment_mark_obj(mark_obj)
  ui <- shiny::fluidPage(
    shiny::titlePanel("Tukelator"),
    shiny::sidebarLayout(
      shiny::sidebarPanel(
        shiny::selectizeInput(
          inputId = 'course_id',
          label = 'Course_ID',
          choices = courses, multiple = TRUE
        ),
        shiny::radioButtons(
          inputId = "year",
          label = "Year", 
          choices = years,
          selected = year
        ),
        shiny::checkboxGroupInput(
          inputId = "term",
          label = "Term", 
          choices = c("Sem 1", "Sem 2", "Tri 1", "Tri 2", "Tri 3"), 
          selected = term
        ), 
        shiny::checkboxGroupInput(
          inputId = "assessment", 
          label = "Assessment", 
          choices = "A1",
          selected = "A1"
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
            "Assessment", 
            shiny::plotOutput("assessment_bp"), 
            shiny::plotOutput("assessment_lg")
          ),
          shiny::tabPanel(
            "Fail rate", 
            shiny::plotOutput("fail_plot"), 
            shiny::htmlOutput("AS_text"),
            shiny::numericInput("MS", "Number of medical supps", value = 0),
            shiny::sliderInput("ASPR","Expected academic pass rate",0, 1, 0.5, 0.1),
            shiny::sliderInput("MSPR","Expected medical pass rate",0, 1, 0.8, 0.1)
          ), 
          shiny::tabPanel(
            "Debugging", 
            shiny::verbatimTextOutput(outputId = "debug")
          )
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
    output$assessment_bp <- shiny::renderPlot({
      shiny::req(input$course_id)
      plot_assessment_bp(assessment_obj, input$assessment)
    })
    output$assessment_lg <- shiny::renderPlot({
      shiny::req(input$course_id)
      plot_assessment_lg(assessment_obj, input$assessment)
    })
    output$fail_plot <- shiny::renderPlot({
      shiny::req(input$course_id)
      plot_fail_rate(
        mark_obj, input$course_id, 
        input$year, input$term, 
        input$MS, input$MSPR, input$ASPR
      )
    })
    assessment_obj_filter <- shiny::reactive({
      shiny::req(input$course_id)
      assessment_obj |> 
        filter_assessment(input$course_id, input$year, input$term)
    })
    output$AS_text <- shiny::renderText({
      # shiny::req(input$course_id)
      stringr::str_glue("<b>Number of academic supps: <br>{count_acad_supps(mark_obj, input$course_id, input$year, input$term)}<br>")
    })
    output$debug <- shiny::renderPrint({
      print(stringr::str_glue("input$course_id: {input$course_id}"))
      print(stringr::str_glue("input$year: {input$year}"))
      print(stringr::str_glue("input$term: {input$term}"))
      print(assessment_obj_filter() |> dplyr::count(course_id, year, term))
      print(input$assessment)
    })
    shiny::observeEvent(assessment_obj_filter(), {
      shiny::updateCheckboxGroupInput(
        inputId = "assessment", 
        choices = get_assessment_list(assessment_obj_filter()),
        selected = get_assessment_list(assessment_obj_filter())
      )
    })
  }
  
  shiny::shinyApp(ui, server)
  
}
# pacman::p_load(conflicted, tidyverse, shiny)
# library(tukelatoR)
# tukelatorApp(mark_obj, term = "Sem 2") |> print()
