library(shiny)
library(bslib)
library(palmerpenguins)
library(ggplot2)

#load data
data(penguins, package = "palmerpenguins")

#remove any row with missing values
penguins <- na.omit(penguins)

#rename columns to make more readable
colnames(penguins) <- c("Species", "Island", 
                        "Bill Length (mm)", "Bill Depth (mm)", 
                        "Flipper Length (mm)", "Body Mass (g)", 
                        "Sex", "Year")

ui <- page_sidebar( #default layout
  #App title
  title = "Palmer Penguin Dashboard",
  
  sidebar = sidebar(
    "This application uses data from the package:", 
    code("palmerpenguins"),
    #shiny dashboard requires special folder named "www" for images to be used in shiny app
    img(src = "penguins.png"),
    "Artwork by @allison_horst"
  )
)

server <- function(input, output) {
  #unique variable "scatterplot" assigned to output$ prefix
  #R code that generates plot within braces of render code
  output$scatterplot <- renderPlot({
    
    ggplot(penguins,
           aes(x = `Bill Length (mm)`,
               y = `Bill Depth (mm)`,
               color = Species)) +
      geom_point(size = 5,
                 alpha = .5) +
      theme_minimal(base_size = 15) +
      theme(legend.position = "bottom")
  })
}

shinyApp(ui, server)
