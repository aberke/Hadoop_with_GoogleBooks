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


--  ********************** problem 1: ********************************************
CREATE EXTERNAL TABLE english_bigrams (
 gram string,
 year int,
 total_count bigint,
 page_count bigint,
 book_count bigint
)
ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t'
STORED AS SEQUENCEFILE
LOCATION 's3://datasets.elasticmapreduce/ngrams/books/20090715/eng-all/2gram/';

--  1) (a) What is the most popular bigram of all time?  (b) What is the most popular bigram in year 1987?  How about in year 1953?
-- ********************** 1.a ###############################		
--  (a) --> Answer in two iterations of map-reduce:
-- 	1st iteration: compile count for each bigram in given (or not given) year
-- 	2nd iteration: find bigram with max count
-- **************************************************************************************** 
-- 1ST ITERATION:
-- input: Google-Books bigram data
-- **************************************************************************************** 

INSERT OVERWRITE DIRECTORY "s3://<bucket>/<prefix>"
SELECT
 gram,
 sum(total_count) as total
FROM
 bigrams
GROUP BY
 gram
SORT BY
 total DESC
LIMIT
 10;


-- ********************** 1.a ###############################
-- //////////////////////////////////////////////////////////
-- ********************** 1.b ###############################
CREATE EXTERNAL TABLE english_bigrams (
 gram string,
 year int,
 total_count bigint,
 page_count bigint,
 book_count bigint
)
ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t'
STORED AS SEQUENCEFILE
LOCATION 's3://datasets.elasticmapreduce/ngrams/books/20090715/eng-all/2gram/';
-- Now extract out data we want and order it by count so we get the top one!
SELECT
 gram,
 total_count
FROM
 english_bigrams
WHERE-- <-- do we want a WHERE clause with regex here?
 year = 1987
DISTRIBUTE BY -- <-- do we want this?? We want to filter out all the other decades anyhow, this might reduce the time of our job flow
 year
SORT BY
 total_count DESC
LIMIT
 10;
-- ********************** 1.b ###############################
-- //////////////////////////////////////////////////////////
-- ********************** 1.c ###############################
CREATE EXTERNAL TABLE english_bigrams (
 gram string,
 year int,
 total_count bigint,
 page_count bigint,
 book_count bigint
)
ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t'
STORED AS SEQUENCEFILE
LOCATION 's3://datasets.elasticmapreduce/ngrams/books/20090715/eng-all/2gram/';
-- Now extract out data we want and order it by count so we get the top one!
SELECT
 gram,
 total_count
FROM
 english_bigrams
WHERE-- <-- do we want a WHERE clause with regex here?
 year = 1953
DISTRIBUTE BY -- <-- do we want this?? We want to filter out all the other decades anyhow, this might reduce the time of our job flow
 year
SORT BY
 total_count DESC
LIMIT
 10;


