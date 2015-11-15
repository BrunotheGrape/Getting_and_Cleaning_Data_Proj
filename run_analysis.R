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

varNames <- varNames$V2 #naming activity variable columns
setnames(tsbjx, varNames)
setnames(trnsbjx, varNames)

        #creating combined data set

tsbjf <- cbind(tsbja, tsbjx)
trnsbjf <- cbind(trnsbja, trnsbjx)
prod <- rbind(tsbjf, trnsbjf)

        #create tidy dataframe
nms <- c(id, anm, varNames)
tidy.data <- data.frame()
tidy.m <- data.frame()
m <- data.frame()
col1 <- data.frame()
sbjid <- data.frame()
sbj <- data.frame()
actid <- data.frame()
act <- data.frame()

        # subsetting data and extracting column means

for (i in 1:30) {
sbst1 <- filter(prod, test_sbj_id == i) # subset by test subject
for (l in 1:6) {
sbst2 <- filter(sbst1, activity_no == l) # subset by activity
sbcol1 <- select(sbst2, -(test_sbj_id:activity_name)) #subset for activity columns
m <- colMeans(sbcol1, na.rm = TRUE)
m <- t(m)
m <- as.data.frame(m)
tidy.m <- rbind(tidy.m, m)
sbj <- i
sbjid <- rbind(sbjid, sbj )
act <- l
actid <- rbind(actid, act)

}
}

tidy.data <- tidy.m
setnames(sbjid, "test_sbj_id")
setnames(actid, "activity_no")
setnames(tidy.data, varNames)
tdactcoltst <- merge(actid, actNames, by.x = "activity_no", by.y = "activity_no" )
tidy.data <- cbind(tdactcoltst, tidy.data)
tidy.data <- cbind(sbjid, tidy.data)


