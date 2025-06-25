library(shiny)
library(shinydashboard)
library(plotly)
library(ggplot2)
library(dplyr)
library(igraph)
library(visNetwork)
library(shinyjs)

# Define UI
ui <- dashboardPage(
  dashboardHeader(title = "🧠 BayesQuest: Regression & Networks"),
  
  dashboardSidebar(
    useShinyjs(),
    sidebarMenu(
      menuItem("🏠 Welcome", tabName = "intro", icon = icon("home")),
      menuItem("📊 Bayesian Foundations", tabName = "foundations", icon = icon("brain")),
      menuItem("📈 Regression Analysis", tabName = "regression", icon = icon("chart-line")),
      menuItem("🧬 Gene Networks", tabName = "networks", icon = icon("dna")),
      menuItem("🎓 Summary & Quiz", tabName = "summary", icon = icon("graduation-cap"))
    )
  ),
  
  dashboardBody(
    useShinyjs(),
    tags$head(
      tags$script('window.MathJax = { tex: { inlineMath: [["$", "$"], ["\\\\(", "\\\\)"]], displayMath: [["$$", "$$"], ["\\\\[", "\\\\]"]] } };'),
      tags$script(src = "https://polyfill.io/v3/polyfill.min.js?features=es6"),
      tags$script(id = "MathJax-script", async = NA, src = "https://cdn.jsdelivr.net/npm/mathjax@3/es5/tex-mml-chtml.js"),
      tags$style(HTML('
        .content-wrapper { background-color: #f8f9fa; }
        
        .intro-box { 
          background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
          color: white;
          border-radius: 15px;
          padding: 30px;
          margin: 15px 0;
          box-shadow: 0 10px 20px rgba(0,0,0,0.2);
        }
        
        .theory-box { 
          background: #ffffff;
          border: 2px solid #3498db;
          border-radius: 10px;
          padding: 20px;
          margin: 15px 0;
          box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        
        .freq-box {
          background: #fff5f5;
          border-left: 5px solid #e74c3c;
          padding: 15px;
          margin: 10px 0;
        }
        
        .bayes-box {
          background: #f0fdf4;
          border-left: 5px solid #2ecc71;
          padding: 15px;
          margin: 10px 0;
        }
        
        .formula-box {
          background: #f8f9fa;
          border: 2px dashed #95a5a6;
          border-radius: 8px;
          padding: 20px;
          margin: 15px 0;
          text-align: center;
          font-size: 1.1em;
        }
        
        .comparison-card {
          background: white;
          border-radius: 10px;
          padding: 20px;
          margin: 10px;
          box-shadow: 0 4px 6px rgba(0,0,0,0.1);
          height: 100%;
        }
        
        .highlight-box {
          background: #fef3c7;
          border: 2px solid #f59e0b;
          border-radius: 8px;
          padding: 15px;
          margin: 15px 0;
        }
      '))
    ),
    
    tabItems(
      # Welcome Tab
      tabItem(tabName = "intro",
              fluidRow(
                column(12,
                       div(class = "intro-box",
                           h1("🧠 Welcome to the BayesQuest!", style = "text-align: center;"),
                           h3("Master Statistical Thinking Through Interactive Examples", style = "text-align: center;"),
                           br(),
                           
                           div(style = "background: rgba(255,255,255,0.2); padding: 20px; border-radius: 10px;",
                               h3("🎯 Your Learning Journey:"),
                               tags$ol(style = "font-size: 18px;",
                                       tags$li("Understand the fundamental difference between Frequentist and Bayesian approaches"),
                                       tags$li("Master Bayesian regression analysis with hands-on examples"),
                                       tags$li("Apply Bayesian methods to gene regulatory networks"),
                                       tags$li("Build intuition through interactive visualizations")
                               )
                           ),
                           
                           br(),
                           div(style = "text-align: center;",
                               actionButton("start_journey", "🚀 Start Your Journey", 
                                            style = "font-size: 20px; padding: 15px 40px; background: white; color: #667eea;")
                           )
                       )
                ),
                
                column(12,
                       div(class = "theory-box",
                           h3("📚 Why Bayesian Statistics?"),
                           fluidRow(
                             column(6,
                                    div(class = "comparison-card",
                                        h4("🏛️ Traditional (Frequentist)", style = "color: #e74c3c;"),
                                        tags$ul(
                                          tags$li("Fixed parameters, random data"),
                                          tags$li("Based on long-run frequencies"),
                                          tags$li("No prior information used"),
                                          tags$li("Point estimates with confidence intervals")
                                        )
                                    )
                             ),
                             column(6,
                                    div(class = "comparison-card",
                                        h4("🧠 Bayesian", style = "color: #2ecc71;"),
                                        tags$ul(
                                          tags$li("Random parameters, fixed data"),
                                          tags$li("Based on degrees of belief"),
                                          tags$li("Incorporates prior knowledge"),
                                          tags$li("Full probability distributions")
                                        )
                                    )
                             )
                           )
                       )
                )
              )
      ),
      
      # Foundations Tab
      tabItem(tabName = "foundations",
              fluidRow(
                column(12,
                       h2("📊 Bayesian Foundations: The Core Concepts"),
                       
                       div(class = "theory-box",
                           h3("🔑 Bayes' Theorem: The Heart of Bayesian Inference"),
                           
                           div(class = "formula-box",
                               h4("The Famous Formula:"),
                               "$$P(\\theta|\\text{data}) = \\frac{P(\\text{data}|\\theta) \\times P(\\theta)}{P(\\text{data})}$$",
                               br(), br(),
                               "$$\\text{Posterior} = \\frac{\\text{Likelihood} \\times \\text{Prior}}{\\text{Evidence}}$$"
                           ),
                           
                           fluidRow(
                             column(3,
                                    div(class = "highlight-box",
                                        h5("Prior P(θ)"),
                                        p("What we believe before seeing data")
                                    )
                             ),
                             column(3,
                                    div(class = "highlight-box",
                                        h5("Likelihood P(data|θ)"),
                                        p("How likely is our data given parameters")
                                    )
                             ),
                             column(3,
                                    div(class = "highlight-box",
                                        h5("Posterior P(θ|data)"),
                                        p("Updated belief after seeing data")
                                    )
                             ),
                             column(3,
                                    div(class = "highlight-box",
                                        h5("Evidence P(data)"),
                                        p("Normalizing constant")
                                    )
                             )
                           )
                       )
                )
              ),
              
              # Interactive Coin Example
              fluidRow(
                column(12,
                       div(class = "theory-box",
                           h3("🪙 Interactive Example: Is This Coin Fair?"),
                           
                           fluidRow(
                             column(4,
                                    h4("🎛️ Control Panel"),
                                    sliderInput("coin_flips", "Number of flips:", 
                                                min = 10, max = 500, value = 50, step = 10),
                                    sliderInput("true_prob", "True probability of heads:", 
                                                min = 0.3, max = 0.7, value = 0.5, step = 0.05),
                                    
                                    h5("Bayesian Prior:"),
                                    sliderInput("prior_belief", "Prior belief (probability of heads):", 
                                                min = 0.3, max = 0.7, value = 0.5, step = 0.05),
                                    sliderInput("prior_strength", "Prior confidence (equivalent flips):", 
                                                min = 1, max = 50, value = 10, step = 1),
                                    
                                    br(),
                                    actionButton("flip_coin", "🪙 Flip Coins!", class = "btn-primary btn-lg")
                             ),
                             
                             column(8,
                                    plotlyOutput("coin_comparison", height = "400px")
                             )
                           ),
                           
                           fluidRow(
                             column(6,
                                    div(class = "freq-box",
                                        h4("Frequentist Results"),
                                        verbatimTextOutput("freq_results")
                                    )
                             ),
                             column(6,
                                    div(class = "bayes-box",
                                        h4("Bayesian Results"),
                                        verbatimTextOutput("bayes_results")
                                    )
                             )
                           )
                       )
                )
              )
      ),
      
      # Regression Tab
      tabItem(tabName = "regression",
              fluidRow(
                column(12,
                       h2("📈 Bayesian Regression: A Complete Comparison"),
                       
                       div(class = "theory-box",
                           h3("🎯 The Linear Regression Model"),
                           
                           div(class = "formula-box",
                               "$$y = \\beta_0 + \\beta_1 x + \\epsilon$$",
                               br(),
                               "$$\\epsilon \\sim \\mathcal{N}(0, \\sigma^2)$$"
                           ),
                           
                           fluidRow(
                             column(6,
                                    div(class = "freq-box",
                                        h4("🏛️ Frequentist Approach"),
                                        p("Find β that minimizes sum of squared errors:"),
                                        div(class = "formula-box",
                                            "$$\\hat{\\beta} = (X^TX)^{-1}X^Ty$$"
                                        ),
                                        tags$ul(
                                          tags$li("Point estimate of β"),
                                          tags$li("Confidence intervals from sampling distribution"),
                                          tags$li("No prior information")
                                        )
                                    )
                             ),
                             column(6,
                                    div(class = "bayes-box",
                                        h4("🧠 Bayesian Approach"),
                                        p("Specify prior and compute posterior:"),
                                        div(class = "formula-box",
                                            "$$p(\\beta|y) \\propto p(y|\\beta)p(\\beta)$$"
                                        ),
                                        tags$ul(
                                          tags$li("Full posterior distribution of β"),
                                          tags$li("Credible intervals from posterior"),
                                          tags$li("Incorporates prior knowledge")
                                        )
                                    )
                             )
                           )
                       )
                )
              ),
              
              # Interactive Regression
              fluidRow(
                column(4,
                       div(class = "theory-box",
                           h3("🎮 Interactive Regression"),
                           
                           h4("Data Generation:"),
                           sliderInput("n_points", "Sample size:", 
                                       min = 20, max = 200, value = 50, step = 10),
                           sliderInput("true_slope", "True slope:", 
                                       min = 0.5, max = 3, value = 2, step = 0.1),
                           sliderInput("noise_level", "Noise level:", 
                                       min = 0.5, max = 3, value = 1, step = 0.1),
                           
                           h4("Bayesian Priors:"),
                           sliderInput("prior_slope_mean", "Prior slope mean:", 
                                       min = 0, max = 4, value = 1.5, step = 0.1),
                           sliderInput("prior_slope_sd", "Prior slope SD:", 
                                       min = 0.1, max = 2, value = 0.5, step = 0.1),
                           
                           br(),
                           actionButton("run_regression", "📊 Run Regression", class = "btn-success btn-lg"),
                           
                           br(), br(),
                           div(class = "highlight-box",
                               h5("💡 Try This:"),
                               p("1. Start with a bad prior (far from true slope)"),
                               p("2. Increase sample size"),
                               p("3. Watch Bayesian estimate converge!")
                           )
                       )
                ),
                
                column(8,
                       div(class = "theory-box",
                           h3("📊 Regression Results"),
                           plotlyOutput("regression_plot", height = "400px"),
                           
                           br(),
                           
                           fluidRow(
                             column(6,
                                    div(class = "freq-box",
                                        h4("Frequentist Analysis"),
                                        verbatimTextOutput("freq_reg_results")
                                    )
                             ),
                             column(6,
                                    div(class = "bayes-box",
                                        h4("Bayesian Analysis"),
                                        verbatimTextOutput("bayes_reg_results")
                                    )
                             )
                           )
                       )
                )
              ),
              
              # Advanced Topics
              fluidRow(
                column(12,
                       div(class = "theory-box",
                           h3("🔬 Advanced Bayesian Regression"),
                           
                           fluidRow(
                             column(6,
                                    h4("📊 Uncertainty Visualization"),
                                    plotlyOutput("uncertainty_plot", height = "300px")
                             ),
                             column(6,
                                    h4("🎯 Posterior Distributions"),
                                    plotlyOutput("posterior_plot", height = "300px")
                             )
                           )
                       )
                )
              )
      ),
      
      # Gene Networks Tab
      tabItem(tabName = "networks",
              fluidRow(
                column(12,
                       h2("🧬 Bayesian Gene Regulatory Networks"),
                       
                       div(class = "theory-box",
                           h3("🔬 Understanding Gene Networks"),
                           
                           p("Gene regulatory networks (GRNs) show how genes control each other's expression:"),
                           
                           fluidRow(
                             column(4,
                                    div(class = "highlight-box",
                                        h5("🧬 Nodes = Genes"),
                                        p("Each node represents a gene's expression level")
                                    )
                             ),
                             column(4,
                                    div(class = "highlight-box",
                                        h5("➡️ Edges = Regulation"),
                                        p("Connections show regulatory relationships")
                                    )
                             ),
                             column(4,
                                    div(class = "highlight-box",
                                        h5("💪 Weights = Strength"),
                                        p("Edge weights indicate regulation strength")
                                    )
                             )
                           ),
                           
                           br(),
                           
                           div(class = "formula-box",
                               h4("Mathematical Model:"),
                               "$$\\text{Expression}_j = \\sum_{i \\neq j} w_{ij} \\times \\text{Expression}_i + \\epsilon$$",
                               br(),
                               p("Where w_ij is the regulatory effect of gene i on gene j")
                           )
                       )
                )
              ),
              
              # Why Bayesian for Networks
              fluidRow(
                column(12,
                       div(class = "theory-box",
                           h3("🎯 Why Bayesian Methods Excel for Gene Networks"),
                           
                           fluidRow(
                             column(6,
                                    div(class = "freq-box",
                                        h4("Traditional Methods"),
                                        tags$ul(
                                          tags$li("Correlation networks: simple but limited"),
                                          tags$li("Point estimates only"),
                                          tags$li("Hard thresholding for edge selection"),
                                          tags$li("No uncertainty quantification"),
                                          tags$li("Difficult to incorporate prior knowledge")
                                        )
                                    )
                             ),
                             column(6,
                                    div(class = "bayes-box",
                                        h4("Bayesian Methods"),
                                        tags$ul(
                                          tags$li("Probabilistic network structure"),
                                          tags$li("Full posterior distributions"),
                                          tags$li("Natural sparsity through priors"),
                                          tags$li("Uncertainty in every edge"),
                                          tags$li("Easy integration of biological priors")
                                        )
                                    )
                             )
                           )
                       )
                )
              ),
              
              # Interactive Network
              fluidRow(
                column(4,
                       div(class = "theory-box",
                           h3("🎮 Build a Gene Network"),
                           
                           h4("Network Parameters:"),
                           sliderInput("n_genes", "Number of genes:", 
                                       min = 5, max = 20, value = 10, step = 1),
                           sliderInput("n_samples", "Number of samples:", 
                                       min = 50, max = 500, value = 100, step = 50),
                           sliderInput("edge_density", "True edge density:", 
                                       min = 0.05, max = 0.3, value = 0.15, step = 0.05),
                           sliderInput("measurement_noise", "Measurement noise:", 
                                       min = 0.1, max = 1, value = 0.3, step = 0.1),
                           
                           h4("Bayesian Settings:"),
                           sliderInput("edge_prior", "Prior edge probability:", 
                                       min = 0.01, max = 0.3, value = 0.1, step = 0.01),
                           sliderInput("sparsity_param", "Sparsity strength:", 
                                       min = 0.1, max = 2, value = 1, step = 0.1),
                           
                           br(),
                           actionButton("generate_network", "🧬 Generate Network", class = "btn-warning btn-lg"),
                           
                           br(), br(),
                           div(class = "highlight-box",
                               h5("🔍 What to Look For:"),
                               p("• Red edges = positive regulation"),
                               p("• Blue edges = negative regulation"),
                               p("• Edge thickness = confidence")
                           )
                       )
                ),
                
                column(8,
                       div(class = "theory-box",
                           h3("🌐 Inferred Gene Network"),
                           visNetworkOutput("gene_network_vis", height = "450px"),
                           
                           br(),
                           verbatimTextOutput("network_stats")
                       )
                )
              ),
              
              # Network Comparison
              fluidRow(
                column(12,
                       div(class = "theory-box",
                           h3("📊 Method Comparison"),
                           
                           fluidRow(
                             column(6,
                                    h4("🔴 True vs Correlation Network"),
                                    plotlyOutput("correlation_network", height = "300px")
                             ),
                             column(6,
                                    h4("🟢 True vs Bayesian Network"),
                                    plotlyOutput("bayesian_network", height = "300px")
                             )
                           ),
                           
                           br(),
                           verbatimTextOutput("network_comparison")
                       )
                )
              )
      ),
      
      # Summary Tab
      tabItem(tabName = "summary",
              fluidRow(
                column(12,
                       div(class = "intro-box",
                           h1("🎓 Congratulations!", style = "text-align: center;"),
                           h3("You've Mastered Bayesian Thinking!", style = "text-align: center;"),
                           br(),
                           
                           div(style = "background: rgba(255,255,255,0.2); padding: 20px; border-radius: 10px;",
                               h3("📚 Key Takeaways:"),
                               tags$ol(style = "font-size: 18px;",
                                       tags$li("Bayesian methods incorporate prior knowledge naturally"),
                                       tags$li("They provide full uncertainty quantification"),
                                       tags$li("Particularly powerful for small samples and complex models"),
                                       tags$li("Essential for modern genomics and bioinformatics")
                               )
                           )
                       )
                ),
                
                column(12,
                       div(class = "theory-box",
                           h3("🧠 Test Your Knowledge"),
                           
                           h4("Question 1: When is Bayesian regression most advantageous?"),
                           radioButtons("q1", "", 
                                        choices = list(
                                          "When you have lots of data" = "a",
                                          "When you have prior information and small samples" = "b",
                                          "When you want faster computation" = "c",
                                          "When you don't care about uncertainty" = "d"
                                        )),
                           
                           h4("Question 2: What makes Bayesian methods ideal for gene networks?"),
                           radioButtons("q2", "", 
                                        choices = list(
                                          "They're always faster" = "a",
                                          "They don't need any data" = "b",
                                          "They naturally handle sparsity and uncertainty" = "c",
                                          "They give exact answers" = "d"
                                        )),
                           
                           br(),
                           actionButton("check_answers", "Check Answers", class = "btn-primary"),
                           
                           br(), br(),
                           verbatimTextOutput("quiz_results")
                       )
                ),
                
                column(12,
                       div(class = "theory-box",
                           h3("🚀 Next Steps"),
                           
                           p("Ready to apply Bayesian methods? Here are some resources:"),
                           
                           tags$ul(style = "font-size: 16px;",
                                   tags$li("Stan - Probabilistic programming language"),
                                   tags$li("PyMC3 - Python library for Bayesian modeling"),
                                   tags$li("brms - Bayesian regression in R"),
                                   tags$li("Edward2 - TensorFlow probability")
                           ),
                           
                           div(style = "text-align: center; margin-top: 30px;",
                               h2("🎉 Happy Bayesian Modeling! 🎉")
                           )
                       )
                )
              )
      )
    )
  )
)

# Define Server
server <- function(input, output, session) {
  
  # Reactive values
  values <- reactiveValues(
    coin_data = NULL,
    regression_data = NULL,
    network_data = NULL
  )
  
  # Navigation
  observeEvent(input$start_journey, {
    updateTabItems(session, "sidebarMenu", "foundations")
  })
  
  # Coin flip analysis
  observeEvent(input$flip_coin, {
    set.seed(123)
    
    # Generate coin flips
    true_p <- input$true_prob
    flips <- rbinom(input$coin_flips, 1, true_p)
    
    # Frequentist analysis
    freq_estimates <- cumsum(flips) / (1:input$coin_flips)
    
    # Bayesian analysis
    prior_alpha <- input$prior_belief * input$prior_strength
    prior_beta <- (1 - input$prior_belief) * input$prior_strength
    
    bayes_estimates <- numeric(input$coin_flips)
    bayes_lower <- numeric(input$coin_flips)
    bayes_upper <- numeric(input$coin_flips)
    
    for(i in 1:input$coin_flips) {
      heads <- sum(flips[1:i])
      tails <- i - heads
      
      post_alpha <- prior_alpha + heads
      post_beta <- prior_beta + tails
      
      bayes_estimates[i] <- post_alpha / (post_alpha + post_beta)
      bayes_lower[i] <- qbeta(0.025, post_alpha, post_beta)
      bayes_upper[i] <- qbeta(0.975, post_alpha, post_beta)
    }
    
    values$coin_data <- data.frame(
      flip = 1:input$coin_flips,
      freq_est = freq_estimates,
      bayes_est = bayes_estimates,
      bayes_lower = bayes_lower,
      bayes_upper = bayes_upper,
      true_p = true_p
    )
  })
  
  output$coin_comparison <- renderPlotly({
    if(is.null(values$coin_data)) return(NULL)
    
    p <- ggplot(values$coin_data, aes(x = flip)) +
      geom_ribbon(aes(ymin = bayes_lower, ymax = bayes_upper), 
                  fill = "#2ecc71", alpha = 0.3) +
      geom_line(aes(y = freq_est, color = "Frequentist"), size = 1.5) +
      geom_line(aes(y = bayes_est, color = "Bayesian"), size = 1.5) +
      geom_hline(aes(yintercept = true_p, color = "True Value"), 
                 linetype = "dashed", size = 1) +
      scale_color_manual(values = c(
        "Frequentist" = "#e74c3c",
        "Bayesian" = "#2ecc71",
        "True Value" = "#34495e"
      )) +
      labs(x = "Number of Flips", y = "Estimated Probability",
           title = "Convergence to True Probability") +
      theme_minimal() +
      theme(legend.position = "bottom")
    
    ggplotly(p)
  })
  
  output$freq_results <- renderText({
    if(is.null(values$coin_data)) return("Click 'Flip Coins' to see results")
    
    final_est <- tail(values$coin_data$freq_est, 1)
    n <- nrow(values$coin_data)
    se <- sqrt(final_est * (1 - final_est) / n)
    ci_lower <- final_est - 1.96 * se
    ci_upper <- final_est + 1.96 * se
    
    paste(
      sprintf("Final estimate: %.3f", final_est),
      sprintf("95%% CI: [%.3f, %.3f]", ci_lower, ci_upper),
      "",
      "Interpretation:",
      "• Point estimate only",
      "• Confidence from repeated sampling",
      "• No use of prior information",
      sep = "\n"
    )
  })
  
  output$bayes_results <- renderText({
    if(is.null(values$coin_data)) return("")
    
    final_est <- tail(values$coin_data$bayes_est, 1)
    final_lower <- tail(values$coin_data$bayes_lower, 1)
    final_upper <- tail(values$coin_data$bayes_upper, 1)
    
    paste(
      sprintf("Posterior mean: %.3f", final_est),
      sprintf("95%% Credible interval: [%.3f, %.3f]", final_lower, final_upper),
      "",
      "Interpretation:",
      "• Full posterior distribution",
      "• Direct probability statements",
      "• Prior knowledge incorporated",
      sep = "\n"
    )
  })
  
  # Regression analysis
  observeEvent(input$run_regression, {
    set.seed(42)
    
    # Generate data
    n <- input$n_points
    x <- runif(n, 0, 10)
    true_intercept <- 3
    y <- true_intercept + input$true_slope * x + rnorm(n, 0, input$noise_level)
    
    # Frequentist regression
    lm_model <- lm(y ~ x)
    freq_slope <- coef(lm_model)[2]
    freq_intercept <- coef(lm_model)[1]
    freq_se <- summary(lm_model)$coefficients[2, 2]
    
    # Bayesian regression (simplified conjugate prior)
    X <- cbind(1, x)
    
    # Prior
    prior_mean <- c(3, input$prior_slope_mean)  # intercept and slope
    prior_precision <- diag(c(0.1, 1/input$prior_slope_sd^2))
    
    # Posterior
    data_precision <- (t(X) %*% X) / input$noise_level^2
    post_precision <- prior_precision + data_precision
    post_cov <- solve(post_precision)
    post_mean <- post_cov %*% (prior_precision %*% prior_mean + t(X) %*% y / input$noise_level^2)
    
    bayes_intercept <- post_mean[1]
    bayes_slope <- post_mean[2]
    bayes_slope_sd <- sqrt(post_cov[2,2])
    
    # Store results
    values$regression_data <- list(
      x = x, y = y,
      true_slope = input$true_slope,
      true_intercept = true_intercept,
      freq_slope = freq_slope,
      freq_intercept = freq_intercept,
      freq_se = freq_se,
      bayes_slope = bayes_slope,
      bayes_intercept = bayes_intercept,
      bayes_slope_sd = bayes_slope_sd,
      prior_slope_mean = input$prior_slope_mean,
      prior_slope_sd = input$prior_slope_sd
    )
  })
  
  output$regression_plot <- renderPlotly({
    if(is.null(values$regression_data)) return(NULL)
    
    d <- values$regression_data
    
    # Create prediction data
    x_pred <- seq(0, 10, length.out = 100)
    
    # Predictions
    freq_pred <- d$freq_intercept + d$freq_slope * x_pred
    bayes_pred <- d$bayes_intercept + d$bayes_slope * x_pred
    true_pred <- d$true_intercept + d$true_slope * x_pred
    
    plot_data <- data.frame(
      x = c(d$x, x_pred, x_pred, x_pred),
      y = c(d$y, freq_pred, bayes_pred, true_pred),
      type = c(rep("Data", length(d$x)), 
               rep("Frequentist", 100),
               rep("Bayesian", 100),
               rep("True", 100))
    )
    
    p <- ggplot() +
      geom_point(data = plot_data[plot_data$type == "Data",], 
                 aes(x = x, y = y), alpha = 0.6, size = 3) +
      geom_line(data = plot_data[plot_data$type == "Frequentist",], 
                aes(x = x, y = y, color = "Frequentist"), size = 1.5) +
      geom_line(data = plot_data[plot_data$type == "Bayesian",], 
                aes(x = x, y = y, color = "Bayesian"), size = 1.5) +
      geom_line(data = plot_data[plot_data$type == "True",], 
                aes(x = x, y = y, color = "True"), size = 1.5, linetype = "dashed") +
      scale_color_manual(values = c(
        "Frequentist" = "#e74c3c",
        "Bayesian" = "#2ecc71",
        "True" = "#34495e"
      )) +
      labs(x = "X", y = "Y", title = "Regression Line Comparison") +
      theme_minimal() +
      theme(legend.position = "bottom")
    
    ggplotly(p)
  })
  
  output$freq_reg_results <- renderText({
    if(is.null(values$regression_data)) return("Run regression to see results")
    
    d <- values$regression_data
    ci_lower <- d$freq_slope - 1.96 * d$freq_se
    ci_upper <- d$freq_slope + 1.96 * d$freq_se
    
    paste(
      sprintf("Slope estimate: %.3f", d$freq_slope),
      sprintf("Standard error: %.3f", d$freq_se),
      sprintf("95%% CI: [%.3f, %.3f]", ci_lower, ci_upper),
      "",
      sprintf("Error from true: %.3f", abs(d$freq_slope - d$true_slope)),
      sep = "\n"
    )
  })
  
  output$bayes_reg_results <- renderText({
    if(is.null(values$regression_data)) return("")
    
    d <- values$regression_data
    ci_lower <- d$bayes_slope - 1.96 * d$bayes_slope_sd
    ci_upper <- d$bayes_slope + 1.96 * d$bayes_slope_sd
    
    paste(
      sprintf("Prior: N(%.2f, %.2f²)", d$prior_slope_mean, d$prior_slope_sd),
      sprintf("Posterior mean: %.3f", d$bayes_slope),
      sprintf("Posterior SD: %.3f", d$bayes_slope_sd),
      sprintf("95%% CI: [%.3f, %.3f]", ci_lower, ci_upper),
      "",
      sprintf("Error from true: %.3f", abs(d$bayes_slope - d$true_slope)),
      sep = "\n"
    )
  })
  
  # Uncertainty plots
  output$uncertainty_plot <- renderPlotly({
    if(is.null(values$regression_data)) return(NULL)
    
    d <- values$regression_data
    
    # Generate samples from posterior
    n_samples <- 100
    slope_samples <- rnorm(n_samples, d$bayes_slope, d$bayes_slope_sd)
    intercept_samples <- rnorm(n_samples, d$bayes_intercept, 0.5)
    
    x_pred <- seq(0, 10, length.out = 50)
    
    p <- ggplot() +
      geom_point(aes(x = d$x, y = d$y), alpha = 0.5)
    
    # Add sampled regression lines
    for(i in 1:min(50, n_samples)) {
      y_pred <- intercept_samples[i] + slope_samples[i] * x_pred
      p <- p + geom_line(aes(x = x_pred, y = y_pred), 
                         alpha = 0.1, color = "#2ecc71")
    }
    
    p <- p + 
      labs(x = "X", y = "Y", 
           title = "Bayesian Uncertainty Visualization") +
      theme_minimal()
    
    ggplotly(p)
  })
  
  output$posterior_plot <- renderPlotly({
    if(is.null(values$regression_data)) return(NULL)
    
    d <- values$regression_data
    
    # Create distributions
    x_range <- seq(d$bayes_slope - 3*d$bayes_slope_sd, 
                   d$bayes_slope + 3*d$bayes_slope_sd, 
                   length.out = 100)
    
    prior_density <- dnorm(x_range, d$prior_slope_mean, d$prior_slope_sd)
    posterior_density <- dnorm(x_range, d$bayes_slope, d$bayes_slope_sd)
    
    plot_data <- data.frame(
      x = rep(x_range, 2),
      density = c(prior_density, posterior_density),
      type = rep(c("Prior", "Posterior"), each = 100)
    )
    
    p <- ggplot(plot_data, aes(x = x, y = density, fill = type)) +
      geom_area(alpha = 0.6, position = "identity") +
      geom_vline(xintercept = d$true_slope, linetype = "dashed", 
                 color = "black", size = 1) +
      scale_fill_manual(values = c("Prior" = "#f39c12", "Posterior" = "#2ecc71")) +
      labs(x = "Slope", y = "Density", 
           title = "Prior vs Posterior Distribution") +
      theme_minimal()
    
    ggplotly(p)
  })
  
  # Gene network analysis
  observeEvent(input$generate_network, {
    set.seed(123)
    
    n_genes <- input$n_genes
    n_samples <- input$n_samples
    
    # Generate true network
    true_network <- matrix(0, n_genes, n_genes)
    for(i in 1:(n_genes-1)) {
      for(j in (i+1):n_genes) {
        if(runif(1) < input$edge_density) {
          true_network[i,j] <- runif(1, -1, 1)
          true_network[j,i] <- true_network[i,j]
        }
      }
    }
    
    # Generate expression data
    expression_data <- matrix(rnorm(n_samples * n_genes), n_samples, n_genes)
    
    # Apply network effects
    for(i in 1:n_samples) {
      for(iter in 1:5) {  # iterate to reach equilibrium
        new_expr <- expression_data[i,]
        for(j in 1:n_genes) {
          network_effect <- sum(true_network[j,] * expression_data[i,])
          new_expr[j] <- network_effect + rnorm(1, 0, input$measurement_noise)
        }
        expression_data[i,] <- new_expr
      }
    }
    
    # Correlation-based network
    cor_network <- cor(expression_data)
    diag(cor_network) <- 0
    
    # Bayesian network inference (simplified)
    bayes_network <- matrix(0, n_genes, n_genes)
    edge_probabilities <- matrix(0, n_genes, n_genes)
    
    for(i in 1:(n_genes-1)) {
      for(j in (i+1):n_genes) {
        # Calculate correlation
        r <- cor(expression_data[,i], expression_data[,j])
        
        # Bayesian inference with prior
        prior_prob <- input$edge_prior
        
        # Simplified Bayes factor calculation
        bf <- exp(n_samples * r^2 / 2)
        
        # Posterior probability
        post_prob <- (bf * prior_prob) / (bf * prior_prob + (1 - prior_prob))
        
        # Apply sparsity
        if(post_prob > 0.5) {
          bayes_network[i,j] <- r * post_prob
          bayes_network[j,i] <- bayes_network[i,j]
        }
        
        edge_probabilities[i,j] <- post_prob
        edge_probabilities[j,i] <- post_prob
      }
    }
    
    values$network_data <- list(
      true_network = true_network,
      cor_network = cor_network,
      bayes_network = bayes_network,
      edge_probabilities = edge_probabilities,
      n_genes = n_genes
    )
  })
  
  output$gene_network_vis <- renderVisNetwork({
    if(is.null(values$network_data)) return(NULL)
    
    d <- values$network_data
    
    # Create nodes
    nodes <- data.frame(
      id = 1:d$n_genes,
      label = paste0("Gene", 1:d$n_genes),
      color = "#3498db",
      size = 25
    )
    
    # Create edges from Bayesian network
    edges <- data.frame()
    for(i in 1:(d$n_genes-1)) {
      for(j in (i+1):d$n_genes) {
        if(abs(d$bayes_network[i,j]) > 0) {
          edges <- rbind(edges, data.frame(
            from = i,
            to = j,
            value = abs(d$bayes_network[i,j]) * 5,
            color = ifelse(d$bayes_network[i,j] > 0, "#e74c3c", "#3498db"),
            title = sprintf("Weight: %.3f<br>Probability: %.3f", 
                            d$bayes_network[i,j], 
                            d$edge_probabilities[i,j])
          ))
        }
      }
    }
    
    visNetwork(nodes, edges) %>%
      visOptions(highlightNearest = TRUE) %>%
      visPhysics(enabled = FALSE)
  })
  
  output$network_stats <- renderText({
    if(is.null(values$network_data)) return("Generate a network to see statistics")
    
    d <- values$network_data
    
    # Calculate statistics
    true_edges <- sum(abs(d$true_network) > 0) / 2
    bayes_edges <- sum(abs(d$bayes_network) > 0) / 2
    cor_edges <- sum(abs(d$cor_network) > 0.3) / 2  # threshold
    
    # Calculate accuracy
    true_binary <- abs(d$true_network) > 0
    bayes_binary <- abs(d$bayes_network) > 0
    cor_binary <- abs(d$cor_network) > 0.3
    
    bayes_tp <- sum(true_binary & bayes_binary) / 2
    bayes_fp <- sum(!true_binary & bayes_binary) / 2
    bayes_precision <- bayes_tp / (bayes_tp + bayes_fp)
    
    cor_tp <- sum(true_binary & cor_binary) / 2
    cor_fp <- sum(!true_binary & cor_binary) / 2
    cor_precision <- cor_tp / (cor_tp + cor_fp)
    
    paste(
      "NETWORK STATISTICS:",
      sprintf("True edges: %d", true_edges),
      sprintf("Bayesian inferred edges: %d", bayes_edges),
      sprintf("Correlation edges (>0.3): %d", cor_edges),
      "",
      "PERFORMANCE:",
      sprintf("Bayesian precision: %.2f%%", bayes_precision * 100),
      sprintf("Correlation precision: %.2f%%", cor_precision * 100),
      "",
      "Bayesian method provides uncertainty estimates for each edge!",
      sep = "\n"
    )
  })
  
  # Network comparison plots
  output$correlation_network <- renderPlotly({
    if(is.null(values$network_data)) return(NULL)
    
    d <- values$network_data
    
    # Compare true vs correlation
    true_edges <- as.vector(d$true_network[upper.tri(d$true_network)])
    cor_edges <- as.vector(d$cor_network[upper.tri(d$cor_network)])
    
    plot_data <- data.frame(
      true = true_edges,
      inferred = cor_edges
    )
    
    p <- ggplot(plot_data, aes(x = true, y = inferred)) +
      geom_point(alpha = 0.5) +
      geom_abline(intercept = 0, slope = 1, color = "red", linetype = "dashed") +
      labs(x = "True Edge Weight", y = "Correlation",
           title = "Correlation Method") +
      theme_minimal()
    
    ggplotly(p)
  })
  
  output$bayesian_network <- renderPlotly({
    if(is.null(values$network_data)) return(NULL)
    
    d <- values$network_data
    
    # Compare true vs Bayesian
    true_edges <- as.vector(d$true_network[upper.tri(d$true_network)])
    bayes_edges <- as.vector(d$bayes_network[upper.tri(d$bayes_network)])
    
    plot_data <- data.frame(
      true = true_edges,
      inferred = bayes_edges
    )
    
    p <- ggplot(plot_data, aes(x = true, y = inferred)) +
      geom_point(alpha = 0.5, color = "#2ecc71") +
      geom_abline(intercept = 0, slope = 1, color = "red", linetype = "dashed") +
      labs(x = "True Edge Weight", y = "Bayesian Estimate",
           title = "Bayesian Method") +
      theme_minimal()
    
    ggplotly(p)
  })
  
  output$network_comparison <- renderText({
    if(is.null(values$network_data)) return("")
    
    paste(
      "KEY OBSERVATIONS:",
      "",
      "• Correlation method includes many false positives",
      "• Bayesian method naturally enforces sparsity",
      "• Bayesian provides uncertainty for each edge",
      "• Prior knowledge can be incorporated easily",
      sep = "\n"
    )
  })
  
  # Quiz functionality
  observeEvent(input$check_answers, {
    correct <- 0
    feedback <- character()
    
    if(input$q1 == "b") {
      correct <- correct + 1
      feedback <- c(feedback, "✓ Question 1: Correct! Bayesian methods shine with small samples and prior information.")
    } else {
      feedback <- c(feedback, "✗ Question 1: Bayesian methods are most valuable when you have prior knowledge and limited data.")
    }
    
    if(input$q2 == "c") {
      correct <- correct + 1
      feedback <- c(feedback, "✓ Question 2: Correct! Natural sparsity and uncertainty quantification are key advantages.")
    } else {
      feedback <- c(feedback, "✗ Question 2: Bayesian methods excel at handling sparse networks with uncertainty.")
    }
    
    output$quiz_results <- renderText({
      paste(c(
        sprintf("Score: %d/2", correct),
        "",
        feedback
      ), collapse = "\n")
    })
  })
}

# Run the application
shinyApp(ui = ui, server = server)
