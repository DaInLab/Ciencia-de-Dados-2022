#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
library(shiny)

ui <- fluidPage(
  sliderInput("x", label = "Se x é", min = 1, max = 50, value = 30),
  "Então x vezes 5 é",
  textOutput("produto")
)

# Define server logic required to draw a histogram
server <- function(input, output, session) {
  output$produto <- renderText({
#    x * 5 # Há algo errado aqui, escolha a alternativa que resolva o problema
    input$x * 5
  })
}

# Run the application 
shinyApp(ui = ui, server = server)
