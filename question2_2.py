#!/usr/bin/python
import sys 


################## problem 2: #####################################################################################################
# Identify a few words that were coined after 1970.  These should be words that were never appear before 1970 but begin to appear
#		(with non-negigable frequency) in later decades.  You might illustrate the increasing usage of the new term by plotting 
#		its frequency in the corpus on the y-axis against time on the x-axis

##### 22222222222222222222222222222222222	2nd pass): 		22222222222222222222222222222222 #############
# Input: output from first_pass
# Output: printed words that are valid to examine -- words coined after 1970 and used non-negligably
# Idea:
#	print words where book_count is an integer value AND book_count > threshhold. 
threshhold = 10 # <-- set reasonable threshhold.

def second_pass(argv):
	for line in sys.stdin:
		[word, book_count] = line.split('\t')
		if not '.' in book_count and book_count >= threshhold: 
			# book_count is an integer -- word wasn't flagged as appearing before 1970 AND book_count non-negligable
			print word
#222222222222222222222222222222222222222222222222222222222222222222222222222222222222222 #############

def main(argv): 
    second_pass(argv) #change on what we're using it for I suppose until we break this into multiple files

if __name__ == "__main__": 
    main(sys.argv) 