data <- read.csv("cbb.csv")

data$POSTSEASON[data$POSTSEASON=="Champions"] <- 6     # Changing qualitative outcome to numeric (how many rounds won)
data$POSTSEASON[data$POSTSEASON=="2ND"] <- 5 
data$POSTSEASON[data$POSTSEASON=="F4"] <- 4 
data$POSTSEASON[data$POSTSEASON=="E8"] <- 3
data$POSTSEASON[data$POSTSEASON=="S16"] <- 2
data$POSTSEASON[data$POSTSEASON=="R32"] <- 1
data$POSTSEASON[data$POSTSEASON=="R64"] <- 0 

data$POSTSEASON <- as.numeric(data$POSTSEASON)

use <- data[,-c(1,3,24)]
use2 <- use[complete.cases(use), ]                          # Problem with NAs (3/17/21)

a <- psych::describe(use2)

use2[2]  <- (use2[2]-a$mean[2])/a$sd[2]
use2[3]  <- (use2[3]-a$mean[3])/a$sd[3]
use2[4]  <- (use2[4]-a$mean[4])/a$sd[4]
use2[5]  <- (use2[5]-a$mean[5])/a$sd[5]
use2[6]  <- (use2[6]-a$mean[6])/a$sd[6]
use2[7]  <- (use2[7]-a$mean[7])/a$sd[7]
use2[8]  <- (use2[8]-a$mean[8])/a$sd[8]
use2[9]  <- (use2[9]-a$mean[9])/a$sd[9]
use2[10] <- (use2[10]-a$mean[10])/a$sd[10]
use2[11] <- (use2[11]-a$mean[11])/a$sd[11]
use2[12] <- (use2[12]-a$mean[12])/a$sd[12]
use2[13] <- (use2[13]-a$mean[13])/a$sd[13]
use2[14] <- (use2[14]-a$mean[14])/a$sd[14]
use2[15] <- (use2[15]-a$mean[15])/a$sd[15]
use2[16] <- (use2[16]-a$mean[16])/a$sd[16]
use2[17] <- (use2[17]-a$mean[17])/a$sd[17]
use2[18] <- (use2[18]-a$mean[18])/a$sd[18]
use2[19] <- (use2[19]-a$mean[19])/a$sd[19]
use2[21] <- (use2[21]-a$mean[21])/a$sd[21]

use3 <- use2[,-1]

library(caret)

control <- trainControl(method="cv", number=10,verboseIter = TRUE)
metric <- "RMSE"

set.seed(32)
fit.lm   <- train(POSTSEASON ~ ., data=use3, method="lm",        metric=metric, trControl=control)
#fit.wm   <- train(POSTSEASON ~ ., data=use3, method="WM",        metric=metric, trControl=control)
fit.cart <- train(POSTSEASON ~ ., data=use3, method="rpart",     metric=metric, trControl=control)
fit.knn  <- train(POSTSEASON ~ ., data=use3, method="knn",       metric=metric, trControl=control)
fit.svm  <- train(POSTSEASON ~ ., data=use3, method="svmRadial", metric=metric, trControl=control)
fit.rf   <- train(POSTSEASON ~ ., data=use3, method="rf",        metric=metric, trControl=control)

# summarize accuracy of models
results <- resamples(list(cart=fit.cart, knn=fit.knn, svm=fit.svm, rf=fit.rf, lm=fit.lm, wm=fit.wm))
summary(results)
dotplot(results)


validate <- read.csv("cbb21.csv")
validate <- validate[,-c(1:3)]


b <- psych::describe(validate)

validate[1]  <- (validate[1]-b$mean[1])/b$sd[1]
validate[2]  <- (validate[2]-b$mean[2])/b$sd[2]
validate[3]  <- (validate[3]-b$mean[3])/b$sd[3]
validate[4]  <- (validate[4]-b$mean[4])/b$sd[4]
validate[5]  <- (validate[5]-b$mean[5])/b$sd[5]
validate[6]  <- (validate[6]-b$mean[6])/b$sd[6]
validate[7]  <- (validate[7]-b$mean[7])/b$sd[7]
validate[8]  <- (validate[8]-b$mean[8])/b$sd[8]
validate[9]  <- (validate[9]-b$mean[9])/b$sd[9]
validate[10] <- (validate[10]-b$mean[10])/b$sd[10]
validate[11] <- (validate[11]-b$mean[11])/b$sd[11]
validate[12] <- (validate[12]-b$mean[12])/b$sd[12]
validate[13] <- (validate[13]-b$mean[13])/b$sd[13]
validate[14] <- (validate[14]-b$mean[14])/b$sd[14]
validate[15] <- (validate[15]-b$mean[15])/b$sd[15]
validate[16] <- (validate[16]-b$mean[16])/b$sd[16]
validate[17] <- (validate[17]-b$mean[17])/b$sd[17]
validate[18] <- (validate[18]-b$mean[18])/b$sd[18]
validate[19] <- (validate[19]-b$mean[19])/b$sd[19]

predictions <- predict(fit.lm, validate)
write.csv(predictions, "winner_z.csv")

