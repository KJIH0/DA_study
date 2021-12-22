--문제6번) Jon Stephens 직원을 통해 dvd대여를 한 payment 기록 정보를  확인하려고 합니다. payment_id,  고객 이름 과 성,  rental_id, amount, staff 이름과 성을 알려주세요.

-- => 이렇게 하면 customer과 staff의 first_name, last_name row가 둘 다 출력되어 구분하기 어렵다. 
SELECT p.payment_id , c.first_name, c.last_name, p.rental_id, p.amount, s.first_name, s.last_name
	FROM payment p 
INNER JOIN staff s ON s.staff_id = p.staff_id 
INNER JOIN customer c ON p.customer_id = c.customer_id 
WHERE s.first_name = 'Jon'AND s.last_name = 'Stephens'

-- => 문제에서 요구하지 않았지만, 위와 같은 이유로 first_name, last_name row을 합친 '고객이름', '직원이름' row를 각각 생성
SELECT 	p.payment_id , c.first_name || ' ' || c.last_name as 고객이름, 
	p.rental_id, p.amount, s.first_name || ' ' || s.last_name as 직원이름
FROM payment p 
INNER JOIN staff s ON s.staff_id = p.staff_id 
INNER JOIN customer c ON p.customer_id = c.customer_id 
WHERE s.first_name = 'Jon'AND s.last_name = 'Stephens'


--문제7번) 배우가 출연하지 않는 영화의 film_id, title, release_year, rental_rate, length 를 알려주세요.

SELECT f.film_id, f.title, f.release_year, f.rental_rate, f.rental_rate, f.length 
	FROM film f 
LEFT JOIN film_actor fa ON f.film_id = fa.film_id 
WHERE fa.film_id IS NULL 


--문제8번) store 상점 id별 주소 (address, address2, distict) 와 해당 상점이 위치한 city 주소를 알려주세요.

-- => 내 답안
SELECT s.store_id, a.address, a.address2, a.district, c.city 
	FROM store s
 INNER JOIN  address a ON s.address_id = a.address_id
 INNER JOIN  city c ON a.city_id = c.city_id

-- => 다른 답안(결과 동일함)
select store.store_id, address.address, address.address2, address.district, city.city
from store
left outer join address on store.address_id= address.address_id
left outer join city on address.city_id = city.city_id


--문제9번) 고객의 id 별로 고객의 이름 (first_name, last_name), 이메일, 고객의 주소 (address, district), phone번호, city, country 를 알려주세요.
-- => 노션 답안 잘못됨

SELECT 	cu.customer_id, cu.first_name || ' ' || cu.last_name as 이름, cu.email, a.address || ' ' || a.district as 주소, a.phone, ci.city, co.country 
	FROM customer cu
JOIN address a ON cu.address_id = a.address_id 
JOIN city ci ON a.city_id = ci.city_id 
JOIN country co ON ci.country_id = co.country_id


--문제10번) country 가 china 가 아닌 지역에 사는, 고객의 이름(first_name, last_name)과 , email, phonenumber, country, city 를 알려주세요

-- NOT IN 은 != 와 동일하게 작동
SELECT cu.first_name || ' ' || cu.last_name as 이름, cu.email, a.phone, co.country, ci.city
	FROM customer cu
JOIN address a ON cu.address_id = a.address_id
JOIN city ci ON a.city_id = ci.city_id
JOIN country co ON ci.country_id = co.country_id
WHERE co.country NOT IN ('China')

