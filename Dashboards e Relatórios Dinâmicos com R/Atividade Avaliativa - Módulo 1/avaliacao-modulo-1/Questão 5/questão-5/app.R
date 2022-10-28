#
library(shiny)
library(ggplot2)

datasets <- c("economics", "faithfuld", "seals")

ui <- fluidPage(
  selectInput("dataset", "Dataset", choices = datasets),
  verbatimTextOutput("summary"),
# tableOutput("plot")  
  plotOutput("plot")
)

server <- function(input, output, session) {
  # Bloco 1.
  dataset <- reactive({
    get(input$dataset, "package:ggplot2")
  })
  # Bloco 2.
# output$summry <- renderPrint({  
  output$summary <- renderPrint({
    summary(dataset())
  })
  # Bloco 3.
  output$plot <- renderPlot({
#   plot(dataset)
    plot(dataset())
  }, res = 96)
}

shinyApp(ui, server)
