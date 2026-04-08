# HW4_code

# Question 1

setwd("~/Documents/KStateSpring2026/Stat730/R")

install.packages("caret")

install.packages("pROC")

install.packages("kernlab")

install.packages("ISLR")

bikes = read.csv("SeoulBikes_Sp2026.csv")
bikes

set.seed(2026341)
splits = sample(1:3, nrow(bikes), replace = TRUE, prob=c(.5,.25,.25))
table(splits)/nrow(bikes)

train.bikes = bikes[splits==1,]
valid.bikes = bikes[splits==2,]
test.bikes = bikes[splits==3,]


#--------------------------------------- Doesn't seem to work for what i need -------
# quick checks relative frequencies
table(bikes$type)/nrow(bikes)
table(train.bikes$type)/nrow(train.bikes)
table(valid.bikes$type)/nrow(valid.bikes)
table(test.bikes$type)/nrow(test.bikes)
--------------------------------------------------------------------------------

# Gives counts for a specific column 
table(train.bikes$Seasons)

# Gives proportions for a specific column
prop.table(table(train.bikes$Seasons))

#Gives percentages for a specific column
round(100 * prop.table(table(train.bikes$Seasons)), 2)

# Question 2
# Using the training set, fit a linear model to predict RentedBikeCount using all the 
# variables, EXCEPT Day and Year. We will focus on main effects, only. Then, use  
# backward elimination to determine a candidate model.  Use 10% significance

Linear_model <- lm(RentedBikeCount ~ . - Day - Year, data = train.bikes)
summary(Linear_model)

# For backward elimination on validation model ( This gives me a new model from backward elimination)
candidate_model <- step(Linear_model, direction = "backward")

# The full candidate model
summary(candidate_model)

# Month was above 10% significance so refitting the model
 Linear_model <- lm(RentedBikeCount ~ . -Month - Day - Year, data = train.bikes)
summary(Linear_model)

# Question 3

Linear_model2 <- lm(RentedBikeCount ~ Seasons + Temperature + Visibility, data = train.bikes)
summary(Linear_model2)

# To find all interactions use *
Linear_model2 <- lm(RentedBikeCount ~ Seasons * Temperature * Visibility, data = train.bikes)
summary(Linear_model2)

# Question 4
# Using the validation set, calculate RMSE, Adjusted  and MAE for the models fitted in 
# problems 2 and 3. Based on your calculations pick the best model.

# For Linear model in Question 2
pred_Lm <- predict(Linear_model, newdata = valid.bikes)
actual <- valid.bikes$RentedBikeCount

# For RMSE (Root Mean Squared Error)
rmse <- sqrt(mean((actual - pred_Lm)^2))
rmse

# For MAE (Mean Absolute Error)
mae <- mean(abs(actual - pred_Lm))
mae

# For Adjusted R^2
n <- length(actual)
p <- length(coef(Linear_model)) - 1   # number of predictors

SSE <- sum((actual - pred_Lm)^2)
SST <- sum((actual - mean(actual))^2)

r2 <- 1 - SSE/SST
# compute adjusted R^2
adj_r2 <- 1 - (1 - r2) * (n - 1)/(n - p - 1)
adj_r2

# This is the combined version for RMSE, MAE, Adjusted R^2 for Linear Model in Question 3.
pred_Lm2 <- predict(Linear_model2, newdata = valid.bikes)
actual_2 <- valid.bikes$RentedBikeCount


rmse <- sqrt(mean((actual_2 - pred_Lm2)^2))
mae  <- mean(abs(actual_2 - pred_Lm2))

n <- length(actual_2)
p <- length(coef(Linear_model2)) - 1

r2 <- 1 - sum((actual_2 - pred_Lm2)^2) / sum((actual_2 - mean(actual_2))^2)
adj_r2 <- 1 - (1 - r2) * (n - 1)/(n - p - 1)

rmse
mae
adj_r2

