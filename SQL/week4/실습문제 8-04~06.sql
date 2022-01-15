--문제4번) 매출이 가장 안나오는 도시는? (anlytic funtion)
-- > 주말에 ROW_NUMBER(중복허용X) 정리하자. 나중에 복습할 땐 RANK(중복허용)로도 풀어보쟛

SELECT c.city, ROW_NUMBER() OVER (ORDER BY SUM(p.amount)), sum(p.amount)
  FROM city c 
 JOIN address a ON c.city_id = a.city_id 
 JOIN customer c2 ON a.address_id = c2.address_id 
 JOIN rental r ON c2.customer_id = r.customer_id 
 JOIN payment p ON r.rental_id = p.rental_id 
 GROUP BY c.city 
 LIMIT 1;


--문제5번) 월별 매출액을 구하고 이전 월보다 매출액이 줄어든 월을 구하세요. (일자는 payment_date 기준)

SELECT *
 FROM (
    SELECT EXTRACT (YEAR FROM date(payment_date)) AS "YEAR",
           EXTRACT(MONTH FROM date(payment_date)) AS  "MONTH",
           sum(amount) AS "SUM",
           LAG(sum(amount)) OVER (ORDER BY EXTRACT(MONTH FROM date(payment_date))) AS "Pre_Mon_Amt",
           sum(amount) - LAG(sum(amount)) OVER (ORDER BY EXTRACT(MONTH FROM date(payment_date))) AS "GAP"
		 FROM payment p 
		 GROUP BY EXTRACT(YEAR FROM date(payment_date)),
              EXTRACT(MONTH FROM date(payment_date))		
		) AS t
 WHERE "GAP" < 0;


--문제6번) 도시별 dvd 대여 매출 순위를 구하세요.
-- 언제 ROW_NUMBER를, 언제 RANK를 써야할지 헷갈린다😅

SELECT c.city, ROW_NUMBER() OVER (ORDER BY SUM(p.amount) desc), sum(p.amount)
  FROM city c 
 JOIN address a ON c.city_id = a.city_id 
 JOIN customer c2 ON a.address_id = c2.address_id 
 JOIN rental r ON c2.customer_id = r.customer_id 
 JOIN payment p ON r.rental_id = p.rental_id 
 GROUP BY c.city ;

