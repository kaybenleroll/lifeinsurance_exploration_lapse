library(shiny)
library(shinydashboard)

library(tidyverse)

library(survival)
library(survminer)



dashboardPage(
    dashboardHeader(title = "CoxPH Survival")
   ,dashboardSidebar(
        title = 'Model Variables'
       ,selectInput("gender",       "Gender", choices = c("M","F"))
       ,selectInput("health",       "Health", choices = c("Unhealthy","Average","Healthy"), selected = 'Average')
       ,sliderInput("age_at_start", "Age",    min = 18, max = 80, value = 45)
    )
   ,dashboardBody(
        fluidRow(
            plotOutput('coxph_plot', height = 600, width = 1000)
        )
    )
)
