# 🧠 BayesQuest: Regression & Networks

Welcome to the **BayesQuest**, an interactive Shiny app that teaches Bayesian statistics through simulation, visualization, and comparison with frequentist methods.

---

## 🚀 Features

- 📚 **Bayesian Foundations** — Learn Bayes' Theorem interactively (coin flip module)
- 📈 **Regression Analysis** — Compare frequentist and Bayesian regression side-by-side
- 🧬 **Gene Regulatory Networks** — Infer networks using Bayesian priors and visualize uncertainty
- 🎓 **Summary & Quiz** — Recap key concepts and test your knowledge

---

## 💻 Run Locally

To run this app on your machine:

1. Clone this repo:
   ```bash
   git clone https://github.com/ngsFC/BayesQuest.git
   cd BayesQuest
   ```

2. Open `app.R` in RStudio.

3. Install required packages:
   ```r
   install.packages(c("shiny", "shinydashboard", "plotly", "ggplot2", "dplyr", 
                      "igraph", "visNetwork", "shinyjs"))
   ```

4. Run the app:
   ```r
   shiny::runApp()
   ```

---

## 📦 Dependencies

- [`shiny`](https://shiny.rstudio.com/)
- [`shinydashboard`](https://rstudio.github.io/shinydashboard/)
- [`plotly`](https://plotly.com/r/)
- [`ggplot2`](https://ggplot2.tidyverse.org/)
- [`dplyr`](https://dplyr.tidyverse.org/)
- [`igraph`](https://igraph.org/r/)
- [`visNetwork`](https://datastorm-open.github.io/visNetwork/)
- [`shinyjs`](https://deanattali.com/shinyjs/)

---

## 📖 Learning Goals

- Understand the distinction between Frequentist and Bayesian inference
- Learn how priors shape posterior distributions
- Visualize uncertainty and posterior updates
- Explore Bayesian applications in genomics

---

## 🔒 License

MIT License © 2025 Your Name

---

