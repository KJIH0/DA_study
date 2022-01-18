# 1. SQL COALESCE() Function

### 1-1. 정의 및 사용법
컬럼이 NULL인 경우 대체 값으로 반환합니다.  <br/>

> **Syntax**  <br/>
> val1의 값이 NULL이면 val2의 값으로 반환

```sql
COALESCE(val1, val2)
``` 

### 1-2. 예시
 
-  user_name 컬럼값이 NULL 일 경우  'empty' 로 변경하여 반환

```sql
SELECT COALESCE(user_name, 'empty') AS worker_name 
FROM worker_table;
```
 
-  products 테이블을 활용하여, productdescription에 상품 상세 설명 값이 없는 상품 데이터 모두 조회
```sql
SELECT *,  COALESCE(productdescription ,'Empty') as new_productdescription
FROM products
WHERE productdescription IS NULL 
```

<br/>

# 2. SQL CASE Statement

### 2-1. 정의 및 사용법
CASE 문은 조건문을 통과하고 첫 번째 조건이 충족될 때 값을 반환합니다(if-then-else 문과 같이). <br/>
따라서 조건이 true이면 멈추고 결과를 반환합니다. 조건이 거짓이면 ELSE 절의 값을 반환합니다.
<br/> 

조건이 참이면 NULL을 반환합니다.

> **Syntax**  <br/>
```sql
CASE
	WHEN condition1 THEN result1
	WHEN condition2 THEN result2
	WHEN conditionN THEN resultN
	ELSE RESULT
END
```

### 2-2. 예시

- 테이블(MY_TABLE)에서 성별(GENDER)이 001이면 여, 아니면 남자로 검색
```sql
SELECT DISTINCT
GENDER,
CASE WHEN GENDER = '001' THEN '여' ELSE '남' END AS 성별
FROM MY_TABLE
```

- 테이블(MY_TABLE)에서 성적(SCORE)별 학점을 계산

```sql
SELECT *,
   (CASE WHEN SCORE>= '90' THEN 'A학점'
        WHEN (SCORE>= '80' AND SCORE < '90') THEN 'B학점'
        WHEN (SCORE>= '70' AND SCORE < '80') THEN 'C학점' 
        WHEN (SCORE>= '60' AND SCORE < '70') THEN 'D학점'
        ELSE 'F학점'
    END) AS '학점'
FROM MY_TABLE
```

- customers 테이블을 이용하여, 고객의 id 별로, custstate 지역 중 WA 지역에 사는 사람과 WA 가 아닌 지역에 사는 사람을 구분
  - customerid 와, newstate_flag 컬럼으로 구성
  - newstate_flag 컬럼은 WA 와 OTHERS 로 노출
```sql
SELECT customerid,
CASE WHEN custstate ='WA' THEN 'WA' ELSE 'OTHERS' END AS newstate_flag
FROM customers 
```

<br/>


*참조 :  https://www.sqlshack.com/using-the-sql-coalesce-function-in-sql-server/*
