--  ********************** problem 1: ********************************************
--  1) (a) What is the most popular bigram of all time?  (b) What is the most popular bigram in year 1987?  (c) How about in year 1953?

-- ********************** 1.a ###############################		
CREATE TABLE question1a_results (
    gram string,
    occurrences bigint
);

INSERT OVERWRITE TABLE question1a_results
SELECT
 gram,
 sum(occurrences) as total
FROM
 bigrams
GROUP BY
 gram
DISTRIBUTE BY
 gram
SORT BY
 total DESC
LIMIT
 10;
-- ********************** 1.a ###############################
-- //////////////////////////////////////////////////////////
-- ********************** 1.b ###############################
CREATE TABLE question1b_results (
    gram string,
    occurrences bigint
);

INSERT OVERWRITE TABLE question1b_results
SELECT
 gram,
 sum(occurrences) as total
FROM
 bigrams
WHERE
 year = 1987
GROUP BY
 gram
DISTRIBUTE BY
 gram
SORT BY
 total DESC
LIMIT
 10;
-- ********************** 1.b ###############################
-- //////////////////////////////////////////////////////////
-- ********************** 1.c ###############################
CREATE TABLE question1c_results (
    gram string,
    occurrences bigint
);

INSERT OVERWRITE TABLE question1c_results
SELECT
 gram,
 sum(occurrences) as total
FROM
 bigrams
WHERE
 year = 1953
GROUP BY
 gram
DISTRIBUTE BY
 gram
SORT BY
 total DESC
LIMIT
 10;

