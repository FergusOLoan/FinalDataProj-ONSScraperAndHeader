#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(httr)
library(tidyRSS)
library(jsonlite)
library(rvest)
library(stringr)
library(rlist)
library(tidyverse)
library(readxl)
library(readr)
library(stringr)
library(gdata)
library(DT)
library(shinyjs)

url <- "www.ons.gov.uk/releasecalendar?rss"

RSScollected <- tidyfeed(url)


RSSCollectedSelect <- RSScollected %>% 
    select(item_pub_date, item_title, item_link)

RSSItems <- RSSCollectedSelect$item_title

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("ONS Recent Release Snapshots"),

    # Sidebar with a slider input for number of bins 
    fluidRow(
        column(2,
            selectInput("RSSitemlink", "Name of Release", RSSCollectedSelect$item_link
            ) 
        ),
        style="overflow-x: scroll; overflow-y: scroll",
        column(2,
               actionButton("bell","Direct Link to Release", class = "btn action-button", 
                            onclick = "window.open($('#RSSitemlink').val())") ,

        # Show a plot of the generated distribution
        mainPanel(
            dataTableOutput("scrape")
        )
    )
))


# Define server logic required to draw a histogram
server <- function(input, output) {

    output$example <- renderUI({
        tags$a(textOutput("Click Me!"),href=input$RSSitemlink)
    })

    output$scrape <- renderDataTable({
        
    testpages <- input$RSSitemlink
    
    mydata <- lapply(testpages, function(file) {
        read_html(file) %>% 
            html_nodes (".tiles__title-h3") %>%
            html_nodes ("a") %>%
            html_attr("href")
    })
    
    #need to unlist data to apply the paste properly, and for functions later
    
    RSSGroups <- RSSCollectedSelect %>%
        add_column(mydata, .after = "item_link")
    
    unlisted <- unlist(mydata)
    
    
    datasets <- unlisted[grepl("datasets", unlisted)]
    
    
    link <- paste("https://www.ons.gov.uk",datasets, sep = "",collapse = NULL)
    
    #don't be dumb, https:// needed to register as html
    
    RollTruDatasets <- lapply(link, function(link) {
        read_html(link) %>% 
            html_nodes (".border-bottom--abbey-lg") %>%
            html_nodes ("a") %>%
            html_attr("href")
    })
    
    TruDatasets <- unlist(RollTruDatasets)
    
    Dls <- TruDatasets[grepl(".xls", TruDatasets)]
    
    Downloads <- paste("http://www.ons.gov.uk",Dls, sep = "",collapse = NULL)
    
    
    Finished <- read.xls(Downloads)
 
    }   
)

}


?read.xls

# Run the application 
shinyApp(ui = ui, server = server)
