## Install R Application
## Session > Set Working Directory > Choose Directory > Select the directory where the Excel file is or you can directly put your excel

getwd()
dir()

input <- read.csv("C:\\paper\\Bank_Account\\Banking_DataSet.csv",header=TRUE)
dim(input)
head(input)

#You can use your Bank Statement,in this case i have 

mybankstatement <- input[1:2583,4:6] ## exclude the columns with description, cheque and 4:6 Just have Withdrawal & Deposits & Balance
normalized_data <- scale(mybankstatement) ## We have just taken withdrawal,deposit & balance & normalized the columns

## K-means clustering - These Steps are standard steps you don't need to change them
?kmeans
fit <- kmeans(normalized_data, centers=3, iter.max=10, nstart=4)
    ## centers: either the number of clusters, or a set of initial (distinct) cluster centres. If a number, a random set of (distinct) rows in x is chosen as the initial centres.
    ## iter.max: the maximum number of iterations allowed.
    ## nstart: if centers is a number, how many random sets should be chosen.
fit

fit$cluster      # A vector of integers (from 1:k) indicating the cluster to which each point is allocated.
fit$centers      # A matrix of cluster centres.
fit$totss        # The total sum of squares.
fit$withinss     # Vector of within-cluster sum of squares, one component per cluster.
fit$tot.withinss # Total within-cluster sum of squares, i.e. sum(withinss).
fit$betweenss    # The between-cluster sum of squares, i.e. totss-tot.withinss.
fit$size         # The number of points in each cluster.
fit$iter         # The number of (outer) iterations.


## Determine number of clusters
Cluster_Variability <- matrix(nrow=5, ncol=1)
for (i in 1:5) Cluster_Variability[i] <- kmeans(normalized_data,centers=i, nstart=4)$tot.withinss
plot(1:5, Cluster_Variability, type="b", xlab="Number of clusters", ylab="Within groups sum of squares") ## Elbow curve or Scree plot


## some trivial analysis
fit <- kmeans(normalized_data, centers=4, iter.max=10, nstart=4)

BankStatementData <- cbind(input, fit$cluster) # append cluster membership, we are adding the cluster group
BankStatementData
cluster1 <- subset(input,fit$cluster==1)
cluster1[,1] 
cluster2 <- subset(input,fit$cluster==2)
cluster2[,1]
cluster3 <- subset(input,fit$cluster==3)
cluster3[,1] 
cluster4 <- subset(input,fit$cluster==4)
cluster4[,1] 

aggregate(BankStatementData[,4:6], by=list(fit$cluster), FUN=mean)
fit$centers ## Does it give similar output as above? Why not?

#NormDatasWithClusterMembership <- cbind(normalized_data, fit$cluster) # append cluster membership
#aggregate(NormDatasWithClusterMembership, by=list(fit$cluster), FUN=mean)
#fit$centers

## You may save UnivsWithClusterMembership for further analysis using Tableau
write.csv(BankStatementData,file="C:\\paper\\Bank_Account\\financial_analysis_11_10_2020.csv")
## You may now launch Tableau, upload UniversitiesWithClusterMembership.csv, and andalyze the cluster characteristics.

