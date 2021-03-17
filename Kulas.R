data <- read.csv("cbb.csv")

data$POSTSEASON[data$POSTSEASON=="Champions"] <- 6     # Changing qualitative outcome to numeric (how many rounds won)
data$POSTSEASON[data$POSTSEASON=="2ND"] <- 5 
data$POSTSEASON[data$POSTSEASON=="F4"] <- 4 
data$POSTSEASON[data$POSTSEASON=="E8"] <- 3
data$POSTSEASON[data$POSTSEASON=="S16"] <- 2
data$POSTSEASON[data$POSTSEASON=="R32"] <- 1
data$POSTSEASON[data$POSTSEASON=="R64"] <- 0 

data$POSTSEASON <- as.numeric(data$POSTSEASON)
hist(data$POSTSEASON)

library(caret)

control <- trainControl(method="cv", number=10)
metric <- "RMSE"

use <- data[complete.cases(data), ]                          # Problem with NAs (3/17/21)
# fit.svm <- train(POSTSEASON ~ ., data=use, method="lm", metric=metric, trControl=control)

## Too many predictors, need to trim down

psych::describe(use)
use2 <- use[,-c(1,3,24)]
fit.svm <- train(POSTSEASON ~ ., data=use2, method="lm", metric=metric, trControl=control)
summary(fit.svm)
