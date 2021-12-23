--문제11번) Horror 카테고리 장르에 해당하는 영화의 이름과 description 에 대해서 알려주세요

SELECT title, description
	FROM film f 
JOIN film_category fc ON f.film_id = fc.film_id 
JOIN category c ON fc.category_id = c.category_id
WHERE c.name = 'Horror'


--문제12번) Music 장르이면서, 영화길이가 60~180분 사이에 해당하는 영화의 title, description, length 를 알려주세요.영화 길이가 짧은 순으로 정렬해서 알려주세요.
-- => 11번과 거의 동일, where절 조건 2개

SELECT title, description, length 
	FROM film f 
JOIN film_category fc ON f.film_id = fc.film_id 
JOIN category c ON fc.category_id = c.category_id
WHERE c.name = 'Music'
	AND f.length BETWEEN 60 AND 180
ORDER BY f.length
 
--문제13번) actor 테이블을 이용하여,  배우의 ID, 이름, 성 컬럼에 추가로    'Angels Life' 영화에 나온 영화 배우 여부를 Y , N 으로 컬럼을 추가 표기해주세요.  해당 컬럼은 angelslife_flag로 만들어주세요.
-- => 쉽지 않았다..⊙﹏⊙ 정답을 보고도 바로 이해되지 않았음
-- => 지금까지 join의 종류와 차이점에 대해서 정확히 모르고 사용했는데, 이 문제에서 LEFT JOIN 과 INNER JOIN 의 차이에 대해서 공부할 수 있었다.
-- => INNER JOIN을 사용하게 되면, 출연한 배우들이 Y, N 플래그가 모두 달려서, 총 행 수가 209행이 나오게 된다.(전체 actor 수는 200) => LEFT JOIN 사용

-- 풀이 1 >>
SELECT a.actor_id , a.first_name, a.last_name , CASE WHEN a.actor_id IN (
		SELECT actor_id
		  FROM film f
		 INNER JOIN  film_actor fa 
			ON f.film_id  = fa.film_id
		 WHERE f.title ='Angels Life') THEN 'Y'
		 ELSE 'N'
		 END AS  angelslife_flag
  FROM actor a

-- 풀이 2 >>
SELECT a.actor_id , a.first_name, a.last_name, 
	CASE WHEN a.actor_id 
	IN (SELECT actor_id FROM film f
      INNER JOIN film_actor fa ON  f.film_id  = fa.film_id
      WHERE f.title ='Angels Life'
      ) 
	THEN 'Y'ELSE 'N'
	END AS angelslife_flag
FROM actor a


--문제14번) 대여일자가 2005-06-01~ 14일에 해당하는 주문 중에서 , 직원의 이름(이름 성) = 'Mike Hillyer' 이거나  고객의 이름이 (이름 성) ='Gloria Cook'  에 해당 하는 rental 의 모든 정보를 알려주세요.
--- 추가로 직원이름과, 고객이름에 대해서도 fullname 으로 구성해서 알려주세요.
-- => 대여일자는 동일하게 적용되지만, 직원 이름과 고객 이름은 둘 중 하나만 충족하면 된다. -> and(~or) where절 사용

-- 풀이 1 >>
SELECT r.*, s.first_name || ' ' || s.last_name AS staff_fullname,
	c.first_name || ' ' || c.last_name AS cust_fullname
FROM rental r
	JOIN staff s ON r.staff_id = s.staff_id
	JOIN customer c ON r.customer_id = c.customer_id
WHERE date(rental_date) BETWEEN '2005-06-01' AND '2005-06-14'
	AND (s.first_name || ' ' || s.last_name = 'Mike Hillyer'
	  OR c.first_name || ' ' || c.last_name = 'Gloria Cook')

-- 풀이 2 >>
SELECT r.*
  FROM rental r
  INNER JOIN  customer c ON r.customer_id = c.customer_id
  INNER JOIN  staff s ON r.staff_id = s.staff_id 
  WHERE date(r.rental_date) BETWEEN '2005-06-01' AND '2005-06-14'
    AND (
   		s.first_name || ' ' || s.last_name = 'Mike Hillyer'
   		OR 
   		c.first_name || ' ' || c.last_name = 'Gloria Cook'
   		)


--문제15번) 대여일자가 2005-06-01~ 14일에 해당하는 주문 중에서 , 직원의 이름(이름 성) = 'Mike Hillyer' 에 해당 하는 직원에게  구매하지 않은  rental 의 모든 정보를 알려주세요.
--- 추가로 직원이름과, 고객이름에 대해서도 fullname 으로 구성해서 알려주세요.

SELECT r.* 
  FROM rental r
  INNER JOIN staff s ON r.staff_id = s.staff_id 
  WHERE date(r.rental_date) BETWEEN '2005-06-01' AND '2005-06-14'
	  AND (s.first_name || ' ' || s.last_name != 'Mike Hillyer')


-- 어려워졌지만 재미는 있다...
--- https://velog.io/@fe26ming?tag=sql => 잘 안풀렸던 문제는 구글링하여 2~3개 정도의 코드를 비교해봤는데 이 분 코드가 가장 깔끔했다.

