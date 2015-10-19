#rm(list=ls())
setwd("/Users/Raga/Dropbox/Documents/RNA splicing/MISO/KORev1/")
setwd("/Users/Raga/Dropbox/Documents/RNA splicing/MISO/KORev2/")
data <- read.table("ALE_vs_ALE.miso_bf", sep="\t", header=TRUE)
newdata=data[order(data$bayes_factor,decreasing=TRUE),] 
chr9=newdata[newdata$chrom=="chr9",]

foo <- data.frame(do.call('rbind', strsplit(as.character(chr9$mRNA_starts),',',fixed=TRUE)))
chr9=cbind(chr9,foo)

chr9=chr9[order(chr9[,19]),] 

#Ilf3 is significant!
filter=newdata[newdata$bayes_factor>10 & abs(newdata$diff)>0.2,]

numsig = function(file){
    newdata=read.table(file, sep="\t", header=TRUE)
    filter=newdata[newdata$bayes_factor>10 & abs(newdata$diff)>0.2,]
    sig=length(filter[,1])
    foo <- data.frame(do.call('rbind', strsplit(as.character(filter$mRNA_starts),',',fixed=TRUE)))
    isos=length(unique(foo$X1))
    output=cbind(sig,isos)
    output
}

allfiles=c("ALE_vs_ALE.miso_bf","A3SS_vs_A3SS.miso_bf","A5SS_vs_A5SS.miso_bf","AFE_vs_AFE.miso_bf","MXE_vs_MXE.miso_bf","RI_vs_RI.miso_bf","SE_vs_SE.miso_bf","TandemUTR_vs_TandemUTR.miso_bf")
lists=sapply(allfiles,numsig)
#datasets=c("ALE","A3SS","A5SS","AFE","MXE","RI","SE","TandemUTR")
#final=data.frame(as.numeric(lists),datasets)
rownames(lists)=c("sig_events","sig_genes")
colnames(lists)=c("ALE","A3SS","A5SS","AFE","MXE","RI","SE","TandemUTR")
lists1=lists
#repeat above for KORev2, get lists and compare with lists1
lists2=lists
colnames(lists1)=c("ALE","A3SS","A5SS","AFE","MXE","RI","SE","TandemUTR")
colnames(lists2)=c("ALE","A3SS","A5SS","AFE","MXE","RI","SE","TandemUTR")

write.table(lists1,"MISOeventssummaryR1.txt", sep="\t", quote=FALSE)
write.table(lists2,"MISOeventssummaryR2.txt", sep="\t", quote=FALSE)





#pull in GTF file
library('GenomicFeatures')
setwd("/Users/Raga/Dropbox/Documents/RNA splicing/MISO/")
gencodeBasicvM6 <- makeTxDbFromGFF('gencode.vM6.basic.annotation.gtf', format='gtf')
saveDb(gencodeBasicvM6, file='gencode_m6_basic.sqlite')
gencode <- loadDb('gencode_m6_basic.sqlite')
tx <- transcripts(gencode)
ge=genes(gencode)

MISOtobed=function(file){
    events=read.table(file, sep="\t", header=TRUE)
    start=as.numeric(do.call('rbind', strsplit(as.character(events$mRNA_starts),',',fixed=TRUE))[,1])
    end=as.numeric(do.call('rbind', strsplit(as.character(events$mRNA_ends),',',fixed=TRUE))[,1])
    final=data.frame(events$chrom,start,end,events$strand,events$event_name)
    colnames(final)=c("chr","start","stop","strand","id")
    final
}

#' BED to GRanges
#'
#' This function loads a BED-like file and stores it as a GRanges object.
#' The tab-delimited file must be ordered as 'chr', 'start', 'end', 'id', 'score', 'strand'.
#' The minimal BED file must have the 'chr', 'start', 'end' columns.
#' Any columns after the strand column are ignored.
#' 
#' @param file Location of your file
#' @keywords BED GRanges
#' @export
#' @examples
#' bed_to_granges('my_bed_file.bed')

bed_to_granges <- function(thing){
    df <- thing
    
    if(length(df) > 6){
        df <- df[,-c(7:length(df))]
    }
    
    if(length(df)<3){
        stop("File has less than 3 columns")
    }
    
    #header <- c('chr','start','end','id','score','strand')
    header <- c('chr','start','end','strand','id','score')
    names(df) <- header[1:length(names(df))]
    
    if('strand' %in% colnames(df)){
        df$strand <- gsub(pattern="[^+-]+", replacement = '*', x = df$strand)
    }
    
    library("GenomicRanges")
    
    if(length(df)==3){
        gr <- with(df, GRanges(chr, IRanges(start, end)))
    } else if (length(df)==4){
        gr <- with(df, GRanges(chr, IRanges(start, end), strand=strand))
    } else if (length(df)==5){
        gr <- with(df, GRanges(chr, IRanges(start, end), strand=strand, id=id))
    } else if (length(df)==6){
        gr <- with(df, GRanges(chr, IRanges(start, end), strand=strand, id=id, score=score))
    }
    return(gr)
}
setwd("/Users/Raga/Dropbox/Documents/RNA splicing/MISO/KORev1/")
#annotations=c("A3SS.mm10.gff3","A5SS.mm10.gff3","AFE.mm10.gff3","ALE.mm10.gff3","MXE.mm10.gff3","RI.mm10.gff3","SE.mm10.gff3","TandemUTR.mm10.gff3")
#datasets=c("A3SS","A5SS","AFE","ALE","MXE","RI","SE","TandemUTR")
allfiles=c("ALE_vs_ALE.miso_bf","A3SS_vs_A3SS.miso_bf","A5SS_vs_A5SS.miso_bf","AFE_vs_AFE.miso_bf","MXE_vs_MXE.miso_bf","RI_vs_RI.miso_bf","SE_vs_SE.miso_bf","TandemUTR_vs_TandemUTR.miso_bf")
MISOtoGranges=function(miso){
  bed=MISOtobed(miso)
  bed_to_granges(bed)
}

