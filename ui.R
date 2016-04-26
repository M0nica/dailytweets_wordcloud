
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#
library(shiny)
# ui.R

shinyUI(fluidPage(
  titlePanel("Tweets per Candidate"),
  
  sidebarLayout(
    sidebarPanel(
      helpText("Choose a specific candidate, visualize their wordcloud"),
      
      #users select which candidate they would like to visualize
      selectInput("var", 
                  label = "Choose a candidate to display",
                  choices = c("Hillary Clinton", "Bernie Sanders", "Ted Cruz", "Donald Trump"),
                  selected = "Percent White"),
      selectInput("date", 
                  label = "Choose a date to display",
                  choices = c("Feb 09", "Feb 20", "Feb 23", "Feb 27", "Mar 01", "Mar 05", "Mar 08", "Mar 12", "Mar 15", "Mar 22", "Mar 26", "Apr 05", "Apr 09"),
                  selected = "Percent White"),
      #users can choose the maximum amount of words they would like the wordcloud to display
      sliderInput("wordCount", 
                  label = "Max words to display",
                  min = 5, max = 250, value = 100)

     ),
    
    mainPanel(
      
      textOutput("text1"),
      plotOutput("wordcloudT",click = "plot_click"),
      verbatimTextOutput("info_click"),
      plotOutput("freq_plot")
     
    )
    
  )
  
))