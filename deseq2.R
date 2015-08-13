source("http://bioconductor.org/biocLite.R")
biocLite("DESeq2")
biocLite("GenomicRanges")

library("DESeq2")
alldata <- read.table("Ilf2-salmonSummary.txt", sep="\t", header=TRUE)
countMatrix=alldata[,2:5]
layout <- data.frame(row.names = colnames(countMatrix), cells = c(rep('KO',2), rep('Rev',2)))
countMatrix=round(countMatrix)

dds <- DESeqDataSetFromMatrix(countData = countMatrix, colData = layout, design = ~ cells)
featureData <- data.frame(gene=alldata[,1])
(mcols(dds) <- DataFrame(mcols(dds), featureData))
dds$cells <- relevel(dds$cells, "Rev")
dds <- DESeq(dds)
res <- results(dds,alpha=0.05)
resOrdered <- res[order(res$padj),]
summary(res, alpha=0.05)
plotMA(res, main="DESeq2", ylim=c(-4,4))
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
write.table(cbind(featureData,res),"DEseq2-results.txt", sep="\t", quote=FALSE)


