# server.R
library(shiny)

x <- precip
#input <- list(NUMERO_DE_CLASSES = 10)
# Extremos com amplitude estendida em 5%.
a <- extendrange(x, f=0.05)

shinyServer(
    function(input, output) {
      
        MAKE_HISTOGRAM <- reactive({
          bks <- seq(from = a[1],
                     to = a[2],
                     length.out = input$NUMERO_DE_CLASSES + 1)
          ht <- hist(x,
                     breaks = bks,
                     main = NULL,
                     col = "#008A8A",
                     ylab = "Frequência absoluta",
                     xlab = "Precipitação")
          m <- which.max(ht$counts)
 #         ht$counts[m]
          list(hist = ht, classe_modal =  ht$breaks[m + 0:1])
        })      
      
        output$HISTOGRAMA <-
	        renderPlot({
	          plot(MAKE_HISTOGRAM()$hist)
	        })
        
        output$TEXT <- renderText({
          MAKE_HISTOGRAM()$classe_modal
          
        })
	 }
)
