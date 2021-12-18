--문제11번)	영화배우의 이름 (이름+' '+성) 에 대해서,  대문자로 이름을 보여주세요.  단 고객의 이름이 동일한 사람이 있다면,  중복 제거하고, 알려주세요.

SELECT DISTINCT upper(first_name ||' '|| last_name) FROM actor

--문제12번)	고객 중에서,  active 상태가 0 인 즉 현재 사용하지 않고 있는 고객의 수를 알려주세요.

SELECT count(DISTINCT customer_id) FROM customer 
WHERE active = 0

--문제13번)	Customer 테이블을 활용하여,  store_id = 1 에 매핑된  고객의 수는 몇명인지 확인해보세요.

SELECT count(customer_id) FROM customer 
WHERE store_id = 1

--문제14번)	rental 테이블을 활용하여,  고객이 return 했던 날짜가 2005년6월20일에 해당했던 rental 의 갯수가 몇개였는지 확인해보세요.

SELECT count(rental_id) FROM rental r 
WHERE date(return_date) = '2005-06-20'

--문제15번)	film 테이블을 활용하여, 2006년에 출시가 되고 rating 이 'G' 등급에 해당하며, 대여기간이 3일에 해당하는  것에 대한 film 테이블의 모든 컬럼을 알려주세요.

SELECT * FROM film 
WHERE release_year = '2006'
AND rental_duration = '3'
AND rating = 'G'

--문제16번)	langugage 테이블에 있는 id, name 컬럼을 확인해보세요 .

SELECT language_id , name FROM LANGUAGE

--문제17번)	film 테이블을 활용하여,  rental_duration 이  7일 이상 대여가 가능한  film 에 대해서  film_id,   title,  description 컬럼을 확인해보세요.

SELECT film_id, title, description FROM film 
WHERE rental_duration >= 7

--문제18번)	film 테이블을 활용하여,  rental_duration   대여가 가능한 일자가 3일 또는 5일에 해당하는  film_id,  title, desciption 을 확인해주세요.

SELECT film_id, title, description FROM film 
WHERE rental_duration =5 OR rental_duration =3

--문제19번)	Actor 테이블을 이용하여,  이름이 Nick 이거나  성이 Hunt 인  배우의  id 와  이름, 성을 확인해주세요.

SELECT actor_id , first_name , last_name  FROM actor 
WHERE first_name ='Nick' OR last_name = 'Hunt'

--문제20번)	Actor 테이블을 이용하여, Actor 테이블의  first_name 컬럼과 last_name 컬럼을 , firstname, lastname 으로 컬럼명을 바꿔서 보여주세요.

SELECT first_name as firstname, last_name as lastname
FROM actor 
