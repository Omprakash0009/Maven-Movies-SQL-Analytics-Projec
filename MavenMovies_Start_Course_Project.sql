use mavenmovies;

SELECT * 
FROM rental;

SELECT * 
FROM inventory;

SELECT * FROM customer;

SELECT
customer_id,
rental_date
FROM rental;

SELECT
    first_name,
	last_name,
    email
FROM customer;

SELECT DISTINCT
    rating
FROM film;

SELECT DISTINCT
rental_duration
FROM film ;

SELECT
customer_id,
rental_id,
amount,
payment_date
FROM payment
WHERE payment_date > '2006-01-01';

SELECT *
FROM payment
WHERE customer_id < 101;

SELECT
    customer_id,
    rental_id,
    amount,
    payment_date
FROM payment

WHERE amount = 0.99
AND payment_date>'2006-01-01';
   
 SELECT
     customer_id,
     rental_id,
     amount,
     payment_date
FROM payment
WHERE customer_id < 101
     AND amount>= 5
     AND payment_date >'2006-01-01';
     
		SELECT
           customer_id,
           rental_id,
           amount,
           payment_date
           FROM payment
           WHERE customer_id = 5
           OR customer_id = 11
           OR customer_id = 29;
           
             SELECT 
      customer_id,
      rental_id,
      amount,
      payment_date
	FROM payment
	WHERE amount > 5
        AND customer_id = 75
        OR customer_id  = 42
        OR customer_id  = 53
       OR customer_id   = 60;

      SELECT 
          customer_id,
          rental_id,
          amount,
          payment_date
      FROM payment
      WHERE customer_id IN ( 11,15,29);
      
     SELECT
         title,
         description
    FROM film
    WHERE description LIKE '%china%';
	      
   SELECT 
	   title,
       special_features
   FROM film  
   WHERE special_features LIKE '%Behind the Scenes%';
    
SELECT 
    rating,
    COUNT(film_id)
FROM film
GROUP BY 
rating;    
 
 SELECT 
   rating,
   COUNT(film_id),
   COUNT(film_id) AS count_of_films_with_this_rating
   FROM film
   GROUP BY
   rating;
   
   SELECT
		rental_duration,
        COUNT(film_id) AS film_with_this_rental_duration
   FROM film
   GROUP BY
   rental_duration;
   
   SELECT
   rental_duration,
   rating,
   replacement_cost,
   COUNT(film_id) AS film_with_this_rental_duraction
   FROM film
   GROUP BY
   rental_duration,
   rating,
   replacement_cost;
   
 SELECT
     rating,
     COUNT(film_id) AS count_of_films,
     MIN(length) AS shortest_film,
     MAX(length) AS longest_film,
     AVG(length) AS avgerage_length_of_film,
    --SUM(length) AS total_minutes,
     AVG(rental_duration) AS average_rental_duration
     
     FROM film
     GROUP BY
     rating;
   
SELECT
COUNT(film_id) AS number_of_films,
MIN(rental_rate) AS cheapest_rental,
MAX(rental_rate) AS most_expensive_rental,
AVG(rental_rate) AS average_rental
FROM film
GROUP BY
replacement_cost;
      
    SELECT
	 customer_id,
	 COUNT(rental_id) AS total_rentals
	 FROM rental
       GROUP BY 
       customer_id
       HAVING COUNT(rental_id) = 25;
       
 SELECT
     customer_id,
	 COUNT(rental_id) AS total_rentals
  FROM rental
  GROUP BY 
      customer_id
      HAVING COUNT(rental_id) < 15;
       
SELECT
    customer_id,
    SUM(amount) AS total_payment_amount
FROM payment
    GROUP BY
    customer_id
ORDER BY 
SUM(amount) DESC;
    
SELECT
    title,
    length,
    rental_rate
FROM film
   customer_id
ORDER BY
     length DESC;
     
SELECT DISTINCT     
  length,
