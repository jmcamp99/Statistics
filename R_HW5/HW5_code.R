HW5

setwd("Documents/KStateSpring2026/Stat730/Week 6")

bikes = read.csv("SeoulBikesVer2_Sp2026.csv")

head(bikes)

dim(bikes)

names(bikes) <- c("Day", "Month", "Year", "RentedBikeCount", "Temperature", "Humidity", "WindSpeed", "Visibility", "DewPointTemp", "SolarRadiation", "Rainfall", "Snowfall", "Seasons", "Holiday", "BikeCountPlus1", "BikeCountPlus2")

------------------------Question 1: Univariate Regression-------------------------

# Changing Seasons and Holiday to numeric
bikes$Seasons <- as.factor(bikes$Seasons)
bikes$Seasons <- as.numeric(bikes$Seasons)

bikes$Holiday <- as.factor(bikes$Holiday)
bikes$Holiday <- as.numeric(bikes$Holiday)

numeric <- sapply(bikes, is.numeric)
bikes_numeric <- bikes[, numeric]

# Correlation
bikes_numeric_less3 <- bikes_numeric[, -c(1,2,3)]
correlation <- cor(bikes_numeric_less3, use = "complete.obs")
round(correlation, 2)

# Sample Mean Vector
round(colMeans(bikes_numeric_less3), 2)

# Sample Variance-Covariance Matrix
covariance <- bikes_numeric_less3[sapply(covariance, is.numeric)]
round(cov(covariance, use = "complete.obs"), 2) 

# Sample Correlation Matrix
bikes_numeric_less3 <- bikes_numeric[, -c(1,2,3)]
correlation <- cor(bikes_numeric_less3, use = "complete.obs")
round(correlation, 2)

---------------------------------------------------------------------------

###   Response = RentedBikeCount, Predictors = Temperature, SolarRadiation
# Pairs Scatter plots.  pred1_numeric subtracts first three columns, then selects numeric columns 1, 2, 7 (RentedBikeCount, Temperature, SolarRadiation) 
cols1_numeric <- bikes[,-c(1,2,3)][,c(1,2,7)][sapply(bikes[,-c(1,2,3)][,c(1,2,7)], is.numeric)]

pairs(cols1_numeric, labels = names(cols1_numeric))

# Fitting the model
lm1 <- lm(RentedBikeCount~Temperature+SolarRadiation, data=bikes)
summary(lm1)

residuals_lm1 <- residuals(lm1)
mae_lm1 <- mean(abs(residuals_lm1))
mae_lm1

# Diagnostic Plots
par(mfrow=c(2,2))
par(mar=c(4.5, 4, 1.5, 0.4) + 0.1);
plot(lm1,1:3)
plot(lm1,5)
----------------------------------------------------------------------------

### Response = RentedBikeCount, Predictors = Temperature, DewPointTemp, SolarRadiation
cols2_numeric <- bikes[,-c(1,2,3)][,c(1,2,6,7)][sapply(bikes[,-c(1,2,3)][,c(1,2,6,7)], is.numeric)]

pairs(cols2_numeric, labels = names(pred2_numeric))

# Fitting the model
lm2 <- lm(RentedBikeCount~Temperature+DewPointTemp+SolarRadiation, data=bikes)
summary(lm2)

residuals_lm2 <- residuals(lm2)
mae_lm2 <- mean(abs(residuals_lm2))
mae_lm2

# Diagnostic Plots
par(mfrow=c(2,2))
par(mar=c(4.5, 4, 1.5, 0.4) + 0.1);
plot(lm2,1:3)
plot(lm2,5)
----------------------------------------------------------------------------

### Response = RentedBikeCount, Predictors = Temperature, DewPointTemp
cols3_numeric <- bikes[,-c(1,2,3)][,c(1,2,6)][sapply(bikes[,-c(1,2,3)][,c(1,2,6)], is.numeric)]

pairs(cols3_numeric, labels = names(pred3_numeric))

lm3 <- lm(RentedBikeCount~Temperature+DewPointTemp, data=bikes)
summary(lm3)

residuals_lm3 <- residuals(lm3)
mae_lm3 <- mean(abs(residuals_lm3))
mae_lm3

# Diagnostic Plots
par(mfrow=c(2,2))
par(mar=c(4.5, 4, 1.5, 0.4) + 0.1);
plot(lm3,1:3)
plot(lm3,5)
---------------------------------------------------------------------------

# Prediction 
x.new <- data.frame(Temperature=21.5, Humidity=29, WindSpeed=2.3, Visibility=1834, DewPointTemp=5.4, SolarRadiation=2.03, Rainfall=0.00, Snowfall=0.00)

