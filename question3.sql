-- ################## problem 3: #####################################################################################################
--  Suppose we're interesting in finding trigrams which tend to appear many times on the same page or many times in the same book.
--	a) What is the trigram that appears at least 10 times with the lowest ratio of page_count to total_count?
-- 	b) What is the trigram that appears at least 10 times with the lowest ratio of book_count to total_count?


-- ********************** 3.a ###############################
CREATE TABLE question3_firstpass (
 gram string,
 page_count bigint,
 book_count bigint,
 total_count bigint
);

INSERT OVERWRITE TABLE question3_firstpass
SELECT
 gram,
 SUM(pages),
 SUM(books),
 SUM(occurrences)
FROM
 trigrams
GROUP BY
 gram
DISTRIBUTE BY
 gram;

CREATE TABLE question3_pageratio (
    gram string,
    ratio double
);

INSERT OVERWRITE TABLE question3_pageratio
SELECT
 gram,
 page_count / total_count as ratio
FROM
 question3_firstpass
WHERE
 total_count >= 10
SORT BY
 ratio ASC
LIMIT
 5;
-- ********************** 3.a ###############################
-- //////////////////////////////////////////////////////////
-- ********************** 3.b ###############################

CREATE TABLE question3_bookratio (
    gram string,
    ratio double
);

INSERT OVERWRITE TABLE question3_bookratio
SELECT
 gram,
 book_count / total_count as ratio
FROM
 question3_firstpass
WHERE
 total_count >= 10
GROUP BY
 gram
DISTRIBUTE BY
 gram
SORT BY
 ratio ASC
LIMIT
 5;
 
