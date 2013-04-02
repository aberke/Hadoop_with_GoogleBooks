#!/usr/bin/python
import sys 

# question1.a second pass 

# 2ND ITERATION:
	# input: output of 1st iteration
def max_bigram_alltime(argv):
	for line in sys.stdin:
		[bigram, count] = line.split('\t')
		print "LongValueMax:" + bigram + "\t" + count

def main(argv): 
    max_bigram_alltime(argv) 


if __name__ == "__main__": 
    main(sys.argv) 