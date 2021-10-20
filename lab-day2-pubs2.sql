-- AGGREGATES

--select type, pubdate from titles order by type;

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


-- JOINS

select * from titles ;
select * from pub_info;
select * from publishers p ;

--Join the publishers and pub_info and show the publisher name and the first 40 characters of the pr_info information.
select publishers.pub_name, left(pub_info.pr_info, 40) as "pub_info"
from publishers inner join pub_info
on publishers.pub_id = pub_info.pub_id ;

--Join the publishers and titles tables to show all titles published by each publisher. Display the pub_id, pub_name and title_id
select p.pub_id, p.pub_name, t.title_id 
from publishers p inner join titles t 
on p.pub_id = t.pub_id;

--For each title_id in the table titles, rollup the corresponding qty in sales and 
--show: title_id, title, ord_num and the rolled-up value as a column aggregate called Total Sold
select t.title_id, t.title, s.ord_num, sum(s.qty) as "Total Sold"
from titles t inner join sales s 
on t.title_id = s.title_id
group by t.title, t.title_id, s.ord_num 
order by t.title_id ;


--For each stor_id in stores, show the corresponding ord_num in sales and the discount type from table discounts. 
--The output should consist of three columns: ord_num, discount and discounttype and should be sorted on ord_num
select stores.stor_id, sales.ord_num, discounts.discount, discounts.discounttype 
from stores inner join sales 
on stores.stor_id = sales.stor_id 
left outer join discounts
on stores.stor_id = discounts.stor_id
order by sales.ord_num ;


--Show au_lname from authors, and pub_name from publishers when both publisher and author live in the same city.
select  a.au_lname, p.pub_name
from authors a inner join publishers p
on a.city = p.city ;

--for each author you show all publishers who live in the same city and have published one of the authors titles
select a.au_lname, p.pub_name
from authors a inner join publishers p
on a.city = p.city 
inner join titleauthor t 
on a.au_id = t.au_id ;


--Using outer join
--Join the publishers and pub_info and show the publisher name and the first 40 characters of the pr_info information
select publishers.pub_name, left(pub_info.pr_info, 40) as "pub_info"
from publishers left outer join pub_info
on publishers.pub_id = pub_info.pub_id ;


--List each publisher's name, the title of each book they have sold and the total quantity of that title.
select p.pub_name, t.title, sum(s.qty) as "total quantity"
from publishers p inner join titles t
on p.pub_id = t.pub_id 
inner join sales s 
on t.title_id = s.title_id 
group by p.pub_name, t.title
order by p.pub_name, "total quantity" ;


-- How many books have been published by each publisher?
select p.pub_name, count(t.title_id) as "total quantity"
from publishers p inner join titles t
on p.pub_id = t.pub_id 
group by p.pub_name
order by p.pub_name, "total quantity" ;


--How many different types of books has each publisher published?
select p.pub_name, t.type, count(t."type")
from publishers p inner join titles t
on p.pub_id = t.pub_id 
group by p.pub_name, t."type" 
order by p.pub_name;


