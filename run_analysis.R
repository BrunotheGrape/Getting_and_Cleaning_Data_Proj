require(data.table)
require(dplyr)

tsbjx <- fread("test/X_test.txt")
tsbjy <- fread("test/Y_test.txt")
tsbjt <- fread("test/subject_test.txt")
trnsbjx <- fread("train/X_train.txt")
trnsbjy <- fread("train/Y_train.txt")
trnsbjt <- fread("train/subject_train.txt")
varNames <- fread("features.txt")
varNames <- varNames$V2
actNames <- fread("activity_labels.txt")
setnames(tsbjx, varNames)
setnames(trnsbjx, varNames)
actcol <- merge(tsbjy, actNames, by.x="V1",by.y="V1" )

