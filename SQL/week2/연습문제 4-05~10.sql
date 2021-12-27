--문제6번) 영화 재고 (inventory) 수량이 3개 이상인 영화(film) 는? - store는 상관 없이 확인해주세요.
-- => inventory_id가 3 이상인 film

SELECT f.film_id , f.title, count(*) 
  FROM inventory i
JOIN film f ON i.film_id = f.film_id 
GROUP BY f.film_id 
HAVING count(*) >= 3


--문제7번) dvd 대여를 제일 많이한 고객 이름은?
-- => rental_id가 가장 많은 customer_id를 구하고 customer 테이블과 조인
-- => rental_id의 count를 내림차순 정렬 + limit1

SELECT c.first_name 
	FROM customer c 
JOIN rental r ON c.customer_id  = r.customer_id 
GROUP BY c.customer_id 
ORDER BY count(*) DESC 
LIMIT 1


--문제8번) rental 테이블을  기준으로,   2005년 5월26일에 대여를 기록한 고객 중, 하루에 2번 이상 대여를 한 고객의 ID 값을 확인해주세요.

 -- 풀이 1 > 좀 더 간단하다.
SELECT customer_id, count(*)
 FROM rental r 
WHERE date(r.rental_date) = '2005-05-26'
GROUP BY customer_id 
HAVING count(*) >=2

 -- 풀이 2 > 
 SELECT customer_id,  count(DISTINCT rental_id) as cnt
	FROM rental
WHERE rental_date BETWEEN '2005-05-26 00:00:00' AND '2005-05-26 23:59:59'
GROUP BY customer_id
HAVING count(DISTINCT rental_id) > 1


--문제9번) film_actor 테이블을 기준으로, 출현한 영화의 수가 많은  5명의 actor_id 와 , 출현한 영화 수 를 알려주세요.

SELECT fa.actor_id , count(*) 
 FROM film_actor fa
GROUP BY fa.actor_id
ORDER BY count(*) DESC
limit 5;


--문제10번) payment 테이블을 기준으로, 결제일자가 2007년2월15일에 해당 하는 주문 중에서, 하루에 2건 이상 주문한 고객의 총 결제 금액이 10달러 이상인 고객에 대해서 알려주세요.
--(고객의 id,  주문건수 , 총 결제 금액까지 알려주세요)

-- 풀이 1 > 
SELECT customer_id, count(*), sum(amount)
 FROM payment p
WHERE date(p.payment_date) = '2007-02-15'
GROUP BY customer_id
HAVING count(*)>=2
  AND sum(amount) >= 10; 
 
-- 풀이 2 > 
SELECT customer_id , count(distinct rental_id) AS cnt, sum(amount) AS sum_amount
	FROM payment
WHERE payment_date  BETWEEN '2007-02-15 00:00:00' AND '2007-02-15 23:59:59'
GROUP BY customer_id
HAVING count(DISTINCT rental_id) >=2 AND  sum(amount) >=10


-- 10번 sum
 
