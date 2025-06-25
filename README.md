# 🧠 Bayesian Learning Lab: Regression & Networks

Welcome to the **Bayesian Learning Lab**, an interactive Shiny app that teaches Bayesian statistics through simulation, visualization, and comparison with frequentist methods.

---

## 🚀 Features

- 📚 **Bayesian Foundations** — Learn Bayes' Theorem interactively (coin flip module)
- 📈 **Regression Analysis** — Compare frequentist and Bayesian regression side-by-side
- 🧬 **Gene Regulatory Networks** — Infer networks using Bayesian priors and visualize uncertainty
- 🎓 **Summary & Quiz** — Recap key concepts and test your knowledge

---

## 🌐 Launch App

If deployed using [shinyapps.io](https://www.shinyapps.io) or [Shiny Server](https://shiny.rstudio.com/deploy/), include a live link like:

👉 **[Launch the App](https://yourusername.shinyapps.io/bayesian-learning-lab/)**

Or run locally using R (see below).

---

## 💻 Run Locally

To run this app on your machine:

1. Clone this repo:
   ```bash
   git clone https://github.com/yourusername/bayesian-learning-lab.git
   cd bayesian-learning-lab
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

## 📸 Screenshots

| Bayesian Regression | Gene Network Inference |
|---------------------|------------------------|
| ![regression](screenshots/regression.png) | ![network](screenshots/network.png) |

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
