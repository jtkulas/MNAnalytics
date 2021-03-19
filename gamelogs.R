ind.games <- read.csv("MDataFiles_Stage1//MRegularSeasonCompactResults.csv")
teams <- read.csv("MDataFiles_Stage1//MTeams.csv")
teams <- teams[,c(1:2)]
## Scrub out 2009 and earlier (predictors only 2010 through 2021)

twenty10 <- read.csv("2010.csv")
twenty11 <- read.csv("2011.csv")
twenty12 <- read.csv("2012.csv")
twenty13 <- read.csv("2013.csv")
twenty14 <- read.csv("2014.csv")
twenty15 <- read.csv("2015.csv")
twenty16 <- read.csv("2016.csv")
twenty17 <- read.csv("2017.csv")
twenty18 <- read.csv("2018.csv")
twenty19 <- read.csv("2019.csv")

current <- read.csv("current.csv")

write.csv(teams$TeamName, "names_games.csv")
write.csv(twenty10$X.1, "names_predict.csv")

twenty10$X.1 <- gsub("NCAA", "", twenty10$X.1)   ## predictors have "NCAA" next to tournament teams - prob still have match issues but will be better
twenty11$X.1 <- gsub("NCAA", "", twenty11$X.1)
twenty12$X.1 <- gsub("NCAA", "", twenty12$X.1)
twenty13$X.1 <- gsub("NCAA", "", twenty13$X.1)
twenty14$X.1 <- gsub("NCAA", "", twenty14$X.1)
twenty15$X.1 <- gsub("NCAA", "", twenty15$X.1)
twenty16$X.1 <- gsub("NCAA", "", twenty16$X.1)
twenty17$X.1 <- gsub("NCAA", "", twenty17$X.1)
twenty18$X.1 <- gsub("NCAA", "", twenty18$X.1)
twenty19$X.1 <- gsub("NCAA", "", twenty19$X.1)
current$X.1 <- gsub("NCAA", "", current$X.1)

twenty10 <- twenty10[-1,]
twenty11 <- twenty11[-1,]
twenty12 <- twenty12[-1,]
twenty13 <- twenty13[-1,]
twenty14 <- twenty14[-1,]
twenty15 <- twenty15[-1,]
twenty16 <- twenty16[-1,]
twenty17 <- twenty17[-1,]
twenty18 <- twenty18[-1,]
twenty19 <- twenty19[-1,]
current <- current[-1,]

use <- subset(ind.games, Season > 2009)
together <- merge(ind.games, teams, by.x = "WTeamID", by.y = "TeamID")
both <- merge(together, teams, by.x = "LTeamID", by.y = "TeamID")

names(both)[names(both) == "TeamName.x"] <- "Winner"
names(both)[names(both) == "TeamName.y"] <- "Loser"

game2010 <- subset(both, Season == 2010)
game2011 <- subset(both, Season == 2011)
game2012 <- subset(both, Season == 2012)
game2013 <- subset(both, Season == 2013)
game2014 <- subset(both, Season == 2014)
game2015 <- subset(both, Season == 2015)
game2016 <- subset(both, Season == 2016)
game2017 <- subset(both, Season == 2017)
game2018 <- subset(both, Season == 2018)
game2019 <- subset(both, Season == 2019)

to_2010 <- merge(game2010, twenty10, by.x = "Winner", by.y = "X.1")   ## Adding winning team predictors
to_2011 <- merge(game2011, twenty11, by.x = "Winner", by.y = "X.1")
to_2012 <- merge(game2012, twenty12, by.x = "Winner", by.y = "X.1")
to_2013 <- merge(game2013, twenty13, by.x = "Winner", by.y = "X.1")
to_2014 <- merge(game2014, twenty14, by.x = "Winner", by.y = "X.1")
to_2015 <- merge(game2015, twenty15, by.x = "Winner", by.y = "X.1")
to_2016 <- merge(game2016, twenty16, by.x = "Winner", by.y = "X.1")
to_2017 <- merge(game2017, twenty17, by.x = "Winner", by.y = "X.1")
to_2018 <- merge(game2018, twenty18, by.x = "Winner", by.y = "X.1")
to_2019 <- merge(game2019, twenty19, by.x = "Winner", by.y = "X.1")

bo_2010 <- merge(to_2010, twenty10, by.x = "Loser", by.y = "X.1")     ## Adding losing team predictors
bo_2011 <- merge(to_2011, twenty11, by.x = "Loser", by.y = "X.1")
bo_2012 <- merge(to_2012, twenty12, by.x = "Loser", by.y = "X.1")
bo_2013 <- merge(to_2013, twenty13, by.x = "Loser", by.y = "X.1")
bo_2014 <- merge(to_2014, twenty14, by.x = "Loser", by.y = "X.1")
bo_2015 <- merge(to_2015, twenty15, by.x = "Loser", by.y = "X.1")
bo_2016 <- merge(to_2016, twenty16, by.x = "Loser", by.y = "X.1")
bo_2017 <- merge(to_2017, twenty17, by.x = "Loser", by.y = "X.1")
bo_2018 <- merge(to_2018, twenty18, by.x = "Loser", by.y = "X.1")
bo_2019 <- merge(to_2019, twenty19, by.x = "Loser", by.y = "X.1")

