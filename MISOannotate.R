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
    
    header <- c('chr','start','end','id','score','strand')
    names(df) <- header[1:length(names(df))]
    
    if('strand' %in% colnames(df)){
        df$strand <- gsub(pattern="[^+-]+", replacement = '*', x = df$strand)
    }
    
    library("GenomicRanges")
    
    if(length(df)==3){
        gr <- with(df, GRanges(chr, IRanges(start, end)))
    } else if (length(df)==4){
        gr <- with(df, GRanges(chr, IRanges(start, end), id=id))
    } else if (length(df)==5){
        gr <- with(df, GRanges(chr, IRanges(start, end), id=id, score=score))
    } else if (length(df)==6){
        gr <- with(df, GRanges(chr, IRanges(start, end), id=id, score=score, strand=strand))
    }
    return(gr)
}

#rm(list=ls())
setwd("/Users/Raga/Dropbox/Documents/RNA splicing/MISO/")
#got test file from Jake (transcript to gene ensembl)
#save(test, file='transcript_to_gene.RData')
load('transcript_to_gene.RData')
gtf <- read.table("gencode.vM6.basic.annotation.gtf", sep="\t", header=FALSE)
out <- strsplit(as.character(gtf$type),'_and_') 
do.call(rbind, out)

gtf=gtf[,1:6]
colnames(gtf)=c("chr","start","stop","txID")
data <- read.table("ALE.mm10.gff3", sep="\t", header=TRUE)
gtfann=merge(gtf,test,all.x=TRUE)
