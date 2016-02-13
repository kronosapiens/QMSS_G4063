# ui.R

library(shiny)
source("parser.R")

shinyUI(fluidPage(
  titlePanel("Tweets per Candidate"),
  
  sidebarLayout(
    sidebarPanel(
      helpText("Choose a specific candidate, visualize the volume of tweets and the words assoicated with that candidate."),
      
      selectInput("var", 
                  label = "Choose a candidate",
                  choices = candidates),
      
      sliderInput("range", 
                  label = "Range of time",
                  min = 0, max = 200, value = c(0, 200))
    ),
    
    mainPanel(
      
      plotOutput("wordcloudT",click = "plot_click"),
      verbatimTextOutput("info_click"),
      plotOutput("freq_plot")
    
    )

  )
  
))

