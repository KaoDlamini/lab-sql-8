-- 1.Rank films by length (filter out the rows with nulls or zeros in length column). Select only columns title, length and rank in your output.
select title, length, rank () over (order by length) as 'Rank'  from sakila.film

-- 2.Rank films by length within the rating category (filter out the rows with nulls or zeros in length column). 
-- In your output, only select the columns title, length, rating and rank.
select title, rating,length, rank () over (partition by rating order by length) as 'Rank'  from sakila.film

-- 3.How many films are there for each of the categories in the category table? Hint: Use appropriate join between the tables "category" and "film_category".
select name, count(film_id) from sakila.category
join sakila.film_category using (category_id)
group by name
 
-- 4.Which actor has appeared in the most films? Hint: You can create a join between the tables "actor" and "film actor" and count the number of times an actor appears.
select actor_id, concat(first_name, ' ' , last_name) as name , count(film_id) from sakila.actor
join sakila.film_actor using (actor_id)
group by actor_id , concat(first_name, ' ' , last_name)
order by count(film_id) desc
limit 1

-- 5.Which is the most active customer (the customer that has rented the most number of films)? Hint: Use appropriate join between the tables "customer" and "rental" and count the rental_id for each customer.
select customer_id, concat(first_name, ' ' , last_name) as name , count(rental_id) from sakila.customer
join sakila.rental using (customer_id)
group by customer_id , concat(first_name, ' ' , last_name)
order by count(rental_id) desc
limit 1



-- 6.Bonus: Which is the most rented film? (The answer is Bucket Brotherhood).
select film_id,title, count(rental_id) as Amount_of_rentals from sakila.inventory
join sakila.film using (film_id)
join sakila.rental using (inventory_id)
group by film_id,title
order by count(rental_id) desc
limit 1