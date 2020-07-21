library(shiny)
library(ggplot2)

shinyServer(function(input, output) {
    ## Entradas
    n <- reactive({n <- input$n})
    lambda <- reactive({lambda <- input$lambda})
    n_sample <- reactive({n_sample <- input$n_sample})
    
    ## Calculos para todos los graficos
    simulation <- reactive({replicate(n_sample(), rexp(n(), lambda()))})
    sample <- reactive({apply(simulation(), 2, mean)})
    theoretical_mean <- reactive({1/lambda()})
    sample_mean <- reactive({mean(sample())})
    theoretical_variance <- reactive({((1/lambda())^2)/n()})
    sample_variance <- reactive({var(sample())}) 
    ## Calculos grafico 1
    cumulative_mean <- reactive({cumsum(sample())/(seq_along(sample() - 1))})
    df_cum_mean <- reactive({data.frame(simulation = 1:n_sample(), cumulative_mean = cumulative_mean())})
    ## Calculos grafico 2
    cumulative_variance <- reactive({cumsum((sample() - sample_mean())^2)/(seq_along(sample() - 1))})
    df_cum_var <- reactive({data.frame(simulation = 1:n_sample(), cumulative_variance = cumulative_variance())})
    
    ##Salidas
    output$sample_mean <- renderText({paste("Sample mean:",round(sample_mean(),3))})
    output$theoretical_mean <- renderText({paste("Theoretical mean:",round(theoretical_mean(),3))})
    output$percentage_mean <- renderText({paste("Error rate:",round((abs(sample_mean()-theoretical_mean()))/sample_mean(),3),"%")})
    output$sample_variance <- renderText({paste("Sample variance:",round(sample_variance(),3))})
    output$theoretical_variance <- renderText({paste("Theoretical variance:",round(theoretical_variance(),3))})
    output$percentage_variance <- renderText({paste("Error rate:",round((abs(sample_variance()-theoretical_variance()))/sample_variance(),3),"%")})
    
    output$cum_mean_plot <- renderPlot({
        cum_mean_plot <- ggplot(df_cum_mean(),aes(x = simulation, y = cumulative_mean)) + geom_line(color = "black")
        cum_mean_plot <- cum_mean_plot + geom_hline(aes(yintercept = theoretical_mean()), colour = "steelblue", size = 1.0) 
        cum_mean_plot <- cum_mean_plot + labs(x = "Numbers of simulation", y = "Cumulative variance")
        cum_mean_plot <- cum_mean_plot + theme_grey() + theme(plot.title = element_text(face = "bold", vjust = 3, hjust = 0.5))
        cum_mean_plot})
    
    output$cum_var_plot <- renderPlot({
        cum_var_plot <- ggplot(df_cum_var(),aes(x = simulation, y = cumulative_variance)) + geom_line(color = "black")
        cum_var_plot <- cum_var_plot + geom_hline(aes(yintercept = theoretical_variance()), colour = "steelblue", size = 1.0) 
        cum_var_plot <- cum_var_plot + labs(x = "Numbers of simulation", y = "Cumulative variance")
        cum_var_plot <- cum_var_plot + theme_grey() + theme(plot.title = element_text(face = "bold", vjust = 3, hjust = 0.5))
        cum_var_plot})
    
    output$dis_plot <- renderPlot({
        dist_plot <- ggplot(data.frame(means_exp = sample()), aes(x = means_exp)) 
        dist_plot <- dist_plot + geom_density(aes(x= sample(),color = "Mean distribution"),fill = "red",alpha = 0.2)
        dist_plot <- dist_plot + stat_function(fun = dnorm, args = list(sample_mean(), sqrt(sample_variance())),geom = "area", aes(color = "Normal distribution"),fill = "steelblue",alpha = 0.2)
        dist_plot <- dist_plot + geom_vline(aes(xintercept = sample_mean() ), colour = "black", linetype = "dashed", size = 1.0) 
        dist_plot <- dist_plot + labs(y="Density", x="Mean")
        dist_plot <- dist_plot + theme_grey() + theme(plot.title = element_text(face = "bold", vjust = 3, hjust = 0.5))
        dist_plot <- dist_plot + theme(legend.text = element_text(size = 10),legend.title = element_text(hjust = 0.5, vjust = 0.5,size=12, face="bold"),legend.justification=c(1.2,1.2), legend.position=c(1,1))
        dist_plot
        })
})
