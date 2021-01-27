#Get all pairs of actors that worked together.

Use sakila;

select 
    count(*) as actors_pair,
    fa1.film_id, 
    fa1.actor_id as actor_id1, 
    concat(a1.first_name, ' ', a1.last_name) as actor_name1, 
    fa2.actor_id as actor_id2, 
    concat(a2.first_name, ' ', a2.last_name) as actor_name2
from actor as a1
join film_actor as fa1
on a1.actor_id = fa1.actor_id
join film_actor as fa2
on fa1.actor_id <> fa2.actor_id
and fa1.actor_id < fa2.actor_id
and fa1.film_id = fa2.film_id
join actor as a2
on a2.actor_id = fa2.actor_id
group by actor_id1
order by actors_pair, actor_id1, actor_id2;
/*
# 1st external join between actor  as a1 and film_actor as fa1 (a1 and fa1)
# 2nd join is a self join between film_actor and film_actor (fa1 and fa2)
# 3rd join external with actor again (fa2 and a2)

actor=a1
a1.first_name
a1.last_name
a1.actor_id

actor=a2
a2.first_name
a2.last_name
a2.actor_id

film_actor=fa1
fa1.film_id
fa1.actor_id=actor_id1

film_actor=fa2
fa2.film_id
fa2.actor_id=actor_id2
*/


#Get all pairs of customers that have rented the same film more than 3 times.
#rental= rental_id, rental_date, customer_id


select 
    count(*) as rent_cust,
	r1.inventory_id, 
    r1.customer_id as customer_id1, 
    concat(c1.first_name, ' ', c1.last_name) as customer_name1, 
    c2.customer_id as customer_id2, 
    concat(c2.first_name, ' ', c2.last_name) as customer_name2
from customer as c1
join rental as r1
on c1.customer_id = r1.customer_id
join rental as r2
on r1.customer_id <> r2.customer_id
and r1.customer_id < r2.customer_id
and r1.inventory_id = r2.inventory_id
join customer as c2
on c2.customer_id = r2.customer_id
group by customer_name1
having rent_cust>3
order by rent_cust,customer_id1, customer_id2 asc;

/*
customer=c1
c1.first_name
c1.last_name
c1.customer_id

customer=c2
c2.first_name
c2.last_name
c2.customer_id

rental=r1
r1.inventory_id
r1.customer_id= customer_id1

rental=r2
r2.inventory_id
r2.customer_id= customer_id2
*/

#Get all possible pairs of actors and films.
select 
	f1.title,
    fa1.actor_id as actor_id1, 
    concat(a1.first_name, ' ', a1.last_name) as actor_name1, 
    fa2.actor_id as actor_id2, 
    concat(a2.first_name, ' ', a2.last_name) as actor_name2
from actor as a1
join film_actor as fa1
on a1.actor_id = fa1.actor_id
join film_actor as fa2
on fa1.actor_id <> fa2.actor_id
and fa1.actor_id < fa2.actor_id
and fa1.film_id = fa2.film_id
join actor as a2
on a2.actor_id = fa2.actor_id
cross join film as f1
group by f1.title, actor_name1
order by f1.title, actor_id1, actor_id2 asc;