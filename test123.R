---
  title: "Untitled"
author: "Vick"
date: "November 27, 2017"
output: word_document
---
  
  ```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```


```{r}
library(e1071)
library(randomForest)
library(ranger)
library(plyr)
library(caret)
library(lubridate)
```


```{r}
train = read.csv("C:/Users/Vick/Documents/train.csv", header = TRUE)
```



```{r}
train$Dates <- strptime(train$Dates, "%Y-%m-%d %H:%M:%S", tz="GMT")                                                  
train$Years <- as.factor(year(train$Dates))
train$Years = as.numeric(train$Years)
train$Months <- as.factor(month(train$Dates))
train$Months <- as.numeric(train$Months)
train$Hour <- as.factor(hour(train$Dates))
train$Hour <- as.numeric(train$Hour)
```


```{r}
train = train[,-c(1,3,6,7)]
```

```{r}
set.seed(120)
```


```{r}
index = createDataPartition(train$Category, p = .7, list = F)
df.train = train[index,]
df.test = train[-index,]
```


```{r}
set.seed(120)
```

```{r}
rangermodel = ranger(Category ~ ., data = df.train, importance = "impurity", write.forest = TRUE, verbose = TRUE, mtry = 2.8, splitrule = "gini")
rangermodel.predict = predict(rangermodel,df.test[,-1])
confusion.ranger = confusionMatrix(rangermodel.predict$predictions,df.test$Category)
```


