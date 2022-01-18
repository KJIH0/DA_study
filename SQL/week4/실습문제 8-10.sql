-- first_value, last_value
-- >> 행 집합의 순서가 지정되었다고 가정할 때 FIRST VALUE 함수는 창 프레임의 첫 번째 행과 관련하여 지정된 표현식의 값을 반환합니다. 
-- >> LAST VALUE 함수는 프레임의 마지막 행과 관련하여 표현식의 값을 반환합니다.


--문제10번) 매출이 가장 많은 영화 카테고리와 매출이 가장 작은 영화 카테고리를 구하세요. (first_value, last_value)

SELECT DISTINCT FIRST_VALUE (c."name") over(ORDER BY count(*) DESC) AS "Top_Sales_Category",
                LAST_VALUE (c."name") OVER (ORDER BY count(*) DESC 
                  RANGE BETWEEN UNBOUNDED PRECEDING
                  AND UNBOUNDED FOLLOWING) AS "Lowest_Sales_Category"
 FROM film f 
 JOIN inventory i USING (film_id)
 JOIN rental r USING (inventory_id)
 JOIN film_category fc USING (film_id)
 JOIN category c USING (category_id)
 GROUP BY c.name
