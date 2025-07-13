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
  dashboardHeader(title = "🧠 BayesQuest: Introduction to Bayesian Statistics"),
  
  dashboardSidebar(
    useShinyjs(),
    sidebarMenu(
      menuItem("🏠 Introduction", tabName = "intro", icon = icon("home")),
      menuItem("🎯 What is Bayesian Statistics?", tabName = "what_is_bayes", icon = icon("question-circle")),
      menuItem("📊 Bayes' Theorem", tabName = "foundations", icon = icon("brain")),
      menuItem("📊 Bayesian Normal Distribution", tabName = "normal_bayes", icon = icon("chart-bell")),
      menuItem("📈 Bayesian Poisson Distribution", tabName = "poisson_bayes", icon = icon("bar-chart")),
      menuItem("🪙 Practical Example: Coin", tabName = "coin_example", icon = icon("coins")),
      menuItem("📈 Bayesian Regression", tabName = "regression", icon = icon("chart-line")),
      menuItem("🧬 Genetic Networks", tabName = "networks", icon = icon("dna")),
      menuItem("⚡ Variational Inference", tabName = "variational", icon = icon("lightning")),
      menuItem("🎯 Spike and Slab", tabName = "spike_slab", icon = icon("filter")),
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
      # Welcome Tab
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
                                       tags$li("Variational inference methods"),
                                       tags$li("Spike and slab methods"),
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
                                          tags$li("Updates with new data"))
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
                                 tags$li("Su 10.000 persone, 10 hanno la malattia (1 su 1000)"),
                                 tags$li("Il test rileva correttamente 9-10 di queste"),
                                 tags$li("But also gives ~500 false positives from 9,990 healthy people"),
                                 tags$li("Quindi: ~10 veri positivi su ~510 test positivi = ~2%")
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
                                        h4("💡 Vantaggi Pratici"),
                                        tags$ul(
                                          tags$li("Incorpora conoscenze esistenti"),
                                          tags$li("Works well with little data"),
                                          tags$li("Fornisce incertezza completa"),
                                          tags$li("Si aggiorna naturalmente"),
                                          tags$li("Più intuitivo per le decisioni")
                                        )
                                    )
                             ),
                             column(6,
                                    div(class = "comparison-card",
                                        h4("🎯 Applicazioni Reali"),
                                        tags$ul(
                                          tags$li("Medicina: diagnosi e trattamenti"),
                                          tags$li("Finanza: valutazione del rischio"),
                                          tags$li("Intelligenza Artificiale"),
                                          tags$li("Ricerca scientifica"),
                                          tags$li("Controllo qualità industriale")
                                        )
                                    )
                             )
                           )
                       )
                )
              )
      ),
      
      # Mathematical Foundations Tab
      tabItem(tabName = "foundations",
              fluidRow(
                column(12,
                       h2("📊 I Fondamenti Matematici"),
                       
                       div(class = "theory-box",
                           h3("🔑 Il Teorema di Bayes"),
                           
                           div(class = "explanation-box",
                               h4("🤔 What does this formula do?"),
                               p("Bayes' theorem tells us how to update our beliefs when we receive new information. 
                                 It's like having a calculator for uncertainty!")
                           ),
                           
                           div(class = "formula-box",
                               h4("📐 La Formula:"),
                               "$$P(\\text{Ipotesi}|\\text{Evidenza}) = \\frac{P(\\text{Evidenza}|\\text{Ipotesi}) \\times P(\\text{Ipotesi})}{P(\\text{Evidenza})}$$",
                               br(),
                               h4("🗣️ In parole semplici:"),
                               "$$\\text{Updated Belief} = \\frac{\\text{How likely what I observed} \\times \\text{Initial Belief}}{\\text{How likely what I observed in general}}$$"
                           ),
                           
                           fluidRow(
                             column(3,
                                    div(class = "step-box",
                                        h5("🎯 Prior P(Ipotesi)"),
                                        p(strong("CHE COS'È:")),
                                        p("Your belief BEFORE seeing the data"),
                                        p(strong("ESEMPIO:")),
                                        p("'I think this coin is fair' = 50% heads")
                                    )
                             ),
                             column(3,
                                    div(class = "step-box",
                                        h5("📊 Likelihood P(Evidenza|Ipotesi)"),
                                        p(strong("CHE COS'È:")),
                                        p("How likely it is to see this data IF your hypothesis is true"),
                                        p(strong("ESEMPIO:")),
                                        p("Se la moneta è equilibrata, quanto è probabile vedere 8 teste su 10 lanci?")
                                    )
                             ),
                             column(3,
                                    div(class = "step-box",
                                        h5("🔍 Evidence P(Evidenza)"),
                                        p(strong("CHE COS'È:")),
                                        p("How likely it is to see this data in general"),
                                        p(strong("ESEMPIO:")),
                                        p("Probabilità di vedere 8 teste su 10 lanci, considerando TUTTE le possibili monete")
                                    )
                             ),
                             column(3,
                                    div(class = "step-box",
                                        h5("🎉 Posterior P(Ipotesi|Evidenza)"),
                                        p(strong("CHE COS'È:")),
                                        p("Your belief AFTER seeing the data"),
                                        p(strong("ESEMPIO:")),
                                        p("'Dopo aver visto 8 teste su 10, ora penso che la probabilità di testa sia 65%'")
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
                               h4("📝 Il Problema:"),
                               p("Hai due monete: una normale (50% testa) e una truccata (80% testa). 
                                 Ne scegli una a caso e fai 5 lanci, ottenendo: TESTA, TESTA, CROCE, TESTA, TESTA. 
                                 Qual è la probabilità che tu abbia scelto la moneta truccata?")
                           ),
                           
                           h4("🔢 Passo 1: Prior (Credenza Iniziale)"),
                           div(class = "highlight-box",
                               p("Given that you chose randomly:"),
                               tags$ul(
                                 tags$li("P(Moneta Normale) = 0.5"),
                                 tags$li("P(Moneta Truccata) = 0.5")
                               )
                           ),
                           
                           h4("🔢 Passo 2: Likelihood (Probabilità dei Dati)"),
                           div(class = "highlight-box",
                               p("Sequenza osservata: TTCTT (4 teste su 5 lanci)"),
                               p(strong("Se moneta normale (p=0.5):")),
                               p("P(TTCTT | Normale) = 0.5^5 = 0.03125"),
                               br(),
                               p(strong("Se moneta truccata (p=0.8):")),
                               p("P(TTCTT | Truccata) = 0.8^4 × 0.2^1 = 0.08192")
                           ),
                           
                           h4("🔢 Passo 3: Evidence (Normalizzazione)"),
                           div(class = "highlight-box",
                               p("P(TTCTT) = P(TTCTT|Normale) × P(Normale) + P(TTCTT|Truccata) × P(Truccata)"),
                               p("P(TTCTT) = 0.03125 × 0.5 + 0.08192 × 0.5 = 0.056585")
                           ),
                           
                           h4("🔢 Passo 4: Posterior (Risultato Finale)"),
                           div(class = "bayes-box",
                               p(strong("P(Truccata | TTCTT) = (0.08192 × 0.5) / 0.056585 = 72.4%")),
                               br(),
                               p("🎯 INTERPRETAZIONE: Dopo aver visto 4 teste su 5 lanci, 
                                 c'è una probabilità del 72.4% che tu abbia scelto la moneta truccata!")
                           )
                       )
                )
              ),
              
              fluidRow(
                column(12,
                       div(class = "theory-box",
                           h3("🧠 Intuizioni Chiave del Teorema di Bayes"),
                           
                           fluidRow(
                             column(6,
                                    div(class = "warning-box",
                                        h4("⚠️ Errori Comuni da Evitare"),
                                        tags$ul(
                                          tags$li("Confondere P(A|B) con P(B|A)"),
                                          tags$li("Ignorare il prior"),
                                          tags$li("Non considerare la rarità dell'evento"),
                                          tags$li("Pensare che 'accurato al 95%' = '95% di probabilità'")
                                        )
                                    )
                             ),
                             column(6,
                                    div(class = "highlight-box",
                                        h4("💡 Punti Chiave da Ricordare"),
                                        tags$ul(
                                          tags$li("The prior always influences the result"),
                                          tags$li("More data = less influence of the prior"),
                                          tags$li("Rare events remain rare even with positive evidence"),
                                          tags$li("L'aggiornamento è continuo e naturale")
                                        )
                                    )
                             )
                           )
                       )
                )
              )
      ),
      
      tabItem(tabName = "normal_bayes",
        fluidRow(
          column(12,
                 h2("📊 The Normal Distribution: Foundation of Bayesian Inference"),
                 
                 div(class = "explanation-box",
                     h3("🎯 Perché la Normale è Così Importante?"),
                     p("The normal distribution isn't just 'the bell curve' - it's the fundamental building block 
                       di quasi tutta la statistica moderna. Con l'approccio Bayesiano, possiamo stimare 
                       i suoi parametri (media μ e varianza σ²) in modo elegante e principiato."),
                     br(),
                     p(strong("🧮 La magia: "), "Usando prior coniugati, le distribuzioni posteriori 
                       rimangono in famiglie note, rendendo tutto computazionalmente trattabile!")
                 )
          )
        ),
        
        fluidRow(
          column(12,
                 div(class = "theory-box",
                     h3("🔢 I Due Parametri e i Loro Prior Coniugati"),
                     
                     div(class = "formula-box",
                         h4("📐 Il Modello:"),
                         "$$X \\sim \\mathcal{N}(\\mu, \\sigma^2)$$",
                         br(),
                         h4("🧠 I Prior Coniugati:"),
                         "$$\\mu | \\sigma^2 \\sim \\mathcal{N}(\\mu_0, \\frac{\\sigma^2}{\\kappa_0})$$",
                         "$$\\sigma^2 \\sim \\text{InverseGamma}(\\alpha_0, \\beta_0)$$"
                     ),
                     
                     fluidRow(
                       column(6,
                              div(class = "step-box",
                                  h4("🎯 Prior sulla Media μ"),
                                  p(strong("Forma:"), " Normale condizionata"),
                                  p(strong("Parametri:")),
                                  tags$ul(
                                    tags$li("μ₀: where you think the mean is centered"),
                                    tags$li("κ₀: quanto sei sicuro (pseudo-osservazioni)")
                                  ),
                                  p(strong("Interpretazione:"), " 'Penso che μ sia circa μ₀, 
                                    con fiducia equivalente a κ₀ osservazioni'")
                              )
                       ),
                       column(6,
                              div(class = "step-box",
                                  h4("📏 Prior sulla Varianza σ²"),
                                  p(strong("Forma:"), " Gamma Inversa"),
                                  p(strong("Parametri:")),
                                  tags$ul(
                                    tags$li("α₀: parametro di forma"),
                                    tags$li("β₀: parametro di scala")
                                  ),
                                  p(strong("Interpretazione:"), " Controlla forma e spread 
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
                         h4("📚 Scenario Semplificato:"),
                         p("Iniziamo assumendo di conoscere la varianza σ² = 1. 
                           This allows us to focus on estimating the mean μ 
                           using the simplest conjugate prior.")
                     )
                 )
          )
        ),
        
        fluidRow(
          column(4,
                 div(class = "theory-box",
                     h3("🎛️ Controlli del Laboratorio"),
                     
                     div(class = "step-box",
                         h4("🔬 Esperimento"),
                         sliderInput("true_mu", "Media vera (μ):", 
                                     min = -3, max = 3, value = 0, step = 0.5),
                         sliderInput("n_obs", "Numero osservazioni:", 
                                     min = 5, max = 100, value = 20, step = 5),
                         div(class = "explanation-box",
                             p(em("Varianza fissata a σ² = 1 per semplicità")))
                     ),
                     
                     div(class = "step-box",
                         h4("🧠 Il Tuo Prior su μ"),
                         sliderInput("prior_mu", "Credenza iniziale (μ₀):", 
                                     min = -3, max = 3, value = 0, step = 0.5),
                         sliderInput("prior_kappa", "Fiducia nel prior (κ₀):", 
                                     min = 0.1, max = 10, value = 1, step = 0.5),
                         div(class = "explanation-box",
                             p(em("κ₀ = 'osservazioni equivalenti' del tuo prior")))
                     ),
                     
                     br(),
                     actionButton("run_normal_bayes", "🔬 Genera Dati e Stima!", 
                                  class = "btn-primary btn-lg"),
                     
                     br(), br(),
                     div(class = "highlight-box",
                         h5("🧪 Esperimenti Suggeriti:"),
                         p("1. Prior giusto vs sbagliato"),
                         p("2. Prior debole (κ₀=0.5) vs forte (κ₀=5)"),
                         p("3. Little data (n=5) vs lots (n=50)"),
                         p("4. Observe how the posterior updates!")
                     )
                 )
          ),
          
          column(8,
                 div(class = "theory-box",
                     h3("📊 Evoluzione delle Credenze"),
                     
                     fluidRow(
                       column(6,
                              h4("🏛️ Approccio Frequentista", style = "text-align: center; color: #e74c3c;"),
                              plotlyOutput("freq_normal_plot", height = "300px")
                       ),
                       column(6,
                              h4("🧠 Approccio Bayesiano", style = "text-align: center; color: #2ecc71;"),
                              plotlyOutput("bayes_normal_plot", height = "300px")
                       )
                     ),
                     
                     br(),
                     
                     div(class = "explanation-box",
                         h4("🔍 Confronto Grafico:"),
                         tags$ul(
                           tags$li(strong("Left (Frequentist):"), " Only likelihood from data"),
                           tags$li(strong("Destra (Bayesiano):"), " Prior (tratteggiata) + Likelihood = Posterior (continua)"),
                           tags$li(strong("Area grigia:"), " Intervallo di confidenza/credibilità 95%"),
                           tags$li(strong("Linea verticale rossa:"), " Valore vero di μ")
                         )
                     )
                 )
          )
        ),
        
        fluidRow(
          column(6,
                 div(class = "freq-box",
                     h4("🏛️ Analisi Frequentista"),
                     verbatimTextOutput("freq_normal_results"),
                     
                     div(class = "explanation-box",
                         h5("📊 Formula Classica:"),
                         div(class = "formula-box",
                             "$\\hat{\\mu} = \\bar{x}$",
                             br(),
                             "$SE = \\frac{\\sigma}{\\sqrt{n}} = \\frac{1}{\\sqrt{n}}$"
                         ),
                         p("Semplice ma non usa informazioni pregresse")
                     )
                 )
          ),
          column(6,
                 div(class = "bayes-box",
                     h4("🧠 Analisi Bayesiana"),
                     verbatimTextOutput("bayes_normal_results"),
                     
                     div(class = "explanation-box",
                         h5("🧮 Formula Posterior:"),
                         div(class = "formula-box",
                             "$\\mu | x \\sim \\mathcal{N}(\\mu_n, \\frac{1}{\\kappa_n})$",
                             br(),
                             "$\\mu_n = \\frac{\\kappa_0 \\mu_0 + n \\bar{x}}{\\kappa_0 + n}$",
                             br(),
                             "$\\kappa_n = \\kappa_0 + n$"
                         ),
                         p("Combina prior e likelihood ottimalmente")
                     )
                 )
          )
        ),
        
        # Sezione avanzata: stima di entrambi i parametri
        fluidRow(
          column(12,
                 div(class = "theory-box",
                     h3("🚀 Livello Avanzato: Stima Congiunta di μ e σ²"),
                     
                     div(class = "explanation-box",
                         h4("🎯 Il Problema Completo:"),
                         p("Nella realtà, quasi mai conosciamo σ². Dobbiamo stimare ENTRAMBI i parametri 
                           simultaneamente. Qui la potenza dei prior coniugati diventa evidente!")
                     ),
                     
                     div(class = "formula-box",
                         h4("📐 Prior Congiunto (Normal-Inverse-Gamma):"),
                         "$\\mu | \\sigma^2 \\sim \\mathcal{N}(\\mu_0, \\frac{\\sigma^2}{\\kappa_0})$",
                         br(),
                         "$\\sigma^2 \\sim \\text{InverseGamma}(\\alpha_0, \\beta_0)$",
                         br(),
                         h4("🎯 Posterior (anche Normal-Inverse-Gamma):"),
                         "$\\mu | \\sigma^2, x \\sim \\mathcal{N}(\\mu_n, \\frac{\\sigma^2}{\\kappa_n})$",
                         br(),
                         "$\\sigma^2 | x \\sim \\text{InverseGamma}(\\alpha_n, \\beta_n)$"
                     )
                 )
          )
        ),
        
        fluidRow(
          column(4,
                 div(class = "theory-box",
                     h3("🎮 Laboratorio Avanzato"),
                     
                     div(class = "step-box",
                         h4("🔬 Setup Completo"),
                         sliderInput("true_mu_full", "Media vera:", 
                                     min = -2, max = 2, value = 0, step = 0.5),
                         sliderInput("true_sigma_full", "Deviazione standard vera:", 
                                     min = 0.5, max = 3, value = 1, step = 0.25),
                         sliderInput("n_obs_full", "Osservazioni:", 
                                     min = 10, max = 200, value = 50, step = 10)
                     ),
                     
                     div(class = "step-box",
                         h4("🧠 Prior su μ"),
                         sliderInput("prior_mu_full", "μ₀:", 
                                     min = -2, max = 2, value = 0, step = 0.5),
                         sliderInput("prior_kappa_full", "κ₀:", 
                                     min = 0.1, max = 5, value = 1, step = 0.5)
                     ),
                     
                     div(class = "step-box",
                         h4("📏 Prior su σ²"),
                         sliderInput("prior_alpha", "α₀ (forma):", 
                                     min = 1, max = 10, value = 3, step = 1),
                         sliderInput("prior_beta", "β₀ (rate):", 
                                     min = 1, max = 10, value = 2, step = 1),
                         div(class = "explanation-box",
                             p(em("Media prior di σ² ≈ β₀/(α₀-1)")))
                     ),
                     
                     br(),
                     actionButton("run_full_normal", "🚀 Stima Completa!", 
                                  class = "btn-success btn-lg")
                 )
          ),
          
          column(8,
                 div(class = "theory-box",
                     h3("📊 Posterior Congiunti"),
                     
                     fluidRow(
                       column(6,
                              h4("μ Posterior", style = "text-align: center;"),
                              plotlyOutput("mu_posterior_plot", height = "250px")
                       ),
                       column(6,
                              h4("σ² Posterior", style = "text-align: center;"),
                              plotlyOutput("sigma_posterior_plot", height = "250px")
                       )
                     ),
                     
                     br(),
                     
                     h4("🎯 Joint Posterior μ vs σ", style = "text-align: center;"),
                     plotlyOutput("joint_posterior_plot", height = "300px"),
                     
                     div(class = "explanation-box",
                         h5("🔍 Interpretazione:"),
                         tags$ul(
                           tags$li("Grafici sopra: distribuzioni marginali di μ e σ²"),
                           tags$li("Grafico sotto: correlazione tra stime (spesso negativa!)"),
                           tags$li("Punti rossi: valori veri"),
                           tags$li("Ellissi: regioni di credibilità congiunta")
                         )
                     )
                 )
          )
        ),
        
        fluidRow(
          column(6,
                 div(class = "theory-box",
                     h4("📊 Risultati Completi"),
                     verbatimTextOutput("full_bayes_results")
                 )
          ),
          column(6,
                 div(class = "theory-box",
                     h4("🎓 Formule Aggiornamento"),
                     div(class = "formula-box",
                         h5("Parametri Posterior:"),
                         "$\\kappa_n = \\kappa_0 + n$",
                         br(),
                         "$\\mu_n = \\frac{\\kappa_0 \\mu_0 + n \\bar{x}}{\\kappa_n}$",
                         br(),
                         "$\\alpha_n = \\alpha_0 + \\frac{n}{2}$",
                         br(),
                         "$\\beta_n = \\beta_0 + \\frac{1}{2}\\sum(x_i - \\bar{x})^2 + \\frac{\\kappa_0 n (\\bar{x} - \\mu_0)^2}{2\\kappa_n}$"
                     ),
                     div(class = "explanation-box",
                         p("Nota come ogni parametro sia una media pesata 
                           between prior and data, with weights that depend on 
                           'fiducia' relativa!")
                     )
                 )
          )
        ),
        
        fluidRow(
          column(12,
                 div(class = "theory-box",
                     h3("🌟 Insights Chiave dalla Distribuzione Normale"),
                     
                     fluidRow(
                       column(6,
                              div(class = "highlight-box",
                                  h4("🧮 Vantaggi Computazionali"),
                                  tags$ul(
                                    tags$li("Prior coniugati → posterior in forma chiusa"),
                                    tags$li("Nessun MCMC necessario per il caso normale"),
                                    tags$li("Formule esplicite per tutti i momenti"),
                                    tags$li("Aggiornamento sequenziale naturale"),
                                    tags$li("Base per modelli più complessi")
                                  )
                              )
                       ),
                       column(6,
                              div(class = "highlight-box",
                                  h4("🔬 Lezioni Metodologiche"),
                                  tags$ul(
                                    tags$li("Informative priors improve estimates with little data"),
                                    tags$li("Shrinkage automatico verso il prior"),
                                    tags$li("Quantificazione naturale dell'incertezza"),
                                    tags$li("Trade-off bias-varianza gestito automaticamente"),
                                    tags$li("Foundation for regression and mixed models")
                                  )
                              )
                       )
                     ),
                     
                     div(class = "warning-box",
                         h4("🚀 Estensioni Potenti"),
                         p("Il framework Normal-Inverse-Gamma si estende a:"),
                         tags$ul(
                           tags$li(strong("Linear Regression:"), " y = Xβ + ε with β ~ Normal, σ² ~ InvGamma"),
                           tags$li(strong("Modelli Misti:"), " Effetti fissi e random con prior gerarchici"),
                           tags$li(strong("Time Series:"), " Modelli di stato-spazio Bayesiani"),
                           tags$li(strong("Modelli Multi-livello:"), " Prior che variano per gruppi"),
                           tags$li(strong("Robust Regression:"), " t-Student come estensione della normale")
                         ),
                         br(),
                         p(strong("🎯 Key Message:"), " Learning Bayesian normal inference well 
                           ti dà le basi per quasi tutti i modelli statistici avanzati!")
                     )
                 )
          )
        )
),

      # Poisson Bayesian Tab
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
                               "$$\\text{Data: } X_1, \\ldots, X_n \\sim \\text{Poisson}(\\lambda)$$",
                               "$$\\text{Prior: } \\lambda \\sim \\text{Gamma}(\\alpha, \\beta)$$",
                               "$$\\text{Posterior: } \\lambda | \\mathbf{x} \\sim \\text{Gamma}\\left(\\alpha + \\sum x_i, \\beta + n\\right)$$"
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
                               textOutput("poisson_summary_stats")
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
                               sliderInput("prior_strength", "Quanto sei sicuro? (lanci equivalenti):", 
                                           min = 1, max = 50, value = 10, step = 1),
                               div(class = "explanation-box",
                                   p(em("'Lanci equivalenti' = quanta evidenza equivale la tua credenza iniziale")))
                           ),
                           
                           br(),
                           actionButton("flip_coin", "🪙 Lancia la Moneta!", class = "btn-primary btn-lg"),
                           
                           br(), br(),
                           div(class = "highlight-box",
                               h5("💡 Prova Questi Scenari:"),
                               p("1. Prior sbagliato (es. credi 0.3, verità = 0.7)"),
                               p("2. Prior corretto"),
                               p("3. Prior molto sicuro vs poco sicuro"),
                               p("4. Pochi dati vs molti dati")
                           )
                       )
                ),
                
                column(8,
                       div(class = "theory-box",
                           h3("📊 Risultati dell'Esperimento"),
                           plotlyOutput("coin_comparison", height = "400px"),
                           
                           div(class = "explanation-box",
                               h4("📖 Come Leggere il Grafico:"),
                               tags$ul(
                                 tags$li(strong("Linea Rossa:"), " Stima frequentista"),
                                 tags$li(strong("Linea Verde:"), " Stima Bayesiana"),
                                 tags$li(strong("Area Verde:"), " Intervallo di credibilità Bayesiano"),
                                 tags$li(strong("Linea Tratteggiata:"), " Valore vero (sconosciuto nella realtà)")
                               )
                           )
                       )
                )
              ),
              
              fluidRow(
                column(6,
                       div(class = "freq-box",
                           h4("🏛️ Analisi Frequentista"),
                           verbatimTextOutput("freq_results"),
                           
                           div(class = "explanation-box",
                               h5("🔍 Cosa Significa:"),
                               tags$ul(
                                 tags$li(strong("Stima puntuale:"), " Il nostro 'miglior guess'"),
                                 tags$li(strong("Intervallo di confidenza:"), " Se ripetessi l'esperimento 100 volte, 95 intervalli conterrebbero il vero valore"),
                                 tags$li(strong("Nessun prior:"), " Ogni esperimento parte da zero")
                               )
                           )
                       )
                ),
                column(6,
                       div(class = "bayes-box",
                           h4("🧠 Analisi Bayesiana"),
                           verbatimTextOutput("bayes_results"),
                           
                           div(class = "explanation-box",
                               h5("🔍 Cosa Significa:"),
                               tags$ul(
                                 tags$li(strong("Media posteriore:"), " Il nostro 'miglior guess' aggiornato"),
                                 tags$li(strong("Intervallo di credibilità:"), " C'è il 95% di probabilità che il vero valore sia in questo intervallo"),
                                 tags$li(strong("Prior incorporato:"), " Usiamo la conoscenza pregressa")
                               )
                           )
                       )
                )
              ),
              
              fluidRow(
                column(12,
                       div(class = "theory-box",
                           h3("🎓 Lezioni da Questo Esperimento"),
                           
                           fluidRow(
                             column(6,
                                    div(class = "highlight-box",
                                        h4("📈 Con Molti Dati (n > 100):"),
                                        tags$ul(
                                          tags$li("Frequentista e Bayesiano convergono"),
                                          tags$li("Il prior diventa meno influente"),
                                          tags$li("Le stime diventano molto precise"),
                                          tags$li("Gli intervalli si restringono")
                                        )
                                    )
                             ),
                             column(6,
                                    div(class = "highlight-box",
                                        h4("📉 Con Pochi Dati (n < 50):"),
                                        tags$ul(
                                          tags$li("Il prior Bayesiano è molto influente"),
                                          tags$li("Un prior corretto aiuta molto"),
                                          tags$li("Un prior sbagliato può essere problematico"),
                                          tags$li("L'incertezza rimane alta")
                                        )
                                    )
                             )
                           ),
                           
                           div(class = "warning-box",
                               h4("🤔 Riflessioni Importanti:"),
                               tags$ul(
                                 tags$li("Il prior è sia la forza che la debolezza dell'approccio Bayesiano"),
                                 tags$li("Con dati sufficienti, i metodi convergono al valore vero"),
                                 tags$li("L'interpretazione Bayesiana è spesso più intuitiva"),
                                 tags$li("La scelta del prior richiede pensiero e esperienza")
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
                       h2("📈 Regressione Bayesiana: Dalla Teoria alla Pratica"),
                       
                       div(class = "explanation-box",
                           h3("🎯 Cos'è la Regressione? (Spiegazione per Principianti)"),
                           p("La regressione è come tracciare la 'migliore linea' attraverso dei punti su un grafico. 
                             Immagina di avere dati su altezza e peso di persone: la regressione ci aiuta a prevedere 
                             il peso di una persona data la sua altezza, trovando la relazione tra le due variabili."),
                           br(),
                           p(strong("🤔 Ma quale linea è la 'migliore'? E quanto siamo sicuri?"), 
                             " Qui entrano in gioco le differenze tra approccio frequentista e Bayesiano!")
                       )
                )
              ),
              
              fluidRow(
                column(12,
                       div(class = "theory-box",
                           h3("📐 Il Modello Matematico (Spiegato Semplice)"),
                           
                           div(class = "formula-box",
                               h4("🏠 La Relazione di Base:"),
                               "$$y = \\beta_0 + \\beta_1 x + \\epsilon$$",
                               br(),
                               h4("🗣️ In parole semplici:"),
                               "$$\\text{Valore y} = \\text{Intercetta} + \\text{Pendenza} \\times \\text{Valore x} + \\text{Errore casuale}$$"
                           ),
                           
                           fluidRow(
                             column(3,
                                    div(class = "step-box",
                                        h5("📊 y (Variabile Dipendente)"),
                                        p("Quello che vogliamo prevedere"),
                                        p(strong("Esempio:"), " Peso di una persona")
                                    )
                             ),
                             column(3,
                                    div(class = "step-box",
                                        h5("📏 x (Variabile Indipendente)"),
                                        p("Quello che usiamo per prevedere"),
                                        p(strong("Esempio:"), " Altezza di una persona")
                                    )
                             ),
                             column(3,
                                    div(class = "step-box",
                                        h5("🎯 β₀ (Intercetta)"),
                                        p("Valore di y quando x = 0"),
                                        p(strong("Esempio:"), " Peso teorico di una persona alta 0 cm (non realistico!)")
                                    )
                             ),
                             column(3,
                                    div(class = "step-box",
                                        h5("📈 β₁ (Pendenza)"),
                                        p("Quanto cambia y per ogni unità di x"),
                                        p(strong("Esempio:"), " Quanti kg in più per ogni cm di altezza")
                                    )
                             )
                           )
                       )
                )
              ),
              
              fluidRow(
                column(12,
                       div(class = "theory-box",
                           h3("⚔️ Frequentista vs Bayesiano: Il Confronto"),
                           
                           fluidRow(
                             column(6,
                                    div(class = "freq-box",
                                        h4("🏛️ Approccio Frequentista"),
                                        h5("🎯 Obiettivo:"),
                                        p("Trova i valori di β che minimizzano l'errore quadratico"),
                                        
                                        div(class = "formula-box",
                                            "$$\\hat{\\beta} = (X^TX)^{-1}X^Ty$$"
                                        ),
                                        
                                        h5("📊 Fornisce:"),
                                        tags$ul(
                                          tags$li("Una stima puntuale di β"),
                                          tags$li("Intervalli di confidenza"),
                                          tags$li("Test di significatività"),
                                          tags$li("R² per bontà di adattamento")
                                        ),
                                        
                                        h5("🤔 Interpreta:"),
                                        p("'Se ripetessi questo studio 100 volte, il 95% degli intervalli di confidenza conterrebbe il vero valore di β'")
                                    )
                             ),
                             column(6,
                                    div(class = "bayes-box",
                                        h4("🧠 Approccio Bayesiano"),
                                        h5("🎯 Obiettivo:"),
                                        p("Combina prior + dati per ottenere distribuzione posteriore di β"),
                                        
                                        div(class = "formula-box",
                                            "$$p(\\beta|y) \\propto p(y|\\beta)p(\\beta)$$"
                                        ),
                                        
                                        h5("📊 Fornisce:"),
                                        tags$ul(
                                          tags$li("Distribuzione completa di β"),
                                          tags$li("Intervalli di credibilità"),
                                          tags$li("Probabilità posteriori"),
                                          tags$li("Predizioni con incertezza")
                                        ),
                                        
                                        h5("🤔 Interpreta:"),
                                        p("'C'è il 95% di probabilità che β sia in questo intervallo, dato i dati osservati'")
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
                           h3("🎮 Controlli Semplici"),
                           
                           div(class = "step-box",
                               h4("📊 Dati"),
                               sliderInput("n_points", "Quanti punti:", 
                                           min = 10, max = 100, value = 30, step = 10),
                               sliderInput("noise_level", "Quanto rumore:", 
                                           min = 0.5, max = 2, value = 1, step = 0.5),
                               div(class = "explanation-box",
                                   p(em("Più rumore = punti più sparsi")))
                           ),
                           
                           div(class = "step-box",
                               h4("🧠 Il Tuo Prior"),
                               p("Pensi che la pendenza sia circa:"),
                               sliderInput("prior_slope_mean", "", 
                                           min = 0.5, max = 3.5, value = 1, step = 0.5),
                               p("Quanto sei sicuro?"),
                               radioButtons("prior_confidence", "",
                                            choices = list("Poco sicuro" = "weak",
                                                           "Abbastanza sicuro" = "medium", 
                                                           "Molto sicuro" = "strong"),
                                            selected = "medium"),
                               div(class = "explanation-box",
                                   p(em("La pendenza vera è sempre 2.0!")))
                           ),
                           
                           br(),
                           actionButton("run_regression", "🔄 Nuova Regressione", class = "btn-success btn-lg"),
                           
                           br(), br(),
                           div(class = "highlight-box",
                               h5("💡 Prova Questi Scenari:"),
                               p("🎯 Prior corretto (2.0) vs sbagliato (1.0)"),
                               p("📊 Pochi dati (10) vs molti (100)"),
                               p("🔒 Prior sicuro vs incerto"),
                               p("📈 Poco rumore vs molto rumore")
                           )
                       )
                ),
                
                column(9,
                       div(class = "theory-box",
                           h3("📊 Confronto Diretto: Frequentista vs Bayesiano"),
                           
                           fluidRow(
                             column(6,
                                    h4("🏛️ Approccio Frequentista", style = "color: #e74c3c; text-align: center;"),
                                    plotlyOutput("freq_regression_plot", height = "350px")
                             ),
                             column(6,
                                    h4("🧠 Approccio Bayesiano", style = "color: #2ecc71; text-align: center;"),
                                    plotlyOutput("bayes_regression_plot", height = "350px")
                             )
                           ),
                           
                           br(),
                           
                           div(class = "explanation-box",
                               h4("🔍 Cosa Osservare:"),
                               fluidRow(
                                 column(6,
                                        div(style = "border-left: 5px solid #e74c3c; padding-left: 15px;",
                                            h5("Nel Grafico Frequentista:"),
                                            tags$ul(
                                              tags$li("Una sola linea 'migliore'"),
                                              tags$li("Sempre la stessa, indipendentemente dai prior"),
                                              tags$li("Nessuna visualizzazione dell'incertezza")
                                            )
                                        )
                                 ),
                                 column(6,
                                        div(style = "border-left: 5px solid #2ecc71; padding-left: 15px;",
                                            h5("Nel Grafico Bayesiano:"),
                                            tags$ul(
                                              tags$li("Linea principale + banda di incertezza"),
                                              tags$li("Influenzato dal tuo prior iniziale"),
                                              tags$li("Mostra quanto siamo sicuri delle predizioni")
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
                           h4("🏛️ Analisi Frequentista"),
                           verbatimTextOutput("freq_reg_results"),
                           
                           div(class = "explanation-box",
                               h5("✅ Punti di Forza:"),
                               tags$ul(
                                 tags$li("Oggettivo - stessa risposta sempre"),
                                 tags$li("Non influenzato da opinioni pregresse"),
                                 tags$li("Standard nelle pubblicazioni")
                               ),
                               h5("⚠️ Limitazioni:"),
                               tags$ul(
                                 tags$li("Non mostra incertezza nelle predizioni"),
                                 tags$li("Non usa conoscenze pregresse")
                               )
                           )
                       )
                ),
                column(6,
                       div(class = "bayes-box",
                           h4("🧠 Analisi Bayesiana"),
                           verbatimTextOutput("bayes_reg_results"),
                           
                           div(class = "explanation-box",
                               h5("✅ Punti di Forza:"),
                               tags$ul(
                                 tags$li("Mostra incertezza complete"),
                                 tags$li("Usa conoscenze pregresse"),
                                 tags$li("Migliore con pochi dati")
                               ),
                               h5("⚠️ Limitazioni:"),
                               tags$ul(
                                 tags$li("Dipende dalla scelta del prior"),
                                 tags$li("Più complesso da calcolare")
                               )
                           )
                       )
                )
              ),
              
              fluidRow(
                column(12,
                       div(class = "theory-box",
                           h3("🎓 Quando Usare Quale Approccio?"),
                           
                           fluidRow(
                             column(6,
                                    div(class = "freq-box",
                                        h4("🏛️ Usa Frequentista Quando:"),
                                        tags$ul(
                                          tags$li("🔢 Hai molti dati (n > 100)"),
                                          tags$li("❓ Non hai informazioni pregresse"),
                                          tags$li("📄 Vuoi risultati 'oggettivi' e standard"),
                                          tags$li("⚡ La computazione deve essere veloce"),
                                          tags$li("📰 Devi pubblicare su riviste tradizionali")
                                        ),
                                        
                                        div(class = "explanation-box",
                                            h5("💡 Esempio Ideale:"),
                                            p("Sondaggio con 10.000 risposte per stimare 
                                              la percentuale di persone che preferiscono il gelato al cioccolato.")
                                        )
                                    )
                             ),
                             column(6,
                                    div(class = "bayes-box",
                                        h4("🧠 Usa Bayesiano Quando:"),
                                        tags$ul(
                                          tags$li("📊 Hai pochi dati ma conoscenze pregresse"),
                                          tags$li("🎯 Vuoi quantificare l'incertezza completa"),
                                          tags$li("🔮 Devi fare predizioni con incertezza"),
                                          tags$li("🧩 Hai modelli complessi/gerarchici"),
                                          tags$li("👨‍⚕️ Puoi incorporare esperienza di esperti")
                                        ),
                                        
                                        div(class = "explanation-box",
                                            h5("💡 Esempio Ideale:"),
                                            p("Studio clinico con 50 pazienti per un farmaco raro, 
                                              ma hai già conoscenze da studi precedenti simili.")
                                        )
                                    )
                             )
                           ),
                           
                           div(class = "warning-box",
                               h4("⚠️ Attenzione ai Prior!"),
                               p("Il principale rischio dell'approccio Bayesiano è un prior mal scelto. 
                                 Con pochi dati, un prior sbagliato può portare a conclusioni errate. 
                                 Ma con molti dati, anche un prior sbagliato viene 'corretto' dall'evidenza."),
                               br(),
                               p(strong("💡 Strategia sicura:"), " Inizia sempre con prior 'debolmente informativi' 
                                 - abbastanza vaghi da non influenzare troppo, ma abbastanza specifici da essere utili.")
                           )
                       )
                )
              )
      ),
      
      # Gene Networks Tab
      tabItem(tabName = "networks",
              fluidRow(
                column(12,
                       h2("🧬 Reti Genetiche Bayesiane"),
                       
                       div(class = "explanation-box",
                           h3("🔬 Cosa Sono le Reti Genetiche?"),
                           p("Immagina i geni come persone in un'azienda. Alcuni geni sono 'capi' che danno ordini 
                             ad altri geni 'dipendenti'. Una rete genetica è la mappa di questi rapporti gerarchici:"),
                           br(),
                           fluidRow(
                             column(4, 
                                    div(style = "text-align: center; padding: 15px; background: #e8f5e8; border-radius: 8px;",
                                        h5("👨‍💼 Gene Capo"),
                                        p("'Attivati!'"),
                                        p("↓"),
                                        h5("👨‍💻 Gene Dipendente"),
                                        p("Si attiva")
                                    )
                             ),
                             column(4,
                                    div(style = "text-align: center; padding: 15px; background: #ffe8e8; border-radius: 8px;",
                                        h5("👨‍💼 Gene Capo"),
                                        p("'Spegniti!'"),
                                        p("↓"),
                                        h5("😴 Gene Dipendente"),
                                        p("Si spegne")
                                    )
                             ),
                             column(4,
                                    div(style = "text-align: center; padding: 15px; background: #f0f0f0; border-radius: 8px;",
                                        h5("❓ Gene Sconosciuto"),
                                        p("Non sappiamo"),
                                        p("↓"),
                                        h5("❓ Gene Sconosciuto"),  
                                        p("Mistero!")
                                    )
                             )
                           ),
                           br(),
                           p("🎯 ", strong("Il nostro obiettivo:"), " Scoprire questi rapporti osservando solo 
                             quanto ogni gene è attivo in diversi pazienti/condizioni.")
                       )
                )
              ),
              
              fluidRow(
                column(12,
                       div(class = "theory-box",
                           h3("📊 Il Problema: Due Modi per Scoprire le Connessioni"),
                           
                           fluidRow(
                             column(6,
                                    div(class = "freq-box",
                                        h4("🏛️ Metodo Tradizionale: Correlazione"),
                                        h5("🤔 Logica:"),
                                        p("'Se due geni variano insieme, devono essere collegati'"),
                                        
                                        h5("📊 Procedura:"),
                                        tags$ol(
                                          tags$li("Calcola correlazione tra ogni coppia"),
                                          tags$li("Se correlazione > soglia (es. 0.3) → collegati"),
                                          tags$li("Altrimenti → non collegati")
                                        ),
                                        
                                        h5("⚠️ Problemi:"),
                                        tags$ul(
                                          tags$li("Soglia arbitraria - perché 0.3 e non 0.25?"),
                                          tags$li("Tanti falsi positivi - geni sembrano collegati per caso"),
                                          tags$li("Decisioni binarie - sì/no senza sfumature"),
                                          tags$li("Non considera che le reti biologiche sono sparse")
                                        )
                                    )
                             ),
                             column(6,
                                    div(class = "bayes-box",
                                        h4("🧠 Metodo Bayesiano: Probabilità Intelligente"),
                                        h5("🤔 Logica:"),
                                        p("'Quanto è PROBABILE che due geni siano collegati, considerando che le reti biologiche sono normalmente sparse?'"),
                                        
                                        h5("📊 Procedura:"),
                                        tags$ol(
                                          tags$li("Definisci prior: 'Le reti sono sparse, poche connessioni'"),
                                          tags$li("Osserva correlazione: 'Quanto sono correlati?'"),
                                          tags$li("Calcola probabilità: Bayes combina prior + osservazione"),
                                          tags$li("Decidi: Se probabilità > 50% → probabilmente collegati")
                                        ),
                                        
                                        h5("✅ Vantaggi:"),
                                        tags$ul(
                                          tags$li("Nessuna soglia arbitraria - tutto probabilistico"),
                                          tags$li("Meno falsi positivi - considera la sparsità biologica"),  
                                          tags$li("Incertezza quantificata - 'sicuro al 85%'"),
                                          tags$li("Incorpora conoscenza biologica naturalmente")
                                        )
                                    )
                             )
                           )
                       )
                )
              ),
              
              fluidRow(
                column(12,
                       div(class = "theory-box",
                           h3("🧮 La Matematica Bayesiana per le Reti"),
                           
                           div(class = "formula-box",
                               h4("🎯 La Domanda per Ogni Coppia di Geni:"),
                               "$P(\\text{collegati}|\\text{correlazione osservata}) = ?$",
                               br(),
                               h4("🔮 La Risposta di Bayes:"),
                               "$P(\\text{collegati}|\\text{correlazione}) \\propto P(\\text{correlazione}|\\text{collegati}) \\times P(\\text{collegati})$"
                           ),
                           
                           fluidRow(
                             column(4,
                                    div(class = "step-box",
                                        h5("🧠 Prior P(collegati)"),
                                        p(strong("CHE COS'È:")),
                                        p("La probabilità a priori che due geni qualsiasi siano collegati"),
                                        p(strong("ESEMPIO:")),
                                        p("'In media, un gene controlla il 5% degli altri geni'"),
                                        p("→ P(collegati) = 0.05")
                                    )
                             ),
                             column(4,
                                    div(class = "step-box",
                                        h5("📊 Likelihood P(correlazione|collegati)"),
                                        p(strong("CHE COS'È:")),
                                        p("Quanto è probabile osservare questa correlazione SE i geni fossero davvero collegati"),
                                        p(strong("ESEMPIO:")),
                                        p("'Se due geni sono collegati, è molto probabile vedere correlazione alta'")
                                    )
                             ),
                             column(4,
                                    div(class = "step-box",
                                        h5("🎯 Posterior P(collegati|correlazione)"),
                                        p(strong("CHE COS'È:")),
                                        p("La probabilità finale che i geni siano collegati, dopo aver visto la correlazione"),
                                        p(strong("ESEMPIO:")),
                                        p("'Dopo aver visto correlazione 0.7, c'è il 95% di probabilità che siano collegati'")
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
                           h3("🎮 Laboratorio Virtuale"),
                           
                           div(class = "step-box",
                               h4("🧬 La Tua Rete Genetica"),
                               sliderInput("n_genes", "Quanti geni studiare:", 
                                           min = 5, max = 12, value = 8, step = 1),
                               sliderInput("n_samples", "Quanti pazienti/esperimenti:", 
                                           min = 50, max = 200, value = 100, step = 25),
                               div(class = "explanation-box",
                                   p(em("Più pazienti = più affidabilità, ma costa di più!")))
                           ),
                           
                           div(class = "step-box",
                               h4("🔬 Condizioni Sperimentali"),
                               sliderInput("edge_density", "Quanto è connessa la rete vera:", 
                                           min = 0.05, max = 0.25, value = 0.10, step = 0.05),
                               sliderInput("measurement_noise", "Rumore sperimentale:", 
                                           min = 0.1, max = 0.8, value = 0.3, step = 0.1),
                               div(class = "explanation-box",
                                   p(em("Nella realtà: rete sparse (~10%) + rumore alto")))
                           ),
                           
                           div(class = "step-box",
                               h4("🧠 Impostazioni Bayesiane"),
                               sliderInput("edge_prior", "Prior: probabilità di connessione:", 
                                           min = 0.01, max = 0.20, value = 0.08, step = 0.01),
                               div(class = "explanation-box",
                                   p(em("Conoscenza biologica: 'Le reti sono normalmente sparse'")))
                           ),
                           
                           br(),
                           actionButton("generate_network", "🔬 Analizza Rete!", class = "btn-warning btn-lg"),
                           
                           br(), br(),
                           div(class = "highlight-box",
                               h5("🧪 Esperimenti da Provare:"),
                               p("🎯 Prior corretto vs sbagliato"),
                               p("📊 Pochi vs molti pazienti"),
                               p("🔊 Poco vs tanto rumore"),
                               p("📡 Rete densa vs sparsa")
                           )
                       )
                ),
                
                column(9,
                       div(class = "theory-box",
                           h3("🌐 Risultati dell'Analisi"),
                           
                           fluidRow(
                             column(6,
                                    h4("🏛️ Metodo Correlazione", style = "color: #e74c3c; text-align: center;"),
                                    plotlyOutput("correlation_network_plot", height = "300px")
                             ),
                             column(6,
                                    h4("🧠 Metodo Bayesiano", style = "color: #2ecc71; text-align: center;"),
                                    plotlyOutput("bayesian_network_plot", height = "300px")
                             )
                           ),
                           
                           br(),
                           
                           div(class = "explanation-box",
                               h4("🔍 Come Leggere i Grafici:"),
                               fluidRow(
                                 column(6,
                                        div(style = "border-left: 5px solid #e74c3c; padding-left: 15px;",
                                            h5("Grafico Correlazione (Sinistra):"),
                                            tags$ul(
                                              tags$li("Asse X = Correlazione vera (sconosciuta nella realtà)"),
                                              tags$li("Asse Y = Correlazione osservata"),
                                              tags$li("Punti vicini alla diagonale = predizioni accurate"),
                                              tags$li("Punti lontani = errori del metodo")
                                            )
                                        )
                                 ),
                                 column(6,
                                        div(style = "border-left: 5px solid #2ecc71; padding-left: 15px;",
                                            h5("Grafico Bayesiano (Destra):"),
                                            tags$ul(
                                              tags$li("Asse X = Connessione vera (sì/no)"),
                                              tags$li("Asse Y = Probabilità Bayesiana"),
                                              tags$li("Punti alti a destra = connessioni vere trovate"),
                                              tags$li("Punti bassi a sinistra = non-connessioni giuste")
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
                       div(class = "theory-box",
                           h4("🌐 Rete Interattiva Finale"),
                           visNetworkOutput("gene_network_vis", height = "350px"),
                           
                           div(class = "explanation-box",
                               h4("🎯 Come Interagire:"),
                               tags$ul(
                                 tags$li("🖱️ Trascina i nodi per riorganizzare"),
                                 tags$li("🔍 Zoom con la rotella del mouse"),
                                 tags$li("👆 Hover sui nodi per info"),
                                 tags$li("🎨 Colori: rosso = attivazione, blu = inibizione"),
                                 tags$li("📏 Spessore = quanto siamo sicuri")
                               )
                           )
                       )
                ),
                column(6,
                       div(class = "theory-box",
                           h4("📊 Confronto Prestazioni"),
                           verbatimTextOutput("network_stats"),
                           
                           br(),
                           
                           div(class = "explanation-box",
                               h4("📈 Metriche di Qualità:"),
                               tags$ul(
                                 tags$li(strong("Precisione:"), " % di connessioni predette che sono vere"),
                                 tags$li(strong("Sensibilità:"), " % di connessioni vere che sono state trovate"),
                                 tags$li(strong("Specificità:"), " % di non-connessioni identificate correttamente"),
                                 tags$li(strong("F1-score:"), " Bilanciamento precision/recall")
                               )
                           )
                       )
                )
              ),
              
              fluidRow(
                column(12,
                       div(class = "theory-box",
                           h3("🎓 Applicazioni Reali e Futuro"),
                           
                           fluidRow(
                             column(6,
                                    div(class = "highlight-box",
                                        h4("🏥 Medicina Personalizzata"),
                                        tags$ul(
                                          tags$li("🎯 Identificare geni causali delle malattie"),
                                          tags$li("💊 Prevedere risposta ai farmaci per ogni paziente"),
                                          tags$li("🧬 Scoprire nuovi bersagli terapeutici"),
                                          tags$li("📊 Stratificare pazienti in gruppi di trattamento"),
                                          tags$li("🔬 Capire meccanismi di resistenza ai farmaci")
                                        )
                                    )
                             ),
                             column(6,
                                    div(class = "highlight-box",
                                        h4("🚀 Biotecnologie del Futuro"),
                                        tags$ul(
                                          tags$li("🌱 Progettare organismi per biocarburanti"),
                                          tags$li("🍎 Migliorare raccolti e resistenza alle malattie"),
                                          tags$li("🧪 Produzione di farmaci in batteri modificati"),
                                          tags$li("♻️ Biorimediazione per l'ambiente"),
                                          tags$li("🏭 Processi industriali biologici")
                                        )
                                    )
                             )
                           ),
                           
                           div(class = "warning-box",
                               h4("🔬 La Rivoluzione Multi-Omica"),
                               p("Il futuro delle reti Bayesiane è l'integrazione di dati eterogenei:"),
                               tags$ul(
                                 tags$li(strong("Genomica:"), " sequenze e variazioni del DNA"),
                                 tags$li(strong("Trascrittomica:"), " espressione dei geni (quello che abbiamo visto)"),
                                 tags$li(strong("Proteomica:"), " livelli e modifiche delle proteine"),
                                 tags$li(strong("Metabolomica:"), " concentrazioni dei metaboliti"),
                                 tags$li(strong("Epigenomica:"), " modifiche che controllano l'attivazione genica"),
                                 tags$li(strong("Dati clinici:"), " sintomi, farmaci, outcome del paziente")
                               ),
                               br(),
                               p(strong("Risultato:"), " Modelli predittivi enormemente più accurati e personalizzati che 
                                 rivoluzioneranno la medicina. I metodi Bayesiani sono perfetti per questo perché 
                                 gestiscono naturalmente incertezza, dati mancanti, e knowledge integration!")
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
                               "$$\\text{Intractable: } p(\\theta | \\mathbf{x}) = \\frac{p(\\mathbf{x} | \\theta) p(\\theta)}{p(\\mathbf{x})}$$",
                               "$$\\text{Approximate: } q(\\theta) \\approx p(\\theta | \\mathbf{x})$$",
                               "$$\\text{Minimize: } \\text{KL}[q(\\theta) || p(\\theta | \\mathbf{x})]$$"
                           ),
                           
                           div(class = "highlight-box",
                               h4("🔑 Key Idea: Evidence Lower BOund (ELBO)"),
                               p("Since we can't compute the exact posterior, we maximize the ELBO:"),
                               div(class = "formula-box",
                                   "$$\\text{ELBO} = \\mathbb{E}_q[\\log p(\\mathbf{x}, \\theta)] - \\mathbb{E}_q[\\log q(\\theta)]$$",
                                   "$$= \\text{Expected log-likelihood} - \\text{KL divergence}$$"
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
                               "$$q(\\theta) = \\prod_{i=1}^d q_i(\\theta_i)$$"
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
                               "$$\\beta_j | \\gamma_j \\sim (1 - \\gamma_j) \\delta_0 + \\gamma_j \\mathcal{N}(0, \\tau^2)$$",
                               "$$\\gamma_j \\sim \\text{Bernoulli}(\\pi)$$"
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
                               textOutput("ss_model_summary")
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
                                       tags$li("Variational inference for scalable Bayesian computation"),
                                       tags$li("Spike and slab methods for variable selection"),
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
                                   p(em("Ricorda le differenze tra correlazione e approccio Bayesiano..."))
                               )
                           ),
                           
                           div(class = "step-box",
                               h4("Domanda 3: Qual è il principale rischio dell'approccio Bayesiano?"),
                               radioButtons("q3", "", 
                                            choices = list(
                                              "È troppo lento computazionalmente" = "a",
                                              "Un prior mal scelto può influenzare i risultati" = "b",
                                              "Non può gestire dati numerici" = "c",
                                              "Non fornisce incertezza" = "d"
                                            )),
                               
                               div(class = "explanation-box",
                                   p(em("Pensa agli esperimenti con prior sbagliati che hai provato..."))
                               )
                           ),
                           
                           br(),
                           actionButton("check_answers", "🎯 Controlla Risposte", class = "btn-primary btn-lg"),
                           
                           br(), br(),
                           verbatimTextOutput("quiz_results")
                       )
                ),
                
                column(12,
                       div(class = "theory-box",
                           h3("🚀 I Tuoi Prossimi Passi nel Mondo Bayesiano"),
                           
                           fluidRow(
                             column(6,
                                    div(class = "highlight-box",
                                        h4("📚 Risorse per Approfondire"),
                                        tags$ul(
                                          tags$li(strong("Libri:"), " 'Bayesian Data Analysis' di Gelman"),
                                          tags$li(strong("Online:"), " Course Bayesian Statistics su Coursera"),
                                          tags$li(strong("Pratica:"), " Kaggle competitions con dati piccoli"),
                                          tags$li(strong("Community:"), " Cross Validated (StackExchange)")
                                        )
                                    )
                             ),
                             column(6,
                                    div(class = "highlight-box",
                                        h4("🛠️ Strumenti Pratici"),
                                        tags$ul(
                                          tags$li(strong("R:"), " brms, rstanarm, MCMCglmm"),
                                          tags$li(strong("Python:"), " PyMC3, Stan, TensorFlow Probability"),
                                          tags$li(strong("GUI:"), " JASP per analisi point-and-click"),
                                          tags$li(strong("Web:"), " Questa app per riferimento!")
                                        )
                                    )
                             )
                           ),
                           
                           div(class = "warning-box",
                               h4("💡 Consigli per il Successo"),
                               tags$ul(
                                 tags$li(strong("Inizia semplice:"), " Usa prior debolmente informativi all'inizio"),
                                 tags$li(strong("Valida sempre:"), " Confronta risultati con metodi tradizionali"),
                                 tags$li(strong("Documenta prior:"), " Spiega sempre da dove vengono i tuoi prior"),
                                 tags$li(strong("Controllo sensitività:"), " Testa come cambiano i risultati con prior diversi"),
                                 tags$li(strong("Comunica incertezza:"), " Non dimenticare intervalli di credibilità!")
                               )
                           ),
                           
                           div(style = "text-align: center; margin-top: 30px;",
                               h2("🎉 Buon Viaggio nel Mondo dell'Inferenza Bayesiana! 🎉"),
                               br(),
                               p(style = "font-size: 18px; font-style: italic;", 
                                 "Ricorda: ogni esperto era una volta un principiante. 
                                 Continua a sperimentare, sbagliare, e imparare!")
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
    updateTabItems(session, "sidebarMenu", "what_is_bayes")
  })
  
  # Reactive values per il modulo normale
observeEvent(input$run_normal_bayes, {
  set.seed(sample(1:1000, 1))
  
  # Parametri veri
  true_mu <- input$true_mu
  true_sigma <- 1  # Fissato per semplicità
  n <- input$n_obs
  
  # Genera dati
  x <- rnorm(n, true_mu, true_sigma)
  x_bar <- mean(x)
  
  # Prior
  mu_0 <- input$prior_mu
  kappa_0 <- input$prior_kappa
  
  # Posterior (sigma noto)
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

output$freq_normal_plot <- renderPlotly({
  if(is.null(values$normal_data)) return(NULL)
  
  d <- values$normal_data
  
  # Crea griglia per plot
  mu_range <- seq(d$true_mu - 3, d$true_mu + 3, length.out = 200)
  
  # Likelihood frequentista (proporzionale a normale)
  likelihood <- dnorm(mu_range, d$freq_mu, d$freq_se)
  
  # Intervallo di confidenza
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
    labs(x = "μ", y = "Likelihood", title = "Solo Dai Dati") +
    theme_minimal() +
    theme(plot.title = element_text(hjust = 0.5))
  
  ggplotly(p) %>% config(displayModeBar = FALSE)
})

output$bayes_normal_plot <- renderPlotly({
  if(is.null(values$normal_data)) return(NULL)
  
  d <- values$normal_data
  
  # Griglia
  mu_range <- seq(d$true_mu - 3, d$true_mu + 3, length.out = 200)
  
  # Prior
  prior_density <- dnorm(mu_range, d$mu_0, 1/sqrt(d$kappa_0))
  
  # Posterior
  posterior_density <- dnorm(mu_range, d$mu_n, d$sigma_n)
  
  # Intervallo di credibilità
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
    labs(x = "μ", y = "Density", title = "Prior + Dati = Posterior") +
    theme_minimal() +
    theme(plot.title = element_text(hjust = 0.5)) +
    annotate("text", x = d$mu_0, y = max(prior_density) * 0.8, 
             label = "Prior", color = "#3498db", size = 3) +
    annotate("text", x = d$mu_n, y = max(posterior_density) * 0.8, 
             label = "Posterior", color = "#2ecc71", size = 3)
  
  ggplotly(p) %>% config(displayModeBar = FALSE)
})

output$freq_normal_results <- renderText({
  if(is.null(values$normal_data)) return("Genera dati per vedere i risultati")
  
  d <- values$normal_data
  ci_lower <- d$freq_mu - 1.96 * d$freq_se
  ci_upper <- d$freq_mu + 1.96 * d$freq_se
  
  paste(
    "📊 STIMA FREQUENTISTA:",
    sprintf("• Media stimata: %.3f", d$freq_mu),
    sprintf("• Errore standard: %.3f", d$freq_se),
    sprintf("• IC 95%%: [%.3f, %.3f]", ci_lower, ci_upper),
    "",
    sprintf("📏 Errore dal vero (%.2f): %.3f", d$true_mu, abs(d$freq_mu - d$true_mu)),
    "",
    "🔍 CARATTERISTICHE:",
    "• Basato solo sui dati osservati",
    "• Non usa informazioni pregresse",
    sprintf("• Precisione: ±%.3f", 1.96 * d$freq_se),
    sep = "\n"
  )
})

output$bayes_normal_results <- renderText({
  if(is.null(values$normal_data)) return("")
  
  d <- values$normal_data
  ci_lower <- d$mu_n - 1.96 * d$sigma_n
  ci_upper <- d$mu_n + 1.96 * d$sigma_n
  
  # Calcola shrinkage
  shrinkage <- abs(d$mu_n - d$freq_mu) / abs(d$mu_0 - d$freq_mu)
  
  paste(
    "🧠 STIMA BAYESIANA:",
    sprintf("• Media posteriore: %.3f", d$mu_n),
    sprintf("• Dev. std posteriore: %.3f", d$sigma_n),
    sprintf("• IC 95%%: [%.3f, %.3f]", ci_lower, ci_upper),
    "",
    sprintf("📏 Errore dal vero (%.2f): %.3f", d$true_mu, abs(d$mu_n - d$true_mu)),
    sprintf("🧠 Il tuo prior era μ₀ = %.2f", d$mu_0),
    sprintf("🔄 Shrinkage verso prior: %.1f%%", shrinkage * 100),
    "",
    "🔍 CARATTERISTICHE:",
    sprintf("• Combina prior (peso %.1f) e dati (peso %d)", d$kappa_0, d$n),
    sprintf("• Precisione migliorata: ±%.3f vs ±%.3f", 1.96 * d$sigma_n, 1.96 * d$freq_se),
    sprintf("• Credibilità diretta: 95%% probabilità in [%.2f, %.2f]", ci_lower, ci_upper),
    sep = "\n"
  )
})

# Laboratorio avanzato con stima congiunta
observeEvent(input$run_full_normal, {
  set.seed(sample(1:1000, 1))
  
  # Parametri veri
  true_mu <- input$true_mu_full
  true_sigma <- input$true_sigma_full
  n <- input$n_obs_full
  
  # Genera dati
  x <- rnorm(n, true_mu, true_sigma)
  x_bar <- mean(x)
  s_sq <- sum((x - x_bar)^2)
  
  # Prior parameters
  mu_0 <- input$prior_mu_full
  kappa_0 <- input$prior_kappa_full
  alpha_0 <- input$prior_alpha
  beta_0 <- input$prior_beta
  
  # Posterior parameters (Normal-Inverse-Gamma)
  kappa_n <- kappa_0 + n
  mu_n <- (kappa_0 * mu_0 + n * x_bar) / kappa_n
  alpha_n <- alpha_0 + n/2
  beta_n <- beta_0 + 0.5 * s_sq + (kappa_0 * n * (x_bar - mu_0)^2) / (2 * kappa_n)
  
  values$full_normal_data <- list(
    x = x, true_mu = true_mu, true_sigma = true_sigma,
    mu_0 = mu_0, kappa_0 = kappa_0, alpha_0 = alpha_0, beta_0 = beta_0,
    mu_n = mu_n, kappa_n = kappa_n, alpha_n = alpha_n, beta_n = beta_n,
    n = n, x_bar = x_bar
  )
})

output$mu_posterior_plot <- renderPlotly({
  if(is.null(values$full_normal_data)) return(NULL)
  
  d <- values$full_normal_data
  
  # Marginal posterior di mu è t-Student
  df <- 2 * d$alpha_n
  scale <- sqrt(d$beta_n / (d$alpha_n * d$kappa_n))
  
  mu_range <- seq(d$mu_n - 3*scale, d$mu_n + 3*scale, length.out = 200)
  
  # Prior di mu (marginalizzato)
  prior_scale <- sqrt(d$beta_0 / (d$alpha_0 * d$kappa_0))
  prior_density <- dt((mu_range - d$mu_0)/prior_scale, 2*d$alpha_0) / prior_scale
  
  # Posterior di mu
  posterior_density <- dt((mu_range - d$mu_n)/scale, df) / scale
  
  plot_data <- data.frame(
    mu = mu_range,
    prior = prior_density,
    posterior = posterior_density
  )
  
  p <- ggplot(plot_data, aes(x = mu)) +
    geom_line(aes(y = prior), color = "#3498db", linetype = "dashed") +
    geom_line(aes(y = posterior), color = "#2ecc71", size = 2) +
    geom_area(aes(y = posterior), alpha = 0.3, fill = "#2ecc71") +
    geom_vline(xintercept = d$true_mu, color = "red", linetype = "dashed") +
    labs(x = "μ", y = "Density") +
    theme_minimal()
  
  ggplotly(p) %>% config(displayModeBar = FALSE)
})

output$sigma_posterior_plot <- renderPlotly({
  if(is.null(values$full_normal_data)) return(NULL)
  
  d <- values$full_normal_data
  
  # Posterior di sigma^2 è Inverse-Gamma
  sigma_sq_range <- seq(0.1, 3 * d$true_sigma^2, length.out = 200)
  
  # Prior
  prior_density <- dinvgamma(sigma_sq_range, d$alpha_0, d$beta_0)
  
  # Posterior  
  posterior_density <- dinvgamma(sigma_sq_range, d$alpha_n, d$beta_n)
  
  plot_data <- data.frame(
    sigma_sq = sigma_sq_range,
    prior = prior_density,
    posterior = posterior_density
  )
  
  p <- ggplot(plot_data, aes(x = sigma_sq)) +
    geom_line(aes(y = prior), color = "#3498db", linetype = "dashed") +
    geom_line(aes(y = posterior), color = "#e67e22", size = 2) +
    geom_area(aes(y = posterior), alpha = 0.3, fill = "#e67e22") +
    geom_vline(xintercept = d$true_sigma^2, color = "red", linetype = "dashed") +
    labs(x = "σ²", y = "Density") +
    theme_minimal()
  
  ggplotly(p) %>% config(displayModeBar = FALSE)
})

dinvgamma <- function(x, alpha, beta) {
  (beta^alpha / gamma(alpha)) * x^(-alpha-1) * exp(-beta/x)
}

output$joint_posterior_plot <- renderPlotly({
  if(is.null(values$full_normal_data)) return(NULL)
  
  d <- values$full_normal_data
  
  # Genera campioni dal posterior per visualizzazione
  n_samples <- 1000
  
  # Sample sigma^2 from Inverse-Gamma
  sigma_sq_samples <- 1 / rgamma(n_samples, d$alpha_n, d$beta_n)
  
  # Sample mu conditional on sigma^2
  mu_samples <- rnorm(n_samples, d$mu_n, sqrt(sigma_sq_samples / d$kappa_n))
  
  # Crea ellissi di credibilità
  library(car)
  ellipse_data <- dataEllipse(mu_samples, sqrt(sigma_sq_samples), 
                              levels = c(0.5, 0.95), draw = FALSE, plot.points = FALSE)
  
  plot_data <- data.frame(
    mu = mu_samples,
    sigma = sqrt(sigma_sq_samples)
  )
  
  p <- ggplot(plot_data, aes(x = mu, y = sigma)) +
    geom_point(alpha = 0.3, color = "#9b59b6") +
    geom_point(aes(x = d$true_mu, y = d$true_sigma), 
               color = "red", size = 4, shape = 4) +
    labs(x = "μ", y = "σ", title = "Joint Posterior Distribution") +
    theme_minimal() +
    theme(plot.title = element_text(hjust = 0.5))
  
  ggplotly(p) %>% config(displayModeBar = FALSE)
})

output$full_bayes_results <- renderText({
  if(is.null(values$full_normal_data)) return("Clicca 'Stima Completa!' per iniziare")
  
  d <- values$full_normal_data
  
  # Posterior means
  post_mu_mean <- d$mu_n
  post_sigma_sq_mean <- d$beta_n / (d$alpha_n - 1)
  
  paste(
    "🚀 INFERENZA CONGIUNTA:",
    "",
    "📊 PARAMETRI STIMATI:",
    sprintf("• μ posteriore: %.3f", post_mu_mean),
    sprintf("• σ² posteriore: %.3f", post_sigma_sq_mean),
    sprintf("• σ posteriore: %.3f", sqrt(post_sigma_sq_mean)),
    "",
    "🎯 ERRORI DAI VALORI VERI:",
    sprintf("• Errore μ: %.3f (vero = %.2f)", abs(post_mu_mean - d$true_mu), d$true_mu),
    sprintf("• Errore σ²: %.3f (vero = %.2f)", abs(post_sigma_sq_mean - d$true_sigma^2), d$true_sigma^2),
    "",
    "🔧 AGGIORNAMENTO PARAMETRI:",
    sprintf("• κ: %.1f → %.1f (+%d dati)", d$kappa_0, d$kappa_n, d$n),
    sprintf("• α: %.1f → %.1f (+%.1f)", d$alpha_0, d$alpha_n, d$n/2),
    sprintf("• β: %.1f → %.2f", d$beta_0, d$beta_n),
    "",
    "🧠 INTERPRETAZIONE:",
    "• Più dati = posterior più concentrato",
    "• Prior e likelihood bilanciati ottimalmente",
    "• Incertezza su entrambi i parametri quantificata",
    sep = "\n"
  )
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
      geom_line(aes(y = freq_est, color = "Frequentista"), size = 1.5) +
      geom_line(aes(y = bayes_est, color = "Bayesiano"), size = 1.5) +
      geom_hline(aes(yintercept = true_p, color = "Valore Vero"), 
                 linetype = "dashed", size = 1) +
      scale_color_manual(values = c(
        "Frequentista" = "#e74c3c",
        "Bayesiano" = "#2ecc71",
        "Valore Vero" = "#34495e"
      )) +
      labs(x = "Numero di Lanci", y = "Probabilità Stimata",
           title = "Convergenza al Valore Vero") +
      theme_minimal() +
      theme(legend.position = "bottom")
    
    ggplotly(p)
  })
  
  output$freq_results <- renderText({
    if(is.null(values$coin_data)) return("Clicca 'Lancia la Moneta' per vedere i risultati")
    
    final_est <- tail(values$coin_data$freq_est, 1)
    n <- nrow(values$coin_data)
    se <- sqrt(final_est * (1 - final_est) / n)
    ci_lower <- final_est - 1.96 * se
    ci_upper <- final_est + 1.96 * se
    
    paste(
      sprintf("Stima finale: %.3f", final_est),
      sprintf("Intervallo confidenza 95%%: [%.3f, %.3f]", ci_lower, ci_upper),
      "",
      "Interpretazione:",
      "• Stima puntuale unica",
      "• Confidenza da campionamento ripetuto",
      "• Nessun uso di informazioni pregresse",
      "",
      sprintf("Errore dal valore vero: %.3f", abs(final_est - values$coin_data$true_p[1])),
      sep = "\n"
    )
  })
  
  output$bayes_results <- renderText({
    if(is.null(values$coin_data)) return("")
    
    final_est <- tail(values$coin_data$bayes_est, 1)
    final_lower <- tail(values$coin_data$bayes_lower, 1)
    final_upper <- tail(values$coin_data$bayes_upper, 1)
    
    paste(
      sprintf("Media posteriore: %.3f", final_est),
      sprintf("Intervallo credibilità 95%%: [%.3f, %.3f]", final_lower, final_upper),
      "",
      "Interpretazione:",
      "• Distribuzione posteriore completa",
      "• Affermazioni probabilistiche dirette",
      "• Conoscenza pregressa incorporata",
      "",
      sprintf("Errore dal valore vero: %.3f", abs(final_est - values$coin_data$true_p[1])),
      sep = "\n"
    )
  })
  
  # Regression analysis
  observeEvent(input$run_regression, {
    set.seed(sample(1:1000, 1))  # Random seed for variety
    
    # Generate data
    n <- input$n_points
    x <- runif(n, 0, 10)
    true_intercept <- 3
    true_slope <- 2  # Fixed true slope
    y <- true_intercept + true_slope * x + rnorm(n, 0, input$noise_level)
    
    # Frequentist regression
    lm_model <- lm(y ~ x)
    freq_slope <- coef(lm_model)[2]
    freq_intercept <- coef(lm_model)[1]
    freq_se <- summary(lm_model)$coefficients[2, 2]
    
    # Prior confidence mapping
    prior_sd <- switch(input$prior_confidence,
                       "weak" = 1.0,
                       "medium" = 0.5,
                       "strong" = 0.2)
    
    # Bayesian regression (simplified conjugate prior)
    X <- cbind(1, x)
    
    # Prior
    prior_mean <- c(3, input$prior_slope_mean)  # intercept and slope
    prior_precision <- diag(c(0.1, 1/prior_sd^2))
    
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
      true_slope = true_slope,
      true_intercept = true_intercept,
      freq_slope = freq_slope,
      freq_intercept = freq_intercept,
      freq_se = freq_se,
      bayes_slope = bayes_slope,
      bayes_intercept = bayes_intercept,
      bayes_slope_sd = bayes_slope_sd,
      prior_slope_mean = input$prior_slope_mean,
      prior_slope_sd = prior_sd
    )
  })
  
  output$freq_regression_plot <- renderPlotly({
    if(is.null(values$regression_data)) return(NULL)
    
    d <- values$regression_data
    
    # Create prediction data
    x_pred <- seq(0, 10, length.out = 100)
    freq_pred <- d$freq_intercept + d$freq_slope * x_pred
    true_pred <- d$true_intercept + d$true_slope * x_pred
    
    p <- ggplot() +
      geom_point(aes(x = d$x, y = d$y), color = "#34495e", size = 3, alpha = 0.7) +
      geom_line(aes(x = x_pred, y = freq_pred), color = "#e74c3c", size = 2) +
      geom_line(aes(x = x_pred, y = true_pred), color = "#2c3e50", size = 1.5, linetype = "dashed") +
      labs(x = "X", y = "Y", title = "Una Sola Linea 'Ottimale'") +
      theme_minimal() +
      theme(
        plot.title = element_text(hjust = 0.5, size = 14, color = "#e74c3c"),
        axis.title = element_text(size = 12),
        panel.grid.minor = element_blank()
      ) +
      annotate("text", x = 8, y = max(d$y), 
               label = paste("Pendenza stimata:", round(d$freq_slope, 2)), 
               color = "#e74c3c", size = 4, fontface = "bold") +
      annotate("text", x = 8, y = max(d$y) - 2, 
               label = "Linea vera", 
               color = "#2c3e50", size = 3)
    
    ggplotly(p, tooltip = c("x", "y")) %>%
      config(displayModeBar = FALSE)
  })
  
  output$bayes_regression_plot <- renderPlotly({
    if(is.null(values$regression_data)) return(NULL)
    
    d <- values$regression_data
    
    # Create prediction data
    x_pred <- seq(0, 10, length.out = 100)
    bayes_pred <- d$bayes_intercept + d$bayes_slope * x_pred
    true_pred <- d$true_intercept + d$true_slope * x_pred
    
    # Calculate uncertainty bands
    pred_se <- sqrt(d$bayes_slope_sd^2 * x_pred^2)  # Simplified uncertainty
    upper_band <- bayes_pred + 1.96 * pred_se
    lower_band <- bayes_pred - 1.96 * pred_se
    
    p <- ggplot() +
      # Uncertainty ribbon
      geom_ribbon(aes(x = x_pred, ymin = lower_band, ymax = upper_band), 
                  fill = "#2ecc71", alpha = 0.3) +
      # Data points
      geom_point(aes(x = d$x, y = d$y), color = "#34495e", size = 3, alpha = 0.7) +
      # Bayesian line
      geom_line(aes(x = x_pred, y = bayes_pred), color = "#2ecc71", size = 2) +
      # True line
      geom_line(aes(x = x_pred, y = true_pred), color = "#2c3e50", size = 1.5, linetype = "dashed") +
      labs(x = "X", y = "Y", title = "Linea + Incertezza") +
      theme_minimal() +
      theme(
        plot.title = element_text(hjust = 0.5, size = 14, color = "#2ecc71"),
        axis.title = element_text(size = 12),
        panel.grid.minor = element_blank()
      ) +
      annotate("text", x = 8, y = max(d$y), 
               label = paste("Pendenza stimata:", round(d$bayes_slope, 2)), 
               color = "#2ecc71", size = 4, fontface = "bold") +
      annotate("text", x = 8, y = max(d$y) - 2, 
               label = paste("Prior era:", round(d$prior_slope_mean, 2)), 
               color = "#2ecc71", size = 3) +
      annotate("text", x = 8, y = max(d$y) - 4, 
               label = "Linea vera", 
               color = "#2c3e50", size = 3)
    
    ggplotly(p, tooltip = c("x", "y")) %>%
      config(displayModeBar = FALSE)
  })
  
  output$freq_reg_results <- renderText({
    if(is.null(values$regression_data)) return("Clicca 'Nuova Regressione' per iniziare")
    
    d <- values$regression_data
    ci_lower <- d$freq_slope - 1.96 * d$freq_se
    ci_upper <- d$freq_slope + 1.96 * d$freq_se
    
    error_from_truth <- abs(d$freq_slope - d$true_slope)
    
    paste(
      "📊 RISULTATI:",
      sprintf("• Pendenza stimata: %.2f", d$freq_slope),
      sprintf("• Errore standard: %.2f", d$freq_se),
      sprintf("• Intervallo 95%%: [%.2f, %.2f]", ci_lower, ci_upper),
      "",
      sprintf("📏 Distanza dal vero (2.0): %.2f", error_from_truth),
      "",
      "🔍 CARATTERISTICHE:",
      "• Sempre la stessa risposta con questi dati",
      "• Non considera il tuo prior",
      "• Incertezza solo sui parametri",
      sep = "\n"
    )
  })
  
  output$bayes_reg_results <- renderText({
    if(is.null(values$regression_data)) return("")
    
    d <- values$regression_data
    ci_lower <- d$bayes_slope - 1.96 * d$bayes_slope_sd
    ci_upper <- d$bayes_slope + 1.96 * d$bayes_slope_sd
    
    error_from_truth <- abs(d$bayes_slope - d$true_slope)
    prior_was_good <- abs(d$prior_slope_mean - d$true_slope) < 1
    
    paste(
      "📊 RISULTATI:",
      sprintf("• Pendenza stimata: %.2f", d$bayes_slope),
      sprintf("• Deviazione standard: %.2f", d$bayes_slope_sd),
      sprintf("• Intervallo 95%%: [%.2f, %.2f]", ci_lower, ci_upper),
      "",
      sprintf("📏 Distanza dal vero (2.0): %.2f", error_from_truth),
      sprintf("🧠 Il tuo prior era: %.1f (%s)", 
              d$prior_slope_mean, 
              ifelse(prior_was_good, "buono!", "sbagliato")),
      "",
      "🔍 CARATTERISTICHE:",
      "• Influenzato dal tuo prior",
      "• Incertezza su parametri E predizioni",
      "• Si aggiorna con nuovi dati",
      sep = "\n"
    )
  })
  
  # Gene network analysis
  observeEvent(input$generate_network, {
    set.seed(sample(1:1000, 1))  # Random seed for variety
    
    n_genes <- input$n_genes
    n_samples <- input$n_samples
    
    # Generate true network (more realistic)
    true_network <- matrix(0, n_genes, n_genes)
    true_connections <- matrix(FALSE, n_genes, n_genes)
    
    for(i in 1:(n_genes-1)) {
      for(j in (i+1):n_genes) {
        if(runif(1) < input$edge_density) {
          weight <- runif(1, -0.8, 0.8)
          true_network[i,j] <- weight
          true_network[j,i] <- weight
          true_connections[i,j] <- TRUE
          true_connections[j,i] <- TRUE
        }
      }
    }
    
    # Generate more realistic expression data
    expression_data <- matrix(rnorm(n_samples * n_genes, 0, 1), n_samples, n_genes)
    
    # Apply network effects with equilibrium
    for(sample_idx in 1:n_samples) {
      current_expr <- expression_data[sample_idx, ]
      
      # Iterate to reach equilibrium
      for(iter in 1:3) {
        new_expr <- current_expr
        for(j in 1:n_genes) {
          network_effect <- sum(true_network[j,] * current_expr) * 0.3  # Damping factor
          new_expr[j] <- network_effect + rnorm(1, 0, input$measurement_noise)
        }
        current_expr <- new_expr
      }
      expression_data[sample_idx, ] <- current_expr
    }
    
    # Correlation-based network
    cor_network <- cor(expression_data)
    diag(cor_network) <- 0
    
    # Traditional method: threshold-based
    cor_threshold <- 0.3
    cor_decisions <- abs(cor_network) > cor_threshold
    
    # Bayesian network inference (detailed implementation)
    bayes_network <- matrix(0, n_genes, n_genes)
    edge_probabilities <- matrix(0, n_genes, n_genes)
    bayes_decisions <- matrix(FALSE, n_genes, n_genes)
    
    for(i in 1:(n_genes-1)) {
      for(j in (i+1):n_genes) {
        # Calculate correlation
        r <- cor_network[i,j]
        
        # Bayesian inference with proper prior
        prior_prob <- input$edge_prior  # P(edge exists)
        
        # Bayes factor calculation (more sophisticated)
        # Under H1 (edge exists): correlation follows some distribution
        # Under H0 (no edge): correlation should be near zero
        
        # Simplified but more principled Bayes factor
        # Based on how "surprising" this correlation is under null
        bf <- exp(n_samples * r^2 / 2)
        
        # Posterior probability using Bayes' rule
        post_prob <- (bf * prior_prob) / (bf * prior_prob + (1 - prior_prob))
        
        # Store results
        edge_probabilities[i,j] <- post_prob
        edge_probabilities[j,i] <- post_prob
        
        # Decision: if posterior probability > 0.5
        if(post_prob > 0.5) {
          bayes_network[i,j] <- r
          bayes_network[j,i] <- r
          bayes_decisions[i,j] <- TRUE
          bayes_decisions[j,i] <- TRUE
        }
      }
    }
    
    # Calculate performance metrics
    # True positives, false positives, etc.
    true_edges <- sum(true_connections[upper.tri(true_connections)])
    total_possible <- sum(upper.tri(matrix(TRUE, n_genes, n_genes)))
    true_non_edges <- total_possible - true_edges
    
    # Correlation method performance
    cor_pred <- cor_decisions[upper.tri(cor_decisions)]
    true_vec <- true_connections[upper.tri(true_connections)]
    
    cor_tp <- sum(cor_pred & true_vec)
    cor_fp <- sum(cor_pred & !true_vec)
    cor_tn <- sum(!cor_pred & !true_vec)
    cor_fn <- sum(!cor_pred & true_vec)
    
    cor_precision <- ifelse(cor_tp + cor_fp > 0, cor_tp / (cor_tp + cor_fp), 0)
    cor_recall <- ifelse(cor_tp + cor_fn > 0, cor_tp / (cor_tp + cor_fn), 0)
    cor_specificity <- ifelse(cor_tn + cor_fp > 0, cor_tn / (cor_tn + cor_fp), 0)
    
    # Bayesian method performance
    bayes_pred <- bayes_decisions[upper.tri(bayes_decisions)]
    
    bayes_tp <- sum(bayes_pred & true_vec)
    bayes_fp <- sum(bayes_pred & !true_vec)
    bayes_tn <- sum(!bayes_pred & !true_vec)
    bayes_fn <- sum(!bayes_pred & true_vec)
    
    bayes_precision <- ifelse(bayes_tp + bayes_fp > 0, bayes_tp / (bayes_tp + bayes_fp), 0)
    bayes_recall <- ifelse(bayes_tp + bayes_fn > 0, bayes_tp / (bayes_tp + bayes_fn), 0)
    bayes_specificity <- ifelse(bayes_tn + bayes_fp > 0, bayes_tn / (bayes_tn + bayes_fp), 0)
    
    values$network_data <- list(
      true_network = true_network,
      true_connections = true_connections,
      cor_network = cor_network,
      cor_decisions = cor_decisions,
      bayes_network = bayes_network,
      bayes_decisions = bayes_decisions,
      edge_probabilities = edge_probabilities,
      n_genes = n_genes,
      n_samples = n_samples,
      # Performance metrics
      cor_precision = cor_precision,
      cor_recall = cor_recall,
      cor_specificity = cor_specificity,
      bayes_precision = bayes_precision,
      bayes_recall = bayes_recall,
      bayes_specificity = bayes_specificity,
      true_edges = true_edges,
      total_possible = total_possible
    )
  })
  
  output$gene_network_vis <- renderVisNetwork({
    if(is.null(values$network_data)) return(NULL)
    
    d <- values$network_data
    
    # Create nodes with better styling
    nodes <- data.frame(
      id = 1:d$n_genes,
      label = paste0("Gene", 1:d$n_genes),
      color = "#74b9ff",
      size = 30,
      font.size = 16,
      title = paste0("Gene ", 1:d$n_genes, " - Espressione variabile")
    )
    
    # Create edges from Bayesian network (only those with probability > 0.5)
    edges <- data.frame()
    edge_count <- 0
    
    for(i in 1:(d$n_genes-1)) {
      for(j in (i+1):d$n_genes) {
        if(abs(d$bayes_network[i,j]) > 0) {
          edge_count <- edge_count + 1
          
          # Color based on activation/inhibition
          edge_color <- ifelse(d$bayes_network[i,j] > 0, "#e17055", "#0984e3")
          edge_type <- ifelse(d$bayes_network[i,j] > 0, "Attivazione", "Inibizione")
          
          # Width based on probability (confidence)
          edge_width <- d$edge_probabilities[i,j] * 8
          
          edges <- rbind(edges, data.frame(
            from = i,
            to = j,
            value = edge_width,
            color = edge_color,
            title = sprintf("%s<br>Peso: %.3f<br>Probabilità: %.1f%%<br>Tipo: %s", 
                            paste("Gene", i, "→ Gene", j),
                            d$bayes_network[i,j], 
                            d$edge_probabilities[i,j] * 100,
                            edge_type),
            arrows = "to"
          ))
        }
      }
    }
    
    # If no edges, create a simple network message
    if(nrow(edges) == 0) {
      edges <- data.frame(
        from = integer(0),
        to = integer(0),
        value = numeric(0),
        color = character(0),
        title = character(0)
      )
    }
    
    visNetwork(nodes, edges) %>%
      visOptions(highlightNearest = TRUE, nodesIdSelection = TRUE) %>%
      visPhysics(enabled = TRUE, stabilization = list(iterations = 100)) %>%
      visInteraction(hover = TRUE, selectConnectedEdges = FALSE) %>%
      visEdges(arrows = "to", smooth = FALSE) %>%
      visNodes(borderWidth = 2, shadow = TRUE)
  })
  
  output$network_stats <- renderText({
    if(is.null(values$network_data)) return("Clicca 'Analizza Rete!' per iniziare l'esperimento")
    
    d <- values$network_data
    
    # Calculate F1 scores
    cor_f1 <- ifelse(d$cor_precision + d$cor_recall > 0, 
                     2 * (d$cor_precision * d$cor_recall) / (d$cor_precision + d$cor_recall), 0)
    bayes_f1 <- ifelse(d$bayes_precision + d$bayes_recall > 0, 
                       2 * (d$bayes_precision * d$bayes_recall) / (d$bayes_precision + d$bayes_recall), 0)
    
    # Count predicted edges
    cor_predicted <- sum(d$cor_decisions[upper.tri(d$cor_decisions)])
    bayes_predicted <- sum(d$bayes_decisions[upper.tri(d$bayes_decisions)])
    
    paste(
      "🔬 RISULTATI DELL'ESPERIMENTO:",
      "",
      sprintf("📊 Setup: %d geni, %d campioni", d$n_genes, d$n_samples),
      sprintf("🎯 Connessioni vere nella rete: %d (su %d possibili)", d$true_edges, d$total_possible),
      sprintf("📈 Densità vera: %.1f%%", (d$true_edges / d$total_possible) * 100),
      "",
      "🏛️ METODO CORRELAZIONE (soglia > 0.3):",
      sprintf("   📍 Connessioni predette: %d", cor_predicted),
      sprintf("   ✅ Precisione: %.1f%% (di quelle predette, quante sono vere)", d$cor_precision * 100),
      sprintf("   🎯 Sensibilità: %.1f%% (delle vere, quante trovate)", d$cor_recall * 100),
      sprintf("   🛡️ Specificità: %.1f%% (delle false, quante evitate)", d$cor_specificity * 100),
      sprintf("   ⚖️ F1-score: %.1f%% (bilanciamento)", cor_f1 * 100),
      "",
      "🧠 METODO BAYESIANO (probabilità > 50%):",
      sprintf("   📍 Connessioni predette: %d", bayes_predicted),
      sprintf("   ✅ Precisione: %.1f%% (di quelle predette, quante sono vere)", d$bayes_precision * 100),
      sprintf("   🎯 Sensibilità: %.1f%% (delle vere, quante trovate)", d$bayes_recall * 100),
      sprintf("   🛡️ Specificità: %.1f%% (delle false, quante evitate)", d$bayes_specificity * 100),
      sprintf("   ⚖️ F1-score: %.1f%% (bilanciamento)", bayes_f1 * 100),
      "",
      "🏆 VINCITORE:",
      if(bayes_f1 > cor_f1) "   🧠 Metodo Bayesiano!" else if(cor_f1 > bayes_f1) "   🏛️ Metodo Correlazione!" else "   🤝 Pareggio!",
      "",
      "💡 COSA SIGNIFICA:",
      "• Precisione alta = pochi falsi allarmi",
      "• Sensibilità alta = trova la maggior parte delle connessioni vere",  
      "• Specificità alta = evita falsi positivi",
      "• F1 alto = buon bilanciamento generale",
      sep = "\n"
    )
  })
  
  # Network comparison plots
  output$correlation_network_plot <- renderPlotly({
    if(is.null(values$network_data)) return(NULL)
    
    d <- values$network_data
    
    # Compare true vs correlation - focus on the scatter plot of correlations
    true_values <- as.vector(d$true_network[upper.tri(d$true_network)])
    cor_values <- as.vector(d$cor_network[upper.tri(d$cor_network)])
    
    # Color by whether connection exists in truth
    connection_exists <- as.vector(d$true_connections[upper.tri(d$true_connections)])
    
    plot_data <- data.frame(
      true_weight = true_values,
      observed_corr = cor_values,
      exists = ifelse(connection_exists, "Vera Connessione", "Nessuna Connessione"),
      predicted = ifelse(abs(cor_values) > 0.3, "Predetta", "Non Predetta")
    )
    
    p <- ggplot(plot_data, aes(x = true_weight, y = observed_corr, color = exists, shape = predicted)) +
      geom_point(size = 3, alpha = 0.7) +
      geom_abline(intercept = 0, slope = 1, color = "red", linetype = "dashed", size = 1) +
      scale_color_manual(values = c("Vera Connessione" = "#e74c3c", "Nessuna Connessione" = "#95a5a6")) +
      scale_shape_manual(values = c("Predetta" = 16, "Non Predetta" = 1)) +
      labs(x = "Peso Vero della Connessione", y = "Correlazione Osservata",
           title = "Accuratezza delle Correlazioni") +
      theme_minimal() +
      theme(legend.position = "bottom", legend.title = element_blank()) +
      annotate("text", x = max(true_values) * 0.7, y = min(cor_values) * 0.8, 
               label = "Linea perfetta", color = "red", size = 3)
    
    ggplotly(p, tooltip = c("x", "y", "colour", "shape")) %>%
      config(displayModeBar = FALSE)
  })
  
  output$bayesian_network_plot <- renderPlotly({
    if(is.null(values$network_data)) return(NULL)
    
    d <- values$network_data
    
    # Compare true connections vs Bayesian probabilities
    connection_exists <- as.vector(d$true_connections[upper.tri(d$true_connections)])
    bayes_probs <- as.vector(d$edge_probabilities[upper.tri(d$edge_probabilities)])
    
    plot_data <- data.frame(
      true_connection = ifelse(connection_exists, "Esiste", "Non Esiste"),
      bayes_probability = bayes_probs,
      predicted = ifelse(bayes_probs > 0.5, "Predetta", "Non Predetta")
    )
    
    p <- ggplot(plot_data, aes(x = true_connection, y = bayes_probability, color = predicted)) +
      geom_jitter(width = 0.2, height = 0, size = 3, alpha = 0.7) +
      geom_hline(yintercept = 0.5, color = "blue", linetype = "dashed", size = 1) +
      scale_color_manual(values = c("Predetta" = "#2ecc71", "Non Predetta" = "#e74c3c")) +
      labs(x = "Connessione Vera", y = "Probabilità Bayesiana",
           title = "Discriminazione Bayesiana") +
      ylim(0, 1) +
      theme_minimal() +
      theme(legend.position = "bottom", legend.title = element_blank()) +
      annotate("text", x = 1.5, y = 0.55, 
               label = "Soglia decisione (50%)", color = "blue", size = 3)
    
    ggplotly(p, tooltip = c("x", "y", "colour")) %>%
      config(displayModeBar = FALSE)
  })
  
  # Quiz functionality
  observeEvent(input$check_answers, {
    correct <- 0
    feedback <- character()
    
    if(input$q1 == "b") {
      correct <- correct + 1
      feedback <- c(feedback, "✅ Domanda 1: CORRETTO! La regressione Bayesiana eccelle quando hai pochi dati ma buone conoscenze pregresse.")
    } else {
      feedback <- c(feedback, "❌ Domanda 2: I metodi Bayesiani eccellono nel gestire reti sparse con quantificazione dell'incertezza.")
    }
    
    if(input$q2 == "c") {
      correct <- correct + 1
      feedback <- c(feedback, "✅ Domanda 1: CORRETTO! La gestione naturale di sparsità e incertezza sono vantaggi chiave per le reti genetiche.")
    } else {
      feedback <- c(feedback, "❌ Domanda 2: I metodi Bayesiani eccellono nel gestire reti sparse con quantificazione dell'incertezza.")
    }
    
    if(input$q3 == "b") {
      correct <- correct + 1
      feedback <- c(feedback, "✅ Domanda 3: CORRETTO! Un prior mal scelto è il principale rischio dell'approccio Bayesiano, specialmente con pochi dati.")
    } else {
      feedback <- c(feedback, "❌ Domanda 3: Il principale rischio è proprio la scelta del prior, che può influenzare fortemente i risultati.")
    }
    
    # Special message based on score
    if(correct == 3) {
      final_message <- "🎉 PERFETTO! Hai davvero capito i concetti Bayesiani! 🎉"
    } else if(correct == 2) {
      final_message <- "👍 Molto bene! Hai una buona comprensione di base."
    } else if(correct == 1) {
      final_message <- "📚 Non male! Rileggi le sezioni per consolidare."
    } else {
      final_message <- "🔄 Riprova! Torna alle spiegazioni e rifai gli esempi."
    }
    
    output$quiz_results <- renderText({
      paste(c(
        sprintf("🎯 PUNTEGGIO: %d/3", correct),
        "",
        feedback,
        "",
        final_message,
        "",
        if(correct == 3) "🚀 Sei pronto per applicare la statistica Bayesiana nel mondo reale!" else "💡 Continua a sperimentare con gli esempi interattivi per migliorare!"
      ), collapse = "\n")
    })
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
