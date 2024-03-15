# Load libraries
library(shiny)
library(tidyverse)

# Application Layout
shinyUI(
  fluidPage(
    br(),
    # TASK 1: Application title
    titlePanel("My First Shiny App"),
    p("Explore the difference between people who earn less than 50K and more than 50K. You can filter the data by country, then explore various demogrphic information."),
    
    # TASK 2: Add first fluidRow to select input for country
    fluidRow(
      column(12, 
             wellPanel( selectInput("country", "Select Country", choices = unique(adult$native_country)) )  # add select input 
             )
    ),
    
    # TASK 3: Add second fluidRow to control how to plot the continuous variables
    fluidRow(
      column(3, 
             wellPanel(
               p("Select a continuous variable and graph type (histogram or boxplot) to view on the right."),
               radioButtons("var_cont", "variable continua", choices =c("hours_per_week", "age")),   # add radio buttons for continuous variables
               radioButtons("graph_type", "Tipo de gráfico", choices = c("histogram", "boxplot"))   # add radio buttons for chart type
               )
             ),
      column(9, plotOutput("p1") )  # add plot output
    ),
    
    # TASK 4: Add third fluidRow to control how to plot the categorical variables
    fluidRow(
      column(3, 
             wellPanel(
               p("Select a categorical variable to view bar chart on the right. Use the check box to view a stacked bar chart to combine the income levels into one graph. "),
               radioButtons("categorical_variables", "variable categorica", choices =c("workclass", "education")),    # add radio buttons for categorical variables
               checkboxInput("is_stacked", "barras apiladas", value = FALSE)     # add check box input for stacked bar chart option
               )
             ),
      column(9, plotOutput("p2"))  # add plot output
    )
  )
)