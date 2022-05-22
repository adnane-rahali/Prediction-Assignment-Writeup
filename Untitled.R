library(caret)
library(zoo)

set.seed(121)
training <- read.csv("pml-training.csv", na.strings=c("", " ","NA"))
training_new <- training[, which(colMeans(!is.na(training)) > 0.25)]
training_new <- training_new[complete.cases(training_new), ]
training_new$classe <- as.factor(training_new$classe)

inTrain<- createDataPartition(training_new$classe, p=0.7, list=FALSE)
train_data<- training_new[inTrain, ]
test_data<- training_new[-inTrain, ]

mod1 <- train(classe~., data = train_data, method="lda", 
              trControl= trainControl(method = "cv", number = 10),
              metric= "Accuracy",
              na.action = na.omit)
