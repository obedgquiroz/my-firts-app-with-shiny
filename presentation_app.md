---
title: "My firts aplication made with shiny"
author: "Obed Garcia"
date: "20/7/2020"
output: 
  ioslides_presentation: 
    keep_md: yes
---



## Application explanation

This application is used to verify the CLT and the behavior of the value of the mean and variance of an exponential variable, by simulating means of variables with exponential distribution.

The application can be found at: https://ogarciaq.shinyapps.io/my-firts-app-with-shiny/

The ui.R script can be found at: https://github.com/obedgquiroz/my-firts-app-with-shiny/blob/master/server.R

The server.R script can be found at:
https://github.com/obedgquiroz/my-firts-app-with-shiny/blob/master/ui.R

**Note:** When changing the input values if you want to see the results associated with these values, you must press the **submit** button.

## Inputs

**The inputs for this application are:**

1- Simulation number: The user must select a value between 1 and 10.000, which represents the number of simulations, which represent the sample size "n".

2- Value of λ: The user must enter a value between 1 and 100, which represents the value of mean of exponential variables "λ". 

3- Sample size of each exponential variable: The user must enter a value between 1 and 100, which represents the value of the sample size of each exponential variable.

## Outputs

**The outputs for this application are:**

1- Behavior of the mean distribution, through the simulation: A plot, which represents the behavior of the mean distribution, through the simulation

2- Behavior of the sample mean and variance through simulations:

- The values of: sample mean, theoretical mean and error rate between the sample mean and the theoretical mean, and a plot which represents the behavior of the sample mean through simulations.

- The values of: sample variance, theoretical variance and error rate between the sample variance and the theoretical variance, and a plot which represents the behavior of the sample variance through simulations.

## Simulation explained

The simulation is performed using the replicate and rexp functions, to generate n samples of variables with exponential distribution, and then with the apply function the average of each sample is calculated and all the averages are stored in a variable called sample , which is the one that will be used to make the graphs and values previously named, in such a way that if, for example n = 1000, λ = 0.2 and the sample size of each exponential is 40, a numerical vector of size is produced 1000, as shown below.


```r
n_sample <- 40; lambda <- 0.2; n <- 1000
simulation <- replicate(n, rexp(n_sample, lambda))
sample <- apply(simulation, 2, mean)
str(sample)
```

```
##  num [1:1000] 4.52 4.57 5.33 5.25 4.7 ...
```
