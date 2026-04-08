# changing working directory
setwd("Documents/KStateSpring2026/Stat730/R")

# Reading T8-7.dat file with (read.delim) which is for tab delimited files 
data <- read.delim("T8-7.dat", header = TRUE) 

# Finding the mean (x-bar) **should use the code below instead
mean(data[["X1"]])

mean(data[["X2"]])

mean(data[["X3"]])

mean(data[["X4"]])

mean(data[["X5"]])

mean(data[["X6"]])

mean(data[["X7"]])

mean(data[["X8"]])

mean(data[["X9"]])

# Finding the mean vector (this is faster than above)
mean_vector <- colMeans(data)
mean_vector


# finding S (generalized sample variance-covariance)
generalized_varianceX1 <- var(data[["X1"]])
generalized_varianceX1

generalized_varianceX2 <- var(data[["X2"]])
generalized_varianceX2

generalized_varianceX3 <- var(data[["X3"]])
generalized_varianceX3

generalized_varianceX4 <- var(data[["X4"]])
generalized_varianceX4

generalized_varianceX5 <- var(data[["X5"]])
generalized_varianceX5

generalized_varianceX6 <- var(data[["X6"]])
generalized_varianceX6

generalized_varianceX7 <- var(data[["X7"]])
generalized_varianceX7

generalized_varianceX8 <- var(data[["X8"]])
generalized_varianceX8

generalized_varianceX9 <- var(data[["X9"]])
generalized_varianceX9

#finding S (generalized sample variance-covariance) alt to below
S <- cov(data)  # For covariance
S

det(S)  # For generalized variance
# ----------------------------------------------------------

# finding R generalized sample variance of the standardized variables
standardized_columnX1 <- scale(data[["X1"]])
var(standardized_columnX1)

standardized_columnX2 <- scale(data[["X2"]])
var(standardized_columnX2)

standardized_columnX3 <- scale(data[["X3"]])
var(standardized_columnX3)

standardized_columnX4 <- scale(data[["X4"]])
var(standardized_columnX4)

standardized_columnX5 <- scale(data[["X5"]])
var(standardized_columnX5)

standardized_columnX6 <- scale(data[["X6"]])
var(standardized_columnX6)

standardized_columnX7 <- scale(data[["X7"]])
var(standardized_columnX7)

standardized_columnX8 <- scale(data[["X8"]])
var(standardized_columnX8)

standardized_columnX9 <- scale(data[["X9"]])
var(standardized_columnX9)

# Finding V1 = (X3 + X4 + X5 + X6) / 4
V1 <- (data$X3 + data$X4 + data$X5 + data$X6) / 4
V1

# Finding V2 = X7 + X8 + X9
V2 <- data$X7 + data$X8 + data$X9
V2

# Finding the mean vector for V = (V1, V2)'
V1t <- t(V1)
V1t

V2t <- t(V2)
V2t

V <- rbind(V1t, V2t)
V

# Finding the S (covariance) for V = (V1,V2)' 
SoV <- cov(V)
SoV

# Finding the standardized variance of V
standardized_V <- scale(V)
standardized_V

# Question d.
# Recaluclating the mean using vector means and S from question a.
V1d <- (2.991447 + 2.082237 + 2.651316 + 1.671053) / 4
V1d

V2d <- 7.089123 + 173.0814 + 7.01263
V2d

# Recalculating the mean vector for V = (V1d, V2d)'
V1dt <- t(V1d)
V1dt

V2dt <- t(V2d)
V2dt

Vd <- rbind(V1dt, V2dt)
Vd

#Finding the S (covariance) for Vd = (V1d, V2d)'
SoVd <- cov(Vd)
SoVd

# finding the standardized variance of Vd
standardized_Vd <- scale(Vd)
standardized_Vd