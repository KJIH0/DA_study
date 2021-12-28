--문제1번) 영화 배우가,  영화 180분 이상의 길이 의 영화에 출연하거나, 영화의 rating 이 R 인 등급에 해당하는 영화에 출연한  영화 배우에 대해서, 영화 배우 ID 와 (180분이상 / R등급영화)에 대한 Flag 컬럼을 알려주세요.
--- film_actor 테이블와 film 테이블을 이용하세요.
--- union, unionall, intersect, except 중 상황에 맞게 사용해주세요.
--- actor_id 가 동일한 flag 값 이 여러개 나오지 않도록 해주세요.

SELECT DISTINCT actor_id, 'over_180' AS flag
	FROM film_actor fa
INNER JOIN (
      SELECT film_id
        FROM film
      WHERE length >=180) f
  ON fa.film_id = f.film_id
UNION ALL 
SELECT DISTINCT actor_id, 'rating_R' AS flag
	FROM film_actor fa
INNER JOIN (
          SELECT film_id
            FROM film
          WHERE rating = 'R') f
  ON fa.film_id = f.film_id
ORDER BY actor_id 


--문제2번) R등급의 영화에 출연했던 배우이면서, 동시에, Alone Trip의 영화에 출연한  영화배우의 ID 를 확인해주세요.
--- film_actor 테이블와 film 테이블을 이용하세요.
--- union, unionall, intersect, except 중 상황에 맞게 사용해주세요.




--문제3번) G 등급에 해당하는 필름을 찍었으나,   영화를 20편이상 찍지 않은 영화배우의 ID 를 확인해주세요.
--- film_actor 테이블와 film 테이블을 이용하세요.
--- union, unionall, intersect, except 중 상황에 맞게 사용해주세요.





--- UNION, UNION ALL
