## can't find old downloadable site so cut/paste from barttovik site - need to rename columns but mostly looks similar - 3/15/23

old <- read.csv("cbb.csv")[,-24]
twentyone <- read.csv("2023/cbb21_scored.csv")
twentytwo <- read.csv("2023/cbb22_scored.csv")
data <- rbind(old,twentyone,twentytwo)

data$POSTSEASON[data$POSTSEASON=="Champions"] <- 6     # Changing qualitative outcome to numeric (how many rounds won)
data$POSTSEASON[data$POSTSEASON=="2ND"] <- 5 
data$POSTSEASON[data$POSTSEASON=="F4"] <- 4 
data$POSTSEASON[data$POSTSEASON=="E8"] <- 3
data$POSTSEASON[data$POSTSEASON=="S16"] <- 2
data$POSTSEASON[data$POSTSEASON=="R32"] <- 1
data$POSTSEASON[data$POSTSEASON=="R64"] <- 0 

data$POSTSEASON <- as.numeric(data$POSTSEASON)
descr::freq(data$POSTSEASON)

###################################################
###################################################
###################################################
###################################################
###################################################

library(caret)

control <- trainControl(method="cv", number=10,verboseIter = TRUE)
metric <- "RMSE"

use <- data[complete.cases(data), ]                          # Problem with NAs (3/17/21)

use2 <- use[,-c(1,2,3,24)]
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


# summarize accuracy of models
results <- resamples(list(cart=fit.cart, knn=fit.knn, svm=fit.svm, rf=fit.rf, lm=fit.lm, wm=fit.wm))
summary(results)
dotplot(results)


##########################################################
##########################################################
##########################################################

new <- read.csv("2023/use2023.csv.csv")[,-1]

names(new)[names(new) == "EFG."] <- "EFG_O"
names(new)[names(new) == "EFGD."] <- "EFG_D"
names(new)[names(new) == "X2P."] <- "X2P_O"
names(new)[names(new) == "X2P.D"] <- "X2P_D"
names(new)[names(new) == "X3P."] <- "X3P_O"
names(new)[names(new) == "X3P.D"] <- "X3P_D"
names(new)[names(new) == "ADJ.T."] <- "ADJ_T"

validate <- new[,-c(1,2)]

predictions <- predict(fit.lm, validate)
write.csv(predictions, "2023//winner3.csv")
