-- ********************** For each new job: ***********************************************
-- **************************************************************************************** 
-- start a job flow with this command.
elastic-mapreduce --create --alive --hive-interactive --hive-versions 0.7
--This will give you a job flow ID. You can track the status of your job low with the list parameter.
elastic-mapreduce --list <job-flow-id>
--In a few minutes this will start and enter the waiting state, at which point we can SSH to the master node.
elastic-mapreduce --ssh <job-flow-id>
--Now that we have Hive installed on our cluster we can log into its shell by typing 'hive'.
$ hive
--There are two settings that we need to set in order to efficiently process the data from Amazon S3. Type these two commands into the Hive shell.
hive> set hive.base.inputformat=org.apache.hadoop.hive.ql.io.HiveInputFormat;
hive> set mapred.min.split.size=134217728;
-- ****************************************************************************************


-- ################## problem 3: #####################################################################################################
--  Suppose we're interesting in finding trigrams which tend to appear many times on the same page or many times in the same book.
--	a) What is the trigram that appears at least 10 times with the lowest ratio of page_count to total_count?
-- 	b) What is the trigram that appears at least 10 times with the lowest ratio of book_count to total_count?


-- ********************** 1.a ###############################
-- input: Google-books trigram data
CREATE EXTERNAL TABLE english_trigrams (
 gram string,
 year int,
 total_count bigint,
 page_count bigint,
 book_count bigint
)
ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t'
STORED AS SEQUENCEFILE
LOCATION 's3://datasets.elasticmapreduce/ngrams/books/20090715/eng-all/3gram/';


CREATE TABLE question3_firstpass (
 gram string,
 page_count bigint,
 book_count bigint,
 total_count bigint
);

INSERT OVERWRITE TABLE question3_firstpass
SELECT
 gram,
 SUM(page_count),
 SUM(book_count),
 SUM(total_count)
FROM
 english_trigrams
DISTRIBUTE BY
 gram;
-- GROUP BY -- don't need, right??
--  gram;


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
-- ********************** 1.a ###############################
-- //////////////////////////////////////////////////////////
-- ********************** 1.b ###############################
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