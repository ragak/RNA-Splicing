#!/usr/bin/perl
use strict;
use warnings;

my $workdir = '/N/dc2/projects/RNAMap/raga/splicing/mapping';
my $workdir2 = ' /N/dc2/projects/RNAMap/raga/genomes';
my $workdir3 = '/N/dc2/projects/RNAMap/raga/splicing/mapping/salmonout';
my $deDup = '/N/dc2/projects/RNAMap/raga/chromhmm/ChromHMM/sort/deDup.pl';
my @queries1 = ("$workdir/KO1-R1.fastq","$workdir/KO2-R1.fastq","$workdir/Rev1-R1.fastq","$workdir/Rev2-R1.fastq");
my @queries2 = ("$workdir/KO1-R2.fastq","$workdir/KO2-R2.fastq","$workdir/Rev1-R2.fastq","$workdir/Rev2-R2.fastq");
my @outfiles = ("$workdir3/KO1_quant","$workdir3/KO2_quant","$workdir3/Rev1_quant","$workdir3/Rev2_quant");

for (my $i=0; $i<scalar(@queries); $i++) {
	system "salmon quant -i $workdir2/salmon/transcripts_index/ -l ISF -1 $queries1[$i] -2 $queries2[$i] -o $outfiles1[$i]";
}