# Question 5
# Combine your training and validation sets into one and refit your best model from problem 5.

# This combines the train.bikes and valid.bikes sets.
combined <- rbind(train.bikes, valid.bikes)

# Using the combined set,  fit a linear model to predict RentedBikeCount like in Question 3 (this is the best model chosen in Question 5).
---------------------------------------------------------------------------------------------
# this was incorrect because of wrong seedingLinear_model3 <- lm(RentedBikeCount ~ . #Day - Year, data = combined)
#summary(Linear_model3)
--------------------------------------------------------------------------------------
Linear_model3 <- lm(RentedBikeCount ~ Seasons + Temperature + Visibility, data = combined)
summary(Linear_model3)

# Question 6
# Using the testing set, calculate RMSE, Adjusted  and MAE for your best model fitted in problem 5 with the larger set. Compare the numbers with those obtained in problem 4. Did they change or not? What can you conclude?

pred_Lm3 <- predict(Linear_model3, newdata = test.bikes)
actual_3 <- test.bikes$RentedBikeCount


rmse <- sqrt(mean((actual_3 - pred_Lm3)^2))
mae  <- mean(abs(actual_3 - pred_Lm3))

n <- length(actual_3)
p <- length(coef(Linear_model3)) - 1

r2 <- 1 - sum((actual_3 - pred_Lm3)^2) / sum((actual_3 - mean(actual_3))^2)
adj_r2 <- 1 - (1 - r2) * (n - 1)/(n - p - 1)

rmse
mae
adj_r2

# --------------------------------Quiz Attempt 1--------------------------------------

# To get number of rows (observations)
nrow(train.bikes)
nrow(valid.bikes)
nrow(test.bikes)

# Finding the third quartile of visibility in the validation set
quantile(valid.bikes$Visibility, 0.75)

# For all quantiles
quantile(valid.bikes$Visibility)

# Finding the standard deviation for RentedBikeCount in the test.bike set
sd(test.bikes$RentedBikeCount)

# To find the sample correlation matrices and ignoring non-numeric columns
cor(train.bikes[, sapply(train.bikes, is.numeric)])
cor(valid.bikes[, sapply(valid.bikes, is.numeric)])
cor(test.bikes[, sapply(test.bikes, is.numeric)])

# For visual correlation matrices
library(corrplot)
corrplot(cor(train.bikes[, sapply(train.bikes, is.numeric)]))
corrplot(cor(valid.bikes[, sapply(valid.bikes, is.numeric)]))
corrplot(cor(test.bikes[, sapply(test.bikes, is.numeric)]))

# For quiz question 10
pred_Lm <- predict(candidate_model , newdata = valid.bikes)
actual <- valid.bikes$RentedBikeCount


rmse <- sqrt(mean((actual - pred_Lm)^2))
mae  <- mean(abs(actual - pred_Lm))

n <- length(actual)
p <- length(coef(candidate_model)) - 1

r2 <- 1 - sum((actual - pred_Lm)^2) / sum((actual - mean(actual))^2)
adj_r2 <- 1 - (1 - r2) * (n - 1)/(n - p - 1)

rmse
mae
adj_r2

# For Question 11 Using the validation set, what was the MAE for the two-way interaction model?
pred_Lm2 <- predict(Linear_model2, newdata = valid.bikes)
actual_2 <- valid.bikes$RentedBikeCount


rmse <- sqrt(mean((actual_2 - pred_Lm2)^2))
mae  <- mean(abs(actual_2 - pred_Lm2))

n <- length(actual_2)
p <- length(coef(Linear_model2)) - 1

r2 <- 1 - sum((actual_2 - pred_Lm2)^2) / sum((actual_2 - mean(actual_2))^2)
adj_r2 <- 1 - (1 - r2) * (n - 1)/(n - p - 1)

rmse
mae
adj_r2


# For Question 13 Estimate is the coeficient
 