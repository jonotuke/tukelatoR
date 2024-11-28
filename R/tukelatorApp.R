utils::globalVariables(
  c("course_id", "decision_obj")
)
#' tukelator app
#'
#' @param mark_obj mark object tibble
#' @param term selected term
#' @param assessment_obj assessment object tibble
#' @param examiners_report examiners report object
#' @param decision_file CSV file to store decisions
#'
#' @return shiny app
#' @export
#'
#' @examples
#' \dontrun{
#' tukelatorApp(example_marks)
#' }
tukelatorApp <- function(mark_obj, assessment_obj, examiners_report, term = "Sem 1", decision_file) {
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
          inputId = "course_id",
          label = "Course_ID",
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
        shiny::checkboxInput(
          inputId = "all_grades",
          label = "All grades",
          value = FALSE
        ),
        shiny::hr(),
        shiny::checkboxInput(
          inputId = "hurdle",
          label = "Focus on hurdle (49)",
          value = FALSE
        ),
        shiny::hr(),
        shiny::checkboxGroupInput(
          inputId = "assessment",
          label = "Assessment",
          choices = "A1",
          selected = "A1"
        ),
        shiny::hr(),
        shiny::radioButtons(
          inputId = "decision",
          label = "Decision",
          choices = c(
            "Approve",
            "Approve with scale",
            "Approve with review",
            "Flagged for discussion"
          ),
          selected = "Approve"
        ),
        shiny::textInput(inputId = "notes", "Comments"
        ),
        shiny::actionButton(
          inputId = "submit",
          label = "Submit"
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
            gt::gt_output("marks_summary_gt"),
            DT::dataTableOutput("marks_dt")
          ),
          shiny::tabPanel(
            "Assessment",
            shiny::plotOutput("assessment_bp"),
            shiny::plotOutput("assessment_lg")
          ),
          shiny::tabPanel(
            "Examiner's report",
            shiny::textInput("cc", "Course coordinator OR Course name"),
            DT::dataTableOutput("examiners_report_dt")
          ),
          shiny::tabPanel(
            "Fail rate",
            shiny::plotOutput("fail_plot"),
            shiny::htmlOutput("AS_text"),
            shiny::numericInput("MS", "Number of medical supps", value = 0),
            shiny::sliderInput("ASPR", "Expected academic pass rate", 0, 1, 0.5, 0.1),
            shiny::sliderInput("MSPR", "Expected medical pass rate", 0, 1, 0.8, 0.1)
          ),
          shiny::tabPanel(
            "Examiners' meeting decisions",
            DT::dataTableOutput("decision_dt")
          ),
          shiny::tabPanel(
            "Students",
            DT::dataTableOutput("student_dt")
          ),
          shiny::tabPanel(
            "Compare courses",
            shiny::selectizeInput(
              inputId = "other_course_ids",
              label = "Other Course IDs",
              choices = courses, multiple = TRUE
            ),
            shiny::plotOutput("intersection_plot"),
            DT::dataTableOutput("intersection_dt")
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
      plot_grade_bc(mark_obj, input$course_id, input$term, input$all_grades)
    })
    output$grade_gt <- gt::render_gt({
      shiny::req(input$course_id)
      get_grade_tab(mark_obj, input$course_id, input$term)
    })
    output$marks_summary_gt <- gt::render_gt({
      shiny::req(input$course_id)
      get_mark_summary_gt(
        augmented_mark_obj,
        input$course_id,
        input$term, input$year
      )
    })
    output$marks_dt <- DT::renderDataTable({
      shiny::req(input$course_id)
      get_mark_tab(
        augmented_mark_obj,
        input$course_id,
        input$term,
        input$year,
        input$hurdle
      )
    })
    output$examiners_report_dt <- DT::renderDataTable({
      shiny::req(input$cc)
      get_examiners_report(examiners_report, input$cc)
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
    shiny::observeEvent(assessment_obj_filter(), {
      shiny::updateCheckboxGroupInput(
        inputId = "assessment",
        choices = get_assessment_list(assessment_obj_filter()),
        selected = get_assessment_list(assessment_obj_filter())
      )
    })
    ids <- shiny::reactive({
      get_ids(
        augmented_mark_obj, input$course_id, input$year,
        input$term, input$marks_dt_rows_selected
      )
    })
    output$student_dt <- DT::renderDataTable({
      shiny::req(input$marks_dt_rows_selected)
      get_student_dt(mark_obj, ids())
    })
    intersection <- shiny::reactive({
      get_intersection(
        mark_obj, 
        input$course_id, 
        input$term, 
        input$year, 
        input$other_course_ids
      )
    })
    output$intersection_plot <- shiny::renderPlot({
      shiny::req(input$other_course_ids)
      plot_intersection(intersection())
    })
    output$intersection_dt <- DT::renderDataTable({
      shiny::req(input$other_course_ids)
      get_intersection_dt(intersection())
    })
    RV <- shiny::reactiveValues(data = NULL)
    RV$decision_obj <- create_decision_obj(decision_file, term)
    output$decision_dt <- DT::renderDataTable({
      get_decision_dt(RV$decision_obj, input$year, input$term)
    })
    shiny::observeEvent(input$submit, {
      RV$decision_obj <-
        RV$decision_obj |>
        add_decision(
          course_id = input$course_id,
          year = as.numeric(input$year),
          term = input$term, decision = input$decision, 
          notes = input$notes
        )
      readr::write_csv(RV$decision_obj, decision_file)
    })
    output$debug <- shiny::renderPrint({
      print(stringr::str_glue("input$course_id: {input$course_id}"))
      print(stringr::str_glue("input$year: {input$year}"))
      print(stringr::str_glue("input$term: {input$term}"))
      print(stringr::str_glue("input$all_grades: {input$all_grades}"))
      print(stringr::str_glue("input$decision: {input$decision}"))
      print(stringr::str_glue("input$notes: {input$notes}"))
      cat("decision_obj():\n")
      print(utils::head(RV$decision_obj))
    })
  }

  shiny::shinyApp(ui, server)
}
# pacman::p_load(conflicted, tidyverse, shiny)
# library(tukelatoR)
# data(mark_obj)
# data(assessment_obj)
# data(examiners_reports)
# tukelatorApp(
#   mark_obj,
#   assessment_obj,
#   examiners_reports,
#   term = "Sem 2",
#   decision_file = "~/Desktop/decision.csv"
# ) |> print()
