#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
#install.packages("DT")
#install.packages("RMySQL")
library(RMySQL)
library(DT)
library(ggplot2)
library(readr)

farms_db = dbConnect(MySQL(),
                     user="root",
                     password="yourpassword",
                     dbname="farms",
                     port=3306)

dbListTables(farms_db)
dbListTables(farms_db, "farms")

#demo_farms = read_file("farms.sql")
#print(demo_farms)

farms_record = dbSendQuery(farms_db, "select * from farms")

farms_data.frame = fetch(farms_record,n=10000)

var = colnames(farms_data.frame)
#print(list(farms_data.frame["farm_type"]))

dbDisconnect(farms_db)

#farms <- read.csv(file = '/Users/deekay/Desktop/Interview_Challenge/Interview-challenge/database/farms.csv')
#head(farms)

# Define UI for application that draws a histogram
ui <- fluidPage(
   
   # Application title
   titlePanel("Farm Database"),
   
   sidebarPanel(
     plotOutput("plot1"),
     #plotOutput("plot2")
   ),
   
   mainPanel(
     DT::dataTableOutput("table")
   )
   )


# Define server logic required to draw a histogram
server <- function(input, output) {
   
   output$table <- DT::renderDataTable({
     farms_data.frame
   })
   
   output$plot1 <- renderPlot({
     pie(table(farms_data.frame["farm_type"]))
   })
   
   #output$plot2 <- renderPlot({
  #   hist(table(farms_data.frame["animals"]), labels = TRUE)
   #})
  
}

# Run the application 
shinyApp(ui = ui, server = server)

