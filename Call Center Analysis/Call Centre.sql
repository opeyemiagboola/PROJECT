create database call_center;
use call_center;

create table if not exists calls( 
id varchar(255) primary key,
customer_name varchar(255),
centiment varchar(255),
csat_score text,
call_timestamp text,
reason varchar(255),
city varchar(255),
state varchar(255),
channel varchar(255),
response_time varchar(255),
call_duration text,
call_center varchar(255)
);

select count(*) from calls;

-- data cleaning
-- dealing with missing value
select id 
from calls
where id is null;

select *
from calls;

select count(*)
from calls
where csat_score =  '';

select count(*) as'missing_count'
from calls
where call_duration ='';

desc calls; 

-- replace empty value in csat_score to null
set sql_safe_updates = 0;

update calls
set csat_score = null
where csat_score = '';

-- convert datatype of csat_score to int
alter table calls
modify csat_score int;

-- convert the call_timestamp to date
select call_timestamp from calls;

update calls
set call_timestamp = str_to_date(call_timestamp, "%m/%d/%Y");

alter table calls
modify call_stamp date;

-- fill_missing with average
select round(avg(csat_score),0) from calls;

update calls 
set csat_score = 6
where csat_score is null;

select * from calls;

-- EDA (EXPLORATORY DATA ANALYSIS)
/*
TOTAL NO OF CALLS (KPI)
TOTAL UNIQUE CUSTOMERS
TOTAL CALLS BY SENTIMENT
AVG CUSTOMER SATISFACTION SCORE (KPI)
TOTAL CALLS BY REASON
TOTAL CALLS BY STATE
TOTAL CALLS BY CHANNEL
TOTAL SCORE BY RESPONSE_TIME
AVERAGE CALL DURATION (KPI)
TOTALS BY CALL CENTER
*/

-- ANSWERS:
-- TOTAL NO OF CALLS (KPI)
select count(id) as "total calls"
from calls;

-- TOTAL UNIQUE CUSTOMERS (KPI)
select count(distinct customer_name)
from calls;

-- TOTAL CALLS BY SENTIMENT
select centiment, count(id) as "total calls"
from calls
group by centiment
order by count(id) desc;

-- AVG CUSTOMER SATISFACTION SCORE (KPI)
select round(avg(csat_score), 0) as "avg_score"
from calls;

-- TOTAL CALLS BY RESPONSE
select response_time, count (id) as "total calls"
from calls
group by state
order by COUNT(id)


