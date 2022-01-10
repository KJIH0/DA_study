--문제4번) 국가(country)별 도시(city)별 매출액, 국가(country)매출액 소계 그리고 전체 매출액을 구하세요. (rollup)

SELECT country, city, sum(amount)
  FROM payment p 
 INNER JOIN customer c ON p.customer_id =c.customer_id 
 INNER JOIN address a ON c.address_id = a.address_id 
 INNER JOIN city c2 ON c2.city_id  = a.city_id 
 INNER JOIN country c3 ON c2.country_id = c3.country_id 
 GROUP BY ROLLUP (country, city)
ORDER BY country, city


--문제5번) 영화배우별로  출연한 영화 count 수 와,   모든 배우의 전체 출연 영화 수를 합산 해서 함께 보여주세요.

SELECT actor_id, count(DISTINCT fa.film_id)
  FROM film_actor fa 
 GROUP BY
GROUPING SETS (
	(actor_id),
	()
)


--문제6번) 국가 (Country)별, 도시(City)별  고객의 수와 ,  전체 국가별 고객의 수를 함께 보여주세요. (grouping sets)

SELECT country, city, count(*)
  FROM customer c
JOIN address a ON c.address_id = a.address_id 
JOIN city c2 ON a.city_id = c2.city_id 
JOIN country c3 ON c2.country_id = c3.country_id 
GROUP BY 
GROUPING SETS (
	(country, city),
	(country),
	()
)
 ORDER BY country, city 
