select * from titles ;
select * from titleauthor;
select * from authors order by au_fname ;

--Which publishers have published at least one book?
select p.pub_id, p.pub_name 
from publishers p
where (p.pub_id in (
	select t.pub_id
	from titles t));
	
--Which authors have been published by more than one publisher?

select au_id from (
	select ta.au_id , t.pub_id 
	from titleauthor ta inner join titles t 
	on ta.title_id = t.title_id 
	group by ta.au_id ,t.pub_id  
	order by au_id
) as "author_publisher"
group by au_id
having count(au_id) > 1

--Which authors live in a city where a publisher exists?
select a.au_fname, a.au_lname from authors a
where a.city in (
	select p.city from publishers p);


--	How many authors are there with the same first initial?
select sum(count) from (
select (left(a.au_fname,1)), count(left(a.au_fname,1))
from authors a
group by (left(a.au_fname,1))) as firstt
where count>1;


--What is the most expensive book?
select title from titles t
where t.price = (
	select max(price) from titles);


--Which is the oldest published book?
select title from titles
	where pubdate = (select min(pubdate) from titles);

--Which is the youngest?
select title from titles
	where pubdate = (select max(pubdate) from titles);
	
--Which books are more expensive than all books of any other type?
-- find most expensive book for each type, then compare to get max. (Question is not very clear)
select title, price, type from titles t1
where t1.price = (
	select max(price) from titles t2
	group by "type"
	having t1."type"= t2.type);


--Which books have an above average price for their type?
-- for each type, find average, then compare price of title to the average
select title, t1.type, price
from titles t1
where price::numeric > (
	select avg(price::numeric)
	from titles t2
	where t2.type = t1.type);



--How much above or below the "average price of all books" is the price for each book?




-- VIEWS
create view titlestoauthors as 
select t.title_id, t.title, ta.au_id from titles t inner join titleauthor ta
on t.title_id = ta.title_id;

select * from titlestoauthors ;
