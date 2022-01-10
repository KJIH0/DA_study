--문제1번) 대여점(store)별 영화 재고(inventory) 수량과 전체 영화 재고 수량은? (grouping set)

SELECT store_id , count(*)
  FROM inventory i 
GROUP BY GROUPING SETs ((store_id),())


--문제2번) 대여점(store)별 영화 재고(inventory) 수량과 전체 영화 재고 수량은? (rollup)

SELECT store_id, count(*)
  FROM inventory i 
GROUP BY ROLLUP (store_id) 


--문제3번) 국가(country)별 도시(city)별 매출액, 국가(country)매출액 소계 그리고 전체 매출액을 구하세요. (grouping set)

SELECT c3.country, c2.city, sum(p.amount)
  FROM payment p 
JOIN customer c USING (customer_id)
JOIN address a USING (address_id)
JOIN city c2 USING (city_id)
JOIN country c3 USING (country_id)
GROUP BY GROUPING SETS (country, city), (country), ()
ORDER BY country

-- 어렵다..ㅠㅠ
