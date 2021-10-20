select type, pubdate from titles order by type;

--Get average prices from the titles table for each type of book, and convert type to char(30).
select type::char(30), avg(coalesce(price, '0')::numeric) from titles
group by type;

--Print the difference between (to a resolution of days) the earliest and latest publication date in titles
select max(pubdate)-min(pubdate) as "difference in number of days" from titles;

--Print the average, min and max book prices within the titles table organised into groups based on type and publisher id
select type, pub_id, avg(coalesce(price, '0')::numeric) as "average price", min(coalesce(price, '0')::numeric) as "min price", max(coalesce(price, '0')::numeric) as "max price"  
from titles
group by type, pub_id
having avg(coalesce(price, '0')::numeric) > 20
order by "average price";

--List the books in order of the length of their title
select title  from titles
order by length(title);

--What is the average age in months of each type of title?
select type, avg(extract(year from age(pubdate))*12  + extract(month from age(pubdate)))
from titles
group by type
order by type;

--How many authors live in each city?
select city, count(city) from authors
group by city
order by count(city);

--What is the longest title?
select title, length(title) from titles
order by length(title) desc limit 1 ;

--How many books have been sold by each store
select stor_id, sum(qty) from sales
group by stor_id;

--how many books have been sold in total
select sum(qty) from sales;