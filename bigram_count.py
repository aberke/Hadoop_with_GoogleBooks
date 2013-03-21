#!/usr/bin/python
import sys 
import re 


# problem 1:

# 1) (a) What is the most popular bigram of all time?  (b) What is the most popular bigram in year 1987?  How about in year 1953?
#********************** 1.a ###############################		
# (a) --> Answer in two iteration of map-reduce:
#	1st iteration: compile count for each bigram in given (or not given) year
#	2nd iteration: find bigram with max count

# 1ST ITERATION:
	# input: Google-Books n-gram data
def count_bigram(argv):
	for line in sys.stdin:
		[trigram, year, count, page_count, book_count] = line.split('\t')
		print "LongValueSum:" + trigram + "\t" + count

# 2ND ITERATION:
	# input: output of 1st iteration
def max_bigram_alltime(argv):
	for line in sys.stdin:
		[trigram, count] = line.split('\t')
		print "LongValueMax:" + trigram + "\t" + count  # is this how to use LongValueMax??????
######################## 1.a #################################

######################## 1.b #################################
# (b) --> much simpler than (a) since only need to find max

	# input: Google-books n-gram data
def max_bigram_year(argv, match_year):
	for line in sys.stdin:
		[trigram, year, count, page_count, book_count] = line.split('\t')
		if year == match_year:
			print "LongValueMax:" + trigram + "\t" + count



match_year = None

def main(argv): 
    count_bigram(argv) #change on what we're using it for I suppose until we break this into multiple files


if __name__ == "__main__": 
    main(sys.argv) 