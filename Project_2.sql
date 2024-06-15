show databases;
use gs_data;
show tables;

select * from vgsales;

create table vgsales_copy like vgsales;

insert into vgsales_copy select * from vgsales;

select * from vgsales_copy;

-- DATA UNDERSTANDING 
desc vgsales;                       -- It shows there are NULL values

select distinct Name from vgsales_copy;
select distinct platform from vgsales_copy;
select distinct Genre from vgsales_copy;
select distinct Publisher from vgsales_copy;
/* Here we understand what kind of datawe have also,
we see there are no errors for which we need to STANDARDIZE */

-- Missing values / Null Values 
select * from vgsales_copy where 'Name' is NULL;
select * from vgsales_copy where 'Name' = ' ';

select * from vgsales_copy where Global_Sales is NULL;
select * from vgsales_copy where Global_Sales = ' ';

/*If we run above query for every column we find that there are no missing or Null values with in data */

-- DUPLICATES 

 select *,
 row_number() over( partition by Name, `Rank`, Platform, Year, Genre, Publisher, NA_Sales,
 EU_Sales, JP_Sales, Other_Sales, Global_Sales) as row_num from vgsales_copy;

with duplicate_cte as 
( select *,
 row_number() over( partition by Name, `Rank`, Platform, Year, Genre, Publisher, NA_Sales,
 EU_Sales, JP_Sales, Other_Sales, Global_Sales) as row_num from vgsales_copy)
 select * from duplicate_cte where row_num > 1;
 -- Hence no duplicates were found
 
 -- It seems thankfully we have good clean data now we can further analyze it in Power BI 
