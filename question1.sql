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

--  1) (a) What is the most popular bigram of all time?  (b) What is the most popular bigram in year 1987?  How about in year 1953?
-- ********************** 1.a ###############################		
--  (a) --> Answer in two iterations of map-reduce:
-- 	1st iteration: compile count for each bigram in given (or not given) year
-- 	2nd iteration: find bigram with max count
-- **************************************************************************************** 
-- 1ST ITERATION:
-- input: Google-Books bigram data
-- **************************************************************************************** 

CREATE TABLE question1a_results (
    gram string,
    occurrences bigint
)
ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t'
LINES TERMINATED BY '\n'
STORED AS TEXTFILE
LOCATION 's3://cs158-aberke-hadoop/output/question1a/';

INSERT OVERWRITE TABLE question1a_results
SELECT
 gram,
 sum(occurrences) as total
FROM
 bigrams
GROUP BY
 gram
SORT BY
 total DESC
DISTRIBUTE BY
 gram
LIMIT
 10;


-- ********************** 1.a ###############################
-- //////////////////////////////////////////////////////////
-- ********************** 1.b ###############################
CREATE TABLE question1b_results (
    gram string,
    occurrences bigint
)
ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t'
LINES TERMINATED BY '\n'
STORED AS TEXTFILE
LOCATION 's3://cs158-aberke-hadoop/output/question1b/';

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
SORT BY
 total DESC
DISTRIBUTE BY
 gram
LIMIT
 10;
 
-- ********************** 1.b ###############################
-- //////////////////////////////////////////////////////////
-- ********************** 1.c ###############################
CREATE TABLE question1c_results (
    gram string,
    occurrences bigint
)
ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t'
LINES TERMINATED BY '\n'
STORED AS TEXTFILE
LOCATION 's3://cs158-aberke-hadoop/output/question1c/';

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
SORT BY
 total DESC
DISTRIBUTE BY
 gram
LIMIT
 10;



