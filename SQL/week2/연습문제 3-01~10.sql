-- 문제1번) 고객의 기본 정보인, 고객 id, 이름, 성, 이메일과 함께 고객의 주소 address, district, postal_code, phone 번호를 함께 보여주세요.

SELECT  c.customer_id, c.first_name, c.last_name, c.email, a.address, a.district, a.postal_code, a.phone 
	FROM customer c
INNER JOIN address a
ON c.customer_id = a.address_id 

-- 문제2번) 고객의  기본 정보인, 고객 id, 이름, 성, 이메일과 함께 고객의 주소 address, district, postal_code, phone , city 를 함께 알려주세요.
-- => 총 3개의 테이블 join해야함... 들여쓰기가 중요해진다

SELECT  c.customer_id, c.first_name, c.last_name, c.email, 
		a.address, a.district, a.postal_code, a.phone, ci.city
	FROM customer c
INNER JOIN address a
	ON c.customer_id = a.address_id 
INNER JOIN city ci
    ON a.city_id = ci.city_id

-- 문제3번) Lima City에 사는 고객의 이름과, 성, 이메일, phonenumber에 대해서 알려주세요.

SELECT c.first_name, c.last_name, c.email, a.phone 
  FROM customer c
INNER JOIN  address a
 	ON c.customer_id = a.address_id
WHERE  a.city_id 
 	IN (SELECT city_id FROM city WHERE city = 'Lima')

-- 문제4번) rental 정보에 추가로, 고객의 이름과, 직원의 이름을 함께 보여주세요. 고객의 이름, 직원 이름은 이름과 성을 fullname 컬럼으로만들어서 직원이름/고객이름 2개의 컬럼으로 확인해주세요.

SELECT r.*, c.first_name || ' '|| c.last_name AS customer_name, s.first_name || ' '|| s.last_name AS staff_name
	FROM rental r
LEFT OUTER JOIN customer c 
	ON r.customer_id  =  c.customer_id
LEFT OUTER JOIN staff s 
	ON r.staff_id  = s.staff_id

-- 문제5번) [seth.hannon@sakilacustomer.org](mailto:seth.hannon@sakilacustomer.org) 이메일 주소를 가진 고객의  주소 address, address2, postal_code, phone, city 주소를 알려주세요.
-- 다섯문제 중 가장 헷갈림^^;

SELECT address, address2, postal_code, phone, city
	FROM address a
JOIN customer c ON a.address_id = c.address_id 
JOIN city c2 on c2.city_id = a.city_id 
WHERE c.email ='seth.hannon@sakilacustomer.org'
