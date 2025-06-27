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
  dashboardHeader(title = "🧠 BayesQuest: Missione introduttiva alla Statistica Bayesiana"),
  
  dashboardSidebar(
    useShinyjs(),
    sidebarMenu(
      menuItem("🏠 Introduzione", tabName = "intro", icon = icon("home")),
      menuItem("🎯 Cos'è la Statistica Bayesiana?", tabName = "what_is_bayes", icon = icon("question-circle")),
      menuItem("📊 Teorema di Bayes", tabName = "foundations", icon = icon("brain")),
      menuItem("🪙 Esempio Pratico: Moneta", tabName = "coin_example", icon = icon("coins")),
      menuItem("📈 Regressione Bayesiana", tabName = "regression", icon = icon("chart-line")),
      menuItem("🧬 Reti Genetiche", tabName = "networks", icon = icon("dna")),
      menuItem("🎓 Riepilogo & Quiz", tabName = "summary", icon = icon("graduation-cap"))
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
                           h1("🧠 Benvenuto in BayesQuest!", style = "text-align: center;"),
                           h3("Inizia la tua missione alla scoperta della Statistica Bayesiana", style = "text-align: center;"),
                           br(),
                           
                           div(style = "background: rgba(255,255,255,0.2); padding: 20px; border-radius: 10px;",
                               h3("🎯 Cosa Imparerai:"),
                               tags$ol(style = "font-size: 18px;",
                                       tags$li("Cos'è la statistica Bayesiana e perché è importante"),
                                       tags$li("Come funziona il teorema di Bayes"),
                                       tags$li("Differenze tra approccio Frequentista e Bayesiano"),
                                       tags$li("Applicazioni alle regressioni"),
                                       tags$li("Applicazioni alle reti genetiche"),
                                       tags$li("Quando usare ogni metodo")
                               ),
                               
                               br(),
                               div(class = "highlight-box",
                                   h4("📚 Prerequisiti: NESSUNO!"),
                                   p("Questa app è pensata per VERI principianti")
                               )
                           ),
                           
                           br(),
                           div(style = "text-align: center;",
                               actionButton("start_journey", "🚀 Inizia il Viaggio", 
                                            style = "font-size: 20px; padding: 15px 40px; background: white; color: #667eea;")
                           )
                       )
                ),
                
                column(12,
                       div(class = "theory-box",
                           h3("📊 Due Modi di Pensare alla Probabilità"),
                           fluidRow(
                             column(6,
                                    div(class = "comparison-card",
                                        h4("🏛️ Approccio Tradizionale (Frequentista)", style = "color: #e74c3c;"),
                                        h5("🤔 La domanda:"),
                                        p("'Se ripetessi questo esperimento 1000 volte, cosa succederebbe in media?'"),
                                        h5("📊 Esempio:"),
                                        p("Una moneta ha probabilità 0.5 di dare testa perché su 1000 lanci, circa 500 daranno testa."),
                                        h5("⚖️ Caratteristiche:"),
                                        tags$ul(
                                          tags$li("Parametri fissi, dati casuali"),
                                          tags$li("Basato su frequenze a lungo termine"),
                                          tags$li("Non usa conoscenze pregresse")
                                        )
                                    )
                             ),
                             column(6,
                                    div(class = "comparison-card",
                                        h4("🧠 Approccio Bayesiano", style = "color: #2ecc71;"),
                                        h5("🤔 La domanda:"),
                                        p("'Dato quello che ho osservato e quello che già sapevo, quanto sono sicuro che sia vero?'"),
                                        h5("📊 Esempio:"),
                                        p("Penso che questa moneta sia bilanciata, ma dopo 10 lanci tutti testa, ora sono meno sicuro..."),
                                        h5("⚖️ Caratteristiche:"),
                                        tags$ul(
                                          tags$li("Parametri incerti, dati fissi"),
                                          tags$li("Basato su gradi di credenza"),
                                          tags$li("Incorpora conoscenze pregresse"),
                                          tags$li("Si aggiorna con nuovi dati")
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
                       h2("🎯 Cos'è la Statistica Bayesiana?"),
                       
                       div(class = "explanation-box",
                           h3("🌟 L'Idea Principale"),
                           p(style = "font-size: 18px;", 
                             "La statistica Bayesiana è un modo di ragionare che rispecchia come pensiamo naturalmente nella vita reale. 
                             Quando dobbiamo prendere una decisione, non partiamo da zero: usiamo il nostro sapere e aggiorniamo le nostre opinioni quando riceviamo nuove informazioni.")
                       ),
                       
                       div(class = "theory-box",
                           h3("🏠 Esempio della Vita Quotidiana:"),
                           
                           div(class = "step-box",
                               h4("📱 Situazione:"),
                               p("Chiami Emanuela alle 15:00 di Venerdì. Il telefono squilla ma lei non risponde. 
                                 È a casa o no?")
                           ),
                           
                           fluidRow(
                             column(4,
                                    div(class = "highlight-box",
                                        h5("🧠 Prior (Conoscenza Pregressa)"),
                                        p("So che Emanuela di solito ha il lab meeting di Venerdì dalle 14:30 alle 15:30 al CNR."),
                                        p(strong("Probabilità iniziale che sia a casa: 30%"))
                                    )
                             ),
                             column(4,
                                    div(class = "highlight-box",
                                        h5("📊 Evidenza (Nuovi Dati)"),
                                        p("Il telefono squilla ma non risponde."),
                                        p("Questo può succedere sia se è a casa che al CNR.")
                                    )
                             ),
                             column(4,
                                    div(class = "highlight-box",
                                        h5("🎯 Posterior (Conclusione Aggiornata)"),
                                        p("Considerando tutto, probabilmente sta facendo il lab meeting."),
                                        p(strong("Probabilità aggiornata che sia a casa: 15%"))
                                    )
                             )
                           ),
                           
                           div(class = "warning-box",
                               h5("🔄 E se chiami di nuovo alle 19:00 e non risponde?"),
                               p("Ora la tua conoscenza pregressa cambia: di sera Emanuela è spesso a casa. 
                                 La stessa evidenza (non risponde) ora ti porta a una conclusione diversa: 
                                 probabilmente lei è a casa ma sta cenando!")
                           )
                       )
                )
              ),
              
              fluidRow(
                column(12,
                       div(class = "theory-box",
                           h3("🏥 Esempio Medico: Diagnosi di una Malattia"),
                           
                           div(class = "explanation-box",
                               h4("📋 Scenario:"),
                               p("Un test per una malattia rara è accurato al 95% (rileva correttamente la malattia nel 95% dei casi). 
                                 Se il tuo test è positivo, qual è la probabilità che tu abbia davvero la malattia?"),
                               br(),
                               div(style = "text-align: center; font-size: 24px; color: #e74c3c;",
                                   "La risposta NON è 95%! 🤯"
                               )
                           ),
                           
                           fluidRow(
                             column(6,
                                    div(class = "freq-box",
                                        h4("🏛️ Pensiero Frequentista"),
                                        p("'Il test è accurato al 95%, quindi se è positivo, 
                                          ho il 95% di probabilità di avere la malattia.'"),
                                        p(strong("❌ SBAGLIATO!"), style = "color: red;"),
                                        p("Questo ragionamento ignora quanto sia rara la malattia.")
                                    )
                             ),
                             column(6,
                                    div(class = "bayes-box",
                                        h4("🧠 Pensiero Bayesiano"),
                                        p("'Devo considerare: quanto è rara la malattia? 
                                          Se colpisce solo 1 persona su 1000, anche con un test positivo, 
                                          è più probabile che sia un falso positivo.'"),
                                        p(strong("✅ CORRETTO!"), style = "color: green;"),
                                        p("Se la malattia colpisce 1 su 1000, la probabilità reale 
                                          con test positivo è solo circa 2%!")
                                    )
                             )
                           ),
                           
                           div(class = "highlight-box",
                               h5("🧮 Il Calcolo (semplificato):"),
                               tags$ul(
                                 tags$li("Su 10.000 persone, 10 hanno la malattia (1 su 1000)"),
                                 tags$li("Il test rileva correttamente 9-10 di queste"),
                                 tags$li("Ma dà anche ~500 falsi positivi dalle 9.990 persone sane"),
                                 tags$li("Quindi: ~10 veri positivi su ~510 test positivi = ~2%")
                               )
                           )
                       )
                )
              ),
              
              fluidRow(
                column(12,
                       div(class = "theory-box",
                           h3("🔍 Perché la Statistica Bayesiana è Utile?"),
                           
                           fluidRow(
                             column(6,
                                    div(class = "comparison-card",
                                        h4("💡 Vantaggi Pratici"),
                                        tags$ul(
                                          tags$li("Incorpora conoscenze esistenti"),
                                          tags$li("Funziona bene con pochi dati"),
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
                               h4("🤔 Cosa fa questa formula?"),
                               p("Il teorema di Bayes ci dice come aggiornare le nostre credenze quando riceviamo nuove informazioni. 
                                 È come avere una calcolatrice per l'incertezza!")
                           ),
                           
                           div(class = "formula-box",
                               h4("📐 La Formula:"),
                               "$$P(\\text{Ipotesi}|\\text{Evidenza}) = \\frac{P(\\text{Evidenza}|\\text{Ipotesi}) \\times P(\\text{Ipotesi})}{P(\\text{Evidenza})}$$",
                               br(),
                               h4("🗣️ In parole semplici:"),
                               "$$\\text{Credenza Aggiornata} = \\frac{\\text{Quanto è probabile quello che ho visto} \\times \\text{Credenza Iniziale}}{\\text{Quanto è probabile quello che ho visto in generale}}$$"
                           ),
                           
                           fluidRow(
                             column(3,
                                    div(class = "step-box",
                                        h5("🎯 Prior P(Ipotesi)"),
                                        p(strong("CHE COS'È:")),
                                        p("La tua credenza PRIMA di vedere i dati"),
                                        p(strong("ESEMPIO:")),
                                        p("'Penso che questa moneta sia equilibrata' = 50% testa")
                                    )
                             ),
                             column(3,
                                    div(class = "step-box",
                                        h5("📊 Likelihood P(Evidenza|Ipotesi)"),
                                        p(strong("CHE COS'È:")),
                                        p("Quanto è probabile vedere questi dati SE la tua ipotesi è vera"),
                                        p(strong("ESEMPIO:")),
                                        p("Se la moneta è equilibrata, quanto è probabile vedere 8 teste su 10 lanci?")
                                    )
                             ),
                             column(3,
                                    div(class = "step-box",
                                        h5("🔍 Evidence P(Evidenza)"),
                                        p(strong("CHE COS'È:")),
                                        p("Quanto è probabile vedere questi dati in generale"),
                                        p(strong("ESEMPIO:")),
                                        p("Probabilità di vedere 8 teste su 10 lanci, considerando TUTTE le possibili monete")
                                    )
                             ),
                             column(3,
                                    div(class = "step-box",
                                        h5("🎉 Posterior P(Ipotesi|Evidenza)"),
                                        p(strong("CHE COS'È:")),
                                        p("La tua credenza DOPO aver visto i dati"),
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
                           h3("🧮 Il Problema della Moneta Truccata"),
                           
                           div(class = "explanation-box",
                               h4("📝 Il Problema:"),
                               p("Hai due monete: una normale (50% testa) e una truccata (80% testa). 
                                 Ne scegli una a caso e fai 5 lanci, ottenendo: TESTA, TESTA, CROCE, TESTA, TESTA. 
                                 Qual è la probabilità che tu abbia scelto la moneta truccata?")
                           ),
                           
                           h4("🔢 Passo 1: Prior (Credenza Iniziale)"),
                           div(class = "highlight-box",
                               p("Dato che hai scelto a caso:"),
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
                                          tags$li("Il prior influenza sempre il risultato"),
                                          tags$li("Più dati = meno influenza del prior"),
                                          tags$li("Eventi rari restano rari anche con evidenze positive"),
                                          tags$li("L'aggiornamento è continuo e naturale")
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
                       h2("🪙 Esempio Interattivo: Lancio di una Moneta"),
                       
                       div(class = "explanation-box",
                           h3("🎯 Obiettivo di Questo Esperimento"),
                           p("Simularemo il lancio di una moneta e confronteremo come l'approccio frequentista 
                             e quello Bayesiano analizzano i dati. Vedrai come le due metodologie convergono 
                             o divergono in base ai tuoi prior e ai dati osservati.")
                       )
                )
              ),
              
              # Interactive Coin Example
              fluidRow(
                column(4,
                       div(class = "theory-box",
                           h3("🎛️ Pannello di Controllo"),
                           
                           div(class = "step-box",
                               h4("🪙 Proprietà della Moneta"),
                               sliderInput("coin_flips", "Numero di lanci:", 
                                           min = 10, max = 500, value = 50, step = 10),
                               sliderInput("true_prob", "Probabilità reale di testa:", 
                                           min = 0.3, max = 0.7, value = 0.5, step = 0.05),
                               div(class = "explanation-box",
                                   p(em("Questa è la vera probabilità della moneta (che non conosciamo nella realtà!)")))
                           ),
                           
                           div(class = "step-box",
                               h4("🧠 I Tuoi Prior Bayesiani"),
                               sliderInput("prior_belief", "Tua credenza iniziale (prob. di testa):", 
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
      
      # Summary Tab
      tabItem(tabName = "summary",
              fluidRow(
                column(12,
                       div(class = "intro-box",
                           h1("🎓 Congratulazioni, Maestro Bayesiano!", style = "text-align: center;"),
                           h3("Hai Completato il Tuo Viaggio nell'Inferenza Bayesiana!", style = "text-align: center;"),
                           br(),
                           
                           div(style = "background: rgba(255,255,255,0.2); padding: 20px; border-radius: 10px;",
                               h3("📚 Cosa Hai Imparato:"),
                               tags$ol(style = "font-size: 18px;",
                                       tags$li("La differenza fondamentale tra pensiero frequentista e Bayesiano"),
                                       tags$li("Come il teorema di Bayes aggiorna le credenze con nuove evidenze"),
                                       tags$li("L'importanza dei prior e come sceglierli"),
                                       tags$li("Regressione Bayesiana e quando preferirla alla classica"),
                                       tags$li("Applicazioni alle reti genetiche e alla bioinformatica"),
                                       tags$li("Vantaggi e svantaggi di ogni approccio")
                               )
                           )
                       )
                ),
                
                column(12,
                       div(class = "theory-box",
                           h3("🧠 Verifica la Tua Comprensione"),
                           
                           div(class = "step-box",
                               h4("Domanda 1: Quando la regressione Bayesiana è più vantaggiosa?"),
                               radioButtons("q1", "", 
                                            choices = list(
                                              "Quando hai migliaia di dati e nessuna conoscenza pregressa" = "a",
                                              "Quando hai pochi dati ma buone conoscenze pregresse" = "b",
                                              "Quando vuoi la computazione più veloce possibile" = "c",
                                              "Quando l'incertezza non è importante" = "d"
                                            )),
                               
                               div(class = "explanation-box",
                                   p(em("Pensa a quello che abbiamo visto negli esempi interattivi..."))
                               )
                           ),
                           
                           div(class = "step-box",
                               h4("Domanda 2: Cosa rende i metodi Bayesiani ideali per le reti genetiche?"),
                               radioButtons("q2", "", 
                                            choices = list(
                                              "Sono sempre più veloci da calcolare" = "a",
                                              "Non hanno bisogno di alcun dato" = "b",
                                              "Gestiscono naturalmente sparsità e incertezza" = "c",
                                              "Danno sempre risposte esatte" = "d"
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
}

# Run the application
shinyApp(ui = ui, server = server)
