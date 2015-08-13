#!/usr/bin/perl
use strict;
use warnings;

my $workdir = '/N/dc2/projects/RNAMap/raga/splicing/mapping'
#my $workdir2 = '/N/dc2/projects/RNAMap/raga/chromhmm/ChromHMM/sort/'
#my $deDup = '/N/dc2/projects/RNAMap/raga/chromhmm/ChromHMM/sort/deDup.pl';
my @queries = ("$workdir/KO2.fastqAligned.out.sam");
my @outfiles = ("$workdir/KO2-sorted");
my @outfiles2 = ("$workdir/KO2-sorted.bam");
my @outfiles3 = ("$workdir/KO2-sorted.bai");



for (my $i=0; $i<scalar(@queries); $i++) {
	system "samtools view -bS $queries[$i] | samtools sort - $outfiles[$i]";
	system "samtools index $outfiles2[$i] $outfiles3[$i]"
}
