#!/usr/bin/python
import sys 

match_year = 1987

# input: Google-books bigram data
def max_bigram_year(argv):
	for line in sys.stdin:
		try:
			[bigram, year, count, page_count, book_count] = line.split('\t')
		except ValueError:
			print "Error with -- %s" % line
			raise
		
		if year == str(match_year):
			print "LongValueMax:" + bigram + "\t" + count


def main(argv): 
	max_bigram_year(argv) #change on what we're using it for I suppose until we break this into multiple files


if __name__ == "__main__": 
	main(sys.argv) 