#-----------------------------------------------------------------------
# ui.R

library(shiny)

cols <- c(
    Vermelho = "#F81D54",
    Amarelo = "#FF9F1E",
    Azul = "#2791E1",
    Verde = "#72F51D"
)
cols2 <- c(cols, rev(cols))

shinyUI(
    fluidPage(
        titlePanel("Histograma"),
        sidebarLayout(
            sidebarPanel(
                checkboxGroupInput(
                    inputId = "CORES",
                    label = "Escolha as cores para interpolar:",
                    choices = cols2,
                    selected = "#72F51D"
                )
            ),
            mainPanel(
                plotOutput("HISTOGRAMA")
            )
        )
    )
)
