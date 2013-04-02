-- ################## problem 2: #####################################################################################################
--  Identify a few words that were coined after 1970.  These should be words that were never appear before 1970 but begin to appear
-- 		(with non-negigable frequency) in later decades.  You might illustrate the increasing usage of the new term by plotting 
-- 		its frequency in the corpus on the y-axis against time on the x-axis.

-- ##### 111111111111111111111111111111111111	 1st pass): 	111111111111111111111111111111 ###########
CREATE EXTERNAL TABLE english_unigrams (
 gram string,
 year int,
 total_count bigint,
 page_count bigint,
 book_count bigint
)
ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t'
STORED AS SEQUENCEFILE
LOCATION 's3://datasets.elasticmapreduce/ngrams/books/20090715/eng-all/1gram/';

CREATE TABLE question2_firstpass (
 gram string,
 min_year int,
 total_count bigint
);

INSERT OVERWRITE TABLE question2_firstpass
SELECT
 gram,
 MIN(year),
 SUM(total_count)
FROM
 english_unigrams
WHERE
 gram REGEXP "^[A-Za-z+'-]+$"
DISTRIBUTE BY
 gram;
-- GROUP BY -- don't need GROUP BY, right?
--  gram;

-- ##### 111111111111111111111111111111111111	 2nd pass):  print out relevant grams	111111111111111111111111111111 ###########
SELECT
 gram, total_count
FROM
 question2_firstpass
WHERE
 min_year > 1970
DISTRIBUTE BY
 gram
SORT BY
 total_count DESC
LIMIT
 20;


 
-- ##### 111111111111111111111111111111111111	 3rd pass):  For given gram selected from output of 2nd pass: 111111111111111111111111111111 ###########
SELECT
 year as <gram selected>_year,
 total_count as <gram selected>_count
FROM
 english_unigrams
WHERE
 gram == <gram selected>
SORT BY
 year ASC;






