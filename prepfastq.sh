#!/bin/bash

#PBS -l nodes=1:ppn=4,vmem=50gb,walltime=6:00:00,mem=50gb
#PBS -M raga.krishnakumar@ucsf.edu
#PBS -m abe
#PBS -N MISO
#PBS -j oe
#PBS -t 1-12

cd /N/dc2/projects/RNAMap/raga/RBP_RNAseq_2013

INPUT=$(awk -v line=${PBS_ARRAYID} '{if (NR == line) { print $1 }}' folders.txt)
OUTPUT=$(awk -v line=${PBS_ARRAYID} '{if (NR == line) { print $2 }}' folders.txt)

#tophat -p 4 -o ${INPUT} --library-type fr-firststrand --transcriptome-index=/N/dc2/projects/RNAMap/jake/genome/bowtie2index/transcriptome/gencodeM6 /N/dc2/projects/RNAMap/jake/genome/bowtie2index/GRCm38 /N/dc2/projects/RNAMap/jake/4su/fastq/${INPUT}.noContam.fastq

gunzip /N/dc2/projects/RNAMap/raga/RBP_RNAseq_2013/${INPUT}/*.gz
cat /N/dc2/projects/RNAMap/raga/RBP_RNAseq_2013/${INPUT}/*.fastq > /N/dc2/projects/RNAMap/raga/RBP_RNAseq_2013/${INPUT}/${OUTPUT}.fastq