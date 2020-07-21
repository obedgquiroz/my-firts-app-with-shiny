
library(shiny)
library(ggplot2)
shinyUI(fluidPage(class = "text-center",
    titlePanel(""),
    
    sidebarLayout(
        sidebarPanel(class = "text-center",
            h3(strong("My firts aplication made with shiny")),
            br(),
            sliderInput("n_sample",h4("Select the simulation number (n Value)",align = "center"),min = 1, max = 10000, value = 1000),
            numericInput("lambda",h4("Enter the value of λ", align = "center"),min = 0, max = 100, value = 0.2,step = 0.1),
            numericInput("n",h4("Enter the sample size of each exponential variable",align = "center"),min = 0, max = 100, value = 40),
            submitButton("Submit"),
            br(),
            img(src = "Rstudio.png", height = 80, width = 200)
        ),

        mainPanel(
            tabsetPanel(
                tabPanel("Behavior of the mean distribution, through the simulation",
                         column(6,h4(strong("Statement of the central limit theorem"),align = "center"),img(src = "CLT.png", height = 480, width = 420)),
                         column(6,h4(strong("Behavior of the distribution of mean as n increases"),align = "center"),plotOutput("dis_plot", height = 500))),
                tabPanel("Behavior of the sample mean and variance through simulations",
                         column(6,h4(strong("These are the values of the means:"),align = "center"),
                                h5(textOutput("sample_mean"),align = "center"),
                                h5(textOutput("theoretical_mean"),align = "center"),
                                h5(textOutput("percentage_mean"),align = "center"),
                                h4(strong("Behavior of the sample mean through simulations"),align = "center"),
                                plotOutput("cum_mean_plot")),
                         column(6,h4(strong("These are the values of the variances:"),align = "center"),
                                h5(textOutput("sample_variance"),align = "center"),
                                h5(textOutput("theoretical_variance"),align = "center"),
                                h5(textOutput("percentage_variance"),align = "center"),
                                h4(strong("Behavior of the sample variance through simulations"),align = "center"),
                                plotOutput("cum_var_plot")))
            )
    ))
))
