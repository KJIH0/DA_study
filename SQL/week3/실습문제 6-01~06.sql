--문제1번) 매출을 가장 많이 올린 dvd 고객 이름은? (subquery 활용)

SELECT customer_id , first_name ,last_name 
  FROM customer c 
WHERE customer_id IN (
                      SELECT customer_id 
                        FROM payment p
                      GROUP BY customer_id
                      ORDER BY sum(amount) DESC 
                      LIMIT 1
                      )
            
            
--문제2번) 대여가 한번도이라도 된 영화 카테 고리 이름을 알려주세요. (쿼리는, Exists조건을 이용하여 풀어봅시다)

SELECT category_id , "name"
  FROM category c 
WHERE EXISTS (
              SELECT 1
                FROM rental r
              JOIN inventory i ON r.inventory_id = i.inventory_id
              JOIN film_category fc ON fc.film_id = i.film_id
              WHERE c.category_id = fc.category_id
              )


--문제3번) 대여가 한번도이라도 된 영화 카테 고리 이름을 알려주세요. (쿼리는, Any 조건을 이용하여 풀어봅시다)

SELECT category_id , "name"
  FROM category c 
WHERE c.category_id = ANY (
                           SELECT c. category_id
                            FROM rental r
                           JOIN inventory i ON r.inventory_id = i.inventory_id
                           JOIN film_category fc ON fc.film_id = i.film_id
                           )


--문제4번) 대여가 가장 많이 진행된 카테고리는 무엇인가요? (Any, All 조건 중 하나를 사용하여 풀어봅시다)

SELECT "name" 
FROM category c 
WHERE c.category_id = ANY (
	SELECT fc.category_id 
		FROM rental r 
	JOIN inventory i ON r.inventory_id = i.inventory_id
	JOIN film_category fc ON fc.film_id = i.film_id
	GROUP BY category_id 
	ORDER BY count(rental_id) DESC 
	LIMIT 1
	)


--문제5번) dvd 대여를 제일 많이한 고객 이름은? (subquery 활용)

SELECT c.customer_id , c.first_name , c.last_name 
  FROM  customer c 
WHERE customer_id IN (
	SELECT customer_id
	  FROM rental r
	GROUP BY customer_id
	ORDER BY count(DISTINCT rental_id) DESC
	LIMIT 1
	)


--문제6번) 영화 카테고리값이 존재하지 않는 영화가 있나요?
-- NOT IN + NULL = NOT EXIST
-- IN과 EXIST는 같은 결과를 가져오지만, 데이터에 NULL이 포함되어 있다면 같은 결과를 가져오지 못한다.

SELECT *
  FROM  film f 
WHERE film_id NOT IN (
	SELECT film_id 
	  FROM film_category fc)


