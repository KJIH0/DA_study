--문제7번) 영화에서 사용한 언어와  영화 개봉 연도 에 대한 영화  갯수와, 영화 개봉 연도에 대한 영화 갯수를 함께 보여주세요.
-- 뭔소린지 모르겠음



--문제8번) 연도별, 일별 결제  수량과,  연도별 결제 수량을 함께 보여주세요.
-- 결제수량은 결제 의 id 갯수 를 의미합니다.

SELECT to_char(payment_date, 'YYYY') AS "Year", 
       COALESCE (to_char(payment_date, 'MM-DD'), 'Total') AS "Date", 
       count(payment_id)
  FROM payment
GROUP BY 
GROUPING SETS (to_char(payment_date, 'YYYY'), to_char(payment_date, 'MM-DD')), (to_char(payment_date, 'YYYY'))
ORDER BY "Date"


--문제9번) 지점 별,  active 고객의 수와 ,   active 고객 수 를  함께 보여주세요.
-- 지점과, active 여부에 대해서는 customer 테이블을 이용하여 보여주세요.
-- grouping sets 를 이용해서 풀이해주세요.
-- COALESCE를 이렇게도 쓸 수 있구나! 태규님 답안을 참조했다. 신세계,,, 총합이 null로 처리되는게 보기 싫었는데 해결방법을 찾았다.
-- 그 외 COALESCE 문법은 https://stackoverflow.com/questions/20181422/invalid-input-syntax-for-type-numeric-for-entering-emptyness 참조하여 공부함

SELECT COALESCE (store_id::TEXT, 'Total') AS "store", active, count(customer_id) AS actovie_user_count
  FROM customer c 
GROUP  BY grouping sets( ( store_id, active ), ( active ) )
ORDER BY store_id


--문제10번) 지점 별,  active 고객의 수와 ,   active 고객 수 를  함께 보여주세요.
-- 지점과, active 여부에 대해서는 customer 테이블을 이용하여 보여주세요.
-- roll up으로 풀이해보면서, grouping sets 과의 차이를 확인해보세요.

SELECT COALESCE (store_id::TEXT , 'Total') AS "store_id", active, Count(*) 
  FROM customer
LEFT JOIN store s USING (store_id)
GROUP BY ROLLUP (store_id), (active)
ORDER BY store_id

1	0	8
1	1	318
2	0	7
2	1	266
Total	0	15
Total	1	584


-- GROUP BY ROLLUP (store_id), (active) 과
-- GROUP BY ROLLUP (store_id, active)의 차이가 뭐지...?
-- 후자로 풀었을땐 null에 택스트 대치가 적용되지 않는다ㅜㅜ

1		326
1	0	8
1	1	318
2	0	7
2	1	266
2		273
Total		599
