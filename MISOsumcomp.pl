#!/usr/bin/perl

use strict;
use warnings;

my $workdir = '/N/dc2/projects/RNAMap/raga/splicing/miso/test/A3SS/';
my $workdir2 = '/N/dc2/projects/RNAMap/raga/splicing/miso/test/A3SS/';
my $workdir3 = '/N/dc2/projects/RNAMap/raga/splicing/miso/RdYcomp/';

system "summarize_miso --summarize-samples $workdir $workdir";
system "summarize_miso --summarize-samples $workdir2 $workdir2";
system "compare_miso --compare-samples $workdir $workdir2 $workdir3";