 -- Identify the museums which are openon both Sunday and Monday.
 -- Display museum name, city.

 select m.name as mudeum_name,m.city from museum_hours m1 
 join museum m on m1.museum_id=m.museum_id 
 where day ='sunday' and exists 
(select 1 from museum_hours m2 where m1.museum_id=m2.museum_id and m2.day ='monday')


-- Which museum is open for the longest during a day.
--  Dispay museum name, state and hours open and which day?

SELECT m.name as museum_name ,m.state,mh.day
to_timestamp(close ,'HH:MI AM')-to_timestamp(open ,'HH:MI AM') as duration ,
rank() over(order by(to_timestamp(close ,'HH:MI AM')-to_timestamp(open ,'HH:MI AM')))
as rank
FROM museum_hours mh
join museum m on m.musuem_id =mh.museum_id


-- display the country and the city with most no of museums.

with cte_country as 
			(SELECT country, count(1),rank()over(order by count(1) desc)as rank
			FROM museum
			group by country)
with cte_city as 
			(SELECT city, count(1),rank()over(order by count(1) desc)as rank
			FROM museum
			group by city)
select contry ,city
from cte_country cross join cte_city where cte_country.rank=1 
and cte_city.rank=1