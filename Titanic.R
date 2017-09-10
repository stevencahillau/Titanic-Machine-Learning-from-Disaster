train <- read.csv(file = "~/AnacondaProjects/Titanic Machine Learning/train.csv", stringsAsFactors = FALSE, header = TRUE)
test <- read.csv(file = "~/AnacondaProjects/Titanic Machine Learning/test.csv", stringsAsFactors = FALSE, header = TRUE)

# SURVIVAL RATE
prop.table(table(train$Survived)) * 100
#= 38.38384 Survived

# SURVIVAL RATE BY SEX
prop.table(table(train$Survived, train$Sex), 1) * 100
#= 68.12865 Females Survived | 31.87135 Males Survived

# SURVIVAL RATE BY PCLASS
prop.table(table(train$Survived, train$Pclass), 1) * 100
#       1        2        3
#   0   14.57195 17.66849 67.75956
#   1   39.76608 25.43860 34.79532

# SURVIVAL RATE BY SEX AND PCLASS
prop.table(table(train$Pclass, train$Sex, train$Survived), 1) * 100
# DID NOT SURVIVE
#       female      male
#   1   1.388889 35.648148
#   2   3.260870 49.456522
#   3   14.663951 61.099796
# SURVIVED
#       female      male
#   1   42.129630 20.833333
#   2   38.043478  9.239130
#   3   14.663951  9.572301

df <- data.frame(train$Survived == 0, train$Sex == 'female', train$Pclass == 1)
head(df)


####################################################################################################
# RESET COLUMN

test$Survived <- rep(0, 418)

# MAKE PREDICTION
test$Survived <- 0
test$Survived[test$Sex == 'female'] <- 1
test$Survived[test$Sex == 'female' & test$Pclass == 3 & test$Far >= 20] <- 0

# WRITE TO FILE
submit <- data.frame(PassengerId = test$PassengerId, Survived = test$Survived)
write.csv(submit, file = "~/AnacondaProjects/Titanic Machine Learning/TitanicPrediction.csv", row.names = FALSE)