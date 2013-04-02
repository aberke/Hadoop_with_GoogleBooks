#!/usr/bin/python
import sys 

# question1.a first pass

# 1ST ITERATION:
	# input: Google-Books bigram data
def count_bigram(argv):
	for line in sys.stdin:
		[bigram, year, count, page_count, book_count] = line.split('\t')
		print "LongValueSum:" + bigram + "\t" + count

def main(argv): 
    count_bigram(argv) 


if __name__ == "__main__": 
    main(sys.argv) 