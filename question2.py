#!/usr/bin/python
import sys 


################## problem 2: #####################################################################################################
# Identify a few words that were coined after 1970.  These should be words that were never appear before 1970 but begin to appear
#		(with non-negigable frequency) in later decades.  You might illustrate the increasing usage of the new term by plotting 
#		its frequency in the corpus on the y-axis against time on the x-axis.


##################### Alex's idea for how to do: ###############################################################

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


##### 22222222222222222222222222222222222	2nd pass): 		22222222222222222222222222222222 #############
# Input: output from first_pass
# Output: printed words that are valid to examine -- words coined after 1970 and used non-negligably
# Idea:
#	print words where book_count is an integer value AND book_count > threshhold. 
threshhold = 5 # <-- set reasonable threshhold.

def second_pass(argv):
	for line in sys.stdin:
		[word, book_count] = line.split('\t')
		if not '.' in book_count and book_count >= threshhold: 
			# book_count is an integer -- word wasn't flagged as appearing before 1970 AND book_count non-negligable
			print word
#222222222222222222222222222222222222222222222222222222222222222222222222222222222222222 #############

##### 3333333333333333333333333333333333 	3rd pass): 		333333333333333333333333333333 ############
# Input: Full data set, word to print (year, count) data for
# Output: file where each line is 'year, count'
#
# Idea: For given unigram word:
# 			if unigram == word:
# 				print x-axis-data, y-axis-data
def third_pass(argv, word): # <-- that syntax probably is not compatible with command line interface
	for line in sys.stdin:
		[unigram, year, count, page_count, book_count] = line.split('\t')
		if unigram == word:
			print year "," + count

	
# Other Idea: ######################################################################################################
# 
# Idea issue: Does not do a good job of dismissing negligably appearing words

word: count+ 0 minyear

1st pass:
	map bigram to min year appeared
2nd pass:
	print bigrams where minyear > 1970

for each outputted bigram:
	3rd pass:
		year: count


