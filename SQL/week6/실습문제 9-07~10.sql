--문제7번) Payement 테이블을 기준으로,  결제에 대한 Quarter 분기를 함께 표기해주세요.
--with 절을 활용해서 풀이해주세요.
--1~월의 경우 Q1
--4~6월 의 경우 Q2
--7~9월의 경우 Q3
--10~12월의 경우 Q4

-- 내 답안>> 
WITH tmp AS (
	SELECT 'Q1' AS Q, 1 AS month_1, 3 AS month_2 UNION ALL
	SELECT 'Q2' AS Q, 4 AS month_1, 6 AS month_2 UNION ALL
	SELECT 'Q3' AS Q, 7 AS month_1, 9 AS month_2 UNION ALL
	SELECT 'Q4' AS Q, 10 AS month_1, 12 AS month_2
	)
SELECT p.* , tmp.q AS quarter
 FROM payment p
 LEFT JOIN tmp 
 ON EXTRACT('Month' FROM p.payment_date) BETWEEN tmp.month_1 AND tmp.month_2

-- 다른 풀이>>
with  tbl as (
select cast('2007-01-01 00:00:00' as timestamp) as chk1 , cast('2007-03-31 23:59:59' as timestamp) as chk2 , 'Q1' as quarter union all
select cast('2007-04-01 00:00:00' as timestamp) as chk1 , cast('2007-06-30 23:59:59' as timestamp) as chk2 , 'Q2' as quarter union all
select cast('2007-07-01 00:00:00' as timestamp) as chk1 , cast('2007-09-30 23:59:59' as timestamp) as chk2 , 'Q3' as quarter union all
select cast('2007-10-01 00:00:00' as timestamp) as chk1 , cast('2007-12-31 23:59:59' as timestamp) as chk2 , 'Q4' as quarter
)
select p.*,
		tbl.quarter
from payment p
	 left outer join tbl  on p.payment_date  between  tbl.chk1 and tbl.chk2
   


--문제8번) Rental 테이블을 기준으로,  회수일자에 대한 Quater 분기를 함께 표기해주세요.
--with 절을 활용해서 풀이해주세요.
--1~월의 경우 Q1
--4~6월 의 경우 Q2
--7~9월의 경우 Q3
--10~12월의 경우 Q4 로 함께 보여주세요.

WITH tmp AS (
	SELECT 'Q1' AS Q, 1 AS month_1, 3 AS month_2 UNION ALL
	SELECT 'Q2' AS Q, 4 AS month_1, 6 AS month_2 UNION ALL
	SELECT 'Q3' AS Q, 7 AS month_1, 9 AS month_2 UNION ALL
	SELECT 'Q4' AS Q, 10 AS month_1, 12 AS month_2
	)
 SELECT r.* , tmp.q AS quarter
 FROM rental r 
 LEFT JOIN tmp 
 ON extract('Month' FROM r.rental_date) BETWEEN tmp.month_1 AND tmp.month_2
