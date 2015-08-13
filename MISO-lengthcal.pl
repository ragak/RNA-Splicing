#!/usr/bin/perl
use strict;
use warnings;

my $workdir = '/N/dc2/projects/RNAMap/raga/splicing/mapping'
my $workdir2 = ' /N/dc2/projects/RNAMap/raga/genomes'
#my $deDup = '/N/dc2/projects/RNAMap/raga/chromhmm/ChromHMM/sort/deDup.pl';
#my @queries1 = ("$workdir/KO1-R1.fastq","$workdir/KO2-R1.fastq","$workdir/Rev1-R1.fastq","$workdir/Rev2-R1.fastq");
#my @queries1 = ("$workdir/KO1-R2.fastq","$workdir/KO2-R2.fastq","$workdir/Rev1-R2.fastq","$workdir/Rev2-R2.fastq");
#my @outfiles = ("$workdir/KO1.fastq","$workdir/KO2.fastq","$workdir/Rev1.fastq","$workdir/Rev2.fastq");


system "exon_utils --get-const-exons $workdir2/Mus_musculus.NCBIM37.65.gff --min-exon-size 1000 --output-dir $workdir/exons/";

