--문제4번) 고객 등급별 고객 수를 구하세요. (대여 횟수에 따라 고객 등급을 나누고 조건은 아래와 같습니다.)
--A 등급은 31회 이상
--B 등급은 21회 이상 30회 이하
--C 등급은 11회 이상 20회 이하
--D 등급은 10회 이하


WITH cus_grade AS (SELECT customer_id, (CASE 
                        WHEN count(*) > 30 THEN 'A'
                        WHEN count(*) > 20 THEN 'B'
                        WHEN count(*) > 10 THEN 'C'
                        ELSE 'D'
                        END) AS grade
                   FROM rental r 
                   JOIN customer c USING(customer_id)
                   GROUP BY customer_id 
                   )
SELECT grade, count(*) FROM cus_grade
 GROUP BY grade
 ORDER BY grade



--문제5번) 고객 이름 별로 , flag  를 붙여서 보여주세요.
--- 고객의 first_name 이름의 첫번째 글자가, A, B,C 에 해당 하는 사람은 각 A,B,C 로 flag 를 붙여주시고
-- A,B,C 에 해당하지 않는 인원에 대해서는 Others 라는 flag 로 붙여주세요.

SELECT c.customer_id , c.first_name ||' '|| c.last_name AS customer name
    , (CASE 
        WHEN first_name LIKE 'A%' THEN 'A'
        WHEN first_name LIKE 'B%' THEN 'B'
        WHEN first_name LIKE 'C%' THEN 'C'
        ELSE 'Others'
        END) AS flag
  FROM customer c 
  ORDER BY customer_id 



--문제6번) payment 테이블을 기준으로,  2007년 1월~ 3월 까지의 결제일에 해당하며,  staff2번 인원에게 결제를 진행한  결제건에 대해서는, Y 로
--그 외에 대해서는 N 으로 표기해주세요. with 절을 이용해주세요.

-- 풀이1 >> 이건 좀... 테이블을 사용한 의미가 없는 것 같다
WITH tb1 AS (SELECT payment_id, staff_id, payment_date
            , (CASE 
                WHEN staff_id = 2 THEN 'Y'
                ELSE 'N'
                END) AS flag
             FROM payment p 
             WHERE payment_date BETWEEN date('2007-01-01') AND date('2007-03-31')
             )
SELECT * FROM tb1


-- 풀이2 >> tkryu9님 풀이 / 테이블을 사용해서 태그를 달고 -> 추출할 칼럼 선택 및 조건 설정
WITH tmp AS (
	SELECT 2 AS staff_id, 'Y' AS flag 
	UNION ALL  
	SELECT 1 AS staff_id, 'N' AS flag
	)
SELECT payment_id, payment_date, staff_id , flag
 FROM payment
 LEFT JOIN tmp USING (staff_id)
 WHERE payment_date BETWEEN date('2007-01-01') AND date ('2007-03-31')
 ORDER BY payment_id 