CASE  
WHEN length < 60  THEN 'UNDER 1 hr'
WHEN length < 90  THEN 'UNDER 1.5hr'
WHEN length < 120 THEN 'over 2 hr '
ELSE 'uh oh...check logic!'
  END AS length_bucket
  FROM film;
  
 SELECT DISTINCT
	  title,
	  CASE
         WHEN rental_duration <= 4 THEN 'rental_too_short'
         WHEN rental_rate >= 3.99 THEN 'too_expensive'
         WHEN rating IN ('NC-17','R') THEN 'too_adult'
         WHEN length NOT BETWEEN 60 AND 90 THEN 'too_short_or_too_long'
         WHEN description LIKE '%shark%' THEN 'nope_has_sharks'
         ELSE 'great_reco_for_my_niece'
	END AS fit_for_recommendation,
  CASE
         WHEN description LIKE '%shark%' THEN 'nope_has_sharks'
         WHEN length NOT BETWEEN 60 AND 90 THEN 'too_short_or_too_long'
         WHEN rating IN ('NC-17','R') THEN 'too_adult'
         WHEN rental_duration <= 4 THEN 'rental_too_short'
         WHEN rental_rate >= 3.99 THEN 'too_expensive'
		 ELSE 'great_reco_for_my_niece'
	END AS reorded_reco
FROM film;

SELECT 
    first_name,
    last_name,
    CASE
	   WHEN store_id = 1 AND active = 1 THEN 'STORE 1 active'
	   WHEN store_id = 1 AND active = 0 THEN 'STORE 1 innactive'
       WHEN store_id = 2 AND active = 1 THEN 'STORE 2 active'
       WHEN store_id = 2 AND active = 0 THEN 'STORE 2 innactive'
       ELSE 'uh oh...check logic!'
   END  AS store_and_status   
FROM customer;

SELECT
    film_id,
    COUNT(CASE WHEN store_id = 1 THEN inventory_id ELSE NULL END) AS store_1_copies,
    COUNT(CASE WHEN store_id = 2 THEN inventory_id ELSE NULL END) AS store_2_copies,
    COUNT(inventory_id) AS Total_copies
FROM inventory
GROUP BY 
  film_id
ORDER BY
  film_id;   
  

SELECT 
	film_id,
    COUNT(CASE WHEN store_id = 1 THEN inventory_id ELSE NULL END) AS store_1_inventory,
    COUNT(CASE WHEN store_id = 2 THEN inventory_id ELSE NULL END) AS store_2_inventory
FROM inventory
GROUP BY
      film_id
ORDER BY  film_id;
    
SELECT 
    store_id,
    count(CASE WHEN active = 1 THEN customer_id ELSE NULL END) AS active,
    count(CASE WHEN active = 0 THEN customer_id ELSE NULL END) AS innactive
FROM customer 
GROUP BY
   store_id;

SELECT DISTINCT
    rental.rental_id
FROM inventory
    INNER JOIN rental    
       ON inventory.inventory_id = rental.inventory_id
	
LIMIT 5000;

SELECT
    inventory_id,
    store_id,
    film.title,
    film.description
FROM inventory   
    INNER JOIN film
        ON inventory.film_id = inventory.film_id;
        
SELECT DISTINCT 
       inventory.inventory_id,
       rental.inventory_id
FROM INVENTORY 
      INNER JOIN rental
      ON inventory.inventory_id = rental.inventory_id
      
   LIMIT 5000;   

 SELECT
     film.title,
     -- film.film_id,
     COUNT(film_actor.actor_id) AS count_of_actors
FROM film
    LEFT JOIN film_actor
       ON film_actor.film_id = film.film_id
 GROUP BY
 film.title;
 
 use mavenmovies;
 
 SELECT
     film.film_id,
     film.title,
     category.name AS category_name
FROM film
    INNER JOIN film_category
       ON film.film_id = film_category.film_id
    INNER JOIN category
        ON film_category.category_id = category.category_id;
        
  SELECT      
     actor.first_name AS actor_first_name,
      actor.last_name AS actor_last_name,
      film.title AS film_title
 FROM actor
      INNER JOIN film_actor
            ON film_actor.actor_id = actor.actor_id
      INNER JOIN film      
            ON film.film_id = film_actor.film_id;

   SELECT      
	  film.title,
      film.description
      
   FROM film
        INNER JOIN inventory
          ON inventory.film_id = film.film_id
          AND inventory.store_id = 2;
          
   SELECT
       'advisor' AS type,
       first_name,
       last_name
   FROM advisor
   
   UNION 
   SELECT
   'investor' AS type,
   first_name,
   last_name
FROM investor;

SELECT
   'advisor' AS type,
    first_name,
    last_name
FROM advisor

UNION

SELECT
'staff' AS type,
    first_name,
    last_name
FROM staff 
 