-- ################## problem 2: #####################################################################################################
--  Identify a few words that were coined after 1970.  These should be words that were never appear before 1970 but begin to appear
-- 		(with non-negigable frequency) in later decades.  You might illustrate the increasing usage of the new term by plotting 
-- 		its frequency in the corpus on the y-axis against time on the x-axis.

-- ##### 111111111111111111111111111111111111	 1st pass): 	111111111111111111111111111111 ###########
CREATE TABLE question2_firstpass (
 gram string,
 min_year int,
 total_count bigint
);

INSERT OVERWRITE TABLE question2_firstpass
SELECT
 gram,
 MIN(year),
 SUM(occurrences)
FROM
 unigrams
GROUP BY
  gram
DISTRIBUTE BY
  gram;

-- ##### 111111111111111111111111111111111111	 2nd pass):  print out relevant grams	111111111111111111111111111111 ###########

CREATE TABLE question2_secondpass (
    gram string,
    total_count bigint
);

INSERT OVERWRITE TABLE question2_secondpass
SELECT
 gram, total_count
FROM
 question2_firstpass
WHERE
 min_year > 1970
SORT BY
 total_count DESC
LIMIT
 20;
 
-- ##### 111111111111111111111111111111111111	 3rd pass):  For given gram selected from output of 2nd pass: 111111111111111111111111111111 ###########
CREATE TABLE question2_graphable (
    gram string,
    year int,
    occurrences bigint
)
ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t'
STORED AS SEQUENCEFILE
LOCATION 's3://cs158-aberke-hadoop/output/question2.csv';

INSERT OVERWRITE TABLE question2_graphable
SELECT
    gram, year, SUM(occurrences)
FROM
    unigrams
WHERE
    gram IN ("autocad", "apoptosis", "comorbidity", "comorbid", "actionscript")
DISTRIBUTE BY
    gram;
