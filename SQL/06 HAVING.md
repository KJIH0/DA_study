# SQL HAVING Clause

### 1-1. 정의 및 사용법
- WHERE 절에서는 집계함수를 사용 할 수 없다.
```sql
SELECT column1, column2, ...
  FROM table_name
WHERE condition;
```
- HAVING 절은 집계함수를 가지고 조건비교를 할 때 사용한다.
- 항상 GROUP BY뒤에 위치하고 WHERE 절과 마찬가지로 조건에는 다양한 비교연산자들이 사용된다.
```sql
SELECT column_name(s)
  FROM table_name
WHERE condition
GROUP BY column_name(s)
HAVING condition
ORDER BY column_name(s);
```
- WHERE 절과 차이점
  - 둘다 조건을 주는 명령어지만, 
  - WHERE절은 모든 필드에 대해 우선적으로 조건을 주고
  - HAVING은 GROUP BY 된 이후 그룹화되어진 새로운 테이블에 조건을 줄 수 있다.

> 즉, 전체 테이블 자체에서 쿼리를 수행하고 싶다면 WHERE를, 전체 테이블을 그룹화 한뒤, 그 해당 그룹에서 조건을 걸어 가져오고 싶다면 HAVING을 사용한다.
<br/>

### 1-2. 예시

- 각 국가의 고객 수를 출력. 고객이 5명 이상인 국가만 포함한다.
```sql
SELECT COUNT(CustomerID), Country
  FROM Customers
GROUP BY Country
HAVING COUNT(CustomerID) > 5;
```

- 각 국가의 고객 수를 높은 순으로 정렬. 고객이 5명 이상인 국가만 포함한다.
```sql
SELECT COUNT(CustomerID), Country
  FROM Customers
GROUP BY Country
HAVING COUNT(CustomerID) > 5
ORDER BY COUNT(CustomerID) DESC;
```

- 출현한 영화배우(actor)가 10명을 초과한 영화명 출력
```sql
SELECT title 
	FROM film f 
WHERE film_id 
IN(SELECT fa.film_id
      FROM film_actor fa
    GROUP BY film_id
    HAVING count(*) > 10
    )

