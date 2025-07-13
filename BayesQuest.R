library(shiny)
library(shinydashboard)
library(plotly)
library(ggplot2)
library(dplyr)
library(igraph)
library(shinyjs)
library(DT)

ui <- dashboardPage(
  dashboardHeader(title = "🧠 BayesQuest: Introduction to Bayesian Statistics"),
  
  dashboardSidebar(
    sidebarMenu(
      id = "sidebarMenu",
      menuItem("🏠 Introduction", tabName = "intro", icon = icon("home")),
      menuItem("🎯 What is Bayesian Statistics?", tabName = "what_is_bayes", icon = icon("question-circle")),
      menuItem("📊 Bayes' Theorem", tabName = "foundations", icon = icon("brain")),
      menuItem("📊 Bayesian Normal Distribution", tabName = "normal_bayes", icon = icon("chart-line")),
      menuItem("📈 Bayesian Poisson Distribution", tabName = "poisson_bayes", icon = icon("bar-chart")),
      menuItem("🪙 Practical Example: Coin", tabName = "coin_example", icon = icon("coins")),
      menuItem("📈 Bayesian Regression", tabName = "regression", icon = icon("chart-line")),
      menuItem("🧬 Genetic Networks", tabName = "networks", icon = icon("dna")),
      menuItem("⚡ Variational Inference", tabName = "variational", icon = icon("bolt")),
      menuItem("🎯 Spike and Slab", tabName = "spike_slab", icon = icon("filter")),
      menuItem("🎓 Summary & Quiz", tabName = "summary", icon = icon("graduation-cap"))
    )
  ),
  
  dashboardBody(
    tabItems(
      # Introduction Tab
      tabItem(tabName = "intro",
        fluidRow(
          column(12,
            h1("🧠 Welcome to BayesQuest!", style = "text-align: center;"),
            h3("Start your mission to discover Bayesian Statistics", style = "text-align: center;"),
            br(),
            p("You will learn:", style = "font-size: 18px;"),
            tags$ul(style = "font-size: 16px;",
              tags$li("What is Bayesian statistics and why it's important"),
              tags$li("How Bayes' theorem works"),
              tags$li("Differences between Frequentist and Bayesian approaches")
            ),
            br(),
            div(style = "text-align: center;",
              actionButton("start_journey", "🚀 Start Your Journey!", 
                          class = "btn-primary btn-lg")
            )
          )
        )
      ),
      
      # What is Bayes Tab  
      tabItem(tabName = "what_is_bayes",
        fluidRow(
          column(12,
            h2("🎯 What is Bayesian Statistics?"),
            p("Bayesian statistics is a way of reasoning that reflects how we naturally think in real life.")
          )
        )
      ),
      
      # Other tabs can be added here following the same pattern...
      tabItem(tabName = "foundations",
        fluidRow(
          column(12,
            h2("📊 Mathematical Foundations"),
            h3("🔑 Bayes' Theorem"),
            p("Bayes' theorem tells us how to update our beliefs when we receive new information.")
          )
        )
      )
    )
  )
)

server <- function(input, output, session) {
  # Navigation
  observeEvent(input$start_journey, {
    updateTabItems(session, "sidebarMenu", "what_is_bayes")
  })
}

shinyApp(ui = ui, server = server)