#Load the test values intro de test variable
test<-read.table("UCI HAR Dataset/test/X_test.txt")

#Load the train values into de value variable
train<-read.table("UCI HAR Dataset/train/X_train.txt")

#Read the names of each column i.e. it indicates each measure
colnames<-read.table("UCI HAR Dataset/features.txt")
#Eliminate the first column, it's not necessary
colnames[,1]=NULL

#Obtain the numbers that idenfifies the activity for each measure
test_labels<-read.table("UCI HAR Dataset/test/y_test.txt")
train_labels<-read.table("UCI HAR Dataset/train/y_train.txt")

#Combine all the activities in the same element
activity_labels<-rbind(test_labels,train_labels)

#Clean the vaiables we don't need any more
rm(test_labels,train_labels)

#Translate the numbers by their human readable meaning
colnames(activity_labels)<-"Activity"
activity_labels[activity_labels==1,]<-"WALKING"
activity_labels[activity_labels==2,]<-"WALKING_UPSTAIRS"
activity_labels[activity_labels==3,]<-"WALKING_DOWNSTAIRS"
activity_labels[activity_labels==4,]<-"SITTING"
activity_labels[activity_labels==5,]<-"STANDING"
activity_labels[activity_labels==6,]<-"LAYING"

#Combine the results for test and train
total<-rbind(test,train)
colnames(total)<-colnames[,1]
#We don't need the independent variables test and train
rm(test,train)

#Find the indexes in colnames that contains the string -mean()- or -std()-
mean_std_index<-grep("[-]mean[(][)][-]|[-]std[(][)][-]",colnames[,1])

#Save only the columns for mean and std into a new variable
total_clean<-total[,mean_std_index]
rm(colnames,mean_std_index,total)

#Add a column with the activity 
total_clean_activity<-cbind(activity_labels,total_clean)

#Add a column with the subject
subject_test<-read.table("UCI HAR Dataset/test/subject_test.txt")
subject_train<-read.table("UCI HAR Dataset/train/subject_train.txt")
#COmbines the two lists of subjects
subject<-rbind(subject_test,subject_train)
#Modify the name of the column
colnames(subject)<-"Subject"
#Add the vector as a column
total_clean_activity<-cbind(subject,total_clean_activity)
#Remove the variables we don't need anymore
rm(activity_labels,total_clean)
rm(subject_test,subject_train,subject)

#Second part
#Means of each measure separated by activity and subject
#We combine activity and subject into the same column
#Thera are 6 activities x 30 subjects, we need 180 rows
total_activity_means<-total_clean_activity[1:180,-1]

#Vector for activities as factors
aux<-as.factor(total_clean_activity[,2])
#Vector for subjects as factors
aux2<-as.factor(total_clean_activity[,1])
#We combine both factors
aux3<-interaction(aux,aux2)
#Add the name of each combination to the first ow of the tidy dataset
total_activity_means[,1]<-attr(aux3,"levels")
rm(aux,aux2)

#Calculate the mean for each variable separated by activity type and subject
for (i in 2:ncol(total_activity_means)) {

  total_activity_means[,i]<-tapply(total_clean_activity[,i+1],aux3,mean)

}

#Variable aux not needed any more
rm(i,aux3)

#We modify the column names by adding the mean word at the end
colnames(total_activity_means)<-sapply(colnames(total_activity_means),paste,"mean")
colnames(total_activity_means)[1]<-"Activity and subject"

#Write the last data frame into a txt file
write.table(total_activity_means,"averages_dataset.txt",row.names = FALSE)
