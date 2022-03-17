data <- read.csv("cbb.csv")

data$POSTSEASON[data$POSTSEASON=="Champions"] <- 1     # Changing qualitative outcome to numeric (how many rounds won)
data$POSTSEASON[data$POSTSEASON=="2ND"] <- 1 
data$POSTSEASON[data$POSTSEASON=="F4"] <- 1
data$POSTSEASON[data$POSTSEASON=="E8"] <- 1
data$POSTSEASON[data$POSTSEASON=="S16"] <- 1
data$POSTSEASON[data$POSTSEASON=="R32"] <- 1
data$POSTSEASON[data$POSTSEASON=="R64"] <- 0 
data$POSTSEASON[data$POSTSEASON=="R68"] <- 0 

# data$POSTSEASON[is.na(data$POSTSEASON)] <- 0

data$POSTSEASON <- as.factor(as.character(data$POSTSEASON))
#hist(data$POSTSEASON)

library(caret)

control <- trainControl(method="repeatedcv", number=10, repeats = 10, verbose = TRUE, search = "grid")
metric <- "Accuracy"
tuneLength <- 10

use <- data[complete.cases(data), ]                          # Problem with NAs (3/17/21)
# fit.svm <- train(POSTSEASON ~ ., data=use, method="lm", metric=metric, trControl=control)

## Too many predictors, need to trim down

# psych::describe(use)
use2 <- use[,-c(1,2,3,24)]

fit.LR <- train(POSTSEASON~., data=use2, method="glm", metric=metric, trControl=control, preProcess = c("center", "scale"), tuneLength = tuneLength)

print(fit.LR)

validate <- read.csv("cbb22.csv")
validate <- validate[,-c(1,2,3)]

predictions <- predict(fit.LR, validate, type="prob")
write.csv(predictions, "winner_round_1.csv")


########################################################################################
########################################################################################

data <- read.csv("cbb.csv")

data$POSTSEASON[data$POSTSEASON=="Champions"] <- 1     # Changing qualitative outcome to numeric (how many rounds won)
data$POSTSEASON[data$POSTSEASON=="2ND"] <- 1 
data$POSTSEASON[data$POSTSEASON=="F4"] <- 1
data$POSTSEASON[data$POSTSEASON=="E8"] <- 1
data$POSTSEASON[data$POSTSEASON=="S16"] <- 1
data$POSTSEASON[data$POSTSEASON=="R32"] <- 0
data$POSTSEASON[data$POSTSEASON=="R64"] <- 0 
data$POSTSEASON[data$POSTSEASON=="R68"] <- 0 

# data$POSTSEASON[is.na(data$POSTSEASON)] <- 0

data$POSTSEASON <- as.factor(as.character(data$POSTSEASON))
#hist(data$POSTSEASON)

library(caret)

control <- trainControl(method="repeatedcv", number=10, repeats = 10, verbose = TRUE, search = "grid")
metric <- "Accuracy"
tuneLength <- 10

use <- data[complete.cases(data), ]                          # Problem with NAs (3/17/21)
# fit.svm <- train(POSTSEASON ~ ., data=use, method="lm", metric=metric, trControl=control)

## Too many predictors, need to trim down

# psych::describe(use)
use2 <- use[,-c(1,2,3,24)]

fit.LR <- train(POSTSEASON~., data=use2, method="glm", metric=metric, trControl=control, preProcess = c("center", "scale"), tuneLength = tuneLength)

print(fit.LR)

validate <- read.csv("cbb22.csv")
validate <- validate[,-c(1,2,3)]

predictions <- predict(fit.LR, validate, type="prob")
write.csv(predictions, "winner_round_2.csv")


########################################################################################
########################################################################################

data <- read.csv("cbb.csv")

data$POSTSEASON[data$POSTSEASON=="Champions"] <- 1     # Changing qualitative outcome to numeric (how many rounds won)
data$POSTSEASON[data$POSTSEASON=="2ND"] <- 1 
data$POSTSEASON[data$POSTSEASON=="F4"] <- 1
data$POSTSEASON[data$POSTSEASON=="E8"] <- 1
data$POSTSEASON[data$POSTSEASON=="S16"] <- 0
data$POSTSEASON[data$POSTSEASON=="R32"] <- 0
data$POSTSEASON[data$POSTSEASON=="R64"] <- 0 
data$POSTSEASON[data$POSTSEASON=="R68"] <- 0 

# data$POSTSEASON[is.na(data$POSTSEASON)] <- 0

data$POSTSEASON <- as.factor(as.character(data$POSTSEASON))
#hist(data$POSTSEASON)

library(caret)

control <- trainControl(method="repeatedcv", number=10, repeats = 10, verbose = TRUE, search = "grid")
metric <- "Accuracy"
tuneLength <- 10

use <- data[complete.cases(data), ]                          # Problem with NAs (3/17/21)
# fit.svm <- train(POSTSEASON ~ ., data=use, method="lm", metric=metric, trControl=control)

## Too many predictors, need to trim down

# psych::describe(use)
use2 <- use[,-c(1,2,3,24)]

fit.LR <- train(POSTSEASON~., data=use2, method="glm", metric=metric, trControl=control, preProcess = c("center", "scale"), tuneLength = tuneLength)

print(fit.LR)

validate <- read.csv("cbb22.csv")
validate <- validate[,-c(1,2,3)]

predictions <- predict(fit.LR, validate, type="prob")
write.csv(predictions, "winner_round_3.csv")


