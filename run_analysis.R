#setting the path of working directory
setwd("C:/Users/Terence/R/UCI HAR Dataset/train")
##getting data from train directory
a<-read.table("subject_train.txt")
b<-read.table("X_train.txt")
c<-read.table("y_train.txt")
#appending the data
mg<-append(c,b,after=ncol(c))
#getting the train data frame into one file
df<-append(a,mg,after=length(mg))
df<-as.data.frame(df)
#getting data from test directory
setwd( "C:/Users/Terence/R/UCI HAR Dataset/test")
f<-read.table("subject_test.txt")
g<-read.table("x_test.txt")
h<-read.table("y_test.txt")
hg<-append(h,g,after=ncol(h))
df2<-append(f,hg,after=length(hg))
df2<-as.data.frame(df2)
finaldata.frame<-rbind(df,df2)
#naming the columns
setwd("C:/Users/Terence/R/UCI HAR Dataset")
m<-read.table("features.txt")
names(finaldata.frame)<-c("subject","activity",as.character(m$V2))
#extracting the means and standard deviations
MEAN<-finaldata.frame[grep("mean()",fixed=TRUE,names(finaldata.frame))]
Deviation<-finaldata.frame[grep("std()",names(finaldata.frame))]
STDMEAN<-append(MEAN,Deviation,after=ncol(MEAN))
STDMEAN<-as.data.frame(STDMEAN)
x<-factor(finaldata.frame$activity)
Activity<-read.table("activity_labels.txt")
labels<-as.character(Activity$V2)
library(plyr)
finaldata.frame$activity<-mapvalues(x,from=levels(x),to=labels)
#part5,creating a tidy data set
D<-as.data.frame(mat.or.vec(180,563))
count<-1
for (i in 1:30)
{
  for (j in 1:6)
  {
    n<-finaldata.frame[(finaldata.frame$subject==i&finaldata.frame$activity==v[j]),]
    for (k in 3:563)
    {D[count,k]<-mean(n[,k])
    }
    D[count,1]<-i
    D[count,2]<-v[j]
    count<-count+1
  }
}
names(D)<-c("subject","activity",as.character(m$V2))
tidydata<-D