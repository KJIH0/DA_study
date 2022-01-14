-- analytic funtion이란?
-->> Aggregate Function 의 계산을 지정하는 행 그룹을 기반으로 계산하여 각 그룹에 대해 여러 행을 반환 할 수 있는 Function

--문제1번) dvd 대여를 제일 많이한 고객 이름은? (analytic funtion 활용)

SELECT c.first_name,
       c.last_name,
       Count(r.rental_id) as rental_cnt
  FROM customer c
JOIN rental r ON r.customer_id = c.customer_id
GROUP  BY c.customer_id
ORDER  BY rental_cnt DESC
LIMIT 1

-->>RANK()는 동일한게 나오면 같은 순위를 매기지만 ROW_NUMBER는 ORDER BY 순으로 순위를 매긴다. 
---- RANK 함수 ->동일한 값에 대해서는 동일한 순서를 부여
----ROW_NUMBER -> 동일한 값이라도 고유한 순위를 부여


--문제2번) 매출을 가장 많이 올린 dvd 고객 이름은? (analytic funtion 활용)

SELECT c.first_name , c.last_name , sum(p.amount) , RANK() OVER (ORDER BY sum(amount) DESC)
  FROM customer c 
JOIN rental r ON c.customer_id = r.customer_id 
JOIN payment p ON r.rental_id = p.rental_id 
GROUP BY c.customer_id 
LIMIT 1;
 

--문제3번) dvd 대여가 가장 적은 도시는? (anlytic funtion)

SELECT c2.city_id , c2.city, ROW_NUMBER() OVER (ORDER BY count(rental_id) ASC)
  FROM rental r
 JOIN customer c ON r.customer_id = c.customer_id 
 JOIN address a ON c.address_id = a.address_id
 JOIN city c2 ON a.city_id = c2.city_id 
 GROUP BY c2.city , c2.city_id
 LIMIT 1;


