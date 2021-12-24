--문제1번) store 별로 staff는 몇명이 있는지 확인해주세요.

SELECT store_id ,count(*) cnt 
  FROM store s 
GROUP BY store_id

--문제2번) 영화등급(rating) 별로 몇개 영화film을 가지고 있는지 확인해주세요.

SELECT rating ,count(*) 
  FROM film f 
GROUP BY rating 

--문제3번) 출현한 영화배우(actor)가  10명 초과한 영화명은 무엇인가요?

SELECT title 
	FROM film f 
WHERE film_id 
IN(
  SELECT fa.film_id
    FROM film_actor fa
  GROUP BY film_id
  HAVING count(*) > 10
  )

--문제4번) 영화 배우(actor)들이 출연한 영화는 각각 몇 편인가요?
--- 영화 배우의 이름 , 성 과 함께 출연 영화 수를 알려주세요.

-- 풀이 1>
SELECT a.first_name ,a.last_name ,count(*)
  FROM actor a ,film_actor fa 
WHERE fa.actor_id = a.actor_id 
GROUP BY a.actor_id 

-- 풀이 2>
select a.first_name , a.last_name ,fa.cnt
from
(
select fa.actor_id , count(*) count
from film_actor fa
group by fa.actor_id
) fa
inner join actor a on fa.actor_id = a.actor_id
;


--문제5번) 국가(country)별 고객(customer) 는 몇명인가요?

-- 풀이 1>
SELECT co.country ,sum(cnt)
  FROM (
    SELECT a.city_id, count(*) cnt
      FROM address a
    GROUP BY a.city_id
    ) AS ac, city c, country co
WHERE ac.city_id = c.city_id
AND c.country_id = co.country_id
GROUP BY co.country_id;

-- 풀이 2>
SELECT cy.country , count(*) cnt
  FROM customer c
INNER JOIN address a ON c.address_id = a.address_id
INNER JOIN city ct ON ct.city_id = a.city_id
INNER JOIN country cy on ct.country_id = ct.country_id
GROUP BY cy.country



-- => HAVING 함수
