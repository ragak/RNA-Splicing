rm(list=ls())
setwd("/Users/Raga/Dropbox/Documents/RNA splicing/")
isoforms <- read.table("DEseq2-results.txt", sep="\t", header=TRUE)
sig_iso=na.omit(isoforms[isoforms$padj<0.05,])
sig_iso <- sig_iso[order(sig_iso$geneID),] 
#ID=data.frame(sig_iso$geneID)
ID=data.frame(sig_iso$geneID)
FC=data.frame(sig_iso$log2FoldChange)
raga=unique(ID[,1])
changes=list()
for(a in raga){
    relevant=FC[ID[,1]==a,]
    great=function(i){i>0}
    result=sapply(relevant,great)
    add=if((all(result=="TRUE")|all(result=="FALSE"))=="FALSE"){a}
    changes=c(changes,add)
}
changes=as.character(changes)
write.table(changes,"salmon-deseq2-discordant.txt", sep="\t", quote=FALSE)


anno=data.frame(sig_iso$gene.must,sig_iso$geneID)
#check code
test=FC[ID[,1]=="Ate1",]
test
