#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    titlePanel("Questão 1"),

    # Bloco 4.
    textInput("nome", "Qual o seu nome?"),

        # Show a plot of the generated distribution
  #  Bloco 5.
    textOutput("cumprimento")
    )
)
