#!/usr/bin/perl
use strict;
use warnings;

my $workdir = '/N/dc2/projects/RNAMap/raga/splicing/mapping';
my $workdir2 = '/N/dc2/projects/RNAMap/raga/genomes';
my $workdir3 = '/N/dc2/projects/RNAMap/raga/genomes/mm10';
#my $deDup = '/N/dc2/projects/RNAMap/raga/chromhmm/ChromHMM/sort/deDup.pl';
#my @queries1 = ("$workdir/KO1-R1.fastq","$workdir/KO2-R1.fastq","$workdir/Rev1-R1.fastq","$workdir/Rev2-R1.fastq");
#my @queries1 = ("$workdir/KO1-R2.fastq","$workdir/KO2-R2.fastq","$workdir/Rev1-R2.fastq","$workdir/Rev2-R2.fastq");
#my @outfiles = ("$workdir/KO1.fastq","$workdir/KO2.fastq","$workdir/Rev1.fastq","$workdir/Rev2.fastq");


## Run MISO on a pair of paired-end sample (with insert length distribution with mean 250,
## standard deviation 15) using the mouse genome skipped exon annotations using the
## the cluster

# Compute Psi values for control sample
system "miso --run mm9/pickled/SE data/control.bam --output-dir SE/control/ --read-len 35 --paired-end 250 15 --use-cluster"
system "miso --run mm9/pickled/SE data/control.bam --output-dir SE/control/ --read-len 35 --paired-end 250 15 --use-cluster"

# Compute Psi values for knockdown sample
system "miso --run mm9/pickled/SE data/knockdown.bam --output-dir SE/knockdown/ --read-len 35 --paired-end 250 15 --use-cluster"
system "miso --run mm9/pickled/SE data/knockdown.bam --output-dir SE/knockdown/ --read-len 35 --paired-end 250 15 --use-cluster"

## Summarize the output (only run this once --run finished!)
## This will create a "summary" directory in SE/control/ and in SE/knockdown/
system "summarize_miso --summarize-samples SE/control/ SE/control/"
system "summarize_miso --summarize-samples SE/knockdown/ SE/knockdown/"

## Detect differentially expressed isoforms between "control" and "knockdown"
## This will compute Bayes factors and delta Psi values between the samples
## and place the results in the directory SE/comparisons/control_vs_knockdown
system "compare_miso --compare-samples SE/control/ SE/knockdown/ SE/comparisons/"