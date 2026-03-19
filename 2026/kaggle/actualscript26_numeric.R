
## `SEED` previously run as character vector in `actualscript26.R`, so re-running as numeric - 3/18/26

cbb <- read.csv("2026//kaggle//cbb.csv") ## appears to have everything needed through 2025

library(dplyr)

cbb2 <- cbb %>%
  mutate(POSTSEASON = na_if(POSTSEASON, "N/A"))

use <- na.omit(cbb2)

use$POSTSEASON[use$POSTSEASON=="Champions"] <- 6     # Changing qualitative outcome to numeric (how many rounds won)
use$POSTSEASON[use$POSTSEASON=="2ND"]       <- 5     
use$POSTSEASON[use$POSTSEASON=="F4"]        <- 4 
use$POSTSEASON[use$POSTSEASON=="E8"]        <- 3
use$POSTSEASON[use$POSTSEASON=="S16"]       <- 2
use$POSTSEASON[use$POSTSEASON=="R32"]       <- 1
use$POSTSEASON[use$POSTSEASON=="R64"]       <- -1    ## change to -1 (2025)
use$POSTSEASON[use$POSTSEASON=="R68"]       <- -2    ## change to -2 (2026; lost "win & in" game

use$POSTSEASON <- as.numeric(use$POSTSEASON)
use$SEED <- as.numeric(use$SEED)
hist(use$POSTSEASON)
hist(use$SEED)

######################
######################

library(caret)

control <- trainControl(method="cv", number=10,verboseIter = TRUE)
metric <- "RMSE"

use2 <- use[,-c(1,3,24)]  # team, games, year -- leaving conf IN

##########################################
##########################################
##########################################
##########################################


fit.lm <- train(POSTSEASON ~ ., data=use2, method="lm", metric=metric, trControl=control, preProcess = "knnImpute")

fit.wm <- train(POSTSEASON ~ ., data=use2, method="WM", metric=metric, trControl=control, preProcess = "knnImpute")

fit.evtree <- train(POSTSEASON ~ ., data=use2, method="evtree", metric=metric, trControl=control)

# CART
fit.cart <- train(POSTSEASON~., data=use2, method="rpart", metric=metric, trControl=control, preProcess = "knnImpute")

# kNN
fit.knn <- train(POSTSEASON~., data=use2, method="knn", metric=metric, trControl=control, preProcess = "knnImpute")

# c) advanced algorithms
# SVM
fit.svm <- train(POSTSEASON~., data=use2, method="svmRadial", metric=metric, trControl=control, preProcess = "knnImpute")
# Random Forest
#set.seed(87)
fit.rf <- train(POSTSEASON~., data=use2, method="rf", metric=metric, trControl=control, preProcess = "knnImpute")

#
# summarize accuracy of models
results <- resamples(list(cart=fit.cart, knn=fit.knn, svm=fit.svm, rf=fit.rf, lm=fit.lm, wm=fit.wm, ev=fit.evtree))
summary(results)
dotplot(results)


#############################################################
#############################################################
#############################################################
###################################################This Year#

cbb26_raw <- read.csv("2026//kaggle//cbb26.csv")[,-c(1,2,4)]

cbb26 <- cbb26_raw %>%
  mutate(SEED = na_if(SEED, "N/A"))

validate <- na.omit(cbb26)

validate$SEED <- as.numeric(validate$SEED)

predictions <- predict(fit.svm, validate)   ## wm, rf, svm (I think)
predictions2 <- predict(fit.lm, validate)   ## wm, rf, svm (I think)
predictions3 <- predict(fit.evtree, validate)   ## wm, rf, svm (I think)
predictions4 <- predict(fit.rf, validate)   ## wm, rf, svm (I think)


teamnames <- read.csv("2026//kaggle//cbb26.csv")
teamnames2 <- teamnames %>%
  mutate(SEED = na_if(SEED, "N/A"))

teamnames3 <- na.omit(teamnames2)

together <- as.data.frame(cbind(teamnames3[,2], predictions, predictions2,predictions3, predictions4))

colnames(together)[2] <- "svm"
colnames(together)[3] <- "lm"
colnames(together)[4] <- "ev"
colnames(together)[5] <- "rf"

write.csv(together, "2026//kaggle//predictions_numeric.csv")
