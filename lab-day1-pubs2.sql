select * from titles;
-- Find all titles with an undefined price in table 'titles'
select * from titles t where price is null;

-- Find all titles with an undefined price in table titles and supply a price of $20.00 for those with no defined price
select title, '20'::money from titles t where price is null;
select * from titles, coalesce(price, '20') new_prices;

select * from pub_info pi3;
-- List the first 50 characters of the pr_info column of the pub_info table
select substring(pr_info, 1, 50) from pub_info pi2;
select pr_info::varchar(50) from pub_info;

select * from sales;

-- WORKING WITH DATES

-- print out date as string format eg: Tuesday 13th September 1994
select * from sales, to_char(ord_date, 'Day DD Month YYYY ') ;
select current_timestamp::varchar;

-- display the current date
select current_date as "Todays date";

-- display the current time
select current_time as "Current Time";

-- display the current timestamp
select current_timestamp as "Current Timestamp";

-- convert string to date
select '2018-10-19'::date;
select to_date('2018-10-19', 'YYYY MM DD') 

-- convert string to timestamp
select '2018-10-19'::timestamp;

-- subtracting dates
select '2018-12-25'::date - '2018-09-26'::date;
select *, current_date - pubdate as "elapsed days" from titles;

-- Display the year of publication of each book in titles
select *, extract(year from pubdate)::varchar as "Year of Publication",
extract (day from pubdate)::varchar as "Day of Publication"
from titles;
	

-- EXERCISES

-- add the difference between current date and 2011-01-01 to the ord_date column in sales 
select *, to_char((ord_date +(current_date - '2011-01-01'::date)), 'dd-mm-yy') as "new ord_date" from sales;

-- print number of days to Christmas and new years
select ('2021-12-25'::date - current_date) as "Countdown to Christmas",
	('2022-01-01'::date - current_date) as "Countdown to New Years";

-- find number of days old from birthdate and current date
select (current_date - '1999-05-27'::date) as "Number of days old";

select * from sales;

-- change ord_date to dd/mm/yyyy format, then select sales for date nearest to birthdate.
-- find the absolute value of the difference between dates, sort the values and choose the first.
-- use either fetch first 1 row only or limit 1
select stor_id, to_char(ord_date, 'dd/mm/yyyy') as "Order Date" from sales
	order by abs(ord_date - '1999-05-27'::date) fetch first 1 row only;	


-- select title and display dates for USA, UK and Japan date formats
select title, to_char(pubdate, 'MM/DD/YYYY') as "USA format",
	to_char(pubdate, 'DD/MM/YYYY') as "UK format",
	to_char(pubdate, 'YYYY/MM/DD') as "Japan format"
	from titles;

-- show the first word of each title
select *, substring(title, 1, position(' ' in title)) as "first word in title" from titles;


-- replacing all occurences of space in address to --hello--
select *, replace (address, ' ', '--hello--') as "new address" from authors

-- replace first occurence of space in address to --hello--
select *, regexp_replace (address, ' ', '--hello--') as "new address" from authors


-- replace null prices in titles table with random price
select * from titles, coalesce(price, round((random()*100)::numeric, 2)::money) new_prices;

select * from authors;

-- Print all phone numbers from the authors table without the three digit area code.
select *, substring(phone, position(' ' in phone)) as "only phone number" from authors;

-- Capitalise the second character in all last names from the authors table.
select *, substring(au_lname, 1,1) || upper(substring(au_lname, 2,1)) || substring(au_lname,3) from authors;
select *, left(au_lname, 1) || upper(substring(au_lname, 2,1)) || right(au_lname,-2) from authors;

select sellers.id, sellers.name, suppliers.name from sellers inner join suppliers on sellers.supplier_id = suppliers.id