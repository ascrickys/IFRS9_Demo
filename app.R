# Load required libraries
library(shiny)
library(shinythemes)

# Define UI
ui <- fluidPage(
  theme = shinytheme("flatly"),
  
  # App title
  titlePanel("CSV File Uploader"),
  
  # Sidebar layout with input and output definitions
  sidebarLayout(
    sidebarPanel(
      fileInput("file", "Choose CSV File", accept = ".csv"),
      tags$hr(),
      checkboxInput("header", "Header", TRUE),
      checkboxInput("stringAsFactors", "Convert strings to factors", TRUE)
    ),
    
    # Show CSV data
    mainPanel(
      tableOutput("contents")
    )
  )
)

# Define server logic
server <- function(input, output) {
  
  # Read CSV file
  data <- reactive({
    req(input$file)
    df <- read.csv(input$file$datapath,
                   header = input$header,
                   stringsAsFactors = input$stringAsFactors)
    save(df, file = paste0("./testing.rdata"))
    return(df)
  })
  
  # Show CSV data
  output$contents <- renderTable({
    data()
  })
}

# Run the application
shinyApp(ui = ui, server = server)
