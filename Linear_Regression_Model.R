#Linear Regression Model 
library(readr)
maternal_health_data <- read_csv("C:/Users/HP/Desktop/R DATA ANALYSIS/Maternal Health Risk Data Set.csv")
summary(maternal_health_data)
names(maternal_health_data)

# Converting Risk Levels from categorical to numeric
maternal_health_data$risk_numeric <- as.numeric(as.factor(maternal_health_data$RiskLevel))
View(maternal_health_data)
levels(as.factor(maternal_health_data$RiskLevel))
maternal_health_data <- maternal_health_data[ , -7]

#Plots
plot(risk_numeric ~ DiastolicBP, data = maternal_health_data)
plot(risk_numeric ~ SystolicBP, data = maternal_health_data)
plot(risk_numeric ~ BS, data = maternal_health_data)
plot(risk_numeric ~ BodyTemp, data = maternal_health_data)
plot(risk_numeric ~ HeartRate, data = maternal_health_data)
plot(risk_numeric ~ Age, data = maternal_health_data)


# Linear regression model 
set.seed(380)
lm_model1 <- lm(risk_numeric ~ Age+BS+SystolicBP+ DiastolicBP+BS+BodyTemp+HeartRate, data = maternal_health_data)
summary(lm_model1)
plot(lm_model1)
train.rows = sample(nrow(maternal_health_data),round(0.8*nrow(maternal_health_data))) 
train = maternal_health_data[train.rows,]
test = maternal_health_data[-train.rows,]
regfit.full = regsubsets(risk_numeric~., data = train)

#Summaries with different approaches
summary(regfit.full)
summary(regfit.full)$adjr2
summary(regfit.full)$bic
summary(regfit.full)$cp

#Plots with different approaches
plot(regfit.full, scale = "adjr2")
plot(regfit.full, scale = "bic")

#Final Model Selection
final_model <- lm(risk_numeric ~ BS + SystolicBP + DiastolicBP + HeartRate + BodyTemp, data = train)
summary(final_model)
test_predictions <- predict(final_model, newdata = test)
summary(test_predictions)

# In-sample performance
final_model$fitted.values
mean((final_model$fitted.values - train$risk_numeric)^2)

# Out-of-sample performance
test_predictions <- predict(final_model, test)
mean((test_predictions - test$risk_numeric)^2)






























