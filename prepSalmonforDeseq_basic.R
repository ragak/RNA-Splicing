rm(list=ls())
setwd("/Users/Raga/Dropbox/Documents/RNA splicing/salmon_basic/")
KO1 <- read.table("KO1quant.txt", sep="\t", header=TRUE)
KO2 <- read.table("KO2quant.txt", sep="\t", header=TRUE)
Rev1 <- read.table("Rev1quant.txt", sep="\t", header=TRUE)
Rev2 <- read.table("Rev2quant.txt", sep="\t", header=TRUE)
anno <- read.table("/Users/Raga/Dropbox/Documents/RNA splicing/DEseq2-results.txt", sep="\t", header=TRUE)
anno2=data.frame(anno$gene.must,anno[,13])
colnames(anno2)=c("Name","geneID")
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
alldataanno=merge(alldata,anno2)
write.table(alldataanno,"Ilf2-salmonSummary-basic.txt", sep="\t", quote=FALSE)
#write.table(alldata,"Ilf2-salmonSummary-exon.txt", sep="\t", quote=FALSE)

