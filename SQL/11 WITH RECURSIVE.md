# SQL WITH RECURSIVE
> *프로그래머스의 SQL 문제를 풀다가 알게된 문법 정리!*

- Q. 몇 시에 입양이 가장 활발하게 일어나는지 알아보려 합니다. 
  - 0시부터 23시까지, 각 시간대별로 입양이 몇 건이나 발생했는지 조회하는 SQL문을 작성해주세요. 
  - 이때 결과는 시간대 순으로 정렬해야 합니다.

```sql
with recursive time as
(select 0 as hour union all select hour + 1 from time where hour < 23)

select hour, count(animal_id) count
from time
left join animal_outs on (hour = date_format(datetime, '%H'))
group by hour;
```

## 1. WITH
> CTE(common table expression)을 생성하는 문법

## 1-1. CTE 정의
- CTE란 해당 SQL문 내에서만 존재하는 일시적인 테이블(정확히는 결과의 집합)을 말한다

- 아래 sql문은 CTE인 cte1과 cte2를 생성하고 이를 통해 JOIN 연산과 SELECT 연산을 한다
```sql
WITH
    cte1 AS (SELECT a, b FROM table1)
    cte2 AS (SELECT c, d, FROM table2)
SELECT b, d FROM cte1 JOIN cte2
WHERE cte1.a = cte2.c;
```

- 다른 CTE를 통해 CTE를 정의하는 것 또한 가능하다

## 1-2. CTE의 열 이름
- 열의 이름은 다음처럼 정할 수 있다

```sql
WITH cte (col1, col2) AS
(
  SELECT 1, 2
  UNION ALL
  SELECT 3, 4
)
SELECT col1, col2 FROM cte;
```

- 열의 이름을 WITH에서 정하지 않으면 첫번째 SELECT 문으로 정해진다

```sql
WITH cte AS
(
  SELECT 1 AS col1, 2 AS col2
  UNION ALL
  SELECT 3, 4
)
SELECT col1, col2 FROM cte;
```

<br/><br/>

## 2. Recursive CTE
서브쿼리에서 스스로를 참조하는 CTE이다

2-1. WITH RECURSIVE
```sql
WITH RECURSIVE cte (n) AS
(
    SELECT 1
    UNION ALL
    SELECT n + 1 FROM cte WHERE n < 5
)
SELECT * FROM cte;
```
```sql
+------+
| n    |
+------+
|    1 |
|    2 |
|    3 |
|    4 |
|    5 |
+------+
```
- 재귀적 CTE의 서브쿼리는 UNION으로 구분된 2 파트로 나눠져 있다

```sql
SELECT ...    -- 최초 행 반환 (non recursive)
UNION ALL
SELECT ...    -- 추가 행 반환 (recursive)
```

- 따라서 1~5를 출력한 위 sql문은 처음 1을 출력하는 SELECT문과 이후 5보다 작은 n에 재귀적으로 n + 1을 반복하는 두번째 SELECT문으로 구성되어 있다

- 두번째 SELECT문이 더이상 행을 생성하지 않을때, 재귀는 끝난다

- 두 SELECT문 또한 여러 SELECT문의 유니온으로 구성할 수 있다

```sql
SELECT ... UNION SELECT ...   -- 최초 행 반환 (non recursive)
UNION ALL
SELECT ... UNION SELECT ...   -- 추가 행 반환 (recursive)
```

## 2-2. 재귀적 CTE의 데이터 크기
- 재귀적 CTE에서 행의 데이터 크기는 재귀적이지 않은 파트에 의해 정해진다

- 따라서 아래와 같은 sql문은 "abcabcabc..." 같은 문자열이 아니라 char(3)로 크기가 고정되어 "abc"만 남게된다

```sql
WITH RECURSIVE cte AS
(
  SELECT 1 AS n, 'abc' AS str
  UNION ALL
  SELECT n + 1, CONCAT(str, str) FROM cte WHERE n < 3
)
SELECT * FROM cte;
```

```sql
+------+------+
| n    | str  |
+------+------+
|    1 | abc  |
|    2 | abc  |
|    3 | abc  |
+------+------+
```

- 이를 해결하기 위해선 재귀적이지 않은 파트에서 CAST를 통해 형 변환을 해줘야한다

```sql
WITH RECURSIVE cte AS
(
  SELECT 1 AS n, CAST('abc' AS CHAR(20)) AS str
  UNION ALL
  SELECT n + 1, CONCAT(str, str) FROM cte WHERE n < 3
)
SELECT * FROM cte;
```

```sql
+------+--------------+
| n    | str          |
+------+--------------+
|    1 | abc          |
|    2 | abcabc       |
|    3 | abcabcabcabc |
+------+--------------+
```

<br/><br/><br/>

> Mysql 공식문서 참조 : https://dev.mysql.com/doc/refman/8.0/en/with.html#common-table-expressions-recursive
