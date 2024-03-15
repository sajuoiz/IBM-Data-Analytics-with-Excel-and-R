# Load libraries
library(shiny)
library(tidyverse)

# Read in data
adult <- read_csv("adult.csv")
# Convert column names to lowercase for convenience 
names(adult) <- tolower(names(adult))

# Define server logic
shinyServer(function(input, output) {
  
  df_country <- reactive({
    adult %>% filter(native_country == input$country)
  })
  
  # TASK 5: Create logic to plot histogram or boxplot
  output$p1 <- renderPlot({
    if (input$graph_type == "histogram") {
      # Histogram
      ggplot(df_country(), aes_string(x = input$var_cont)) +
        geom_histogram(bins = 30) +  # histogram geom
        ggtitle("GRÁFICO") +
        xlab("Variable") +
        ylab("Frecuencia") +  # labels
        facet_grid(~prediction) +  # facet by prediction
        theme_classic()
    }
    else {
      # Boxplot
      ggplot(df_country(), aes_string(y = input$var_cont)) +
        geom_boxplot() +  # boxplot geom
        coord_flip() +  # flip coordinates
        labs(x = "Variable", y = "Medición") +  # labels
        facet_grid(~prediction)+  
        theme_classic()   # facet by prediction
    }
    
  })
  
  # TASK 6: Create logic to plot faceted bar chart or stacked bar chart
  output$p2 <- renderPlot({
    # Bar chart
    p <- ggplot(df_country(), aes_string(x = input$categorical_variables, fill = "prediction")) +
      labs(title = "Gráfico de Barras", x = "Categoría") +  # labels
      theme_classic()+theme(
        axis.text.x = element_text(angle = 45, hjust = 1),  # Ángulo y alineación del texto en el eje x
        legend.position = "top"  # Posición de la leyenda
      )    # modify theme to change text angle and legend position
    
    if (input$is_stacked) {
      p + geom_bar()+  
        theme_classic() # add bar geom and use prediction as fill
    }
    else{
      p + 
        geom_bar() + # add bar geom and use input$categorical_variables as fill 
        facet_grid(~prediction) +  
        theme_classic()  # facet by prediction
    }
  })
  
})
