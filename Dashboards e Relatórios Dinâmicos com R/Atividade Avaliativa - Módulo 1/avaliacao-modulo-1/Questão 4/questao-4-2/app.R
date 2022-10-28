#
library(shiny)
ui <- fluidPage(
  sliderInput("x", "Se x é", min = 1, max = 50, value = 30),
  sliderInput("y", "e y é", min = 1, max = 50, value = 5),
  "então, (x * y) é", textOutput("produto"),
  "e, (x * y) + 5 é", textOutput("produto_mais5"),
  "e (x * y) + 10 é", textOutput("produto_mais10")
)

# Define server logic required to draw a histogram
server <- function(input, output, session) {
  produto <- reactive({
    input$x * input$y
  })
  output$produto <- renderText({
    produto()
  })
  output$produto_mais5 <- renderText({
    produto() + 5
  })
  output$produto_mais10 <- renderText({
    produto() + 10
  })
}

# Run the application 
shinyApp(ui = ui, server = server)
