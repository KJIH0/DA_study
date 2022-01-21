--문제1번) dvd 대여를 제일 많이한 고객 이름은?   (with 문 활용)

WITH dvd_rent AS(
	SELECT r.customer_id
	 FROM rental r 
	 GROUP BY customer_id 
	 ORDER BY count(*) DESC
	)
SELECT c.first_name, c.last_name 
 FROM customer c, dvd_rent
 WHERE c.customer_id = dvd_rent.customer_id
 LIMIT 1;

--문제2번) 영화 시간 유형 (length_type)에 대한 영화 수를 구하세요.
--영화 상영 시간 유형의 정의는 다음과 같습니다.
--영화 길이 (length) 은 60분 이하 short , 61분 이상 120분 이하 middle , 121 분이상 long 으로 한다.

WITH ft AS (
	SELECT (CASE 
	   WHEN f.length <=60 THEN 'short'
	   WHEN f.length >=61 AND f.length <=120 THEN 'middle'
	   WHEN f.length >=121 THEN 'long'
	   END) AS Film_Type
	 FROM film f
	 )
SELECT Film_Type, count(*) 
 FROM ft
 GROUP BY Film_Type
 ORDER BY "count"


--문제3번) 약어로 표현되어 있는 영화등급(rating) 을 영문명, 한글명과 같이 표현해 주세요. (with 문 활용)
--G        ? General Audiences (모든 연령대 시청가능)
--PG      ? Parental Guidance Suggested. (모든 연령대 시청가능하나, 부모의 지도가 필요)
--PG-13 ? Parents Strongly Cautioned (13세 미만의 아동에게 부적절 할 수 있으며, 부모의 주의를 요함)
--R         ? Restricted. (17세 또는 그이상의 성인)
--NC-17 ? No One 17 and Under Admitted.  (17세 이하 시청 불가)

WITH RAT AS (
      SELECT DISTINCT rating
        ,(CASE
          WHEN rating = 'G' THEN 'General Audiences (모든 연령대 시청가능)'
          WHEN rating = 'PG' THEN 'Parental Guidance Suggested. (모든 연령대 시청가능하나, 부모의 지도가 필요)'
          WHEN rating = 'PG-13' THEN 'Parents Strongly Cautioned (13세 미만의 아동에게 부적절 할 수 있으며, 부모의 주의를 요함)'
          WHEN rating = 'R' THEN 'Restricted. (17세 또는 그이상의 성인)'
          WHEN rating = 'NC-17' THEN 'No One 17 and Under Admitted.  (17세 이하 시청 불가)'
          END
          ) AS rating_description
      FROM film f 
      )
SELECT * FROM RAT
ORDER BY rating
