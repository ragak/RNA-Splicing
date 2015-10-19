##identifying 3'end of transcripts pulled out by programs
##like DeSeq

#identify transcript by transcript ID in GTF
#if stop<start, reverse stop and start (reverse strand)
#identify row named 'UTR' for given transcript ID
#if multiple UTR rows (multiple exons in UTR): take the last (the
# largest number) as the end
#associate each end with transcript ID and gene ID
#determine from discordant genes whether shorter transcripts are
#being favored over longer ones

rm(list=ls())
setwd("C:/Users/Raga/Dropbox/Documents/RNA Splicing/")
gtf<-read.table("gencode.vM6.basic.annotation.gtf",sep="\t",header=FALSE)
library(reshape)
df = transform(df, FOO = colsplit(FOO, split = "\\|", names = c('a', 'b')))
