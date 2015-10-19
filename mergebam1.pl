#!/usr/bin/perl
use strict;
use warnings;

my $workdir = '/N/dc2/projects/RNAMap/raga/splicing/mapping';
#my $workdir2 = '/N/dc2/projects/RNAMap/raga/chromhmm/ChromHMM/sort/'
#my $deDup = '/N/dc2/projects/RNAMap/raga/chromhmm/ChromHMM/sort/deDup.pl';
my @queries1 = ("$workdir/KO1-sorted.bam");
my @queries2 = ("$workdir/KO2-sorted.bam");
my @outfiles = ("$workdir/KO.bam");
my @outfiles2 = ("$workdir/KO-sorted");
my @outfiles3 = ("$workdir/KO-sorted.bam");
my @outfiles4 = ("$workdir/KO-sorted.bai");



for (my $i=0; $i<scalar(@queries1); $i++) {
	system "samtools merge $outfiles[$i] $queries1[$i] $queries2[$i]";
	system "samtools sort $outfiles[$i] $outfiles2[$i]";
	system "samtools index $outfiles3[$i] $outfiles4[$i]";
}
