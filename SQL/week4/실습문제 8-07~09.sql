--문제7번) 대여점별 매출 순위를 구하세요.

SELECT RANK () OVER (ORDER BY sum(p.amount) DESC) AS "RANK",
       s.store_id, sum(p.amount) AS SUM_AMOUNT
 FROM payment p
 JOIN rental r ON p.rental_id = r.rental_id 
 JOIN inventory i  ON r.inventory_id  = i.inventory_id 
 JOIN store s ON i.store_id = s.store_id 
 GROUP BY s.store_id 
 ORDER BY "RANK"


--문제8번) 나라별로 가장 대여를 많이한 고객 TOP 5를 구하세요.
-- > USING 조건절을 이용해 원하는 컬럼에 대해서만 선택적으로 JOIN을 할 수 있음

SELECT t1.*
 FROM (SELECT country, 
              customer_id, 
              first_name ||' '|| last_name as "name",
              sum(amount),
              RANK () OVER (PARTITION BY country ORDER BY COALESCE (sum(amount), 0) DESC) AS "RANK"
       FROM country c
       JOIN address a USING (city_id)
       JOIN payment p USING (customer_id)
       JOIN city c2 USING (country_id)
       JOIN customer c3 USING (address_id)
       GROUP BY country , customer_id 
       )AS t1
 WHERE "RANK" <= 5;


--문제9번) 영화 카테고리 (Category) 별로 대여가 가장 많이 된 영화 TOP 5를 구하세요

SELECT t1.*
 FROM (SELECT c.name, 
       	      f.title, 
              count(r.rental_id) AS cnt,
              ROW_NUMBER () OVER (PARTITION BY c.name ORDER BY count(r.rental_id) DESC, title) AS "CATEGORY_RANK"
       FROM category c
       JOIN film_category fc ON c.category_id = fc.category_id
       JOIN inventory i ON fc.film_id = i.film_id 
       JOIN rental r ON i.inventory_id = r.inventory_id 
       JOIN film f ON fc.film_id = f.film_id 		
       GROUP BY c.name, f.title )AS t1
 WHERE "CATEGORY_RANK" <= 5;


-- 10번까지 풀고싶었으나.. first_value, last_value 정리하고 내일 마저 풀어보자!
