-- 문제11번) 사용되는 언어별 영화 수는?

SELECT l."name" , count(*) 
	FROM "language" l 
JOIN film f ON l.language_id = f.language_id 
GROUP BY l.language_id 


--문제12번) 40편 이상 출연한 영화 배우(actor) 는 누구인가요?

SELECT a.first_name ||' '|| a.last_name as actor_name , count(*)
  FROM film_actor fa 
JOIN actor a ON a.actor_id = fa.actor_id 
GROUP BY a.actor_id 
HAVING count(*) >= 40


--문제13번) 고객 등급별 고객 수를 구하세요. (대여 금액 혹은 매출액  에 따라 고객 등급을 나누고 조건은 아래와 같습니다.)
/*
A 등급은 151 이상
B 등급은 101 이상 150 이하
C 등급은   51 이상 100 이하
D 등급은   50 이하

- 대여 금액의 소수점은 반올림 하세요.

HINT
반올림 하는 함수는 ROUND 입니다.	
*/

SELECT grade, count(*)
	FROM (SELECT customer_id, CASE 
				WHEN round(sum(amount)) >= 151 then 'A' 
				WHEN round(sum(amount)) BETWEEN 101 and 150 then 'B'
				WHEN round(sum(amount)) BETWEEN 51 and 100 then 'C'
				WHEN round(sum(amount)) <= 50 then 'D'
				END AS grade
			FROM payment p 
	   GROUP BY p.customer_id ) AS a
GROUP BY grade
ORDER BY grade
