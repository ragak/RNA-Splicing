#!/usr/bin/perl
use strict;
use warnings;

my $workdir = '/N/dc2/projects/RNAMap/raga/splicing/mapping'
#my $workdir2 = '/N/dc2/projects/RNAMap/raga/chromhmm/ChromHMM/sort/'
#my $deDup = '/N/dc2/projects/RNAMap/raga/chromhmm/ChromHMM/sort/deDup.pl';
my @queries = ("$workdir/KO1.fastqAligned.out.sam","$workdir/KO2.fastqAligned.out.sam","$workdir/Rev1.fastqAligned.out.sam","$workdir/Rev2.fastqAligned.out.sam");
my @outfiles = ("$workdir/KO1-sorted","$workdir/KO2-sorted","$workdir/Rev1-sorted","$workdir/Rev2-sorted");
my @outfiles2 = ("$workdir/KO1-sorted.bam","$workdir/KO2-sorted.bam","$workdir/Rev1-sorted.bam","$workdir/Rev2-sorted.bam");
my @outfiles3 = ("$workdir/KO1-sorted.bai","$workdir/KO2-sorted.bai","$workdir/Rev1-sorted.bai","$workdir/Rev2-sorted.bai");



for (my $i=0; $i<scalar(@queries); $i++) {
	system "samtools view -bS $queries[$i] | samtools sort - $outfiles[$i]";
	system "samtools index $outfiles2[$i] $outfiles3[$i]"
}
