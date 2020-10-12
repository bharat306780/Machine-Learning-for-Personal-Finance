## Install R Application

#You need to use your Bank Statement, this is an example with other bankstatment  
input <- read.csv("C:\\paper\\Bank_Account\\Banking_DataSet.csv",header=TRUE)
dim(input)
head(input)



mybankstatement <- input[1:2583,4:6] ## exclude the columns with description, cheque and 4:6 Just have Withdrawal & Deposits & Balance
normalized_data <- scale(mybankstatement) ## We have just taken withdrawal,deposit & balance & normalized the columns

## K-means clustering - These Steps are standard steps you don't need to change them
?kmeans
fit <- kmeans(normalized_data, centers=3, iter.max=10, nstart=4)
    ## centers: either the number of clusters, or a set of initial (distinct) cluster centres. If a number, a random set of (distinct) rows in x is chosen as the initial centres.
    ## iter.max: the maximum number of iterations allowed.
    ## nstart: if centers is a number, how many random sets should be chosen.

## Determine number of clusters
Cluster_Variability <- matrix(nrow=5, ncol=1)
for (i in 1:5) Cluster_Variability[i] <- kmeans(normalized_data,centers=i, nstart=4)$tot.withinss
plot(1:5, Cluster_Variability, type="b", xlab="Number of clusters", ylab="Within groups sum of squares") ## Elbow curve or Scree plot

BankStatementData <- cbind(input, fit$cluster) # append cluster membership, we are adding the cluster group
BankStatementData

## You may save the BankStatement with cluster Details then You can label your Data 
write.csv(BankStatementData,file="C:\\paper\\Bank_Account\\financial_analysis_12_10_2020_10AM.csv") 
## Next Step is get the Label Data for Descriptive Analytics

