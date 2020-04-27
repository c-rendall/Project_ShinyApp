library(shiny)
library(shinydashboard)
library(tidyverse)

#Loading dataset  
vgsales <- read.csv('./vgsales.csv', stringsAsFactors = FALSE)

#Remove years outside of the range 1980-2016.  The data has three extra values in 'Year', 
#'N/A', '2017', and '2020'. This decreases obs. from 16958 to 16323.
vgsales <- filter(vgsales, Year != 'N/A' & Year != '2017' & Year != '2020')

#Create new columns 'Region' and 'Revenue' by using gather() to create key-value pairs and reducing the
#columns NA_Sales, EU_Sales, JP_Sales, and Other_Sales.  
vgsales <- vgsales %>% gather(Region, Revenue, 7:10)

#Convert 'Region' into a factor 
vgsales$Region <- factor(vgsales$Region)

