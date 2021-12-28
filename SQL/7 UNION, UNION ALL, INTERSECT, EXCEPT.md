> 1. 합집합 연산자 : UNION , UNION ALL
> 2. 교집합 연산자 : INTERSECT
> 3. 차집합 연산자 :  EXCEPT

# 1. UNION 
### 정의 및 사용법
- 여러개의 쿼리문을 사용하여 하나에 데이터로 출력할 때 사용(2개 이상의 SELECT문 결합).
- 즉, UNION은 **두 개의 테이블을 하나로 만드는 연산자**이다.
- 합친 후에 테이블에서 **중복되는 데이터는 제거**한다. 
- 사용할 컬럼의 수와 데이터 형식이 일치해야 한다.
- 중복 제거를 위해 정렬이 발생되는데, 올바른 정렬을 위해서는 ORDER BY 구문을 추가로 사용하는 것이 좋다. 
- UNION과 비슷한 연산자로 UNION ALL이 있는데, UNION과 달리 중복 제거와 정렬은 수행하지 않는다.

```sql
SELECT column_name(s) FROM table1
UNION
SELECT column_name(s) FROM table2;

-- 두 SELECT 문에는 동일한 수의 컬럼이 있어야 함
-- 두 SELECT 문의 컬럼에는 호환되는 데이터 형식이 있어야 함. 
```

# 2. UNION ALL
### 정의 및 사용법
- UNION과 달리 중복 제거와 정렬은 수행하지 않는다(모든 행이 반환됨).
- 따라서 중복값을 허용한다면 UNION ALL을 사용한다.
- 사용법은 UNION과 동일.

```sql
SELECT column, column2, ... columnn
  FROM tables
[conditions]
UNION ALL
SELECT column, column2, ... columnn
  FROM tables
[conditions];
```
<br/>

### UNION, UNION ALL 사용 예시

- 영화 배우가,  영화 180분 이상의 길이 의 영화에 출연하거나, 영화의 rating 이 R 인 등급에 해당하는 영화에 출연한  영화 배우에 대해서, 영화 배우 ID 와 (180분이상 / R등급영화)에 대한 Flag 컬럼을 알려주세요.
  - film_actor 테이블와 film 테이블을 이용하세요.
  - union, unionall, intersect, except 중 상황에 맞게 사용해주세요.
  - actor_id 가 동일한 flag 값 이 여러개 나오지 않도록 해주세요.
```sql
SELECT DISTINCT actor_id, 'over_180' AS flag
  FROM film_actor fa
INNER JOIN (SELECT film_id
              FROM film
            WHERE length >=180) f
            ON fa.film_id = f.film_id
UNION ALL 
SELECT DISTINCT actor_id, 'rating_R' AS flag
  FROM film_actor fa
INNER JOIN (SELECT film_id
              FROM film
            WHERE rating = 'R'
            ) f
            ON fa.film_id = f.film_id
ORDER BY actor_id 
```

- 추후 예시 추가 예정

<br/>

# 3. INTERSECT
### 3-1. 정의 및 사용법
- **두 개 테이블의 교집합을 추출**하는 연산
- 추출 후 중복된 결과를 제거하여 보여준다. 
- UNION 연산자와 유사하게 다음 규칙을 따라야 한다.
  - 두 쿼리의 열 수와 순서는 동일해야 함.
  - 해당 열의 데이터 유형은 동일하거나 호환 가능해야 함.
- 단, INTERSECT 명령어는 MySQL에서는 지원되지 않는데, 이 경우 JOIN을 통해 구현해야 한다.

  ![image](https://user-images.githubusercontent.com/83413923/147573868-8a540893-1556-4faf-a5db-dfc47fbbc0d1.png)
  

```sql
SELECT column1 , column2 ....
  FROM table_names
WHERE condition

INTERSECT

SELECT column1 , column2 ....
  FROM table_names
WHERE condition
```
<br/>

### 3-2. 예시

- 첫 번째 쿼리는 고객의 모든 도시를 찾고, 두 번째 쿼리는 상점의 도시를 찾습니다. 
- 전체 쿼리는 쿼리의 stores 와 customers의 공통된 city를 반환합니다.
```sql
SELECT city
  FROM sales.customers

INTERSECT

SELECT city
  FROM sales.stores
ORDER BY city;
```
<br/>

- suppliers 및 orders 테이블 모두에 나타나는(교집합) Supplier_id 출력. 
```sql
SELECT supplier_id
  FROM suppliers
INTERSECT
SELECT supplier_id
  FROM orders;
```
<br/><br/>

# 4. EXCEPT
### 4-1. 정의 및 사용법
- 두 개의 테이블에서 겹치는 부분을 앞의 테이블에서 제외하여 추출하는 연산. 
  - +)두 번째 쿼리에서 출력되지 않은 첫 번째 쿼리 의 고유한 행을 반환한다.
- 추출 후 중복된 결과를 제거하여 보여준다.
- 차집합의 개념
- 타 연산자와 유사하게 다음 규칙을 따라야 한다.
  - 두 쿼리의 열 수와 순서는 동일해야 함.
  - 해당 열의 데이터 유형은 동일하거나 호환 가능해야 함.
  ![image](https://user-images.githubusercontent.com/83413923/147575806-65c8b6f0-228f-40f9-9b7d-9d2d2933264b.png)
  
```sql
SELECT * 
  FROM TableA 
EXCEPT 
SELECT * 
  FROM TableB

-- > TableA 칼럼의 행 중에서 TableB와 내용이 같지 않거나/ TableA 에는 있는데 TableB에는 없는 데이터를 출력
```
<br/>

### 4-2. 예시

-  첫 번째 쿼리는 모든 제품을 반환합니다. 두 번째 쿼리는 판매된 제품을 반환합니다. 
-  매출이 없는 제품만 반환합니다.(판매되지 않은 제품 출력)

```sql
SELECT product_id
  FROM production.products

EXCEPT

SELECT product_id
  FROM sales.order_items;
```