big_predictor_win <- rbind(bo_2010, bo_2011, bo_2012, bo_2013, bo_2014, bo_2015, bo_2016, bo_2017, bo_2018, bo_2019)

big_predictor_win$DV1 <- 1
big_predictor_win$DV3 <- big_predictor_win$WScore - big_predictor_win$LScore
  
## need to duplicate for loser but swap winner and losers

toq_2010 <- merge(game2010, twenty10, by.x = "Loser", by.y = "X.1")   ## Adding winning team predictors
toq_2011 <- merge(game2011, twenty11, by.x = "Loser", by.y = "X.1")
toq_2012 <- merge(game2012, twenty12, by.x = "Loser", by.y = "X.1")
toq_2013 <- merge(game2013, twenty13, by.x = "Loser", by.y = "X.1")
toq_2014 <- merge(game2014, twenty14, by.x = "Loser", by.y = "X.1")
toq_2015 <- merge(game2015, twenty15, by.x = "Loser", by.y = "X.1")
toq_2016 <- merge(game2016, twenty16, by.x = "Loser", by.y = "X.1")
toq_2017 <- merge(game2017, twenty17, by.x = "Loser", by.y = "X.1")
toq_2018 <- merge(game2018, twenty18, by.x = "Loser", by.y = "X.1")
toq_2019 <- merge(game2019, twenty19, by.x = "Loser", by.y = "X.1")

boq_2010 <- merge(to_2010, twenty10, by.x = "Winner", by.y = "X.1")     ## Adding losing team predictors
boq_2011 <- merge(to_2011, twenty11, by.x = "Winner", by.y = "X.1")
boq_2012 <- merge(to_2012, twenty12, by.x = "Winner", by.y = "X.1")
boq_2013 <- merge(to_2013, twenty13, by.x = "Winner", by.y = "X.1")
boq_2014 <- merge(to_2014, twenty14, by.x = "Winner", by.y = "X.1")
boq_2015 <- merge(to_2015, twenty15, by.x = "Winner", by.y = "X.1")
boq_2016 <- merge(to_2016, twenty16, by.x = "Winner", by.y = "X.1")
boq_2017 <- merge(to_2017, twenty17, by.x = "Winner", by.y = "X.1")
boq_2018 <- merge(to_2018, twenty18, by.x = "Winner", by.y = "X.1")
boq_2019 <- merge(to_2019, twenty19, by.x = "Winner", by.y = "X.1")

big_predictor_lose <- rbind(boq_2010, boq_2011, boq_2012, boq_2013, boq_2014, boq_2015, boq_2016, boq_2017, boq_2018, boq_2019)

big_predictor_lose$DV1 <- 0
big_predictor_lose$DV3 <- big_predictor_lose$LScore - big_predictor_lose$WScore

tlose <- t(big_predictor_lose)
tsort <- tlose[order(row.names(tlose)),]
big_predictor_lose <- as.data.frame(t(tsort))

twin <- t(big_predictor_win)
tsortw <- twin[order(row.names(twin)),]
big_predictor_win <- as.data.frame(t(tsortw))

finally <- rbind(big_predictor_win, big_predictor_lose)

library(caret)

control <- trainControl(method="cv", number=10)
metric <- "RMSE"

## psych::describe(finally)
finally <- finally[,-c(27,28,31,32,35,36,71,72,75,76)] ## data not completely good but tourney starts manana
finally2 <- finally[,c(7,14:19,25:68)]
dat2 <- data.frame(lapply(finally2, function(x) as.numeric(as.character(x))))

user <- dat2[complete.cases(dat2), ]

# user$DV2 <- as.factor(as.character(user$DV1))

memory.limit(16500)
fit.lm <- train(DV3 ~ ., data=user, method="lm", metric=metric, trControl=control)
# summary(fit.lm)

write.csv(game2010, "template.csv")


current <- read.csv("current_bracket.csv")
current <- current[-1,]

both2 <- read.csv("bracket.csv")

pred_to_2010 <- merge(both2, current, by.x = "Winner", by.y = "X.1")  
pred_bo_2010 <- merge(pred_to_2010, current, by.x = "Loser", by.y = "X.1")   

tlose <- t(pred_bo_2010)
tsort <- tlose[order(row.names(tlose)),]
big_validate <- as.data.frame(t(tsort))

psych::describe(big_validate)

finally3 <- big_validate[,c(12:17,23:24,27:28,31:32,35:68,71:72,75:76)]
validate <- data.frame(lapply(finally3, function(x) as.numeric(as.character(x))))

predictions <- predict(fit.lm, validate)
write.csv(predictions, "winnerR1.csv")


