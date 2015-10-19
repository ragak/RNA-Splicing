#!/usr/bin/perl
use strict;
use warnings;

my $workdir = '/N/dc2/projects/RNAMap/raga/splicing/mapping';
my $workdir2 = ' /N/dc2/projects/RNAMap/raga/genomes';
my $workdir3 = '/N/dc2/projects/RNAMap/raga/splicing/mapping/kallistoout';
my $deDup = '/N/dc2/projects/RNAMap/raga/chromhmm/ChromHMM/sort/deDup.pl';
my @queries1 = ("$workdir/KO1-R1.fastq","$workdir/KO2-R1.fastq","$workdir/Rev1-R1.fastq","$workdir/Rev2-R1.fastq");
my @queries2 = ("$workdir/KO1-R2.fastq","$workdir/KO2-R2.fastq","$workdir/Rev1-R2.fastq","$workdir/Rev2-R2.fastq");
my @outfiles = ("$workdir3/KO1_quant_kall","$workdir3/KO2_quant_kall","$workdir3/Rev1_quant_kall","$workdir3/Rev2_quant_kall");

for (my $i=0; $i<scalar(@queries); $i++) {
	system "kallisto quant -i $workdir2/kallisto/mm10basic_index -b 10 -t 10 -o $outfiles1[$i] $queries1[$i] $queries2[$i] ";
}
