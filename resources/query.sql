--2.1
delete
from clients
where length(name) = (select max(length(name)) from clients);

--2.2
update orders
set discount = discount + 10
where discount < 90;

--3.1
select cakes.name
from cakes
order by cakes.name;

--3.2
select c.name, c2.name
from clients c
       join orders o on c.id = o.client_id
       join cakes c2 on o.cake_id = c2.id
order by c.name, c2.name;

--3.3
select orders.id, c.name
from orders
       left join confictioners c on confictioner_id = c.id
where discount between 10 and 90;

--3.4
select distinct c2.name
from cakes c
       join orders o on c.id = o.cake_id
       join confictioners c2 on o.confictioner_id = c2.id
where c.name in ('Наполеон', 'Королевский');

--3.5
select c.name, avg(o.weight)
from clients c
       join orders o on c.id = o.client_id
group by c.name
having avg(julianday(o.execution_date) - julianday(o.order_date)) > 10;

--3.6
with orde as (
  select c2.name, c.name as cake, c2.id as id, count(*) as count
  from clients c2
         join orders o on c2.id = o.client_id
         join cakes c on o.cake_id = c.id
  group by c2.id, c.name
  order by count desc)
select clients.id, clients.name, cake
from clients
       left join
     orde o on o.id = clients.id
where o.count IS NULL OR o.count = (select max(o2.count) from orde o2 where o2.name = o.name)
group by clients.id;
