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
nms <- c(id, anm, varNames) # creating naming vector

tidy.data <- data.frame() #estblishing data frames for future use
tidy.m <- data.frame()
m <- data.frame()
col1 <- data.frame()
sbjid <- data.frame()
sbj <- data.frame()
actid <- data.frame()
act <- data.frame()

        # subsetting data and extracting column means

for (i in 1:30) { # for loop to loop through test subject id numbers
sbst1 <- filter(prod, test_sbj_id == i) # subset by test subject
for (l in 1:6) { # for loop to loop through activities by number
sbst2 <- filter(sbst1, activity_no == l) # subset by activity
sbcol1 <- select(sbst2, -(test_sbj_id:activity_name)) #subset for activity columns
m <- colMeans(sbcol1, na.rm = TRUE) # calculating the column means and storing it in "m"
m <- t(m) # reorienting m as a column
m <- as.data.frame(m) # redifining m as a data frame
tidy.m <- rbind(tidy.m, m) # using row bind to store reults in "tidy.m"
sbj <- i # storing the test subject id
sbjid <- rbind(sbjid, sbj )
act <- l # storing the activity number
actid <- rbind(actid, act)

}
}

        # assembly the data into the "tidy.data" product

tidy.data <- tidy.m # storing the column means in the "tidy.data" data frame

        #naming the columns of "tidy.data" before binding them into a single object
setnames(sbjid, "test_sbj_id") 
setnames(actid, "activity_no") 
setnames(tidy.data, varNames)

        # combines the collected data into a single data frame called "tidy.data"

tdactcoltst <- merge(actid, actNames, by.x = "activity_no", by.y = "activity_no" )
tidy.data <- cbind(tdactcoltst, tidy.data)
tidy.data <- cbind(sbjid, tidy.data)


