#!/usr/bin/perl
use strict;
use warnings;

my $workdir = '/N/dc2/projects/RNAMap/raga/splicing/mapping';
my $infile1 = '/N/dc2/projects/RNAMap/raga/splicing/mapping/KO1-R1.fastq';
my $infile2 = '/N/dc2/projects/RNAMap/raga/splicing/mapping/KO1-R2.fastq';
my $outfile1 = '/N/dc2/projects/RNAMap/raga/splicing/mapping/KO1-R1.trimmed.fastq';
my $outfile2 = '/N/dc2/projects/RNAMap/raga/splicing/mapping/KO1-R2.trimmed.fastq';

system 'cutadapt -a AGATCGGAAGAGC -A AGATCGGAAGAGC -o /N/dc2/projects/RNAMap/raga/splicing/mapping/KO1-R1.trimmed.fastq -p /N/dc2/projects/RNAMap/raga/splicing/mapping/KO1-R2.trimmed.fastq /N/dc2/projects/RNAMap/raga/splicing/mapping/KO1-R1.fastq /N/dc2/projects/RNAMap/raga/splicing/mapping/KO1-R2.fastq';
#system 'cutadapt -a AGATCGGAAGAGC -A AGATCGGAAGAGC -o KO1-R1.trimmed.fastq -p KO1-R2.trimmed.fastq KO1-R1.fastq KO1-R2.fastq';