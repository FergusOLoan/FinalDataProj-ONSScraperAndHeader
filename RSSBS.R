library(httr)

url <- "www.ons.gov.uk/releasecalendar?rss"

install.packages("tidyRSS")
library(tidyRSS)

RSScollected <- tidyfeed(url)

RSSCollectedSelect <- RSScollected %>% 
  select(item_pub_date, item_title, item_link)

testpages <- RSSCollectedSelect$item_link

YesterDayDate = Sys.Date() - 1

if (Sys.Date() <= Sys.Date() - 1) {
  print(RSSCollectedSelect)
}

install.packages("jsonlite")

library(jsonlite)

install.packages("rvest")
library(rvest)
?rvest

testpages <- RSSCollectedSelect$item_link %>%
  map(read_html) %>%
  map(html_nodes (".tiles__title-h3")) %>%
  map(html_nodes ("a")) %>%
  map(html_attr("href"))

HTMLTest <- testpages %>%
  map(read_html) %>%
  map(html_nodes (".tiles__title-h3")) %>%
  map(html_nodes ("a")) %>%
  map(html_attr("href"))


for (i in "https://www.ons.gov.uk/releases/traveltrends2019" ) {
  html_nodes (".tiles__title-h3") %>%
    html_nodes ("a") %>%
    html_attr("href")
}

mydata <- lapply(testpages, function(file) {
  read_html(file) %>% 
  html_nodes (".tiles__title-h3") %>%
  html_nodes ("a") %>%
  html_attr("href")
})

# 
testpageshtml <- read_html("https://www.ons.gov.uk/releases/traveltrends2019" ) %>%
  html_nodes (".tiles__title-h3") %>%
  html_nodes ("a") %>%
  html_attr("href")
  
library(stringr)

unlisted %>%
  str_detect("datasets") %>%
  names(mydata,.)
  
unlisted <- unlist(mydata)

filter(unlisted, "datasets")

str(unlisted)

datasets <- unlisted[grepl("datasets", unlisted)]

?str_detect
  
?names
install.packages("rlist")
library(rlist)

link <- paste("ons.gov.uk",datasets, sep = "",collapse = NULL)

print(link)

?grepl

testpages <- NULL



testpage <-read_html("https://www.ons.gov.uk/peoplepopulationandcommunity/leisureandtourism/datasets/overseastravelandtourism") %>%
  html_nodes (".border-bottom--abbey-lg") %>%
  html_nodes ("a") %>%
  html_attr("href")


testpages <- read_html("https://www.ons.gov.uk/peoplepopulationandcommunity/leisureandtourism/datasets/overseastravelandtourism")

testpaste <- paste0("ons.gov.uk",testpage)

testpaste
