# 1. The SQL SELECT DISTINCT Statement
SELECT DISTINCT문은 고유한(다른) 값만 반환하는 데 사용됩니다.

```sql
SELECT DISTINCT column1, column2, ...
FROM table_name;
```

### 1-1. SELECT Example Without DISTINCT
다음 SQL 문은 "Customers" 테이블의 "Country" 열에서 모든 값(중복 포함)을 선택합니다.

```sql
SELECT Country FROM Customers;
```
<br/>
이제 SELECT DISTINCT구문을 사용 하여 결과를 살펴보겠습니다.

### 1-2. SELECT DISTINCT Examples

1) 다음 SQL 문은 "Customers" 테이블의 "Country" 열에서 DISTINCT 값만 선택합니다.

```sql
SELECT DISTINCT Country FROM Customers;
```
[OUT]

![image](https://user-images.githubusercontent.com/83413923/146638995-d490bb88-942f-41a5-8b0a-dd134ae155bb.png)


2) 다음 SQL 문은 서로 다른(고유한) 고객 국가의 수를 나열합니다. 

```sql
SELECT COUNT(DISTINCT Country) FROM Customers;
```
[OUT]
![image](https://user-images.githubusercontent.com/83413923/146639000-310eee75-4b7c-434b-8bd9-559ddadd708b.png)


<br/>

# 2. SQL GROUP BY Statement

GROUP BY 문은 "각 국가의 고객 수 찾기"와 같이 동일한 값을 가진 행을 요약 행으로 그룹화 합니다.

GROUP BY 문은 하나 이상의 열로 결과 집합을 그룹화하기 위해 집계 함수 COUNT(), MAX(), MIN(), SUM(), AVG()와 함께 자주 사용됩니다.

### 2-1. SQL GROUP BY Examples

1) 다음 SQL 문은 각 국가의 고객 수를 나열합니다.

```sql
SELECT COUNT(CustomerID), Country
FROM Customers
GROUP BY Country;
```

![image](https://user-images.githubusercontent.com/83413923/146639099-2ce8ec6b-49b6-4878-9654-661e7657fda0.png)


2) 다음 SQL 문은 높은 순으로 정렬된 각 국가의 고객 수를 나열합니다.

```sql
SELECT COUNT(CustomerID), Country
FROM Customers
GROUP BY Country
ORDER BY COUNT(CustomerID) DESC;
```

# 3. DISTINCT 와 GROUP BY의 차이

먼저 개념적인 차이는 다음과 같습니다.

**DISTINCT** : 컬럼 내 데이터를 중복을 제거해 조회한다.
**GROUP BY** : 컬럼 내 데이터를 Unique한 값을 기준으로 그 결과를 가져온다.


두 작업은 기능적으로는 약간의 차이가 있지만, 결과적으로는 동일한 형태의 작업입니다.<br/>
일부 작업의 경우 DISTINCT로 동시에 GROUP BY로도 처리될 수 있는 쿼리들이 있습니다.

간단하게 아래 예를 살펴 보면,
```sql
1. SELECT DISTINCT fd1 FROM tab;
2. SELECT DISTINCT fd1, fd2 FROM tab;
```

위의 두개 쿼리는 간단히 GROUP BY로 바꿔서 실행할 수 있습니다.
```sql
1. SELECT fd1 FROM tab GROUP BY fd1;
2. SELECT fd1, fd2 FROM tab GROUP BY fd1, fd2;
```

이런 형태의 DISTINCT는 내부적으로 GROUP BY와 동일한 코드를 사용합니다.

하지만 DISTINCT의 결과는 정렬된 결과가 아니지만, GROUP BY는 정렬된 결과를 보여줍니다.
GROUP BY의 작업을 크게 "그룹핑" + "정렬"로 나누어서 본다면, DISTINCT는 "그룹핑" 작업만 수행하고 "정렬" 작업은 수행하지 않는 것 입니다.

쉽게 생각해서, DISTICNT는 그룹핑만, GROUP BY는 그룹핑 + 정렬의 과정입니다. 
때문에 연산 속도는 DISTINCT가 더 빠르며, "정렬"이 필요하지 않다면 DISTINCT를 사용하는 것이 성능상 더 빠르다고 볼 수 있습니다.

<br/>

### + 참고 

1. DISTINCT로만 가능한 기능

```sql
SELECT COUNT(DISTINCT fd1) FROM tab;
```
  => 이런 형태의 쿼리는 서브 쿼리를 사용하지 않으면 GROUP BY로는 작성하기 어렵습니다.


2. GROUP BY로만 가능한 기능
```sql
SELECT fd1, MIN(fd2), MAX(fd2) FROM tab 
GROUP BY fd1;
```

  => 이렇게 집합함수(Aggregation)가 필요한 경우에는 GROUP BY를 사용해야 합니다.
