--문제1번) 영화 배우가,  영화 180분 이상의 길이 의 영화에 출연하거나, 영화의 rating 이 R 인 등급에 해당하는 영화에 출연한  영화 배우에 대해서, 영화 배우 ID 와 (180분이상 / R등급영화)에 대한 Flag 컬럼을 알려주세요.
--- film_actor 테이블와 film 테이블을 이용하세요.
--- union, unionall, intersect, except 중 상황에 맞게 사용해주세요.
--- actor_id 가 동일한 flag 값 이 여러개 나오지 않도록 해주세요.

SELECT DISTINCT actor_id, 'over_180' AS flag
	FROM film_actor fa
INNER JOIN (
      SELECT film_id
        FROM film
      WHERE length >=180) f
  ON fa.film_id = f.film_id
UNION ALL 
SELECT DISTINCT actor_id, 'rating_R' AS flag
	FROM film_actor fa
INNER JOIN (
          SELECT film_id
            FROM film
          WHERE rating = 'R') f
  ON fa.film_id = f.film_id
ORDER BY actor_id 


--문제2번) R등급의 영화에 출연했던 배우이면서, 동시에, Alone Trip의 영화에 출연한  영화배우의 ID 를 확인해주세요.
--- film_actor 테이블와 film 테이블을 이용하세요.
--- union, unionall, intersect, except 중 상황에 맞게 사용해주세요.

-- > 풀이 1 / 서브쿼리 싫어서.. 풀이 2 보단 이게 더 나은 것 같다.
SELECT DISTINCT a.actor_id
	FROM actor a 
JOIN film_actor fa ON a.actor_id =fa.actor_id 
JOIN film f ON fa.film_id = f.film_id 
WHERE f.rating = 'R'

UNION 

SELECT DISTINCT a.actor_id
	FROM actor a 
JOIN film_actor fa ON a.actor_id = fa.film_id 
JOIN film f ON fa.film_id = f.film_id 
WHERE f.title = 'Alone Trip'

-- > 풀이 2
SELECT  actor_id
	FROM film_actor fa
WHERE film_id  IN (SELECT film_id
		   	FROM film
		   WHERE rating ='R')
INTERSECT
SELECT actor_id
	FROM film_actor fa
WHERE film_id IN (SELECT film_id
		  	FROM film f
		  WHERE title='Alone Trip')
 

--문제3번) G 등급에 해당하는 필름을 찍었으나, 영화를 20편이상 찍지 않은 영화배우의 ID 를 확인해주세요.
--- film_actor 테이블와 film 테이블을 이용하세요.
--- union, unionall, intersect, except 중 상황에 맞게 사용해주세요.

--> 풀이 1
SELECT DISTINCT fa.actor_id 
	FROM film_actor fa 
JOIN film f ON fa.film_id = f.film_id 
WHERE f.rating = 'G'

EXCEPT 

SELECT fa.actor_id 
	FROM film_actor fa 
GROUP BY fa.actor_id 
HAVING count(fa.film_id) >= 20

--문제4번) 필름 중에서, 필름 카테고리가 Action, Animation, Horror 에 해당하지 않는 필름 아이디를 알려주세요.
--- category 테이블을 이용해서 알려주세요.

SELECT fc.film_id
	FROM film_category fc 
JOIN category c ON fc.category_id = c.category_id 
WHERE c.name NOT IN ('Action', 'Animation', 'Horror')


--문제5번) Staff의 id, 이름,성 에 대한 데이터와, Customer 의 id, 이름, 성에 대한 데이터를 하나의 데이터셋의 형태로 보여주세요.
--- 컬럼 구성 : id, 이름 , 성, flag (직원/고객여부) 로 구성해주세요.

SELECT DISTINCT staff_id AS id, first_name , last_name, 'staff' AS flag
	FROM staff s 
UNION ALL
SELECT DISTINCT customer_id AS id, first_name , last_name , 'customer' AS flag
	FROM customer c 
ORDER BY id


--문제6번) 직원과  고객의 이름이 동일한 사람이 혹시 있나요? 있다면, 해당 사람의 이름과 성을 알려주세요.
--> 헷갈린다... 한국에서 이름은 보통 (성+이름)이고, 영문 테이블에선 이름/성을 구분짓고 있는데😅
--> 두개 중 아래의 쿼리문이 정답인걸로 봐선 문제의 '이름'은 (성+이름)을 의미하고, INTERSECT 연산자를 사용하는것이 출제 의도인 듯 하다.

--> 오답  => 두 테이블을 조인하여 이름(first_name)이 동일한 사람을 where절로 추출.
--> 정답이 되려면 WHERE절에 조건 추가(AND c.last_name = s.last_name)
SELECT c.first_name , c.last_name 
	FROM customer c 
JOIN staff s ON c.store_id = s.store_id 
WHERE c.first_name = s.first_name 

--> 정답 => 두 개 테이블의 교집합을 추출하는 연산자 INTERSECT 를 사용.
--> 이름과 성이 동일한 사람이 추출되는 쿼리문 같은데,
SELECT first_name, last_name 
  FROM customer c 
INTERSECT 
SELECT first_name, last_name 
  FROM staff s


--문제7번) 반납이 되지 않은 대여점(store)별 영화 재고 (inventory)와 전체 영화 재고를 같이 구하세요. (union all)
--> 반납이 되지 않은 영화수를 대여점별로 집계하고 전체 합계도 같이 표현
--> 반납이 되지 않은 영화는 대여일은 있으나 반납일은 없는 영화 (rental테이블 사용)





--문제8번) 국가(country)별 도시(city)별 매출액, 국가(country)매출액 소계 그리고 전체 매출액을 구하세요. (union all)




--- UNION, UNION ALL
