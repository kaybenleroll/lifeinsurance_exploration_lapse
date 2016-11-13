library(shiny)
library(shinydashboard)

library(survival)
library(ggplot2)
library(survminer)


dashboardPage(
    dashboardHeader(title = "KM Estimates")
   ,dashboardSidebar(
        title = 'KM Variables'
       ,checkboxInput("gender", "Gender", value = FALSE)
       ,checkboxInput("health", "Health", value = FALSE)
    )
   ,dashboardBody(
        fluidRow(
            plotOutput('km_plot', height = 600, width = 1000)
        )
    )
)
