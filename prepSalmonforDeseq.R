rm(list=ls())
setwd("/Users/Raga/Dropbox/Documents/RNA splicing/")
KO1 <- read.table("KO1_quant.txt", sep="\t", header=TRUE)
KO2 <- read.table("KO2_quant.txt", sep="\t", header=TRUE)
Rev1 <- read.table("Rev1_quant.txt", sep="\t", header=TRUE)
Rev2 <- read.table("Rev2_quant.txt", sep="\t", header=TRUE)
KO1lite=KO1[,-2]
KO1lite=KO1lite[,-2]
KO2lite=KO2[,-2]
KO2lite=KO2lite[,-2]
Rev1lite=Rev1[,-2]
Rev1lite=Rev1lite[,-2]
Rev2lite=Rev2[,-2]
Rev2lite=Rev2lite[,-2]
colnames(KO1lite) <- c("Name","KO1counts")
colnames(KO2lite) <- c("Name","KO2counts")
colnames(Rev1lite) <- c("Name","Rev1counts")
colnames(Rev2lite) <- c("Name","Rev2counts")
KO=merge(KO1lite,KO2lite,all.x=TRUE)
Rev=merge(Rev1lite,Rev2lite,all.x=TRUE)
alldata=merge(KO,Rev,all.x=TRUE)
write.table(alldata,"Ilf2-salmonSummary.txt", sep="\t", quote=FALSE)
