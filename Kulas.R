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

# psych::describe(use)
use2 <- use[,-c(1,3,24)]

fit.lm <- train(POSTSEASON ~ ., data=use2, method="lm", metric=metric, trControl=control)
fit.wm <- train(POSTSEASON ~ ., data=use2, method="WM", metric=metric, trControl=control)
# fit.evtree <- train(POSTSEASON ~ ., data=use2, method="evtree", metric=metric, trControl=control)

results <- resamples(list(lm=fit.lm, wm=fit.wm))
summary(results)
dotplot(results)


validate <- read.csv("cbb21.csv")
validate <- validate[,-c(1,3)]

predictions <- predict(fit.lm, validate)
write.csv(predictions, "winner.csv")