########################################################################################
########################################################################################

data <- read.csv("cbb.csv")

data$POSTSEASON[data$POSTSEASON=="Champions"] <- 1     # Changing qualitative outcome to numeric (how many rounds won)
data$POSTSEASON[data$POSTSEASON=="2ND"] <- 1 
data$POSTSEASON[data$POSTSEASON=="F4"] <- 1
data$POSTSEASON[data$POSTSEASON=="E8"] <- 0
data$POSTSEASON[data$POSTSEASON=="S16"] <- 0
data$POSTSEASON[data$POSTSEASON=="R32"] <- 0
data$POSTSEASON[data$POSTSEASON=="R64"] <- 0 
data$POSTSEASON[data$POSTSEASON=="R68"] <- 0 

# data$POSTSEASON[is.na(data$POSTSEASON)] <- 0

data$POSTSEASON <- as.factor(as.character(data$POSTSEASON))
#hist(data$POSTSEASON)

library(caret)

control <- trainControl(method="repeatedcv", number=10, repeats = 10, verbose = TRUE, search = "grid")
metric <- "Accuracy"
tuneLength <- 10

use <- data[complete.cases(data), ]                          # Problem with NAs (3/17/21)
# fit.svm <- train(POSTSEASON ~ ., data=use, method="lm", metric=metric, trControl=control)

## Too many predictors, need to trim down

# psych::describe(use)
use2 <- use[,-c(1,2,3,24)]

fit.LR <- train(POSTSEASON~., data=use2, method="glm", metric=metric, trControl=control, preProcess = c("center", "scale"), tuneLength = tuneLength)

print(fit.LR)

validate <- read.csv("cbb22.csv")
validate <- validate[,-c(1,2,3)]

predictions <- predict(fit.LR, validate, type="prob")
write.csv(predictions, "winner_round_4.csv")


########################################################################################
########################################################################################

data <- read.csv("cbb.csv")

data$POSTSEASON[data$POSTSEASON=="Champions"] <- 1     # Changing qualitative outcome to numeric (how many rounds won)
data$POSTSEASON[data$POSTSEASON=="2ND"] <- 1 
data$POSTSEASON[data$POSTSEASON=="F4"] <- 0
data$POSTSEASON[data$POSTSEASON=="E8"] <- 0
data$POSTSEASON[data$POSTSEASON=="S16"] <- 0
data$POSTSEASON[data$POSTSEASON=="R32"] <- 0
data$POSTSEASON[data$POSTSEASON=="R64"] <- 0 
data$POSTSEASON[data$POSTSEASON=="R68"] <- 0 

# data$POSTSEASON[is.na(data$POSTSEASON)] <- 0

data$POSTSEASON <- as.factor(as.character(data$POSTSEASON))
#hist(data$POSTSEASON)

library(caret)

control <- trainControl(method="repeatedcv", number=10, repeats = 10, verbose = TRUE, search = "grid")
metric <- "Accuracy"
tuneLength <- 10

use <- data[complete.cases(data), ]                          # Problem with NAs (3/17/21)
# fit.svm <- train(POSTSEASON ~ ., data=use, method="lm", metric=metric, trControl=control)

## Too many predictors, need to trim down

# psych::describe(use)
use2 <- use[,-c(1,2,3,24)]

fit.LR <- train(POSTSEASON~., data=use2, method="glm", metric=metric, trControl=control, preProcess = c("center", "scale"), tuneLength = tuneLength)

print(fit.LR)

validate <- read.csv("cbb22.csv")
validate <- validate[,-c(1,2,3)]

predictions <- predict(fit.LR, validate, type="prob")
write.csv(predictions, "winner_round_5.csv")


########################################################################################
########################################################################################

data <- read.csv("cbb.csv")

data$POSTSEASON[data$POSTSEASON=="Champions"] <- 1     # Changing qualitative outcome to numeric (how many rounds won)
data$POSTSEASON[data$POSTSEASON=="2ND"] <- 0 
data$POSTSEASON[data$POSTSEASON=="F4"] <- 0
data$POSTSEASON[data$POSTSEASON=="E8"] <- 0
data$POSTSEASON[data$POSTSEASON=="S16"] <- 0
data$POSTSEASON[data$POSTSEASON=="R32"] <- 0
data$POSTSEASON[data$POSTSEASON=="R64"] <- 0 
data$POSTSEASON[data$POSTSEASON=="R68"] <- 0 

# data$POSTSEASON[is.na(data$POSTSEASON)] <- 0

data$POSTSEASON <- as.factor(as.character(data$POSTSEASON))
#hist(data$POSTSEASON)

library(caret)

control <- trainControl(method="repeatedcv", number=10, repeats = 10, verbose = TRUE, search = "grid")
metric <- "Accuracy"
tuneLength <- 10

use <- data[complete.cases(data), ]                          # Problem with NAs (3/17/21)
# fit.svm <- train(POSTSEASON ~ ., data=use, method="lm", metric=metric, trControl=control)

## Too many predictors, need to trim down

# psych::describe(use)
use2 <- use[,-c(1,2,3,24)]

fit.LR <- train(POSTSEASON~., data=use2, method="glm", metric=metric, trControl=control, preProcess = c("center", "scale"), tuneLength = tuneLength)

print(fit.LR)

validate <- read.csv("cbb22.csv")
validate <- validate[,-c(1,2,3)]

predictions <- predict(fit.LR, validate, type="prob")
write.csv(predictions, "winner_round_6.csv")



