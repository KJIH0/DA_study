--문제1번) film 테이블을 활용하여,  film 테이블의  100개의 row 만 확인해보세요.

SELECT * FROM film 
LIMIT 100

--문제2번) actor 의 성(last_name) 이  Jo 로 시작하는 사람의 id 값이 가장 낮은 사람 한사람에 대하여, 사람의  id 값과  이름, 성 을 알려주세요.

SELECT actor_id, first_name, last_name FROM actor 
WHERE last_name LIKE 'Jo%'
ORDER BY actor_id asc
LIMIT 1

--문제3번)film 테이블을 이용하여, film 테이블의 아이디값이 1~10 사이에 있는 모든 컬럼을 확인해주세요.

SELECT * FROM film 
WHERE film_id BETWEEN 1 AND 10
--WHERE film_id <= 10 도 동일한 결과 출력

--문제4번) country 테이블을 이용하여, country 이름이 A 로 시작하는 country 를 확인해주세요.

SELECT * FROM country 
WHERE country LIKE 'A%'

--문제5번) country 테이블을 이용하여, country 이름이 s 로 끝나는 country 를 확인해주세요.

SELECT * FROM country 
WHERE country LIKE '%s'

--문제6번) address 테이블을 이용하여, 우편번호(postal_code) 값이 77로 시작하는  주소에 대하여, address_id, address, district ,postal_code  컬럼을 확인해주세요.

SELECT address_id, address, district ,postal_code FROM address 
WHERE postal_code LIKE '77%'

--문제7번) address 테이블을 이용하여, 우편번호(postal_code) 값이 두번째글자가 1인 우편번호의  address_id, address, district ,postal_code  컬럼을 확인해주세요.

SELECT address_id, address, district ,postal_code FROM address 
WHERE substring(postal_code,2,1) ='1'

--문제8번) payment 테이블을 이용하여, 고객번호가 341에 해당 하는 사람이 결제를 2007년 2월 15~16일 사이에 한 모든 결제내역을 확인해주세요.
--[1] 정답
SELECT  * FROM payment 
WHERE customer_id = 341 
AND date(payment_date) BETWEEN '2007-02-15' and '2007-02-16'

--[2]오답
SELECT  * FROM payment 
WHERE customer_id = 341 
AND payment_date BETWEEN '2007-02-15' and '2007-02-16'


--문제9번) payment 테이블을 이용하여, 고객번호가 355에 해당 하는 사람의 결제 금액이 1~3원 사이에 해당하는 모든 결제 내역을 확인해주세요.

SELECT * FROM payment p 
WHERE customer_id = 355 
AND amount BETWEEN 1 AND 3

--문제10번) customer 테이블을 이용하여, 고객의 이름이 Maria, Lisa, Mike 에 해당하는 사람의 id, 이름, 성을 확인해주세요.

SELECT customer_id, first_name, last_name FROM customer c 
WHERE first_name IN ('Maria','Lisa','Mike')

--문제11번) film 테이블을 이용하여, film의 길이가  100~120 에 해당하거나 또는 rental 대여기간이 3~5일에 해당하는 film 의 모든 정보를 확인해주세요.

SELECT * FROM film f 
WHERE (length BETWEEN 100 AND 120) OR (rental_duration BETWEEN 3 AND 5)

--문제12번) address 테이블을 이용하여, postal_code 값이  공백('') 이거나 35200, 17886 에 해당하는 address 에 모든 정보를 확인해주세요.

--[첫번째 풀이]
SELECT * FROM address a 
WHERE postal_code = '' OR postal_code = '35200' OR postal_code = '178860'

--[두번째 풀이 => 더 깔끔]
select *
  from address
 where postal_code in ('','35200','17886')
 
 --문제13번) address 테이블을 이용하여,  address 의 상세주소(=address2) 값이  존재하지 않는 모든 데이터를 확인하여 주세요.

SELECT * FROM address
WHERE address2 IS NULL

--문제14번) staff 테이블을 이용하여, staff 의  picture  사진의 값이 있는  직원의  id, 이름,성을 확인해주세요. 단 이름과 성을  하나의 컬럼으로 이름, 성의형태로  새로운 컬럼 name 컬럼으로 도출해주세요.
-- => 확인 필요

SELECT staff_id, first_name || ' ' || last_name AS name
FROM staff 
WHERE picture IS NOT NULL 

--문제15번) rental 테이블을 이용하여,  대여는했으나 아직 반납 기록이 없는 대여건의 모든 정보를 확인해주세요.

SELECT * FROM rental 
WHERE return_date IS NULL 

--문제16번) address 테이블을 이용하여, postal_code 값이  빈 값(NULL) 이거나 35200, 17886 에 해당하는 address 에 모든 정보를 확인해주세요.

SELECT * FROM address 
WHERE postal_code IS NULL 
OR postal_code IN ('35200', '17886')

--문제17번) 고객의 성에 John 이라는 단어가 들어가는, 고객의 이름과 성을 모두 찾아주세요.

SELECT first_name, last_name FROM customer 
WHERE last_name LIKE '%John%'

--문제18번) 주소 테이블에서, address2 값이 null 값인 row 전체를 확인해볼까요?

SELECT * FROM address 
WHERE address2  IS NULL 
