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


system "index_gff --index $workdir3/SE.mm10.gff3 $workdir2/indexed_SE_events_MISO/";
system "index_gff --index $workdir3/A3SS.mm10.gff3 $workdir2/indexed_A3SS_events_MISO/";
system "index_gff --index $workdir3/A5SS.mm10.gff3 $workdir2/indexed_A5SS_events_MISO/";
system "index_gff --index $workdir3/AFE.mm10.gff3 $workdir2/indexed_AFE_events_MISO/";
system "index_gff --index $workdir3/ALE.mm10.gff3 $workdir2/indexed_ALE_events_MISO/";
system "index_gff --index $workdir3/MXE.mm10.gff3 $workdir2/indexed_MXE_events_MISO/";
system "index_gff --index $workdir3/RI.mm10.gff3 $workdir2/indexed_RI_events_MISO/";
system "index_gff --index $workdir3/TandemUTR.mm10.gff3 $workdir2/indexed_TandemUTR_events_MISO/";