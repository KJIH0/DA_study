> 그룹 내 순위를 결정하는 함수 정리
> - RANK : 1등이 두명이면 그 다음 순위는 3등이 된다.
> - ROW_NUMBER : 1등이 두명이어도 1,2등으로 나눈다. (중복 허용X)
> - DENSE_RANK : 1등이 두명이면 그 다음 순위는 2등이 된다.
<br/>

## 0. Window Function
> 순위 함수를 알기 전에, 윈도우 함수(Window Function)에 대한 이해가 필요하다.
- 윈도우 함수란?
  - 행과 행 간의 관계를 정의하기 위해서 제공되는 함수.
  - 윈도우 함수를 사용해서 **순위, 합계, 평균, 행 위치 등을 조작**할 수 있다.
  - 윈도우 함수는 **GROUP BY 구문과 병행**하여 사용할 수 없다.
  - 윈도우 함수로 인해 결과 건수가 줄어들지는 않는다.
  - WINDOW 함수의 PARTITION 구문과 GROUP BY 구문은 둘 다 파티션을 분할한다는 의미에서는 유사하다.
  - sum, max, min 등과 같은 집계 윈도우 함수를 사용할 때 윈도우 절과 함께 사용하면 집계 대상이 되는 레코드 범위를 지정할 수 있다.
<br/>

- 윈도우 함수 문법
```sql
SELECT WINDOW_FUNCTION (ARGUMENTS) OVER 
( [PARTITION BY 컬럼] [ORDER BY 컬럼] [WINDOWING 절] )
FROM 테이블명 ; 
  
-- ARGUMENTS(인수) : 함수에 따라 0 ~ N개 인수가 지정될 수 있다. 
-- PARTITION BY 절 : 전체 집합을 기준에 의해 소그룹으로 나눌 수 있다.   
-- ORDER BY 절 : 어떤 항목에 대해 순위를 지정할 지 order by 절을 기술한다.
-- WINDOWING 절 : WINDOWING 절은 함수의 대상이 되는 행 기준의 범위를 강력하게 지정할 수 있다. 
```

- 윈도우 함수 종류
  - 그룹 내 순위(RANK) 관련 함수: RANK, DENSE_RANK, ROW_NUMBER
  - 그룹 내 집계(AGGREGATE) 관련 함수 : SUM, MAX, MIN, AVG, COUNT 
  - 그룹 내 행 순서 관련 함수 : FIRST_VALUE, LAST_VALUE, LAG, LEAD 
  - 그룹 내 비율 관련 함수 : CUME_DIST, PERCENT_RANK, NTILE, RATIO_TO_REPORT  
  
<br/>

# 1. RANK FUNCTION

### 1-1. 정의 및 사용법
- 순위를 계산하며, 동일한 순위에는 같은 순위가 부여된다.
  - ex) 1, 2, 2, 4, 5, 6..


```sql
RANK ( ) OVER ( [ partition_by_clause ] order_by_clause )
```

### 1-2. 사용 예시
```sql
SELECT ENAME, SAL
    RANK() OVER (ORDER BY SAL DESC) ALL_RANK,
    RANK() OVER (PARTITION BY JOB ORDER BY SAL DESC) JOB_RANK,
FROM EMP;
```
- RANK() OVER (ORDER BY SAL DESC)는 SAL로 등수를 계산하고, 내림차순으로 조회하게 한다.
- RANK() OVER (PARTITION BY JOB ORDER BY SAL DESC)는 JOB으로 파티션을 만들고, JOB별로 SAL 순위를 조회하게 한다.

<br/><br/>


# 2. ROW_NUMBER FUNCTION

### 2 -1. 정의 및 사용법

- **동일한 값이라도 고유한 순위를 부여한다.**(RANK, DENSE_RANK는 동일한 값에 동일한 순위 부여)
  -  ex. 1, 2, 3, 4, 5 ...
- 같은 값에 대해서 어떤 결과가 먼저 나올지 순서를 정하고 싶다면, ORDER BY를 사용한다.

```sql
ROW_NUMBER ( )   
    OVER ( [ PARTITION BY value_expression , ... [ n ] ] order_by_clause )
```


### 2-2. 사용 예시

- 알파벳 순서로 4개의 시스템 테이블을 반환
```sql
SELECT 
  name, recovery_model_desc
FROM sys.databases 
WHERE database_id < 5
ORDER BY name ASC;
```
![image](https://user-images.githubusercontent.com/83413923/149943393-3921c6e4-f346-4a93-8d3a-65a16db7ca2d.png)


- 위의 결과에서, 각 행 앞에 번호 열을 포함하는 sql문은 다음과 같다.
```sql
SELECT 
  ROW_NUMBER() OVER(ORDER BY name ASC) AS Row#,
  name, recovery_model_desc
FROM sys.databases 
WHERE database_id < 5;
```
- 각 행 앞에 행 번호 열을 추가하려면 ROW_NUMBER 함수가 있는 열(이 경우 Row#)을 추가한다.
- ORDER BY 절을 OVER 절로 이동시켜야 한다!

![image](https://user-images.githubusercontent.com/83413923/149943363-1b81d8ff-56cb-4f87-a340-45a7276f2602.png)

- 열에 PARTITION BY절을 추가하면 값이 변경될 때 순위를 다시 매긴다.
```sql
SELECT 
  ROW_NUMBER() OVER(PARTITION BY recovery_model_desc ORDER BY name ASC) 
    AS Row#,
  name, recovery_model_desc
FROM sys.databases WHERE database_id < 5;
```

<br/><br/>


# 3. DENSE_RANK FUNCTION

### 3-1. 정의 및 사용법

- DENSE_RANK는 동일한 순위를 하나의 건수로 인식해서 조회한다. 
  - ex) 1, 2, 2, 3, 4, 5, 6, 7...

```sql
DENSE_RANK ( ) OVER ( [ <partition_by_clause> ] < order_by_clause > ) 
```

### 3-2. 사용 예시

- 급여별로 순위가 매겨진 상위 10명의 직원을 반환
```sql
USE AdventureWorks2012;  
GO  
SELECT TOP(10) BusinessEntityID, Rate,   
       DENSE_RANK() OVER (ORDER BY Rate DESC) AS RankBySalary  
FROM HumanResources.EmployeePayHistory;  
```
SELECT를 지정하지 않았기 때문에 함수가 모든 행에 적용됨.
![image](https://user-images.githubusercontent.com/83413923/149944833-8d1bafe7-06ba-447e-a9cd-cea1ddab3a98.png)



<br/><br/>
> 구글 공식 문서 참조 : https://docs.microsoft.com/en-us/sql/t-sql/functions/row-number-transact-sql?view=sql-server-ver15
