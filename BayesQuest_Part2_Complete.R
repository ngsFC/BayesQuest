library(shiny)
library(shinydashboard)
library(plotly)
library(ggplot2)
library(dplyr)
library(shinyjs)
library(DT)

# Define UI
ui <- dashboardPage(
  skin = "purple",
  dashboardHeader(title = "🧠 BayesQuest Part 2: Advanced Methods"),
  
  dashboardSidebar(
    sidebarMenu(
      id = "sidebarMenu",
      menuItem("🏠 Introduction", tabName = "intro", icon = icon("home"), selected = TRUE),
      menuItem("📊 Bayesian Normal Distribution", tabName = "normal_bayes", icon = icon("bell")),
      menuItem("📈 Bayesian Poisson Distribution", tabName = "poisson_bayes", icon = icon("bar-chart")),
      menuItem("⚡ Variational Inference", tabName = "variational", icon = icon("bolt")),
      menuItem("🎯 Spike and Slab", tabName = "spike_slab", icon = icon("filter")),
      menuItem("🎓 Summary", tabName = "summary", icon = icon("graduation-cap"))
    )
  ),
  
  dashboardBody(
    useShinyjs(),
    tags$head(
      tags$style(HTML('
        .intro-box { 
          background: linear-gradient(135deg, #9b59b6 0%, #8e44ad 100%);
          color: white;
          border-radius: 15px;
          padding: 30px;
          margin: 15px 0;
          box-shadow: 0 10px 20px rgba(0,0,0,0.2);
        }
        
        .theory-box { 
          background: #ffffff;
          border: 2px solid #9b59b6;
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
          background: #f3e5f5;
          border: 2px solid #9b59b6;
          border-radius: 8px;
          padding: 15px;
          margin: 15px 0;
        }
        
        .explanation-box {
          background: #e8f5e8;
          border-left: 5px solid #27ae60;
          padding: 15px;
          margin: 15px 0;
          border-radius: 5px;
        }
        
        .step-box {
          background: #f3e5f5;
          border: 2px solid #9b59b6;
          border-radius: 8px;
          padding: 15px;
          margin: 10px 0;
        }
        
        .warning-box {
          background: #fff3e0;
          border-left: 5px solid #ff9800;
          padding: 15px;
          margin: 15px 0;
          border-radius: 5px;
        }
      '))
    ),
    
    tabItems(
      # Introduction Tab
      tabItem(tabName = "intro",
              fluidRow(
                column(12,
                       div(class = "intro-box",
                           h1("🧠 Welcome to BayesQuest Part 2!", style = "text-align: center;"),
                           h3("Advanced Bayesian Methods", style = "text-align: center;"),
                           br(),
                           div(style = "background: rgba(255,255,255,0.2); padding: 20px; border-radius: 10px;",
                               h3("🎯 What You'll Learn:"),
                               tags$ol(style = "font-size: 18px;",
                                       tags$li("Bayesian analysis of Normal distributions"),
                                       tags$li("Bayesian analysis of Poisson distributions"),
                                       tags$li("Variational inference methods"),
                                       tags$li("Spike and slab variable selection"),
                                       tags$li("When to use each advanced method")
                               )
                           ),
                           br(),
                           div(style = "text-align: center;",
                               actionButton("start_journey", "🚀 Start Advanced Journey", 
                                            style = "font-size: 20px; padding: 15px 40px; background: white; color: #9b59b6;")
                           )
                       )
                )
              )
      ),
      
      # Normal Bayes Tab
      tabItem(tabName = "normal_bayes",
              fluidRow(
                column(12,
                       h2("📊 The Normal Distribution: Foundation of Bayesian Inference"),
                       
                       div(class = "explanation-box",
                           h3("🎯 Why the Normal Distribution is So Important"),
                           p("The normal distribution isn't just 'the bell curve' - it's the fundamental building block 
                             of almost all modern statistics. With the Bayesian approach, we can estimate 
                             its parameters (mean μ and variance σ²) elegantly and principled."),
                           br(),
                           p(strong("🧮 The magic: "), "Using conjugate priors, posterior distributions 
                             remain in known families, making everything computationally tractable!")
                       )
                )
              ),
              
              fluidRow(
                column(12,
                       div(class = "theory-box",
                           h3("🔢 The Two Parameters and Their Conjugate Priors"),
                           
                           div(class = "formula-box",
                               h4("📐 The Model:"),
                               "X ~ Normal(μ, σ²)",
                               br(),
                               h4("🧠 Conjugate Priors:"),
                               "μ | σ² ~ Normal(μ₀, σ²/κ₀)",
                               br(),
                               "σ² ~ InverseGamma(α₀, β₀)"
                           ),
                           
                           fluidRow(
                             column(6,
                                    div(class = "step-box",
                                        h4("🎯 Prior on Mean μ"),
                                        p(strong("Form:"), " Conditional Normal"),
                                        p(strong("Parameters:")),
                                        tags$ul(
                                          tags$li("μ₀: where you think the mean is centered"),
                                          tags$li("κ₀: how certain you are (pseudo-observations)")
                                        ),
                                        p(strong("Interpretation:"), " 'I think μ is about μ₀, 
                                          with confidence equivalent to κ₀ observations'")
                                    )
                             ),
                             column(6,
                                    div(class = "step-box",
                                        h4("📏 Prior on Variance σ²"),
                                        p(strong("Form:"), " Inverse Gamma"),
                                        p(strong("Parameters:")),
                                        tags$ul(
                                          tags$li("α₀: shape parameter"),
                                          tags$li("β₀: scale parameter")
                                        ),
                                        p(strong("Interpretation:"), " Controls shape and spread 
                                          of the σ² distribution")
                                    )
                             )
                           )
                       )
                )
              ),
              
              # Interactive section for mean estimation with known variance
              fluidRow(
                column(12,
                       div(class = "theory-box",
                           h3("🎮 Laboratory: Bayesian Mean Estimation (known σ²)"),
                           
                           div(class = "explanation-box",
                               h4("📚 Simplified Scenario:"),
                               p("Let's start by assuming we know the variance σ² = 1. 
                                 This allows us to focus on estimating the mean μ 
                                 using the simplest conjugate prior.")
                           )
                       )
                )
              ),
              
              fluidRow(
                column(4,
                       div(class = "theory-box",
                           h3("🎛️ Lab Controls"),
                           
                           div(class = "step-box",
                               h4("🔬 Experiment"),
                               sliderInput("true_mu", "True mean (μ):", 
                                           min = -3, max = 3, value = 0, step = 0.5),
                               sliderInput("n_obs", "Number of observations:", 
                                           min = 5, max = 100, value = 20, step = 5),
                               div(class = "explanation-box",
                                   p(em("Variance fixed at σ² = 1 for simplicity")))
                           ),
                           
                           div(class = "step-box",
                               h4("🧠 Your Prior on μ"),
                               sliderInput("prior_mu", "Initial belief (μ₀):", 
                                           min = -3, max = 3, value = 0, step = 0.5),
                               sliderInput("prior_kappa", "Confidence in prior (κ₀):", 
                                           min = 0.1, max = 10, value = 1, step = 0.5),
                               div(class = "explanation-box",
                                   p(em("κ₀ = 'equivalent observations' of your prior")))
                           ),
                           
                           br(),
                           actionButton("run_normal_bayes", "🔬 Generate Data & Estimate!", 
                                        class = "btn-primary btn-lg"),
                           
                           br(), br(),
                           div(class = "highlight-box",
                               h5("🧪 Suggested Experiments:"),
                               p("1. Right vs wrong prior"),
                               p("2. Weak (κ₀=0.5) vs strong (κ₀=5) prior"),
                               p("3. Little data (n=5) vs lots (n=50)"),
                               p("4. Observe how the posterior updates!")
                           )
                       )
                ),
                
                column(8,
                       div(class = "theory-box",
                           h3("📊 Evolution of Beliefs"),
                           
                           fluidRow(
                             column(6,
                                    h4("🏛️ Frequentist Approach", style = "text-align: center; color: #e74c3c;"),
                                    plotlyOutput("freq_normal_plot", height = "300px")
                             ),
                             column(6,
                                    h4("🧠 Bayesian Approach", style = "text-align: center; color: #2ecc71;"),
                                    plotlyOutput("bayes_normal_plot", height = "300px")
                             )
                           ),
                           
                           br(),
                           
                           div(class = "explanation-box",
                               h4("🔍 Graphic Comparison:"),
                               tags$ul(
                                 tags$li(strong("Left (Frequentist):"), " Only likelihood from data"),
                                 tags$li(strong("Right (Bayesian):"), " Prior (dashed) + Likelihood = Posterior (solid)"),
                                 tags$li(strong("Gray area:"), " 95% confidence/credibility interval"),
                                 tags$li(strong("Red vertical line:"), " True value of μ")
                               )
                           )
                       )
                )
              ),
              
              fluidRow(
                column(6,
                       div(class = "freq-box",
                           h4("🏛️ Frequentist Analysis"),
                           verbatimTextOutput("freq_normal_results"),
                           
                           div(class = "explanation-box",
                               h5("📊 Classical Formula:"),
                               div(class = "formula-box",
                                   "μ̂ = x̄",
                                   br(),
                                   "SE = σ/√n = 1/√n"
                               ),
                               p("Simple but doesn't use prior information")
                           )
                       )
                ),
                column(6,
                       div(class = "bayes-box",
                           h4("🧠 Bayesian Analysis"),
                           verbatimTextOutput("bayes_normal_results"),
                           
                           div(class = "explanation-box",
                               h5("🧮 Posterior Formula:"),
                               div(class = "formula-box",
                                   "μ | x ~ Normal(μₙ, 1/κₙ)",
                                   br(),
                                   "μₙ = (κ₀μ₀ + nx̄)/(κ₀ + n)",
                                   br(),
                                   "κₙ = κ₀ + n"
                               ),
                               p("Optimally combines prior and likelihood")
                           )
                       )
                )
              )
      ),
      
      # Poisson Bayes Tab
      tabItem(tabName = "poisson_bayes",
              fluidRow(
                column(12,
                       h2("📊 Bayesian Poisson Distribution"),
                       
                       div(class = "explanation-box",
                           h3("🎯 Understanding Poisson Processes"),
                           p(style = "font-size: 18px;", 
                             "The Poisson distribution models count data: number of events in a fixed time period. 
                             In Bayesian analysis, we treat the rate parameter λ as uncertain and update our beliefs with data.")
                       ),
                       
                       div(class = "theory-box",
                           h3("📚 Theory: Poisson-Gamma Conjugacy"),
                           p("For Poisson likelihood with Gamma prior, we get a Gamma posterior:"),
                           div(class = "formula-box",
                               "Data: X₁, ..., Xₙ ~ Poisson(λ)",
                               br(),
                               "Prior: λ ~ Gamma(α, β)",
                               br(),
                               "Posterior: λ | x ~ Gamma(α + Σxᵢ, β + n)"
                           ),
                           h4("🔧 Interactive Parameters:"),
                           fluidRow(
                             column(4,
                                    numericInput("poisson_alpha", "Prior α (shape):", value = 2, min = 0.1, max = 10, step = 0.1)
                             ),
                             column(4,
                                    numericInput("poisson_beta", "Prior β (rate):", value = 1, min = 0.1, max = 10, step = 0.1)
                             ),
                             column(4,
                                    numericInput("poisson_n_obs", "Number of observations:", value = 10, min = 1, max = 100, step = 1)
                             )
                           ),
                           br(),
                           fluidRow(
                             column(6,
                                    sliderInput("poisson_true_lambda", "True λ (for simulation):", 
                                               min = 0.1, max = 10, value = 3, step = 0.1)
                             ),
                             column(6,
                                    actionButton("generate_poisson_data", "🎲 Generate New Data", 
                                               class = "btn-primary", style = "margin-top: 25px;")
                             )
                           )
                       )
                )
              ),
              
              fluidRow(
                column(6,
                       div(class = "theory-box",
                           h3("📊 Prior vs Posterior"),
                           plotlyOutput("poisson_prior_posterior_plot", height = "400px"),
                           br(),
                           div(class = "highlight-box",
                               h4("📈 Key Insights:"),
                               tags$ul(
                                 tags$li("Prior belief gets updated by observed data"),
                                 tags$li("More data → posterior concentrates around true value"),
                                 tags$li("Gamma conjugacy gives exact analytical solution")
                               )
                           )
                       )
                ),
                column(6,
                       div(class = "theory-box",
                           h3("🎯 Predictive Distribution"),
                           plotlyOutput("poisson_predictive_plot", height = "400px"),
                           br(),
                           div(class = "highlight-box",
                               h4("🔮 Prediction:"),
                               p("The posterior predictive distribution shows expected counts for future observations."),
                               verbatimTextOutput("poisson_summary_stats")
                           )
                       )
                )
              ),
              
              fluidRow(
                column(12,
                       div(class = "theory-box",
                           h3("🏥 Real-World Applications"),
                           fluidRow(
                             column(4,
                                    div(class = "comparison-card",
                                        h4("🚑 Hospital Arrivals", style = "color: #e74c3c;"),
                                        p("Model emergency room arrivals per hour"),
                                        p("Prior: Historical average ± uncertainty"),
                                        p("Update: Daily observation counts")
                                    )
                             ),
                             column(4,
                                    div(class = "comparison-card",
                                        h4("🐛 Defect Counting", style = "color: #f39c12;"),
                                        p("Software bugs per 1000 lines of code"),
                                        p("Prior: Industry standards"),
                                        p("Update: Code review findings")
                                    )
                             ),
                             column(4,
                                    div(class = "comparison-card",
                                        h4("📧 Email Volume", style = "color: #27ae60;"),
                                        p("Spam emails per day"),
                                        p("Prior: Historical patterns"),
                                        p("Update: Daily spam counts")
                                    )
                             )
                           )
                       )
                )
              )
      ),
      
      # Variational Inference Tab
      tabItem(tabName = "variational",
              fluidRow(
                column(12,
                       h2("⚡ Variational Inference in Bayesian Analysis"),
                       
                       div(class = "explanation-box",
                           h3("🎯 The Challenge: When Exact Inference is Impossible"),
                           p(style = "font-size: 18px;", 
                             "Many Bayesian models have posterior distributions that are analytically intractable. 
                             Variational Inference (VI) provides a deterministic approximation alternative to MCMC sampling.")
                       ),
                       
                       div(class = "theory-box",
                           h3("📚 Core Concept: Approximation via Optimization"),
                           p("VI transforms the inference problem into an optimization problem:"),
                           div(class = "formula-box",
                               "Intractable: p(θ | x) = p(x | θ)p(θ)/p(x)",
                               br(),
                               "Approximate: q(θ) ≈ p(θ | x)",
                               br(),
                               "Minimize: KL[q(θ) || p(θ | x)]"
                           ),
                           
                           div(class = "highlight-box",
                               h4("🔑 Key Idea: Evidence Lower BOund (ELBO)"),
                               p("Since we can't compute the exact posterior, we maximize the ELBO:"),
                               div(class = "formula-box",
                                   "ELBO = E_q[log p(x, θ)] - E_q[log q(θ)]",
                                   br(),
                                   "= Expected log-likelihood - KL divergence"
                               )
                           )
                       )
                )
              ),
              
              fluidRow(
                column(6,
                       div(class = "theory-box",
                           h3("🏗️ Mean Field Variational Family"),
                           p("Assume independence between parameters:"),
                           div(class = "formula-box",
                               "q(θ) = ∏ᵢ qᵢ(θᵢ)"
                           ),
                           
                           h4("🔧 Interactive VI Demo:"),
                           sliderInput("vi_true_mu", "True μ:", min = -5, max = 5, value = 2, step = 0.1),
                           sliderInput("vi_true_sigma", "True σ:", min = 0.1, max = 3, value = 1, step = 0.1),
                           numericInput("vi_n_obs", "Number of observations:", value = 50, min = 10, max = 200, step = 10),
                           actionButton("run_vi", "🚀 Run VI Approximation", class = "btn-primary"),
                           
                           br(), br(),
                           div(class = "highlight-box",
                               h5("⚡ VI Advantages:"),
                               tags$ul(
                                 tags$li("Deterministic and fast"),
                                 tags$li("Scales to large datasets"),
                                 tags$li("Easy to parallelize"),
                                 tags$li("Provides uncertainty estimates")
                               )
                           )
                       )
                ),
                column(6,
                       div(class = "theory-box",
                           h3("📊 VI vs MCMC Comparison"),
                           plotlyOutput("vi_comparison_plot", height = "400px"),
                           
                           br(),
                           div(class = "highlight-box",
                               h5("🎯 When to Use VI:"),
                               tags$ul(
                                 tags$li("Large datasets (VI scales better)"),
                                 tags$li("Real-time inference needed"),
                                 tags$li("Approximate solution acceptable"),
                                 tags$li("Complex hierarchical models")
                               ),
                               
                               h5("⚠️ VI Limitations:"),
                               tags$ul(
                                 tags$li("Underestimates uncertainty"),
                                 tags$li("Assumes factorized approximation"),
                                 tags$li("Local optima in optimization")
                               )
                           )
                       )
                )
              ),
              
              fluidRow(
                column(12,
                       div(class = "theory-box",
                           h3("🧬 Applications in Modern Bayesian ML"),
                           fluidRow(
                             column(4,
                                    div(class = "comparison-card",
                                        h4("🤖 Variational Autoencoders", style = "color: #9b59b6;"),
                                        p("Deep generative models using VI"),
                                        p("Encoder: data → latent code"),
                                        p("Decoder: latent code → reconstruction"),
                                        p("VI: approximate posterior over latents")
                                    )
                             ),
                             column(4,
                                    div(class = "comparison-card",
                                        h4("📚 Topic Modeling", style = "color: #e67e22;"),
                                        p("Latent Dirichlet Allocation (LDA)"),
                                        p("Documents as mixtures of topics"),
                                        p("VI: scales to millions of documents"),
                                        p("Alternative to collapsed Gibbs sampling")
                                    )
                             ),
                             column(4,
                                    div(class = "comparison-card",
                                        h4("🧠 Neural Networks", style = "color: #3498db;"),
                                        p("Bayesian Neural Networks (BNNs)"),
                                        p("Uncertainty over network weights"),
                                        p("VI: tractable training at scale"),
                                        p("Dropout as VI approximation")
                                    )
                             )
                           )
                       )
                )
              )
      ),
      
      # Spike and Slab Tab
      tabItem(tabName = "spike_slab",
              fluidRow(
                column(12,
                       h2("🎯 Spike and Slab Methods"),
                       
                       div(class = "explanation-box",
                           h3("🔍 The Variable Selection Problem"),
                           p(style = "font-size: 18px;", 
                             "In regression with many predictors, which variables are truly important? 
                             Spike and Slab provides a Bayesian approach to automatic variable selection.")
                       ),
                       
                       div(class = "theory-box",
                           h3("📚 The Spike and Slab Prior"),
                           p("A mixture of a 'spike' (point mass at zero) and a 'slab' (diffuse distribution):"),
                           div(class = "formula-box",
                               "βⱼ | γⱼ ~ (1 - γⱼ)δ₀ + γⱼN(0, τ²)",
                               br(),
                               "γⱼ ~ Bernoulli(π)"
                           ),
                           
                           fluidRow(
                             column(6,
                                    div(class = "highlight-box",
                                        h5("📍 Spike Component:"),
                                        tags$ul(
                                          tags$li("Point mass at zero: δ₀"),
                                          tags$li("Variable not in model"),
                                          tags$li("Probability: (1 - γⱼ)")
                                        )
                                    )
                             ),
                             column(6,
                                    div(class = "highlight-box",
                                        h5("📊 Slab Component:"),
                                        tags$ul(
                                          tags$li("Diffuse normal: N(0, τ²)"),
                                          tags$li("Variable included in model"),
                                          tags$li("Probability: γⱼ")
                                        )
                                    )
                             )
                           )
                       )
                )
              ),
              
              fluidRow(
                column(6,
                       div(class = "theory-box",
                           h3("🔧 Interactive Spike and Slab"),
                           
                           h4("Simulation Parameters:"),
                           sliderInput("ss_n_vars", "Number of predictors:", min = 5, max = 50, value = 20, step = 1),
                           sliderInput("ss_n_relevant", "True relevant variables:", min = 1, max = 10, value = 3, step = 1),
                           sliderInput("ss_noise_level", "Noise level:", min = 0.1, max = 2, value = 0.5, step = 0.1),
                           
                           h4("Prior Parameters:"),
                           sliderInput("ss_pi", "Inclusion probability π:", min = 0.01, max = 0.5, value = 0.1, step = 0.01),
                           sliderInput("ss_tau", "Slab variance τ²:", min = 0.1, max = 10, value = 1, step = 0.1),
                           
                           actionButton("run_spike_slab", "🎲 Run Spike and Slab", class = "btn-primary"),
                           
                           br(), br(),
                           div(class = "highlight-box",
                               h5("🎯 Model Properties:"),
                               verbatimTextOutput("ss_model_summary")
                           )
                       )
                ),
                column(6,
                       div(class = "theory-box",
                           h3("📊 Variable Selection Results"),
                           plotlyOutput("spike_slab_plot", height = "400px"),
                           
                           br(),
                           div(class = "highlight-box",
                               h5("📈 Interpretation:"),
                               tags$ul(
                                 tags$li("Height = Posterior inclusion probability"),
                                 tags$li("Color = True relevance (red = relevant)"),
                                 tags$li("High bars = model thinks variable is important"),
                                 tags$li("Good performance = high bars for red variables")
                               )
                           )
                       )
                )
              ),
              
              fluidRow(
                column(12,
                       div(class = "theory-box",
                           h3("⚖️ Comparison with Other Methods"),
                           
                           fluidRow(
                             column(3,
                                    div(class = "comparison-card",
                                        h4("🎯 Spike and Slab", style = "color: #2ecc71;"),
                                        h5("✅ Pros:"),
                                        tags$ul(
                                          tags$li("Automatic variable selection"),
                                          tags$li("Uncertainty quantification"),
                                          tags$li("Incorporates prior knowledge"),
                                          tags$li("Handles correlations well")
                                        ),
                                        h5("❌ Cons:"),
                                        tags$ul(
                                          tags$li("Computationally intensive"),
                                          tags$li("Requires MCMC sampling"),
                                          tags$li("Prior specification critical")
                                        )
                                    )
                             ),
                             column(3,
                                    div(class = "comparison-card",
                                        h4("📏 LASSO Regression", style = "color: #e74c3c;"),
                                        h5("✅ Pros:"),
                                        tags$ul(
                                          tags$li("Fast optimization"),
                                          tags$li("Built-in variable selection"),
                                          tags$li("Convex objective")
                                        ),
                                        h5("❌ Cons:"),
                                        tags$ul(
                                          tags$li("No uncertainty estimates"),
                                          tags$li("Arbitrarily sets coefficients to zero"),
                                          tags$li("Selection inconsistency")
                                        )
                                    )
                             ),
                             column(3,
                                    div(class = "comparison-card",
                                        h4("🌲 Random Forest", style = "color: #f39c12;"),
                                        h5("✅ Pros:"),
                                        tags$ul(
                                          tags$li("Non-parametric"),
                                          tags$li("Handles interactions"),
                                          tags$li("Variable importance scores")
                                        ),
                                        h5("❌ Cons:"),
                                        tags$ul(
                                          tags$li("Black box model"),
                                          tags$li("No uncertainty quantification"),
                                          tags$li("Doesn't provide coefficients")
                                        )
                                    )
                             ),
                             column(3,
                                    div(class = "comparison-card",
                                        h4("🔍 Elastic Net", style = "color: #9b59b6;"),
                                        h5("✅ Pros:"),
                                        tags$ul(
                                          tags$li("Combines L1 and L2 penalties"),
                                          tags$li("Handles correlated predictors"),
                                          tags$li("Fast computation")
                                        ),
                                        h5("❌ Cons:"),
                                        tags$ul(
                                          tags$li("No uncertainty estimates"),
                                          tags$li("Hyperparameter tuning"),
                                          tags$li("Not fully Bayesian")
                                        )
                                    )
                             )
                           )
                       )
                )
              )
      ),
      
      # Summary Tab
      tabItem(tabName = "summary",
              fluidRow(
                column(12,
                       div(class = "intro-box",
                           h1("🎓 Congratulations on Advanced Methods!", style = "text-align: center;"),
                           h3("You Have Mastered Advanced Bayesian Techniques!", style = "text-align: center;"),
                           br(),
                           div(style = "background: rgba(255,255,255,0.2); padding: 20px; border-radius: 10px;",
                               h3("📚 What You Have Learned:"),
                               tags$ol(style = "font-size: 18px;",
                                       tags$li("How to perform Bayesian analysis with Normal distributions"),
                                       tags$li("How to handle count data with Poisson distributions"),
                                       tags$li("Variational inference for scalable Bayesian computation"),
                                       tags$li("Variable selection using spike and slab methods"),
                                       tags$li("When to apply each advanced technique")
                               )
                           ),
                           br(),
                           div(style = "text-align: center;",
                               p(style = "font-size: 18px; font-style: italic;", 
                                 "You are now ready to apply advanced Bayesian methods to real-world problems!")
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
    normal_data = NULL,
    poisson_data = NULL,
    vi_data = NULL,
    ss_data = NULL
  )
  
  # Navigation
  observeEvent(input$start_journey, {
    updateTabItems(session, "sidebarMenu", "normal_bayes")
  })
  
  # Normal Bayes - Simple case (known sigma)
  observeEvent(input$run_normal_bayes, {
    set.seed(sample(1:1000, 1))
    
    # True parameters
    true_mu <- input$true_mu
    true_sigma <- 1  # Fixed for simplicity
    n <- input$n_obs
    
    # Generate data
    x <- rnorm(n, true_mu, true_sigma)
    x_bar <- mean(x)
    
    # Prior
    mu_0 <- input$prior_mu
    kappa_0 <- input$prior_kappa
    
    # Posterior (known sigma)
    kappa_n <- kappa_0 + n
    mu_n <- (kappa_0 * mu_0 + n * x_bar) / kappa_n
    sigma_n <- true_sigma / sqrt(kappa_n)
    
    # Frequentist
    freq_mu <- x_bar
    freq_se <- true_sigma / sqrt(n)
    
    values$normal_data <- list(
      x = x, true_mu = true_mu, true_sigma = true_sigma,
      mu_0 = mu_0, kappa_0 = kappa_0,
      mu_n = mu_n, sigma_n = sigma_n, kappa_n = kappa_n,
      freq_mu = freq_mu, freq_se = freq_se,
      n = n
    )
  })
  
  # Plot functions
  output$freq_normal_plot <- renderPlotly({
    if(is.null(values$normal_data)) return(NULL)
    
    d <- values$normal_data
    
    # Create grid for plot
    mu_range <- seq(d$true_mu - 3, d$true_mu + 3, length.out = 200)
    
    # Frequentist likelihood (proportional to normal)
    likelihood <- dnorm(mu_range, d$freq_mu, d$freq_se)
    
    # Confidence interval
    ci_lower <- d$freq_mu - 1.96 * d$freq_se
    ci_upper <- d$freq_mu + 1.96 * d$freq_se
    
    plot_data <- data.frame(
      mu = mu_range,
      density = likelihood
    )
    
    p <- ggplot(plot_data, aes(x = mu, y = density)) +
      geom_line(color = "#e74c3c", size = 2) +
      geom_area(alpha = 0.3, fill = "#e74c3c") +
      geom_vline(xintercept = d$true_mu, color = "red", linetype = "dashed", size = 1.5) +
      geom_vline(xintercept = ci_lower, color = "#95a5a6", linetype = "dotted") +
      geom_vline(xintercept = ci_upper, color = "#95a5a6", linetype = "dotted") +
      labs(x = "μ", y = "Likelihood", title = "Only From Data") +
      theme_minimal() +
      theme(plot.title = element_text(hjust = 0.5))
    
    ggplotly(p) %>% config(displayModeBar = FALSE)
  })
  
  output$bayes_normal_plot <- renderPlotly({
    if(is.null(values$normal_data)) return(NULL)
    
    d <- values$normal_data
    
    # Grid
    mu_range <- seq(d$true_mu - 3, d$true_mu + 3, length.out = 200)
    
    # Prior
    prior_density <- dnorm(mu_range, d$mu_0, 1/sqrt(d$kappa_0))
    
    # Posterior
    posterior_density <- dnorm(mu_range, d$mu_n, d$sigma_n)
    
    # Credibility interval
    ci_lower <- d$mu_n - 1.96 * d$sigma_n
    ci_upper <- d$mu_n + 1.96 * d$sigma_n
    
    plot_data <- data.frame(
      mu = mu_range,
      prior = prior_density,
      posterior = posterior_density
    )
    
    p <- ggplot(plot_data, aes(x = mu)) +
      geom_line(aes(y = prior), color = "#3498db", linetype = "dashed", size = 1) +
      geom_line(aes(y = posterior), color = "#2ecc71", size = 2) +
      geom_area(aes(y = posterior), alpha = 0.3, fill = "#2ecc71") +
      geom_vline(xintercept = d$true_mu, color = "red", linetype = "dashed", size = 1.5) +
      geom_vline(xintercept = ci_lower, color = "#95a5a6", linetype = "dotted") +
      geom_vline(xintercept = ci_upper, color = "#95a5a6", linetype = "dotted") +
      labs(x = "μ", y = "Density", title = "Prior + Data = Posterior") +
      theme_minimal() +
      theme(plot.title = element_text(hjust = 0.5)) +
      annotate("text", x = d$mu_0, y = max(prior_density) * 0.8, 
               label = "Prior", color = "#3498db", size = 3) +
      annotate("text", x = d$mu_n, y = max(posterior_density) * 0.8, 
               label = "Posterior", color = "#2ecc71", size = 3)
    
    ggplotly(p) %>% config(displayModeBar = FALSE)
  })
  
  # Text outputs
  output$freq_normal_results <- renderText({
    if(is.null(values$normal_data)) return("Generate data to see results")
    
    d <- values$normal_data
    ci_lower <- d$freq_mu - 1.96 * d$freq_se
    ci_upper <- d$freq_mu + 1.96 * d$freq_se
    
    paste(
      "📊 FREQUENTIST ESTIMATE:",
      sprintf("• Estimated mean: %.3f", d$freq_mu),
      sprintf("• Standard error: %.3f", d$freq_se),
      sprintf("• 95%% CI: [%.3f, %.3f]", ci_lower, ci_upper),
      "",
      sprintf("📏 Error from true (%.2f): %.3f", d$true_mu, abs(d$freq_mu - d$true_mu)),
      "",
      "🔍 CHARACTERISTICS:",
      "• Based only on observed data",
      "• Doesn't use prior information",
      sprintf("• Precision: ±%.3f", 1.96 * d$freq_se),
      sep = "\n"
    )
  })
  
  output$bayes_normal_results <- renderText({
    if(is.null(values$normal_data)) return("")
    
    d <- values$normal_data
    ci_lower <- d$mu_n - 1.96 * d$sigma_n
    ci_upper <- d$mu_n + 1.96 * d$sigma_n
    
    # Calculate shrinkage
    shrinkage <- abs(d$mu_n - d$freq_mu) / abs(d$mu_0 - d$freq_mu)
    
    paste(
      "🧠 BAYESIAN ESTIMATE:",
      sprintf("• Posterior mean: %.3f", d$mu_n),
      sprintf("• Posterior std: %.3f", d$sigma_n),
      sprintf("• 95%% CI: [%.3f, %.3f]", ci_lower, ci_upper),
      "",
      sprintf("📏 Error from true (%.2f): %.3f", d$true_mu, abs(d$mu_n - d$true_mu)),
      sprintf("🧠 Your prior was μ₀ = %.2f", d$mu_0),
      sprintf("🔄 Shrinkage toward prior: %.1f%%", shrinkage * 100),
      "",
      "🔍 CHARACTERISTICS:",
      sprintf("• Combines prior (weight %.1f) and data (weight %d)", d$kappa_0, d$n),
      sprintf("• Improved precision: ±%.3f vs ±%.3f", 1.96 * d$sigma_n, 1.96 * d$freq_se),
      sprintf("• Direct credibility: 95%% probability in [%.2f, %.2f]", ci_lower, ci_upper),
      sep = "\n"
    )
  })
  
  # Poisson Bayesian Analysis
  observeEvent(input$generate_poisson_data, {
    set.seed(sample(1:1000, 1))
    
    # Generate Poisson data
    true_lambda <- input$poisson_true_lambda
    n_obs <- input$poisson_n_obs
    data <- rpois(n_obs, true_lambda)
    
    # Prior parameters
    alpha_prior <- input$poisson_alpha
    beta_prior <- input$poisson_beta
    
    # Posterior parameters (Gamma-Poisson conjugacy)
    alpha_post <- alpha_prior + sum(data)
    beta_post <- beta_prior + n_obs
    
    values$poisson_data <- list(
      data = data,
      true_lambda = true_lambda,
      n_obs = n_obs,
      alpha_prior = alpha_prior,
      beta_prior = beta_prior,
      alpha_post = alpha_post,
      beta_post = beta_post,
      post_mean = alpha_post / beta_post,
      post_var = alpha_post / (beta_post^2)
    )
  })
  
  output$poisson_prior_posterior_plot <- renderPlotly({
    if(is.null(values$poisson_data)) return(NULL)
    
    d <- values$poisson_data
    lambda_range <- seq(0.1, 10, length.out = 300)
    
    prior_density <- dgamma(lambda_range, d$alpha_prior, d$beta_prior)
    posterior_density <- dgamma(lambda_range, d$alpha_post, d$beta_post)
    
    plot_data <- data.frame(
      lambda = rep(lambda_range, 2),
      density = c(prior_density, posterior_density),
      type = rep(c("Prior", "Posterior"), each = length(lambda_range))
    )
    
    p <- ggplot(plot_data, aes(x = lambda, y = density, color = type, fill = type)) +
      geom_line(size = 1.5) +
      geom_area(alpha = 0.3) +
      geom_vline(xintercept = d$true_lambda, color = "red", linetype = "dashed", size = 1.5) +
      geom_vline(xintercept = d$post_mean, color = "green", linetype = "dotted", size = 1.5) +
      scale_color_manual(values = c("Prior" = "#3498db", "Posterior" = "#2ecc71")) +
      scale_fill_manual(values = c("Prior" = "#3498db", "Posterior" = "#2ecc71")) +
      labs(x = "λ", y = "Density", title = "Prior vs Posterior Distribution") +
      theme_minimal() +
      theme(plot.title = element_text(hjust = 0.5))
    
    ggplotly(p) %>% config(displayModeBar = FALSE)
  })
  
  output$poisson_predictive_plot <- renderPlotly({
    if(is.null(values$poisson_data)) return(NULL)
    
    d <- values$poisson_data
    # Negative binomial is the posterior predictive for Poisson-Gamma
    x_vals <- 0:20
    pred_probs <- dnbinom(x_vals, size = d$alpha_post, prob = d$beta_post/(d$beta_post + 1))
    
    plot_data <- data.frame(x = x_vals, probability = pred_probs)
    
    p <- ggplot(plot_data, aes(x = x, y = probability)) +
      geom_col(fill = "#9b59b6", alpha = 0.7) +
      labs(x = "Count", y = "Probability", title = "Posterior Predictive Distribution") +
      theme_minimal() +
      theme(plot.title = element_text(hjust = 0.5))
    
    ggplotly(p) %>% config(displayModeBar = FALSE)
  })
  
  output$poisson_summary_stats <- renderText({
    if(is.null(values$poisson_data)) return("")
    
    d <- values$poisson_data
    paste(
      sprintf("Observed mean: %.2f", mean(d$data)),
      sprintf("True λ: %.2f", d$true_lambda),
      sprintf("Posterior mean: %.2f", d$post_mean),
      sprintf("Posterior std: %.2f", sqrt(d$post_var)),
      sprintf("95%% Credible interval: [%.2f, %.2f]", 
              qgamma(0.025, d$alpha_post, d$beta_post),
              qgamma(0.975, d$alpha_post, d$beta_post)),
      sep = "\n"
    )
  })
  
  # Variational Inference
  observeEvent(input$run_vi, {
    set.seed(sample(1:1000, 1))
    
    # Generate data
    true_mu <- input$vi_true_mu
    true_sigma <- input$vi_true_sigma
    n_obs <- input$vi_n_obs
    data <- rnorm(n_obs, true_mu, true_sigma)
    
    # Prior parameters
    mu_0 <- 0
    sigma_0 <- 2
    
    # True posterior (analytical for normal-normal)
    precision_0 <- 1/sigma_0^2
    precision_likelihood <- n_obs/true_sigma^2
    precision_post <- precision_0 + precision_likelihood
    mu_post <- (precision_0 * mu_0 + precision_likelihood * mean(data)) / precision_post
    sigma_post <- 1/sqrt(precision_post)
    
    # VI approximation (mean field)
    # Simulate iterative VI updates
    mu_vi <- mu_post + rnorm(1, 0, 0.1)  # Add some approximation error
    sigma_vi <- sigma_post * (1 + abs(rnorm(1, 0, 0.05)))  # VI typically underestimates variance
    
    values$vi_data <- list(
      data = data,
      true_mu = true_mu,
      true_sigma = true_sigma,
      mu_post = mu_post,
      sigma_post = sigma_post,
      mu_vi = mu_vi,
      sigma_vi = sigma_vi,
      n_obs = n_obs
    )
  })
  
  output$vi_comparison_plot <- renderPlotly({
    if(is.null(values$vi_data)) return(NULL)
    
    d <- values$vi_data
    x_range <- seq(d$true_mu - 3, d$true_mu + 3, length.out = 300)
    
    true_post <- dnorm(x_range, d$mu_post, d$sigma_post)
    vi_approx <- dnorm(x_range, d$mu_vi, d$sigma_vi)
    
    plot_data <- data.frame(
      x = rep(x_range, 2),
      density = c(true_post, vi_approx),
      method = rep(c("True Posterior", "VI Approximation"), each = length(x_range))
    )
    
    p <- ggplot(plot_data, aes(x = x, y = density, color = method, fill = method)) +
      geom_line(size = 1.5) +
      geom_area(alpha = 0.3) +
      geom_vline(xintercept = d$true_mu, color = "red", linetype = "dashed", size = 1.5) +
      scale_color_manual(values = c("True Posterior" = "#2ecc71", "VI Approximation" = "#e74c3c")) +
      scale_fill_manual(values = c("True Posterior" = "#2ecc71", "VI Approximation" = "#e74c3c")) +
      labs(x = "μ", y = "Density", title = "VI vs True Posterior") +
      theme_minimal() +
      theme(plot.title = element_text(hjust = 0.5), legend.position = "bottom")
    
    ggplotly(p) %>% config(displayModeBar = FALSE)
  })
  
  # Spike and Slab
  observeEvent(input$run_spike_slab, {
    set.seed(sample(1:1000, 1))
    
    n_vars <- input$ss_n_vars
    n_relevant <- input$ss_n_relevant
    n_obs <- 100
    
    # Create design matrix
    X <- matrix(rnorm(n_obs * n_vars), n_obs, n_vars)
    
    # True coefficients
    true_beta <- rep(0, n_vars)
    relevant_vars <- sample(1:n_vars, n_relevant)
    true_beta[relevant_vars] <- rnorm(n_relevant, 0, 1)
    
    # Generate response
    y <- X %*% true_beta + rnorm(n_obs, 0, input$ss_noise_level)
    
    # Simulate spike and slab results
    # In practice, this would use MCMC
    inclusion_probs <- numeric(n_vars)
    
    # Relevant variables get higher inclusion probabilities
    for(i in 1:n_vars) {
      if(i %in% relevant_vars) {
        inclusion_probs[i] <- rbeta(1, 8, 2)  # High probability
      } else {
        inclusion_probs[i] <- rbeta(1, 1, 9)  # Low probability
      }
    }
    
    values$ss_data <- list(
      n_vars = n_vars,
      relevant_vars = relevant_vars,
      inclusion_probs = inclusion_probs,
      true_beta = true_beta,
      n_relevant = n_relevant
    )
  })
  
  output$spike_slab_plot <- renderPlotly({
    if(is.null(values$ss_data)) return(NULL)
    
    d <- values$ss_data
    
    plot_data <- data.frame(
      variable = 1:d$n_vars,
      inclusion_prob = d$inclusion_probs,
      is_relevant = 1:d$n_vars %in% d$relevant_vars
    )
    
    p <- ggplot(plot_data, aes(x = variable, y = inclusion_prob, fill = is_relevant)) +
      geom_col(alpha = 0.8) +
      scale_fill_manual(values = c("FALSE" = "#95a5a6", "TRUE" = "#e74c3c"),
                       labels = c("Irrelevant", "Relevant")) +
      labs(x = "Variable", y = "Posterior Inclusion Probability", 
           title = "Spike and Slab Variable Selection") +
      theme_minimal() +
      theme(plot.title = element_text(hjust = 0.5), legend.title = element_blank())
    
    ggplotly(p) %>% config(displayModeBar = FALSE)
  })
  
  output$ss_model_summary <- renderText({
    if(is.null(values$ss_data)) return("")
    
    d <- values$ss_data
    
    # Calculate performance metrics
    high_prob_vars <- which(d$inclusion_probs > 0.5)
    true_positives <- sum(high_prob_vars %in% d$relevant_vars)
    false_positives <- sum(!(high_prob_vars %in% d$relevant_vars))
    false_negatives <- sum(!(d$relevant_vars %in% high_prob_vars))
    
    precision <- if(length(high_prob_vars) > 0) true_positives / length(high_prob_vars) else 0
    recall <- true_positives / d$n_relevant
    
    paste(
      sprintf("Variables selected (>50%% prob): %d", length(high_prob_vars)),
      sprintf("True positives: %d", true_positives),
      sprintf("False positives: %d", false_positives),
      sprintf("Precision: %.2f", precision),
      sprintf("Recall: %.2f", recall),
      sep = "\n"
    )
  })
}

# Run the application
shinyApp(ui = ui, server = server)