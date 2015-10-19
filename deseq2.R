source("http://bioconductor.org/biocLite.R")
biocLite("DESeq2")
biocLite("GenomicRanges")
rm(list=ls())


library("DESeq2")
alldata <- read.table("Ilf2-salmonSummary-basic.txt", sep="\t", header=TRUE)
#sumdata <- read.table("Sumcounts-salmoniso.txt", sep="\t", header=TRUE)
#exondata <- read.table("Ilf2-salmonSummary-exon.txt", sep="\t", header=TRUE)
countMatrix=alldata[,2:5]
#countMatrixS=sumdata[,1:4]
#countMatrixS[is.na(countMatrixS)] <- 0
#countMatrixE=exondata[,2:5]
layout <- data.frame(row.names = colnames(countMatrix), cells = c(rep('KO',2), rep('Rev',2)))
countMatrix=round(countMatrix)
#layoutS <- data.frame(row.names = colnames(countMatrixS), cells = c(rep('KO',2), rep('Rev',2)))
#countMatrixS=round(countMatrixS)
#layoutE <- data.frame(row.names = colnames(countMatrixE), cells = c(rep('KO',2), rep('Rev',2)))
#countMatrixE=round(countMatrixE)

dds <- DESeqDataSetFromMatrix(countData = countMatrix, colData = layout, design = ~ cells)
featureData <- data.frame(gene=alldata[,1])
(mcols(dds) <- DataFrame(mcols(dds), featureData))
dds$cells <- relevel(dds$cells, "Rev")
dds <- DESeq(dds)
res <- results(dds,alpha=0.05)
resOrdered <- res[order(res$padj),]
summary(res, alpha=0.05)

ddsS <- DESeqDataSetFromMatrix(countData = countMatrixS, colData = layoutS, design = ~ cells)
featureDataS <- data.frame(gene=sumdata[,5])
(mcols(ddsS) <- DataFrame(mcols(ddsS), featureDataS))
ddsS$cells <- relevel(ddsS$cells, "Rev")
ddsS <- DESeq(ddsS)
resS <- results(ddsS,alpha=0.05)
resSOrdered <- resS[order(resS$padj),]
summary(resS, alpha=0.05)

ddsE <- DESeqDataSetFromMatrix(countData = countMatrixE, colData = layoutE, design = ~ cells)
featureDataE <- data.frame(gene=exondata[,1])
(mcols(ddsE) <- DataFrame(mcols(ddsE), featureDataE))
ddsE$cells <- relevel(ddsE$cells, "Rev")
ddsE <- DESeq(ddsE)
resE <- results(ddsE,alpha=0.05)
resEOrdered <- resE[order(resE$padj),]
summary(resE, alpha=0.05)

par(mfrow=c(1,2))
plotMA(resS, main="DESeq2sum", ylim=c(-4,4))
plotMA(resE, main="DESeq2exon", ylim=c(-4,4))

write.table(cbind(featureDataS,resS),"DEseq2-sum_results.txt", sep="\t", quote=FALSE)
write.table(cbind(featureDataE,resE),"DEseq2-exon_results.txt", sep="\t", quote=FALSE)




#for direct comparison, you want to log transform the data. there are two ways to do this
#variance stabilizing transformation
vst <- varianceStabilizingTransformation(dds)
#regularized log
rld=rlog(dds)
DESeq2::plotPCA(vst, intgroup=c('cells'))
DESeq2::plotPCA(rld, intgroup=c('cells'))
#can also use ggplot to do PCA
data <- plotPCA(rld, intgroup=c("cells"), returnData=TRUE)
percentVar <- round(100 * attr(data, "percentVar"))
library(ggplot2)
ggplot(data, aes(PC1, PC2, color=cells)) +
    geom_point(size=5) +
    xlab(paste0("PC1: ",percentVar[1],"% variance")) +
    ylab(paste0("PC2: ",percentVar[2],"% variance"))
write.table(cbind(featureData,res),"DEseq2-results-basic.txt", sep="\t", quote=FALSE)

salmon <- read.table("DEseq2-results-basic.txt", sep="\t", header=TRUE)
sleuth=results_table

