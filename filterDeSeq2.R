rm(list=ls())
setwd("/Users/Raga/Dropbox/Documents/RNA splicing/")
isoforms <- read.table("DEseq2-results.txt", sep="\t", header=TRUE)
sum <- read.table("DEseq2-sum-results.txt", sep="\t", header=TRUE)
exon <- read.table("DEseq2-exon-results.txt", sep="\t", header=TRUE)
sig_iso=na.omit(isoforms[isoforms$padj<0.05,])
sig_sum=na.omit(sum[sum$padj<0.05,])
sig_exon=na.omit(exon[exon$padj<0.05,])
anno=sig_iso[,8:13]
anno=anno[,-1]
anno=anno[,-2]
anno=anno[,-2]
anno=anno[,-2]
colnames(anno)=c("gene","geneID")
sig_exon=merge(sig_exon,anno)
overlap=intersect(sig_exon$geneID,sig_sum$gene)
overlap_RS=intersect(changes,overlap)
