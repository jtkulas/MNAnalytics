## salvaged from 2023//twenty24.R  (3/19/25)

## toRvik has been depreciated - need to use `cbbdata`

library(cbbdata)
cbbdata::cbd_login(username='John Kulas', password='Haskins94')
write.csv(cbd_torvik_ratings(2025), "2025//2025.csv")  ## current year at bottom of file



old <- read.csv("2023//2015_2022_scored.csv.csv")                     ## had tourney results
new <- read.csv("2023//2023 - 2023.csv.csv", na.strings=c("","NA"))   ## also tourney results
new24 <- read.csv("2025//2024.csv.csv", na.strings=c("","NA"))
names(new24)[3] <- "X.1" 
## Scoring 2024 by hand (3/19/25)


temp <- rbind(old,new,new24)
use <- na.omit(temp)

names(use)[names(use) == "final"] <- "POSTSEASON"

use$POSTSEASON[use$POSTSEASON=="Champions"] <- 6     # Changing qualitative outcome to numeric (how many rounds won)
use$POSTSEASON[use$POSTSEASON=="2ND"]       <- 5     
use$POSTSEASON[use$POSTSEASON=="F4"]        <- 4 
use$POSTSEASON[use$POSTSEASON=="E8"]        <- 3
use$POSTSEASON[use$POSTSEASON=="S16"]       <- 2
use$POSTSEASON[use$POSTSEASON=="R32"]       <- 1
use$POSTSEASON[use$POSTSEASON=="R64"]       <- -1    ## change to -1 (2025)

use$POSTSEASON <- as.numeric(use$POSTSEASON)
hist(use$POSTSEASON)

######################
######################

library(caret)

control <- trainControl(method="cv", number=10,verboseIter = TRUE)
metric <- "RMSE"

use2 <- use[,-c(1,2,3,4,21)]  # index, conf, year
use3 <- use[,-c(1,2,21)]

##########################################
##########################################
##########################################
##########################################

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



thisyear <- read.csv("2025//2025 - Sheet1.csv")  ## need to chop from bottom of `cbd_torvik_ratings(2025)`
intermediate <- na.omit(thisyear)
validate <- intermediate[,-c(1,2,3,20)]
predict <- intermediate[,2]
write.csv(predict, "predictionfile.csv")

predictions <- predict(fit.svm, validate)   ## wm, rf, svm (I think)
write.csv(predictions, "2025//winner.csv")
