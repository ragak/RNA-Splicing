rm(list=ls())
setwd("/Users/Raga/Dropbox/Documents/RNA splicing/")
isoforms <- read.table("DEseq2-results.txt", sep="\t", header=TRUE)
sig_iso=na.omit(isoforms[isoforms$padj<0.05,])
sig_iso <- sig_iso[order(sig_iso$geneID),] 
ID=data.frame(sig_iso$geneID)
FC=data.frame(sig_iso$log2FoldChange)
raga=unique(ID[,1])
raga2=list()
changes=list()
for(a in raga){
    for(b in 1:length(ID[,1])){
        if(ID[b,1]==a){
            raga2=c(raga2,FC[b,1])
        }
    }
    great=function(i){i>0}
    result=sapply(raga2,great)
    add=ifelse((all(result=="TRUE")|all(result=="FALSE")),a,NA)
    changes=c(changes,add)
}

