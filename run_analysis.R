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
m <- data.frame()
col1 <- data.frame()
setnames(col1, test_sbj_id)
sbjid <- data.frame()
sbj <- data.frame()

        # subsetting data and extracting column means

for (i in 1:30) {
sbst1 <- filter(prod, test_sbj_id == i) # subset by test subject
for (l in 1:6) {
sbst2 <- filter(sbst1, activity_no == l) # subset by activity
sbcol1 <- select(sbst2, -(test_sbj_id:activity_name)) #subset for activity columns
m <- colMeans(sbcol1, na.rm = TRUE)
tidy.data <- rbind(tidy.data, m)
sbj <- i
sbjid <- rbind(sbjid, sbj )               }
}
#m <- as.data.frame(m)

#m <- t(m)
#sbcol2 <- sbst2[1 , 1:4]
#col1 <- cbind(sbcol2, m)
#col1 <- unique(col1)
#tidy.data <- rbind(tidy.data, col1)
}
#setnames(tidy.data, nms)
#tidy.data <- merge(tidy.data, col1, all = TRUE)

# sapply(1:30, function(prod) filter(prod, test_sbj_id == ind)
                #rslt2 <- colMeans(select(rslt1, -(test_sbj_id:activity_name)))

# x <- filter(prod, test_sbj_id == 3)

for (i in 1:30) {print(i)}
