pathdata<-file.path("./W4/getdata_projectfiles_UCI HAR Dataset","UCI HAR Dataset")
files<-list.files(pathdata,recursive=TRUE)
xtrain<-read.table(file.path(pathdata,"train","X_train.txt"),header=FALSE)
ytrain<-read.table(file.path(pathdata,"train","y_train.txt"),header=FALSE)
subject_train<-read.table(file.path(pathdata,"train","subject_train.txt"),header=FALSE)

xtest<-read.table(file.path(pathdata,"test","X_test.txt"),header=FALSE)
ytest<-read.table(file.path(pathdata,"test","y_test.txt"),header=FALSE)
subject_test<-read.table(file.path(pathdata,"test","subject_test.txt"),header=FALSE)

features<-read.table(file.path(pathdata,"features.txt"),header=FALSE)
activityLabels<-read.table(file.path(pathdata,"activity_labels.txt"),header=FALSE)

colnames(xtrain)<-features[,2]
colnames(ytrain)<-"activityID"
colnames(subject_train)<-"subjectID"
colnames(xtest)<-features[,2]
colnames(ytest)<-"activityID"
colnames(subject_test)<-"subjectID"

colnames(activityLabels)<-c("activityID","activityType")

merge_train<-cbind(ytrain,subject_train,xtrain)
merge_test<-cbind(ytest,subject_test,xtest)

all_data<-rbind(merge_train,merge_test)

colNames<-colnames(all_data)
mean_std<-(grepl("activityID",colNames)|grepl("subjectID",colNames) |grepl("mean..",colNames)| grepl("std..",colNames))
MeanStd<-all_data[,mean_std==TRUE]

data2<-merge(MeanStd,activityLabels,by='activityID',all.x=TRUE)

TidySet2<-aggregate(.~subjectID+activityID,data2,mean)
TidySet2<-TidySet2[order(TidySet2$subjectID,TidySet2$activityID), ]
write.table(TidySet2,"TidySet.txt",row.name=FALSE)