library(shiny)
library(shinydashboard)
library(plotly)
library(ggplot2)
library(dplyr)
library(igraph)
library(visNetwork)
library(shinyjs)
library(DT)

# Define UI
ui <- dashboardPage(
  skin = "blue",
  dashboardHeader(title = "🧠 BayesQuest Part 1: Foundations & Applications"),
  
  dashboardSidebar(
    sidebarMenu(
      id = "sidebarMenu",
      menuItem("🏠 Introduction", tabName = "intro", icon = icon("home"), selected = TRUE),
      menuItem("🎯 What is Bayesian Statistics?", tabName = "what_is_bayes", icon = icon("question-circle")),
      menuItem("📊 Bayes' Theorem", tabName = "foundations", icon = icon("brain")),
      menuItem("🪙 Practical Example: Coin", tabName = "coin_example", icon = icon("coins")),
      menuItem("📈 Bayesian Regression", tabName = "regression", icon = icon("chart-line")),
      menuItem("🧬 Genetic Networks", tabName = "networks", icon = icon("dna")),
      menuItem("🎓 Summary & Quiz", tabName = "summary", icon = icon("graduation-cap"))
    )
  ),
  
  dashboardBody(
    useShinyjs(),
    tags$head(
      tags$style(HTML('
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
        
        .explanation-box {
          background: #e0f2fe;
          border-left: 5px solid #0288d1;
          padding: 15px;
          margin: 15px 0;
          border-radius: 5px;
        }
        
        .step-box {
          background: #f3e5f5;
          border: 2px solid #9c27b0;
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
                           h1("🧠 Welcome to BayesQuest!", style = "text-align: center;"),
                           h3("Start your mission to discover Bayesian Statistics", style = "text-align: center;"),
                           br(),
                           
                           div(style = "background: rgba(255,255,255,0.2); padding: 20px; border-radius: 10px;",
                               h3("🎯 What You'll Learn:"),
                               tags$ol(style = "font-size: 18px;",
                                       tags$li("What is Bayesian statistics and why it's important"),
                                       tags$li("How Bayes' theorem works"),
                                       tags$li("Differences between Frequentist and Bayesian approaches"),
                                       tags$li("Applications to regression"),
                                       tags$li("Applications to genetic networks"),
                                       tags$li("When to use each method")
                               ),
                               
                               br(),
                               div(class = "highlight-box",
                                   h4("📚 Prerequisites: NONE!"),
                                   p("This app is designed for TRUE beginners")
                               )
                           ),
                           
                           br(),
                           div(style = "text-align: center;",
                               actionButton("start_journey", "🚀 Start the Journey", 
                                            style = "font-size: 20px; padding: 15px 40px; background: white; color: #667eea;")
                           )
                       )
                ),
                
                column(12,
                       div(class = "theory-box",
                           h3("📊 Two Ways of Thinking About Probability"),
                           fluidRow(
                             column(6,
                                    div(class = "comparison-card",
                                        h4("🏛️ Traditional Approach (Frequentist)", style = "color: #e74c3c;"),
                                        h5("🤔 The question:"),
                                        p("'If I repeated this experiment 1000 times, what would happen on average?'"),
                                        h5("📊 Example:"),
                                        p("A coin has a 0.5 probability of heads because in 1000 flips, about 500 will be heads."),
                                        h5("⚖️ Characteristics:"),
                                        tags$ul(
                                          tags$li("Fixed parameters, random data"),
                                          tags$li("Based on long-term frequencies"),
                                          tags$li("Doesn't use prior knowledge")
                                        )
                                    )
                             ),
                             column(6,
                                    div(class = "comparison-card",
                                        h4("🧠 Bayesian Approach", style = "color: #2ecc71;"),
                                        h5("🤔 The question:"),
                                        p("'Given what I've observed and what I already knew, how confident am I that this is true?'"),
                                        h5("📊 Example:"),
                                        p("I think this coin is fair, but after 10 flips all heads, now I'm less sure..."),
                                        h5("⚖️ Characteristics:"),
                                        tags$ul(
                                          tags$li("Uncertain parameters, fixed data"),
                                          tags$li("Based on degrees of belief"),
                                          tags$li("Incorporates prior knowledge"),
                                          tags$li("Updates with new data")
                                        )
                                    )
                             )
                           )
                       )
                )
              )
      ),
      
      # What is Bayes Tab
      tabItem(tabName = "what_is_bayes",
              fluidRow(
                column(12,
                       h2("🎯 What is Bayesian Statistics?"),
                       
                       div(class = "explanation-box",
                           h3("🌟 The Main Idea"),
                           p(style = "font-size: 18px;", 
                             "Bayesian statistics is a way of reasoning that reflects how we naturally think in real life. 
                             When we need to make a decision, we don't start from scratch: we use our knowledge and update our opinions when we receive new information.")
                       ),
                       
                       div(class = "theory-box",
                           h3("🏠 Everyday Life Example:"),
                           
                           div(class = "step-box",
                               h4("📱 Situation:"),
                               p("You call Emma at 3:00 PM on Friday. The phone rings but she doesn't answer. 
                                 Is she home or not?")
                           ),
                           
                           fluidRow(
                             column(4,
                                    div(class = "highlight-box",
                                        h5("🧠 Prior (Previous Knowledge)"),
                                        p("I know that Emma usually has a lab meeting on Fridays from 2:30 to 3:30 PM at the research center."),
                                        p(strong("Initial probability she's home: 30%"))
                                    )
                             ),
                             column(4,
                                    div(class = "highlight-box",
                                        h5("📊 Evidence (New Data)"),
                                        p("The phone rings but she doesn't answer."),
                                        p("This can happen whether she's home or at the research center.")
                                    )
                             ),
                             column(4,
                                    div(class = "highlight-box",
                                        h5("🎯 Posterior (Updated Conclusion)"),
                                        p("Considering everything, she's probably at the lab meeting."),
                                        p(strong("Updated probability she's home: 15%"))
                                    )
                             )
                           ),
                           
                           div(class = "warning-box",
                               h5("🔄 What if you call again at 7:00 PM and she doesn't answer?"),
                               p("Now your prior knowledge changes: in the evening Emma is often home. 
                                 The same evidence (doesn't answer) now leads you to a different conclusion: 
                                 she's probably home but having dinner!")
                           )
                       )
                )
              ),
              
              fluidRow(
                column(12,
                       div(class = "theory-box",
                           h3("🏥 Medical Example: Disease Diagnosis"),
                           
                           div(class = "explanation-box",
                               h4("📋 Scenario:"),
                               p("A test for a rare disease is 95% accurate (correctly detects the disease in 95% of cases). 
                                 If your test is positive, what's the probability you actually have the disease?"),
                               br(),
                               div(style = "text-align: center; font-size: 24px; color: #e74c3c;",
                                   "The answer is NOT 95%! 🤯"
                               )
                           ),
                           
                           fluidRow(
                             column(6,
                                    div(class = "freq-box",
                                        h4("🏛️ Frequentist Thinking"),
                                        p("'The test is 95% accurate, so if it's positive, 
                                          I have a 95% probability of having the disease.'"),
                                        p(strong("❌ WRONG!"), style = "color: red;"),
                                        p("This reasoning ignores how rare the disease is.")
                                    )
                             ),
                             column(6,
                                    div(class = "bayes-box",
                                        h4("🧠 Bayesian Thinking"),
                                        p("'I need to consider: how rare is the disease? 
                                          If it affects only 1 person in 1000, even with a positive test, 
                                          it's more likely to be a false positive.'"),
                                        p(strong("✅ CORRECT!"), style = "color: green;"),
                                        p("If the disease affects 1 in 1000, the real probability 
                                          with a positive test is only about 2%!")
                                    )
                             )
                           ),
                           
                           div(class = "highlight-box",
                               h5("🧮 The Calculation (simplified):"),
                               tags$ul(
                                 tags$li("Out of 10,000 people, 10 have the disease (1 in 1000)"),
                                 tags$li("The test correctly detects 9-10 of these"),
                                 tags$li("But also gives ~500 false positives from 9,990 healthy people"),
                                 tags$li("So: ~10 true positives out of ~510 positive tests = ~2%")
                               )
                           )
                       )
                )
              ),
              
              fluidRow(
                column(12,
                       div(class = "theory-box",
                           h3("🔍 Why is Bayesian Statistics Useful?"),
                           
                           fluidRow(
                             column(6,
                                    div(class = "comparison-card",
                                        h4("💡 Practical Advantages"),
                                        tags$ul(
                                          tags$li("Incorporates existing knowledge"),
                                          tags$li("Works well with little data"),
                                          tags$li("Provides complete uncertainty"),
                                          tags$li("Updates naturally"),
                                          tags$li("More intuitive for decision making")
                                        )
                                    )
                             ),
                             column(6,
                                    div(class = "comparison-card",
                                        h4("🎯 Real Applications"),
                                        tags$ul(
                                          tags$li("Medicine: diagnosis and treatments"),
                                          tags$li("Finance: risk assessment"),
                                          tags$li("Artificial Intelligence"),
                                          tags$li("Scientific research"),
                                          tags$li("Industrial quality control")
                                        )
                                    )
                             )
                           )
                       )
                )
              )
      ),
      
      # Foundations Tab - Bayes' Theorem
      tabItem(tabName = "foundations",
              fluidRow(
                column(12,
                       h2("📊 Mathematical Foundations"),
                       
                       div(class = "theory-box",
                           h3("🔑 Bayes' Theorem"),
                           
                           div(class = "explanation-box",
                               h4("🤔 What does this formula do?"),
                               p("Bayes' theorem tells us how to update our beliefs when we receive new information. 
                                 It's like having a calculator for uncertainty!")
                           ),
                           
                           div(class = "formula-box",
                               h4("📐 The Formula:"),
                               "P(Hypothesis|Evidence) = P(Evidence|Hypothesis) × P(Hypothesis) / P(Evidence)",
                               br(),
                               h4("🗣️ In simple words:"),
                               "Updated Belief = (How likely what I observed × Initial Belief) / How likely what I observed in general"
                           ),
                           
                           fluidRow(
                             column(3,
                                    div(class = "step-box",
                                        h5("🎯 Prior P(Hypothesis)"),
                                        p(strong("WHAT IT IS:")),
                                        p("Your belief BEFORE seeing the data"),
                                        p(strong("EXAMPLE:")),
                                        p("'I think this coin is fair' = 50% heads")
                                    )
                             ),
                             column(3,
                                    div(class = "step-box",
                                        h5("📊 Likelihood P(Evidence|Hypothesis)"),
                                        p(strong("WHAT IT IS:")),
                                        p("How likely it is to see this data IF your hypothesis is true"),
                                        p(strong("EXAMPLE:")),
                                        p("If the coin is fair, how likely is it to see 8 heads in 10 flips?")
                                    )
                             ),
                             column(3,
                                    div(class = "step-box",
                                        h5("🔍 Evidence P(Evidence)"),
                                        p(strong("WHAT IT IS:")),
                                        p("How likely it is to see this data in general"),
                                        p(strong("EXAMPLE:")),
                                        p("Probability of seeing 8 heads in 10 flips, considering ALL possible coins")
                                    )
                             ),
                             column(3,
                                    div(class = "step-box",
                                        h5("🎉 Posterior P(Hypothesis|Evidence)"),
                                        p(strong("WHAT IT IS:")),
                                        p("Your belief AFTER seeing the data"),
                                        p(strong("EXAMPLE:")),
                                        p("'After seeing 8 heads in 10, I now think the probability of heads is 65%'")
                                    )
                             )
                           )
                       )
                )
              ),
              
              fluidRow(
                column(12,
                       div(class = "theory-box",
                           h3("🧮 The Biased Coin Problem"),
                           
                           div(class = "explanation-box",
                               h4("📝 The Problem:"),
                               p("You have two coins: one normal (50% heads) and one biased (80% heads). 
                                 You choose one randomly and flip it 5 times, getting: HEAD, HEAD, TAIL, HEAD, HEAD. 
                                 What's the probability you chose the biased coin?")
                           ),
                           
                           h4("🔢 Step 1: Prior (Initial Belief)"),
                           div(class = "highlight-box",
                               p("Given that you chose randomly:"),
                               tags$ul(
                                 tags$li("P(Normal Coin) = 0.5"),
                                 tags$li("P(Biased Coin) = 0.5")
                               )
                           ),
                           
                           h4("🔢 Step 2: Likelihood (Data Probability)"),
                           div(class = "highlight-box",
                               p("Sequence observed: HHTTH (4 heads out of 5 flips)"),
                               p(strong("If normal coin (p=0.5):")),
                               p("P(HHTTH | Normal) = 0.5^5 = 0.03125"),
                               br(),
                               p(strong("If biased coin (p=0.8):")),
                               p("P(HHTTH | Biased) = 0.8^4 × 0.2^1 = 0.08192")
                           ),
                           
                           h4("🔢 Step 3: Evidence (Normalization)"),
                           div(class = "highlight-box",
                               p("P(HHTTH) = P(HHTTH|Normal) × P(Normal) + P(HHTTH|Biased) × P(Biased)"),
                               p("P(HHTTH) = 0.03125 × 0.5 + 0.08192 × 0.5 = 0.056585")
                           ),
                           
                           h4("🔢 Step 4: Posterior (Final Result)"),
                           div(class = "bayes-box",
                               p(strong("P(Biased | HHTTH) = (0.08192 × 0.5) / 0.056585 = 72.4%")),
                               br(),
                               p("🎯 INTERPRETATION: After seeing 4 heads out of 5 flips, 
                                 there's a 72.4% probability you chose the biased coin!")
                           )
                       )
                )
              ),
              
              fluidRow(
                column(12,
                       div(class = "theory-box",
                           h3("🧠 Key Insights from Bayes' Theorem"),
                           
                           fluidRow(
                             column(6,
                                    div(class = "warning-box",
                                        h4("⚠️ Common Errors to Avoid"),
                                        tags$ul(
                                          tags$li("Confusing P(A|B) with P(B|A)"),
                                          tags$li("Ignoring the prior"),
                                          tags$li("Not considering the rarity of the event"),
                                          tags$li("Thinking that '95% accurate' = '95% probability'")
                                        )
                                    )
                             ),
                             column(6,
                                    div(class = "highlight-box",
                                        h4("💡 Key Points to Remember"),
                                        tags$ul(
                                          tags$li("The prior always influences the result"),
                                          tags$li("More data = less influence of the prior"),
                                          tags$li("Rare events remain rare even with positive evidence"),
                                          tags$li("Updating is continuous and natural")
                                        )
                                    )
                             )
                           )
                       )
                )
              )
      ),
      
      # Coin Example Tab
      tabItem(tabName = "coin_example",
              fluidRow(
                column(12,
                       h2("🪙 Interactive Example: Coin Flipping"),
                       
                       div(class = "explanation-box",
                           h3("🎯 Goal of This Experiment"),
                           p("We will simulate coin flipping and compare how the frequentist 
                             and Bayesian approaches analyze the data. You'll see how the two methodologies converge 
                             or diverge based on your priors and observed data.")
                       )
                )
              ),
              
              # Interactive Coin Example
              fluidRow(
                column(4,
                       div(class = "theory-box",
                           h3("🎛️ Control Panel"),
                           
                           div(class = "step-box",
                               h4("🪙 Coin Properties"),
                               sliderInput("coin_flips", "Number of flips:", 
                                           min = 10, max = 500, value = 50, step = 10),
                               sliderInput("true_prob", "True probability of heads:", 
                                           min = 0.3, max = 0.7, value = 0.5, step = 0.05),
                               div(class = "explanation-box",
                                   p(em("This is the true probability of the coin (which we don't know in reality!)")))
                           ),
                           
                           div(class = "step-box",
                               h4("🧠 Your Bayesian Priors"),
                               sliderInput("prior_belief", "Your initial belief (prob. of heads):", 
                                           min = 0.3, max = 0.7, value = 0.5, step = 0.05),
                               sliderInput("prior_strength", "How certain are you? (equivalent flips):", 
                                           min = 1, max = 50, value = 10, step = 1),
                               div(class = "explanation-box",
                                   p(em("'Equivalent flips' = how much evidence your initial belief equals")))
                           ),
                           
                           br(),
                           actionButton("flip_coin", "🪙 Flip the Coin!", class = "btn-primary btn-lg"),
                           
                           br(), br(),
                           div(class = "highlight-box",
                               h5("💡 Try These Scenarios:"),
                               p("1. Wrong prior (believe 0.3, truth = 0.7)"),
                               p("2. Correct prior"),
                               p("3. Very certain vs uncertain prior"),
                               p("4. Little data vs lots of data")
                           )
                       )
                ),
                
                column(8,
                       div(class = "theory-box",
                           h3("📊 Experiment Results"),
                           plotlyOutput("coin_comparison", height = "400px"),
                           
                           div(class = "explanation-box",
                               h4("📖 How to Read the Graph:"),
                               tags$ul(
                                 tags$li(strong("Red Line:"), " Frequentist estimate"),
                                 tags$li(strong("Green Line:"), " Bayesian estimate"),
                                 tags$li(strong("Green Area:"), " Bayesian credible interval"),
                                 tags$li(strong("Dashed Line:"), " True value (unknown in reality)")
                               )
                           )
                       )
                )
              ),
              
              fluidRow(
                column(6,
                       div(class = "freq-box",
                           h4("🏛️ Frequentist Analysis"),
                           verbatimTextOutput("freq_results"),
                           
                           div(class = "explanation-box",
                               h5("🔍 What This Means:"),
                               tags$ul(
                                 tags$li(strong("Point estimate:"), " Our 'best guess'"),
                                 tags$li(strong("Confidence interval:"), " If you repeated the experiment 100 times, 95 intervals would contain the true value"),
                                 tags$li(strong("No prior:"), " Every experiment starts from scratch")
                               )
                           )
                       )
                ),
                column(6,
                       div(class = "bayes-box",
                           h4("🧠 Bayesian Analysis"),
                           verbatimTextOutput("bayes_results"),
                           
                           div(class = "explanation-box",
                               h5("🔍 What This Means:"),
                               tags$ul(
                                 tags$li(strong("Posterior mean:"), " Our updated 'best guess'"),
                                 tags$li(strong("Credible interval:"), " There's a 95% probability that the true value is in this interval"),
                                 tags$li(strong("Prior incorporated:"), " We use previous knowledge")
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
                       h2("📈 Bayesian Regression: From Theory to Practice"),
                       
                       div(class = "explanation-box",
                           h3("🎯 What is Regression? (Beginner's Explanation)"),
                           p("Regression is like drawing the 'best line' through points on a graph. 
                             Imagine you have data on people's height and weight: regression helps us predict 
                             a person's weight given their height, by finding the relationship between the two variables."),
                           br(),
                           p(strong("🤔 But which line is 'best'? And how sure are we?"), 
                             " This is where the differences between frequentist and Bayesian approaches come in!")
                       )
                )
              ),
              
              fluidRow(
                column(12,
                       div(class = "theory-box",
                           h3("📐 The Mathematical Model (Explained Simply)"),
                           
                           div(class = "formula-box",
                               h4("🏠 The Basic Relationship:"),
                               "y = β₀ + β₁x + ε",
                               br(),
                               h4("🗣️ In simple words:"),
                               "y value = Intercept + Slope × x value + Random error"
                           ),
                           
                           fluidRow(
                             column(3,
                                    div(class = "step-box",
                                        h5("📊 y (Dependent Variable)"),
                                        p("What we want to predict"),
                                        p(strong("Example:"), " Person's weight")
                                    )
                             ),
                             column(3,
                                    div(class = "step-box",
                                        h5("📏 x (Independent Variable)"),
                                        p("What we use to predict"),
                                        p(strong("Example:"), " Person's height")
                                    )
                             ),
                             column(3,
                                    div(class = "step-box",
                                        h5("🎯 β₀ (Intercept)"),
                                        p("Value of y when x = 0"),
                                        p(strong("Example:"), " Theoretical weight of person with 0 cm height")
                                    )
                             ),
                             column(3,
                                    div(class = "step-box",
                                        h5("📈 β₁ (Slope)"),
                                        p("How much y changes for each unit of x"),
                                        p(strong("Example:"), " How many kg more for each cm of height")
                                    )
                             )
                           )
                       )
                )
              ),
              
              fluidRow(
                column(12,
                       div(class = "theory-box",
                           h3("⚔️ Frequentist vs Bayesian: The Comparison"),
                           
                           fluidRow(
                             column(6,
                                    div(class = "freq-box",
                                        h4("🏛️ Frequentist Approach"),
                                        h5("🎯 Objective:"),
                                        p("Find β values that minimize squared error"),
                                        
                                        div(class = "formula-box",
                                            "β̂ = (X'X)⁻¹X'y"
                                        ),
                                        
                                        h5("📊 Provides:"),
                                        tags$ul(
                                          tags$li("Point estimate of β"),
                                          tags$li("Confidence intervals"),
                                          tags$li("Significance tests"),
                                          tags$li("R² for goodness of fit")
                                        ),
                                        
                                        h5("🤔 Interprets:"),
                                        p("'If I repeated this study 100 times, 95% of confidence intervals would contain the true value of β'")
                                    )
                             ),
                             column(6,
                                    div(class = "bayes-box",
                                        h4("🧠 Bayesian Approach"),
                                        h5("🎯 Objective:"),
                                        p("Combine prior + data to get posterior distribution of β"),
                                        
                                        div(class = "formula-box",
                                            "p(β|y) ∝ p(y|β)p(β)"
                                        ),
                                        
                                        h5("📊 Provides:"),
                                        tags$ul(
                                          tags$li("Complete distribution of β"),
                                          tags$li("Credible intervals"),
                                          tags$li("Posterior probabilities"),
                                          tags$li("Predictions with uncertainty")
                                        ),
                                        
                                        h5("🤔 Interprets:"),
                                        p("'There's a 95% probability that β is in this interval, given the observed data'")
                                    )
                             )
                           )
                       )
                )
              ),
              
              # Interactive Regression
              fluidRow(
                column(3,
                       div(class = "theory-box",
                           h3("🎮 Simple Controls"),
                           
                           div(class = "step-box",
                               h4("📊 Data"),
                               sliderInput("n_points", "How many points:", 
                                           min = 10, max = 100, value = 30, step = 10),
                               sliderInput("noise_level", "How much noise:", 
                                           min = 0.5, max = 2, value = 1, step = 0.5),
                               div(class = "explanation-box",
                                   p(em("More noise = more scattered points")))
                           ),
                           
                           div(class = "step-box",
                               h4("🧠 Your Prior"),
                               p("You think the slope is about:"),
                               sliderInput("prior_slope_mean", "", 
                                           min = 0.5, max = 3.5, value = 1, step = 0.5),
                               p("How sure are you?"),
                               radioButtons("prior_confidence", "",
                                            choices = list("Not very sure" = "weak",
                                                           "Somewhat sure" = "medium", 
                                                           "Very sure" = "strong"),
                                            selected = "medium"),
                               div(class = "explanation-box",
                                   p(em("The true slope is always 2.0!")))
                           ),
                           
                           br(),
                           actionButton("run_regression", "🔄 New Regression", class = "btn-success btn-lg"),
                           
                           br(), br(),
                           div(class = "highlight-box",
                               h5("💡 Try These Scenarios:"),
                               p("🎯 Correct prior (2.0) vs wrong (1.0)"),
                               p("📊 Little data (10) vs lots (100)"),
                               p("🔒 Confident vs uncertain prior"),
                               p("📈 Little noise vs lots of noise")
                           )
                       )
                ),
                
                column(9,
                       div(class = "theory-box",
                           h3("📊 Direct Comparison: Frequentist vs Bayesian"),
                           
                           fluidRow(
                             column(6,
                                    h4("🏛️ Frequentist Approach", style = "color: #e74c3c; text-align: center;"),
                                    plotlyOutput("freq_regression_plot", height = "350px")
                             ),
                             column(6,
                                    h4("🧠 Bayesian Approach", style = "color: #2ecc71; text-align: center;"),
                                    plotlyOutput("bayes_regression_plot", height = "350px")
                             )
                           ),
                           
                           br(),
                           
                           div(class = "explanation-box",
                               h4("🔍 What to Observe:"),
                               fluidRow(
                                 column(6,
                                        div(style = "border-left: 5px solid #e74c3c; padding-left: 15px;",
                                            h5("In the Frequentist Plot:"),
                                            tags$ul(
                                              tags$li("One single 'best' line"),
                                              tags$li("Always the same, regardless of priors"),
                                              tags$li("No visualization of uncertainty")
                                            )
                                        )
                                 ),
                                 column(6,
                                        div(style = "border-left: 5px solid #2ecc71; padding-left: 15px;",
                                            h5("In the Bayesian Plot:"),
                                            tags$ul(
                                              tags$li("Main line + uncertainty band"),
                                              tags$li("Influenced by your initial prior"),
                                              tags$li("Shows how sure we are about predictions")
                                            )
                                        )
                                 )
                               )
                           )
                       )
                )
              ),
              
              fluidRow(
                column(6,
                       div(class = "freq-box",
                           h4("🏛️ Frequentist Analysis"),
                           verbatimTextOutput("freq_reg_results"),
                           
                           div(class = "explanation-box",
                               h5("✅ Strengths:"),
                               tags$ul(
                                 tags$li("Objective - same answer always"),
                                 tags$li("Not influenced by prior opinions"),
                                 tags$li("Standard in publications")
                               ),
                               h5("⚠️ Limitations:"),
                               tags$ul(
                                 tags$li("Doesn't show uncertainty in predictions"),
                                 tags$li("Doesn't use prior knowledge")
                               )
                           )
                       )
                ),
                column(6,
                       div(class = "bayes-box",
                           h4("🧠 Bayesian Analysis"),
                           verbatimTextOutput("bayes_reg_results"),
                           
                           div(class = "explanation-box",
                               h5("✅ Strengths:"),
                               tags$ul(
                                 tags$li("Shows complete uncertainty"),
                                 tags$li("Uses prior knowledge"),
                                 tags$li("Better with little data")
                               ),
                               h5("⚠️ Limitations:"),
                               tags$ul(
                                 tags$li("Depends on prior choice"),
                                 tags$li("More complex to compute")
                               )
                           )
                       )
                )
              )
      ),
      
      # Networks Tab
      tabItem(tabName = "networks",
              fluidRow(
                column(12,
                       h2("🧬 Bayesian Genetic Networks"),
                       
                       div(class = "explanation-box",
                           h3("🔬 What Are Genetic Networks?"),
                           p("Imagine genes as people in a company. Some genes are 'bosses' that give orders 
                             to other 'employee' genes. A genetic network is the map of these hierarchical relationships."),
                           br(),
                           p("🎯 ", strong("Our goal:"), " Discover these relationships by only observing 
                             how active each gene is in different patients/conditions.")
                       )
                )
              ),
              
              fluidRow(
                column(12,
                       div(class = "theory-box",
                           h3("📊 The Problem: Two Ways to Discover Connections"),
                           
                           fluidRow(
                             column(6,
                                    div(class = "freq-box",
                                        h4("🏛️ Traditional Method: Correlation"),
                                        h5("🤔 Logic:"),
                                        p("'If two genes vary together, they must be connected'"),
                                        
                                        h5("📊 Procedure:"),
                                        tags$ol(
                                          tags$li("Calculate correlation between every pair"),
                                          tags$li("If correlation > threshold (e.g. 0.3) → connected"),
                                          tags$li("Otherwise → not connected")
                                        ),
                                        
                                        h5("⚠️ Problems:"),
                                        tags$ul(
                                          tags$li("Arbitrary threshold - why 0.3 and not 0.25?"),
                                          tags$li("Many false positives - genes seem connected by chance"),
                                          tags$li("Binary decisions - yes/no without nuance"),
                                          tags$li("Doesn't consider that biological networks are sparse")
                                        )
                                    )
                             ),
                             column(6,
                                    div(class = "bayes-box",
                                        h4("🧠 Bayesian Method: Smart Probability"),
                                        h5("🤔 Logic:"),
                                        p("'How PROBABLE is it that two genes are connected, considering that biological networks are usually sparse?'"),
                                        
                                        h5("📊 Procedure:"),
                                        tags$ol(
                                          tags$li("Define prior: 'Networks are sparse, few connections'"),
                                          tags$li("Observe correlation: 'How correlated are they?'"),
                                          tags$li("Calculate probability: Bayes combines prior + observation"),
                                          tags$li("Decide: If probability > 50% → probably connected")
                                        ),
                                        
                                        h5("✅ Advantages:"),
                                        tags$ul(
                                          tags$li("No arbitrary threshold - everything is probabilistic"),
                                          tags$li("Fewer false positives - considers biological sparsity"),  
                                          tags$li("Quantified uncertainty - 'sure at 85%'"),
                                          tags$li("Incorporates biological knowledge naturally")
                                        )
                                    )
                             )
                           )
                       )
                )
              ),
              
              # Interactive Network
              fluidRow(
                column(3,
                       div(class = "theory-box",
                           h3("🎮 Virtual Lab"),
                           
                           div(class = "step-box",
                               h4("🧬 Your Genetic Network"),
                               sliderInput("n_genes", "How many genes to study:", 
                                           min = 5, max = 12, value = 8, step = 1),
                               sliderInput("n_samples", "How many patients/experiments:", 
                                           min = 50, max = 200, value = 100, step = 25),
                               div(class = "explanation-box",
                                   p(em("More patients = more reliability, but costs more!")))
                           ),
                           
                           div(class = "step-box",
                               h4("🔬 Experimental Conditions"),
                               sliderInput("edge_density", "How connected is the true network:", 
                                           min = 0.05, max = 0.25, value = 0.10, step = 0.05),
                               sliderInput("measurement_noise", "Experimental noise:", 
                                           min = 0.1, max = 0.8, value = 0.3, step = 0.1),
                               div(class = "explanation-box",
                                   p(em("In reality: sparse networks (~10%) + high noise")))
                           ),
                           
                           div(class = "step-box",
                               h4("🧠 Bayesian Settings"),
                               sliderInput("edge_prior", "Prior: probability of connection:", 
                                           min = 0.01, max = 0.20, value = 0.08, step = 0.01),
                               div(class = "explanation-box",
                                   p(em("Biological knowledge: 'Networks are usually sparse'")))
                           ),
                           
                           br(),
                           actionButton("generate_network", "🔬 Analyze Network!", class = "btn-warning btn-lg"),
                           
                           br(), br(),
                           div(class = "highlight-box",
                               h5("🧪 Experiments to Try:"),
                               p("🎯 Correct vs wrong prior"),
                               p("📊 Few vs many patients"),
                               p("🔊 Little vs lots of noise"),
                               p("📡 Dense vs sparse network")
                           )
                       )
                ),
                
                column(9,
                       div(class = "theory-box",
                           h3("🌐 Analysis Results"),
                           
                           fluidRow(
                             column(6,
                                    h4("🏛️ Correlation Method", style = "color: #e74c3c; text-align: center;"),
                                    plotlyOutput("correlation_network_plot", height = "300px")
                             ),
                             column(6,
                                    h4("🧠 Bayesian Method", style = "color: #2ecc71; text-align: center;"),
                                    plotlyOutput("bayesian_network_plot", height = "300px")
                             )
                           ),
                           
                           br(),
                           
                           div(class = "theory-box",
                               h4("📊 Performance Comparison"),
                               verbatimTextOutput("network_stats"),
                               
                               br(),
                               
                               div(class = "explanation-box",
                                   h4("📈 Quality Metrics:"),
                                   tags$ul(
                                     tags$li(strong("Precision:"), " % of predicted connections that are true"),
                                     tags$li(strong("Sensitivity:"), " % of true connections that were found"),
                                     tags$li(strong("Specificity:"), " % of non-connections correctly identified"),
                                     tags$li(strong("F1-score:"), " Balance between precision/recall")
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
                           h1("🎓 Congratulations, Bayesian Master!", style = "text-align: center;"),
                           h3("You Have Completed Your Journey in Bayesian Inference!", style = "text-align: center;"),
                           br(),
                           
                           div(style = "background: rgba(255,255,255,0.2); padding: 20px; border-radius: 10px;",
                               h3("📚 What You Have Learned:"),
                               tags$ol(style = "font-size: 18px;",
                                       tags$li("The fundamental difference between frequentist and Bayesian thinking"),
                                       tags$li("How Bayes' theorem updates beliefs with new evidence"),
                                       tags$li("The importance of priors and how to choose them"),
                                       tags$li("Bayesian regression and when to prefer it to classical methods"),
                                       tags$li("Applications to genetic networks and bioinformatics"),
                                       tags$li("Advantages and disadvantages of each approach")
                               )
                           )
                       )
                ),
                
                column(12,
                       div(class = "theory-box",
                           h3("🧠 Test Your Understanding"),
                           
                           div(class = "step-box",
                               h4("Question 1: When is Bayesian regression most advantageous?"),
                               radioButtons("q1", "", 
                                            choices = list(
                                              "When you have thousands of data points and no prior knowledge" = "a",
                                              "When you have little data but good prior knowledge" = "b",
                                              "When you want the fastest possible computation" = "c",
                                              "When uncertainty is not important" = "d"
                                            )),
                               
                               div(class = "explanation-box",
                                   p(em("Think about what we've seen in the interactive examples..."))
                               )
                           ),
                           
                           div(class = "step-box",
                               h4("Question 2: What makes Bayesian methods ideal for genetic networks?"),
                               radioButtons("q2", "", 
                                            choices = list(
                                              "They are always faster to compute" = "a",
                                              "They don't need any data" = "b",
                                              "They naturally handle sparsity and uncertainty" = "c",
                                              "They always give exact answers" = "d"
                                            )),
                               
                               div(class = "explanation-box",
                                   p(em("Remember the differences between correlation and Bayesian approach..."))
                               )
                           ),
                           
                           div(class = "step-box",
                               h4("Question 3: What is the main risk of the Bayesian approach?"),
                               radioButtons("q3", "", 
                                            choices = list(
                                              "It's too slow computationally" = "a",
                                              "A poorly chosen prior can influence results" = "b",
                                              "It can't handle numerical data" = "c",
                                              "It doesn't provide uncertainty" = "d"
                                            )),
                               
                               div(class = "explanation-box",
                                   p(em("Think about the experiments with wrong priors that you tried..."))
                               )
                           ),
                           
                           br(),
                           actionButton("check_answers", "🎯 Check Answers", class = "btn-primary btn-lg"),
                           
                           br(), br(),
                           verbatimTextOutput("quiz_results")
                       )
                ),
                
                column(12,
                       div(class = "theory-box",
                           h3("🚀 Your Next Steps in the Bayesian World"),
                           
                           fluidRow(
                             column(6,
                                    div(class = "highlight-box",
                                        h4("📚 Resources to Deepen Your Knowledge"),
                                        tags$ul(
                                          tags$li(strong("Books:"), " 'Bayesian Data Analysis' by Gelman"),
                                          tags$li(strong("Online:"), " Bayesian Statistics course on Coursera"),
                                          tags$li(strong("Practice:"), " Kaggle competitions with small datasets"),
                                          tags$li(strong("Community:"), " Cross Validated (StackExchange)")
                                        )
                                    )
                             ),
                             column(6,
                                    div(class = "highlight-box",
                                        h4("🛠️ Practical Tools"),
                                        tags$ul(
                                          tags$li(strong("R:"), " brms, rstanarm, MCMCglmm"),
                                          tags$li(strong("Python:"), " PyMC3, Stan, TensorFlow Probability"),
                                          tags$li(strong("GUI:"), " JASP for point-and-click analysis"),
                                          tags$li(strong("Web:"), " This app for reference!")
                                        )
                                    )
                             )
                           ),
                           
                           div(class = "warning-box",
                               h4("💡 Tips for Success"),
                               tags$ul(
                                 tags$li(strong("Start simple:"), " Use weakly informative priors at first"),
                                 tags$li(strong("Always validate:"), " Compare results with traditional methods"),
                                 tags$li(strong("Document priors:"), " Always explain where your priors come from"),
                                 tags$li(strong("Sensitivity check:"), " Test how results change with different priors"),
                                 tags$li(strong("Communicate uncertainty:"), " Don't forget credible intervals!")
                               )
                           ),
                           
                           div(style = "text-align: center; margin-top: 30px;",
                               h2("🎉 Good Journey in the World of Bayesian Inference! 🎉"),
                               br(),
                               p(style = "font-size: 18px; font-style: italic;", 
                                 "Remember: every expert was once a beginner. 
                                 Keep experimenting, making mistakes, and learning!")
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
  
  # Navigation
  observeEvent(input$start_journey, {
    updateTabItems(session, "sidebarMenu", "what_is_bayes")
  })
  
  # Coin flipping simulation (placeholder)
  observeEvent(input$flip_coin, {
    output$coin_comparison <- renderPlotly({
      # Placeholder for coin flipping plot
      plot_ly(x = c(1, 2, 3), y = c(1, 2, 3), type = "scatter", mode = "lines") %>%
        layout(title = "Coin Flipping Results (Placeholder)")
    })
    
    output$freq_results <- renderText({
      paste("Frequentist Results:\n",
            "Point estimate:", input$true_prob, "\n",
            "95% CI: [", round(input$true_prob - 0.1, 2), ", ", 
            round(input$true_prob + 0.1, 2), "]")
    })
    
    output$bayes_results <- renderText({
      paste("Bayesian Results:\n",
            "Posterior mean:", round((input$prior_belief + input$true_prob) / 2, 2), "\n",
            "95% credible interval: [", round(input$prior_belief - 0.05, 2), ", ", 
            round(input$prior_belief + 0.05, 2), "]")
    })
  })
  
  # Regression analysis (placeholder)
  observeEvent(input$run_regression, {
    output$freq_regression_plot <- renderPlotly({
      plot_ly(x = c(1, 2, 3), y = c(1, 2, 3), type = "scatter", mode = "lines") %>%
        layout(title = "Frequentist Regression (Placeholder)")
    })
    
    output$bayes_regression_plot <- renderPlotly({
      plot_ly(x = c(1, 2, 3), y = c(1, 2, 3), type = "scatter", mode = "lines") %>%
        layout(title = "Bayesian Regression (Placeholder)")
    })
    
    output$freq_reg_results <- renderText({
      paste("Frequentist Results:\n",
            "Slope estimate:", 2.0, "\n",
            "Standard error:", 0.1, "\n",
            "P-value: < 0.001")
    })
    
    output$bayes_reg_results <- renderText({
      paste("Bayesian Results:\n",
            "Posterior mean slope:", round((input$prior_slope_mean + 2.0) / 2, 2), "\n",
            "95% credible interval: [1.8, 2.2]")
    })
  })
  
  # Network analysis (placeholder)
  observeEvent(input$generate_network, {
    output$correlation_network_plot <- renderPlotly({
      plot_ly(x = c(1, 2, 3), y = c(1, 2, 3), type = "scatter", mode = "markers") %>%
        layout(title = "Correlation Method (Placeholder)")
    })
    
    output$bayesian_network_plot <- renderPlotly({
      plot_ly(x = c(1, 2, 3), y = c(1, 2, 3), type = "scatter", mode = "markers") %>%
        layout(title = "Bayesian Method (Placeholder)")
    })
    
    output$network_stats <- renderText({
      paste("Network Analysis Results:\n",
            "Precision: 0.75\n",
            "Sensitivity: 0.82\n",
            "Specificity: 0.91\n",
            "F1-score: 0.78")
    })
  })
  
  # Quiz functionality
  observeEvent(input$check_answers, {
    correct_answers <- c("b", "c", "b")
    user_answers <- c(input$q1, input$q2, input$q3)
    
    score <- sum(user_answers == correct_answers, na.rm = TRUE)
    
    feedback <- paste(
      "🎯 QUIZ RESULTS:",
      "",
      sprintf("Score: %d/3", score),
      "",
      "📝 Correct answers:",
      "1. b - When you have little data but good prior knowledge",
      "2. c - They naturally handle sparsity and uncertainty",
      "3. b - A poorly chosen prior can influence results",
      "",
      ifelse(score == 3, "🎉 PERFECT! You've mastered the basic concepts!",
             ifelse(score == 2, "👍 GREAT! You have a good understanding!",
                    "📚 Review the concepts and try again!")),
      sep = "\n"
    )
    
    output$quiz_results <- renderText({
      feedback
    })
  })
}

# Run the application
shinyApp(ui = ui, server = server)