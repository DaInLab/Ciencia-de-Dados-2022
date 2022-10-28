#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
ui <- fluidPage(
  sliderInput("x", "Se x é", min = 1, max = 50, value = 30),
  sliderInput("y", "e y é", min = 1, max = 50, value = 5),
  "então, (x * y) é", textOutput("produto"),
  "e, (x * y) + 5 é", textOutput("produto_mais5"),
  "e (x * y) + 10 é", textOutput("produto_mais10")
)
server <- function(input, output, session) {
  output$produto <- renderText({
    produto <- input$x * input$y
    produto
  })
  output$produto_mais5 <- renderText({
    produto <- input$x * input$y
    produto + 5
  })
  output$produto_mais10 <- renderText({
    produto <- input$x * input$y
    produto + 10
  })
}
shinyApp(ui, server)
