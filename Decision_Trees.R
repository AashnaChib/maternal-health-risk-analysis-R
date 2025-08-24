# Data Analytics R Code
# Set the working directory to the correct location
setwd("~/Desktop/Data Analytics - Sets/All data sets")  # Adjust to your file location
getwd()  # Check the working directory
dir()  # List files in the directory

# Ensure the dataset name matches exactly (case-sensitive)
maternal_health_data <- read.csv("maternal_health.csv")  # Load the dataset

# View the dataset
View(maternal_health_data)  # Opens the data in a viewer window if running in RStudio or similar

summary(maternal_health_data)
names(maternal_health_data)

# Converting Risk Levels from caterogical to numeric
maternal_health_data$RiskLevel <- as.factor(maternal_health_data$RiskLevel)
View(maternal_health_data)
levels(as.factor(maternal_health_data$RiskLevel))

#split training/testing
set.seed(380)
train.rows =sample(nrow(maternal_health_data), round(0.8*nrow(maternal_health_data)))
train = maternal_health_data[train.rows,]
test = maternal_health_data[-train.rows,]

# Check the dimensions of the training and testing datasets
dim(train) # Should be ~80% of rows
dim(test)  # Should be ~20% of rows

# Build the decision tree model
tree_model <- tree(RiskLevel ~ ., data = train)

# Summary of the tree model
summary(tree_model)

# Plot the tree
plot(tree_model)
text(tree_model, pretty = 0)


# Predict on the test dataset
test_predictions <- predict(tree_model, test, type = "class")

# Confusion matrix to evaluate the model
conf_matrix <- table(test$RiskLevel, test_predictions)
print(conf_matrix)

# Calculate the accuracy
accuracy <- mean(test_predictions == test$RiskLevel)
print(paste("Accuracy:", round(accuracy * 100, 2), "%"))

################# Pruning the Tree to remove less significant splits

# Prune the tree with 3 terminal nodes
pruned_tree_3 <- prune.misclass(tree_model, best = 3)
summary(pruned_tree_3)

plot(pruned_tree_3, main = "Pruned Tree with 3 Terminal Nodes")
text(pruned_tree_3, pretty = 0)

pruned_predictions_3 <- predict(pruned_tree_3, newdata = test, type = "class")
pruned_test_error_rate_3 <- 1 - mean(pruned_predictions_3 == test$RiskLevel)
print(paste("Test Error Rate for Pruned Tree (3 Nodes):", round(pruned_test_error_rate_3 * 100, 2), "%"))


# Prune the tree with 4 terminal nodes
pruned_tree_4 <- prune.misclass(tree_model, best = 4)
summary(pruned_tree_4)

# Plot the pruned tree
plot(pruned_tree_4, main = "Pruned Tree with 4 Terminal Nodes")
text(pruned_tree_4, pretty = 0)

# Predict on the test dataset with the pruned tree
pruned_predictions_4 <- predict(pruned_tree_4, newdata = test, type = "class")
pruned_test_error_rate_4 <- 1 - mean(pruned_predictions_4 == test$RiskLevel)
print(paste("Test Error Rate for Pruned Tree (4 Nodes):", round(pruned_test_error_rate_4 * 100, 2), "%"))

# Prune the tree with 5 terminal nodes
pruned_tree_5 <- prune.misclass(tree_model, best = 5)
summary(pruned_tree_5)

plot(pruned_tree_5, main = "Pruned Tree with 5 Terminal Nodes")
text(pruned_tree_5, pretty = 0)

pruned_predictions_5 <- predict(pruned_tree_5, newdata = test, type = "class")
pruned_test_error_rate_5 <- 1 - mean(pruned_predictions_5 == test$RiskLevel)
print(paste("Test Error Rate for Pruned Tree (5 Nodes):", round(pruned_test_error_rate_5 * 100, 2), "%"))

# Prune the tree with 6 terminal nodes
pruned_tree_6 <- prune.misclass(tree_model, best = 6)
summary(pruned_tree_6)

plot(pruned_tree_6, main = "Pruned Tree with 6 Terminal Nodes")
text(pruned_tree_6, pretty = 0)

pruned_predictions_6 <- predict(pruned_tree_6, newdata = test, type = "class")
pruned_test_error_rate_6 <- 1 - mean(pruned_predictions_6 == test$RiskLevel)
print(paste("Test Error Rate for Pruned Tree 65 Nodes):", round(pruned_test_error_rate_6 * 100, 2), "%"))


# Evaluate the unpruned tree for comparison
unpruned_predictions <- predict(tree_model, newdata = test, type = "class")
unpruned_test_error_rate <- 1 - mean(unpruned_predictions == test$RiskLevel)
print(paste("Test Error Rate for Unpruned Tree:", round(unpruned_test_error_rate * 100, 2), "%"))