predict.lm(lm2, x.new, interval="predict", 0.975)

-----------------------Question 2: Multivariate Regression-------------------

# Pairs plot
mcols1_numeric <- bikes_numeric_less3[,c(1,12,13,2,3,4,5,7,10)][sapply(bikes_numeric_less3[,c(1,12,13,2,3,4,5,7,10)], is.numeric)]

pairs(mcols1_numeric, labels = names(mcols1_numeric))

# Fitting model 1
lm.multi1 <- lm(cbind(RentedBikeCount, BikeCountPlus1, BikeCountPlus2)~Temperature+Humidity+WindSpeed+Visibility+SolarRadiation+Seasons, data=bikes_numeric_less3)
summary(lm.multi1)

residuals_lm.multi1 <- residuals(lm.multi1)
mae_lm.multi1 <- mean(abs(residuals_lm.multi1))
mae_lm.multi1

# Diagnostic Plots
par(mfrow=c(2,2))
par(mar=c(4.5, 4, 1.5, 0.4) + 0.1);
plot(lm.multi1,1:3)
plot(lm.multi1,5)

# Fitting model 2
lm.multi2 <- lm(cbind(RentedBikeCount, BikeCountPlus1, BikeCountPlus2)~Temperature+Humidity+Seasons, data=bikes_numeric_less3)
summary(lm.multi2)

residuals_lm.multi2 <- residuals(lm.multi2)
mae_lm.multi2 <- mean(abs(residuals_lm.multi2))
mae_lm.multi2

# Diagnostic Plots
par(mfrow=c(2,2))
par(mar=c(4.5, 4, 1.5, 0.4) + 0.1);
plot(lm.multi2,1:3)
plot(lm.multi2,5)

# Fitting model 3
lm.multi3 <- lm(cbind(RentedBikeCount, BikeCountPlus1, BikeCountPlus2)~Temperature+Humidity+SolarRadiation+Seasons, data=bikes_numeric_less3)
summary(lm.multi3)

residuals_lm.multi3 <- residuals(lm.multi3)
mae_lm.multi3 <- mean(abs(residuals_lm.multi3))
mae_lm.multi3

# Diagnostic Plots

plot(residuals_lm.multi3[,1],main="Residuals for RentedBikeCount")
qqnorm(residuals_lm.multi3[,1])
qqline(residuals_lm.multi3[,1])

plot(residuals_lm.multi3[,2],main="Residuals for BikeCountPlus1")
qqnorm(residuals_lm.multi3[,2])
qqline(residuals_lm.multi3[,2])

plot(residuals_lm.multi3[,3],main="Residuals for BikeCountPlus3")
qqnorm(residuals_lm.multi3[,3])
qqline(residuals_lm.multi3[,3])

# Prediction
x0 <- c(1, x.new$Temperature, x.new$Humidity, x.new$SolarRadiation, x.new$Seasons)
x0

# Retrieving the design
X <- model.matrix(~Temperature+Humidity+SolarRadiation+Seasons, data=bikes_numeric_less3)

# m = number of response variables
m = 3

# r = number of predictors
r = 4

# estimated matrix of coefficients
hat.Beta <- lm.multi3$coeff
hat.Beta

# Estimated variance covariance matrix
Resid <- lm.multi3$resid
n <- nrow(Resid)
hat.Sigma <- t(Resid)%*%Resid/n
hat.Sigma

# Point Estimate of the mean day
x0%*%hat.Beta

# Simultanious C.I. for the expected value
# To account for the randomness of the data
multiplier <- sqrt(qf(0.95,m,n-r-m)*(m*(n-r-1))/(n-r-m)) for(i in :m){
	mean.se <- sqrt((x0%*%solve(t(X)%*%X)%*%x0)*hat.Sigma[i,i]*(n/(n-r-1)))
	cat("Response",i,(x0%*%hat.Beta[i]-multiplier*mean.se,
		x0%*%hat.Beta)[i]+multiplier*mean.se, "\n")
}

# Point estimate for new day
x0%*%hat.Beta

# Simultanious prediction interval for new day

for(i in 1:m){
	pred.se <- sqrt((1 + x0%*%solve(t(X%*%X)%*%x0)*hat.Sigma[i,i]*(n/n-r-1)))
	cat("Response",i,(x0%*%hat.Beta)[i]-multiplier*pred.se,(x0%*%hat.Beta)[i]+multiplier*pred.se"\n")
}

