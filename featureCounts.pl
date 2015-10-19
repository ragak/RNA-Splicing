#!/usr/bin/perl
use strict;
use warnings;

my $workdir = '/N/dc2/projects/RNAMap/raga/splicing/mapping'
my $workdir3 = '/N/dc2/projects/RNAMap/raga/splicing/featureCounts'
my $workdir2 = ' /N/dc2/projects/RNAMap/raga/genomes'
#my $deDup = '/N/dc2/projects/RNAMap/raga/chromhmm/ChromHMM/sort/deDup.pl';
#my @queries1 = ("$workdir/KO1-R1.fastq","$workdir/KO2-R1.fastq","$workdir/Rev1-R1.fastq","$workdir/Rev2-R1.fastq");
#my @queries1 = ("$workdir/KO1-R2.fastq","$workdir/KO2-R2.fastq","$workdir/Rev1-R2.fastq","$workdir/Rev2-R2.fastq");
#my @outfiles = ("$workdir/KO1.fastq","$workdir/KO2.fastq","$workdir/Rev1.fastq","$workdir/Rev2.fastq");


system "featureCounts -T 2 -a $workdir2/gencode.vM6.basic.annotation.gtf -p -g gene_id -t exon -s 2 -o $workdir3/featureCounts_byexon.txt $workdir/KO1-sorted.bam $workdir/KO2-sorted.bam $workdir/Rev1-sorted.bam $workdir/Rev2-sorted.b