setwd("/Users/Raga/Dropbox/Documents/RNA splicing/MISO/KORev1/")
setwd("/Users/Raga/Dropbox/Documents/RNA splicing/MISO/KORev2/")
for (i in 1:length(allfiles)){
  ALEg=MISOtoGranges(allfiles[i])
  bring=as.matrix(findOverlaps(ALEg,ge))
  geneIDs=sapply(as.integer(bring[,2]),function(x){ge[x]$gene_id})
  misoIDs=sapply(as.integer(bring[,1]),function(x){as.character(ALEg[x]$id)})
  y=cbind(misoIDs,geneIDs)
  colnames(y)=c("event_name","geneID")
  alldata=read.table(allfiles[i], sep="\t", header=TRUE)
  z=merge(y,alldata)
  name=paste(allfiles[i],"anno",sep="_")
  write.table(z,name, sep="\t", quote=FALSE)
}

setwd("/Users/Raga/Dropbox/Documents/RNA splicing/MISO/KORev1/")
setwd("/Users/Raga/Dropbox/Documents/RNA splicing/MISO/KORev2/")
annofiles=c("ALE_vs_ALE.miso_bf_anno","A3SS_vs_A3SS.miso_bf_anno","A5SS_vs_A5SS.miso_bf_anno","AFE_vs_AFE.miso_bf_anno","MXE_vs_MXE.miso_bf_anno","RI_vs_RI.miso_bf_anno","SE_vs_SE.miso_bf_anno","TandemUTR_vs_TandemUTR.miso_bf_anno")
sig = function(file){
  newdata=read.table(file, sep="\t", header=TRUE)
  newdata[newdata$bayes_factor>10 & abs(newdata$diff)>0.2,]
}
ALE1=sig(annofiles[1])
A3SS1=sig(annofiles[2])
A5SS1=sig(annofiles[3])
AFE1=sig(annofiles[4])
MXE1=sig(annofiles[5])
RI1=sig(annofiles[6])
SE1=sig(annofiles[7])
TandemUTR1=sig(annofiles[8])

ALE2=sig(annofiles[1])
A3SS2=sig(annofiles[2])
A5SS2=sig(annofiles[3])
AFE2=sig(annofiles[4])
MXE2=sig(annofiles[5])
RI2=sig(annofiles[6])
SE2=sig(annofiles[7])
TandemUTR2=sig(annofiles[8])

samegenes=function(file1,file2){
  #files here are data frames
  common=sum(file1$geneID %in% file2$geneID)
  fraction1=mean(file1$geneID %in% file2$geneID)
  fraction2=mean(file2$geneID %in% file1$geneID)
  cbind(common,fraction1,fraction2)
}

list1=c("ALE1","A3SS1","A5SS1","AFE1","MXE1","RI1","SE1","TandemUTR1")
list2=c("ALE2","A3SS2","A5SS2","AFE2","MXE2","RI2","SE2","TandemUTR2")

a=samegenes(ALE1,ALE2)
b=samegenes(A3SS1,A3SS2)
c=samegenes(A5SS1,A5SS2)
d=samegenes(AFE1,AFE2)
e=samegenes(MXE1,MXE2)
f=samegenes(RI1,RI2)
g=samegenes(SE1,SE2)
h=samegenes(TandemUTR1,TandemUTR2)
a=rbind(a,b)
a=rbind(a,c)
a=rbind(a,d)
a=rbind(a,e)
a=rbind(a,f)
a=rbind(a,g)
a=rbind(a,h)

rownames(a)=c("ALE","A3SS","A5SS","AFE","MXE","RI","SE","TandemUTR")
  
#just plot correlation between replicates
ALE1n=read.table('/Users/Raga/Dropbox/Documents/RNA splicing/MISO/KORev1/ALE_vs_ALE.miso_bf_anno', sep="\t", header=TRUE)
ALE2n=read.table('/Users/Raga/Dropbox/Documents/RNA splicing/MISO/KORev2/ALE_vs_ALE.miso_bf_anno', sep="\t", header=TRUE)
ALE1lite=cbind(as.character(ALE1n$event_name),ALE1n$sample2_posterior_mean)
colnames(ALE1lite)=c("event","rep1")
ALE2lite=cbind(as.character(ALE2n$event_name),ALE2n$sample2_posterior_mean)
colnames(ALE2lite)=c("event","rep2")
ALEfull=merge(ALE1lite,ALE2lite)
plot(as.integer(ALEfull$rep1),as.integer(ALEfull$rep2))
cor.test(as.integer(ALEfull$rep1),as.integer(ALEfull$rep2),method="pearson")
