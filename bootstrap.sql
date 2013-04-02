# UNIGRAM SETUP
CREATE EXTERNAL TABLE unigrams_raw (
    gram string,
    year int,
    occurrences bigint,
    pages bigint,
    books bigint
)
ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t'
STORED AS SEQUENCEFILE
LOCATION 's3://datasets.elasticmapreduce/ngrams/books/20090715/eng-us-all/1gram/';

CREATE TABLE unigrams (
    gram string,
    year int,
    occurrences bigint
);

INSERT OVERWRITE TABLE unigrams
SELECT lower(gram), year, occurrences FROM unigrams_raw WHERE gram REGEXP "^[A-Za-z+'-]+$";

# BIGRAM SETUP
CREATE EXTERNAL TABLE bigrams_raw (
    gram string,
    year int,
    occurrences bigint,
    pages bigint,
    books bigint
)
ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t'
STORED AS SEQUENCEFILE
LOCATION 's3://datasets.elasticmapreduce/ngrams/books/20090715/eng-us-all/2gram/';

CREATE TABLE bigrams (
    gram string,
    year int,
    occurrences bigint
);

INSERT OVERWRITE TABLE bigrams
SELECT lower(gram), year, occurrences FROM bigrams_raw WHERE gram REGEXP "^[A-Za-z+'-]+ [A-Za-z+'-]+$";

# TRIGRAM SETUP
CREATE EXTERNAL TABLE trigrams_raw (
    gram string,
    year int,
    occurrences bigint,
    pages bigint,
    books bigint
)
ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t'
STORED AS SEQUENCEFILE
LOCATION 's3://datasets.elasticmapreduce/ngrams/books/20090715/eng-us-all/3gram/';

CREATE TABLE trigrams (
    gram string,
    occurrences bigint,
    pages bigint,
    books bigint
);

INSERT OVERWRITE TABLE trigrams
SELECT lower(gram), occurrences, pages, books FROM trigrams_raw WHERE gram REGEXP "^[A-Za-z+'-]+ [A-Za-z+'-]+ [A-Za-z+'-]+$";
