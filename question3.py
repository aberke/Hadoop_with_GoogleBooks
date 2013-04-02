#!/usr/bin/python
import sys 
import re 


################## problem 3: #####################################################################################################
# Suppose we're interesting in finding trigrams which tend to appear many times on the same page or many times in the same book.
#	a) What is the trigram that appears at least 10 times with the lowest ratio of page_count to total_count?
#	b) What is the trigram that appears at least 10 times with the lowest ratio of book_count to total_count?

########### Alex's 1st Idea: ############################
# # Need to find aggregator that will take key and sum two separate items

# 1a)
# input: Google-books trigram data
def first_pass(argv):
	for line in sys.stdin:
		print "LongValueSum:" + 'foo\t1\t2'
		#[trigram, year, count, page_count, book_count] = line.split('\t')
		#print "LongValueSum:" + trigram + "\t" + page_count +"\t" + count


def main(argv): 
    first_pass(argv)

if __name__ == "__main__": 
    main(sys.argv) 