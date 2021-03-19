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

control <- trainControl(method="cv", number=10,verboseIter = TRUE)
metric <- "RMSE"

use <- data[complete.cases(data), ]                          # Problem with NAs (3/17/21)
# fit.svm <- train(POSTSEASON ~ ., data=use, method="lm", metric=metric, trControl=control)


## Too many predictors, need to trim down

# psych::describe(use)
use2 <- use[,-c(1,2,3,24)]
normalize <- function(x) {
  num <- x - mean(x)
  denom <- sd(x)
  return (num/denom)
}
use2 <- as.data.frame(lapply(use2, normalize))

set.seed(32)
fit.lm <- train(POSTSEASON ~ ., data=use2, method="lm", metric=metric, trControl=control, preProcess = "knnImpute")
set.seed(56)
fit.wm <- train(POSTSEASON ~ ., data=use2, method="WM", metric=metric, trControl=control, preProcess = "knnImpute")
# fit.evtree <- train(POSTSEASON ~ ., data=use2, method="evtree", metric=metric, trControl=control)

# CART
set.seed(90)
fit.cart <- train(POSTSEASON~., data=use2, method="rpart", metric=metric, trControl=control, preProcess = "knnImpute")
# kNN
set.seed(12)
fit.knn <- train(POSTSEASON~., data=use2, method="knn", metric=metric, trControl=control, preProcess = "knnImpute")
# c) advanced algorithms
# SVM
set.seed(48)
fit.svm <- train(POSTSEASON~., data=use2, method="svmRadial", metric=metric, trControl=control, preProcess = "knnImpute")
# Random Forest
set.seed(87)
fit.rf <- train(POSTSEASON~., data=use2, method="rf", metric=metric, trControl=control, preProcess = "knnImpute")
set.seed(56)
fit.glmnet<-train(POSTSEASON~.,data=use2,tuneGrid=expand.grid(alpha=0:1,lambda=seq(0.0001,1,length=20)),method="glmnet",metric=metric,trControl=control,preProcess = c("medianImpute","center","scale"))
plot(fit.glmnet)
set.seed(7)
fit.rf <- train(POSTSEASON~., tuneLength=10, data=use2, method="ranger", trControl=control,preProcess = c("medianImpute","center","scale"))
plot(fit.rf)
set.seed(7)
fit.GBM<-train(POSTSEASON~.,data=use2, method="gbm", metric=metric, trControl=control, preProcess= c("medianImpute", "center","scale"))
set.seed(7)
fit.xgboost<-train(POSTSEASON~.,data=use2, method="xgbLinear", metric=metric, trControl=control, preProcess= c("medianImpute", "center","scale"))



# summarize accuracy of models
results <- resamples(list(cart=fit.cart, knn=fit.knn, svm=fit.svm, rf=fit.rf, lm=fit.lm, glmnet=fit.glmnet, gbm=fit.GBM,xgboost=fit.xgboost))
summary(results)
dotplot(results)
results <- resamples(list(lm=fit.lm, wm=fit.wm))
summary(results)
dotplot(results)


validate <- read.csv("cbb21.csv")
validate <- validate[,-c(1,3)]

predictions <- predict(fit.glmnet, validate)
write.csv(predictions, "winner.csv")





####################################################################################################################

data <- read.csv("cbb v2.csv")
use <- data[complete.cases(data), ] 
# Recoding
use$POSTg1<-ifelse(use$POSTg1==1, "win", "lose")
use$POSTg2<-ifelse(use$POSTg2==1, "win", "lose")
use$POSTg3<-ifelse(use$POSTg3==1, "win", "lose")
use$POSTg4<-ifelse(use$POSTg4==1, "win", "lose")
use$POSTg5<-ifelse(use$POSTg5==1, "win", "lose")
use$POSTg6<-ifelse(use$POSTg6==1, "win", "lose")

library(caret)
control <- trainControl(method="cv", number=10,verboseIter = TRUE)
metric <- "Accuracy"

use2 <- use[,-c(1,2,3,24, 22, 26, 27, 28, 29, 30)]

set.seed(7)
fit.lda <- train(POSTg1~., data=use2, method="lda", metric=metric, trControl=control)
# CART
set.seed(90)
fit.cart <- train(POSTg1~., data=use2, method="rpart", metric=metric, trControl=control, preProcess = "knnImpute")
# kNN
set.seed(12)
fit.knn <- train(POSTg1~., data=use2, method="knn", metric=metric, trControl=control, preProcess = "knnImpute")
# c) advanced algorithms
# SVM
set.seed(48)
fit.svm <- train(POSTg1~., data=use2, method="svmRadial", metric=metric, trControl=control, preProcess = "knnImpute")
set.seed(56)
fit.glmnet<-train(POSTg1~.,data=use2,tuneGrid=expand.grid(alpha=0:1,lambda=seq(0.0001,1,length=20)),method="glmnet",metric=metric,trControl=control,preProcess = c("medianImpute","center","scale"))
set.seed(7)
fit.rf <- train(POSTg1~., tuneLength=10, data=use2, method="ranger", trControl=control,preProcess = c("medianImpute","center","scale"))
set.seed(7)
fit.GBM<-train(POSTg1~.,data=use2, method="gbm", metric=metric, trControl=control, preProcess= c("medianImpute", "center","scale"))
set.seed(7)
fit.xgboost<-train(POSTg1~.,data=use2, method="xgbLinear", metric=metric, trControl=control, preProcess= c("medianImpute", "center","scale"))
set.seed(4)
fit.glm<-train(POSTg1~., data=use2, method="glm", metric=metric, trControl=control)

# summarize accuracy of models
results <- resamples(list(lda=fit.lda, cart=fit.cart, knn=fit.knn, svm=fit.svm, rf=fit.rf, glmnet=fit.glmnet, gbm=fit.GBM, xgboost=fit.xgboost, glm=fit.glm))
summary(results)
dotplot(results)

validate <- read.csv("cbb21.csv")
validate <- validate[,-c(1,3)]

predictions <- predict(fit.glm, validate)
write.csv(predictions, "round1.csv")
