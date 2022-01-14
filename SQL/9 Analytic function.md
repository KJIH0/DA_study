## 분석함수란?
- 테이블에 있는 데이터를 특정 용도로 분석하여 결과를 반환하는 함수
- 복잡한 계산을 단순하게 처리해주는 함수
- 쿼리 결과Set을 대상으로 계산을 수행하는 함수
- SELECT 절에서 수행됨
  - FROM, WHERE, GROUP BY 절에서 사용 불가
  -ORDER BY 구문에서는 사용 가능

<br/>

## 집계함수 vs 분석함수
### 1. 집계함수
- 집계함수는 여러행 또는 테이블 전체 행으로부터 그룹별로 집계하여 결과를 반환한다.

```sql
SELECT deptno
     , SUM(sal) s_sal
  FROM emp
 GROUP BY deptno;
 ```
 > 집계함수 실행 결과
 
![image](https://user-images.githubusercontent.com/83413923/149542470-23e2b61c-f0a6-4ba2-b260-f5960ab9cf1a.png)

### 2. 분석함수
- 분석 함수는 집계 결과를 각 행마다 보여준다.
```sql
SELECT deptno
     , empno
     , sal
     , SUM(sal) OVER(PARTITION BY deptno) s_sal
  FROM emp;
```
> 분석함수 실행결과

![image](https://user-images.githubusercontent.com/83413923/149542881-0f33dd1a-84a8-447d-bfe5-1402a70a1547.png)

<br/>


## 차이점
- 집계함수는 그룹별 최대, 최소, 합계, 평균, 건수 등을 구할 때 사용되며, 그룹별 1개의 행을 반환한다.
- 분석함수는 그룹단위로 값을 계산한다는 점에서 집계함수와 유사하지만, 그룹마다가 아니라 결과Set의 각 행마다 집계결과를 보여준다는 점에서 집계함수와 상당한 차이가 있다.
- 쉽게 생각해서, 분석함수는 그룹별 계산결과를 각 행마다 보여주는 것
<br/>

### Syntax
```sql
SELECT ANALYTIC_FUNCTION ( arguments )
       OVER ( [ PARTITION BY 컬럼List ]
              [ ORDER BY 컬럼List ] 
              [ WINDOWING 절 (Rows|Range Between)]
            )
  FROM 테이블 명;
  
-- ANALYTIC_FUNCTION : 분석함수명(입력인자)
-- OVER : 분석함수임을 나타내는 키워드.
-- PARTITION BY : 계산 대상 그룹을 정한다.
-- ORDER BY : 대상 그룹에 대한 정렬을 수행한다.
-- WINDOWING 절 : 분석함수의 계산 대상 범위를 지정한다.
```
<br/>

### 분석함수의 종류
- 순위함수 : RANK, DENSE_RANK, ROW_NUMBER, NTILE
- 집계함수 : SUM, MIN, MAX, AVG, COUNT
- 기타함수 : LEAD, LAG, FIRST_VALUE, LAST_VALUE, RATIO_TO_REPORT

<br/>

> 출처 :  http://www.gurubee.net/lecture/2671
