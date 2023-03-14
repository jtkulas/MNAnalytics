## Trying this package to get 2023 data: (3/13/23)
## https://github.com/andreweatherman/toRvik/blob/HEAD/R/bart_ratings.R
##

## devtools::install_github("andreweatherman/toRvik")

#library(toRvik)

#write.csv(bart_ratings(), "2023//2023.csv")
#write.csv(bart_ratings(2022), "2023//2022.csv")
#write.csv(bart_ratings(2021), "2023//2021.csv")
#write.csv(bart_ratings(2020), "2023//2020.csv")
#write.csv(bart_ratings(2019), "2023//2019.csv")
#write.csv(bart_ratings(2018), "2023//2018.csv")
#write.csv(bart_ratings(2017), "2023//2017.csv")
#write.csv(bart_ratings(2016), "2023//2016.csv")
#write.csv(bart_ratings(2015), "2023//2015.csv")

#data2023 <- read.csv("2023//2023.csv")
#data2022 <- read.csv("2023//2022.csv")
#data2021 <- read.csv("2023//2021.csv")
#data2020 <- read.csv("2023//2020.csv")
#data2019 <- read.csv("2023//2019.csv")
#data2018 <- read.csv("2023//2018.csv")
#data2017 <- read.csv("2023//2017.csv")
#data2016 <- read.csv("2023//2016.csv")
#data2015 <- read.csv("2023//2015.csv")

#data <- rbind(data2022,data2021,data2020,data2019,data2018,data2017,data2016,data2015)

#filtered <- na.omit(data)
#descr::freq(filtered$seed)

#write.csv(filtered, "2023//sevenyears.csv")

## (sometimes incorrect) scores taken from: https://www.ncaa.com/news/basketball-men/article/2020-05-06/2019-ncaa-tournament-bracket-scores-stats-records

use <- read.csv("2023//2015_2022_scored.csv.csv")   ## scored with above

names(use)[names(use) == "final"] <- "POSTSEASON"

use$POSTSEASON[use$POSTSEASON=="Champions"] <- 6     # Changing qualitative outcome to numeric (how many rounds won)
use$POSTSEASON[use$POSTSEASON=="2ND"] <- 5 
use$POSTSEASON[use$POSTSEASON=="F4"] <- 4 
use$POSTSEASON[use$POSTSEASON=="E8"] <- 3
use$POSTSEASON[use$POSTSEASON=="S16"] <- 2
use$POSTSEASON[use$POSTSEASON=="R32"] <- 1
use$POSTSEASON[use$POSTSEASON=="R64"] <- 0 

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



validate <- read.csv("2023//2023.csv")
validate <- na.omit(validate)
validate <- validate[,-c(1,2,3,20)]

predictions <- predict(fit.lm, validate)
write.csv(predictions, "2023//winner.csv")

teams <- read.csv("2023//2023.csv")
teams <- na.omit(teams)
teams <- teams[,2:4]
write.csv(teams, "2023//teams.csv")

