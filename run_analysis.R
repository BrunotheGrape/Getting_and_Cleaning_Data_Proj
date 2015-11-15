        # loading required packages
require(data.table)
require(dplyr)
        #creating column names vectors
ano <- c("activity_no")
anm <- c("activity_no", "activity_name")
id <- c("test_sbj_id", "test_or_train")
        #reading in the data
tsbjx <- fread("test/X_test.txt") 
tsbjy <- fread("test/Y_test.txt", col.names = ano)
tsbjt <- fread("test/subject_test.txt")
trnsbjx <- fread("train/X_train.txt")
trnsbjy <- fread("train/Y_train.txt", col.names = ano)
trnsbjt <- fread("train/subject_train.txt")
varNames <- fread("features.txt")
actNames <- fread("activity_labels.txt", col.names = anm)
        #creating additional columns
actcoltst <- merge(tsbjy, actNames, by.x = "activity_no", by.y = "activity_no" ) #creates activity names columns
actcoltrn <- merge(trnsbjy, actNames, by.x = "activity_no", by.y = "activity_no" )

tsbjt <- cbind(tsbjt, "test") #adds data for tst_or_trn to test subject id columns
trnsbjt <- cbind(trnsbjt, "train")
setnames(tsbjt, id)
setnames(trnsbjt, id)
tsbja <- cbind(tsbjt, actcoltst) # combines test subject id with activity names 
trnsbja <- cbind(trnsbjt, actcoltrn)
        #naming activity variable columns

varNames <- varNames$V2
setnames(tsbjx, varNames)
setnames(trnsbjx, varNames)

        #creating combined data set

tsbjf <- cbind(tsbja, tsbjx)
trnsbjf <- cbind(trnsbja, trnsbjx)
prod <- rbind(tsbjf, trnsbjf)

