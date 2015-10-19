#!/usr/bin/python

infiles = ["/N/dc2/projects/RNAMap/raga/splicing/mapping/",
import shutil

for a in infiles:
	txt=open(a,'r')
	lines = txt.readlines()
	txt.close()
	copyfile(a, b)
	txt2=open(b,'r')
	nlines=[]
	for line in lines:
		temp=line.split()
		if temp[4]==255:
			txt2.write(line)
	txt2.close()