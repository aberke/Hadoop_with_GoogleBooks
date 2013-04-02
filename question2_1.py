#!/usr/bin/python
import sys 


################## problem 2: #####################################################################################################
# Identify a few words that were coined after 1970.  These should be words that were never appear before 1970 but begin to appear
#		(with non-negigable frequency) in later decades.  You might illustrate the increasing usage of the new term by plotting 
#		its frequency in the corpus on the y-axis against time on the x-axis.

##### 111111111111111111111111111111111111	 1st pass): 	111111111111111111111111111111 ###########
# Input: Full data set
# Output: 
#	Idea:
# 		if year>1970:
# 			LongValueSum word book_count <-- I assume we want to ignore when some author makes up a word and uses it in 1 book again and again
# 		else:
# 			LongValueSum word 0.3 <--- since can never sum to full integer, decimal will be a flag that word appeared before 1970.
def first_pass(argv):
	for line in sys.stdin:
		[unigram, year, count, page_count, book_count] = line.split('\t')
		if year > 1970:
			print "DoubleValueSum:" + unigram + "\t" + book_count
		else:
			print "DoubleValueSum:" + unigram + "\t" + 0.3
## 11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111 ##########

def main(argv): 
    first_pass(argv) #change on what we're using it for I suppose until we break this into multiple files


if __name__ == "__main__": 
    main(sys.argv) 