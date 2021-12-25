> 중복 없는 열(column)들을 JOIN한다고 가정했을 때, 
> - A와 B를 INNER JOIN하면 A와 B의 교집합을 얻을 수 있다.
> - A와 B를 OUTER JOIN하면 A와 B의 합집합을 얻을 수 있다.

# 1. SQL INNER JOIN
### 1-1. 정의 및 사용법
table1과 table2가 모두 가지고있는 데이터만 검색한다.<br/>
두 테이블간 조인 조건을 만족하는 행을 반환할 때 사용하는 구문이다. <br/> <br/>
*일반적인 JOIN은 INNER JOIN으로 인식하기 때문에 INNER는 생략 가능하다.*

```sql
SELECT column_name(s)
  FROM table1
INNER JOIN table2
ON table1.column_name = table2.column_name;
```

### 1-2. 예시
- Horror 카테고리 장르에 해당하는 영화의 이름과 description 출력
```sql
SELECT title, description
	FROM film f 
JOIN film_category fc ON f.film_id = fc.film_id 
JOIN category c ON fc.category_id = c.category_id
WHERE c.name = 'Horror'
```
<br/><br/>

# 2. SQL OUTER JOIN
### 2-1. 정의 및 사용법
2개 이상의 테이블이 조인될 때 어느 한쪽 테이블엔 데이터가 존재하는데 다른 쪽 테이블에는 데이터가 존재하지 않는 경우,
데이터가 있는 쪽 테이블의 내용을 모두 출력한다. <br/>
즉, 조인 조건을 만족하지 않는 행까지 함께 출력할 때 사용된다.<br/>
*OUTER는 생략 가능하다.*

```sql
SELECT column_name(s)
FROM table1
LEFT JOIN table2
ON table1.column_name = table2.column_name;
```
### 2-2. 종류
### LEFT OUTER JOIN
- 조인문의 왼쪽에 있는 테이블의 모든 결과를 가져 온 후 오른쪽 테이블의 데이터를 매칭하고, 매칭되는 데이터가 없는 경우 NULL로 표시한다.
- table1의 모든 데이터 + table1과 table2의 중복되는 값이 검색

![image](https://user-images.githubusercontent.com/83413923/147380017-a697359f-8bd4-4eb8-9643-741345bdb9f1.png)

```sql
SELECT column_name(s)
  FROM table1
LEFT JOIN table2
  ON table1.column_name = table2.column_name;
```


### RIGHT OUTER JOIN
- 조인문의 오른쪽에 있는 테이블의 모든 결과를 가져온 후 왼쪽의 테이블의 데이터를 매칭하고, 매칭되는 데이터가 없는 경우 NULL을 표시한다.
- table2의 모든 데이터 + table1과 table2의 중복되는 값이 검색

![image](https://user-images.githubusercontent.com/83413923/147380069-d166fd62-a283-4f3c-98d3-a53e02ea5156.png)
```sql
SELECT column_name(s)
FROM table1
RIGHT JOIN table2
ON table1.column_name = table2.column_name;
```
<br/>

### 2-3. 예시

- actor 테이블을 이용하여, 배우의 ID, 이름, 성 컬럼에 추가로 'Angels Life' 영화에 나온 영화 배우 여부를
Y, N으로 컬럼을 추가 표기해주세요. 해당 컬럼은 angelslife_flag로 만들어주세요.
```sql
SELECT a.actor_id, a.first_name, a.last_name,
	CASE WHEN a.actor_id = feat_actor.actor_id THEN 'Y'
		ELSE 'N' 
	END AS angelslife_flag
FROM actor a
LEFT JOIN (
	SELECT f.film_id, f.title, fa.actor_id 
	FROM film_actor fa
	JOIN film f ON fa.film_id = f.film_id
	WHERE f.title = 'Angels Life'
	) AS feat_actor ON a.actor_id = feat_actor.actor_id;
```

> 위의 문제를 아래와 같이 풀어도 동일하게 출력된다.
```sql
SELECT a.actor_id , a.first_name, a.last_name , CASE WHEN a.actor_id IN (
    SELECT actor_id
      FROM film f
    INNER JOIN film_actor fa ON f.film_id  = fa.film_id
    WHERE f.title ='Angels Life') THEN 'Y'
    ELSE 'N'
    END AS angelslife_flag
  FROM actor a;
```
<br/>

- rental 정보에 추가로, 고객의 이름과, 직원의 이름을 함께 보여주세요. 고객의 이름, 직원 이름은 이름과 성을 fullname 컬럼으로만들어서 직원이름/고객이름 2개의 컬럼으로 확인해주세요.
```sql
SELECT r.*, c.first_name || ' '|| c.last_name AS customer_name, s.first_name || ' '|| s.last_name AS staff_name
	FROM rental r
LEFT JOIN customer c 
	ON r.customer_id  =  c.customer_id
LEFT JOIN staff s 
	ON r.staff_id  = s.staff_id
```

<br/><br/>

> 참조 : https://stackoverflow.com/questions/406294/left-join-vs-left-outer-join-in-sql-server
