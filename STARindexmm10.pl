#!/usr/bin/perl
use strict;
use warnings;

my $workdir = '/N/dc2/projects/RNAMap/raga/splicing';
my $workdir2 = ' /N/dc2/projects/RNAMap/raga/genomes';
#my $deDup = '/N/dc2/projects/RNAMap/raga/chromhmm/ChromHMM/sort/deDup.pl';
#my @queries1 = ("$workdir/KO1-R1.fastq","$workdir/KO2-R1.fastq","$workdir/Rev1-R1.fastq","$workdir/Rev2-R1.fastq");
#my @queries1 = ("$workdir/KO1-R2.fastq","$workdir/KO2-R2.fastq","$workdir/Rev1-R2.fastq","$workdir/Rev2-R2.fastq");
#my @outfiles = ("$workdir/KO1.fastq","$workdir/KO2.fastq","$workdir/Rev1.fastq","$workdir/Rev2.fastq");

system "STAR --genomeDir $workdir2/STARmm10/ --runThreadN 8 --runMode genomeGenerate --genomeFastaFiles $workdir2/GRCm38.p3.genome.fa --sjdbOverhang 49 --sjdbGTFfile $workdir2/gencode.vM6.basic.annotation.gtf";

