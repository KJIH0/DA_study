--문제1번) 대여점(store)별 영화 재고(inventory) 수량과 전체 영화 재고 수량은? (grouping set)

SELECT store_id , count(*)
  FROM inventory i 
GROUP BY GROUPING SETs ((store_id),())


--문제2번) 대여점(store)별 영화 재고(inventory) 수량과 전체 영화 재고 수량은? (rollup)

SELECT store_id, count(*)
  FROM inventory i 
GROUP BY ROLLUP (store_id) 


--문제3번) 국가(country)별 도시(city)별 매출액, 국가(country)매출액 소계 그리고 전체 매출액을 구하세요. (grouping set)



--문제4번) 국가(country)별 도시(city)별 매출액, 국가(country)매출액 소계 그리고 전체 매출액을 구하세요. (rollup)



--문제5번) 영화배우별로  출연한 영화 count 수 와,   모든 배우의 전체 출연 영화 수를 합산 해서 함께 보여주세요.



--문제6번) 국가 (Country)별, 도시(City)별  고객의 수와 ,  전체 국가별 고객의 수를 함께 보여주세요. (grouping sets)



--문제7번) 영화에서 사용한 언어와  영화 개봉 연도 에 대한 영화  갯수와  , 영화 개봉 연도에 대한 영화 갯수를 함께 보여주세요.



--문제8번) 연도별, 일별 결제  수량과,  연도별 결제 수량을 함께 보여주세요.
-- 결제수량은 결제 의 id 갯수 를 의미합니다.



--문제9번) 지점 별,  active 고객의 수와 ,   active 고객 수 를  함께 보여주세요.
-- 지점과, active 여부에 대해서는 customer 테이블을 이용하여 보여주세요.
-- grouping sets 를 이용해서 풀이해주세요.



--문제10번) 지점 별,  active 고객의 수와 ,   active 고객 수 를  함께 보여주세요.
-- 지점과, active 여부에 대해서는 customer 테이블을 이용하여 보여주세요.
-- roll up으로 풀이해보면서, grouping sets 과의 차이를 확인해보세요.
