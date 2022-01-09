# 1. SQL GROUPING SETS

### 1-1. 정의 및 사용법 
- GROUPING SETS 함수는 GROUP BY 절에서 그룹 조건을 여러 개 지정할 수 있는 함수이다. 
  - 여러 개의 그룹 조건을 한꺼번에 지정하여 복잡한 그룹 처리 과정을 단순하게 구성할 수 있다.
  - group by 또는 union all보다 성능이 좋다.(=빠르다.)
- 이 함수의 결과는 각 그룹 조건에 대해 별도로 GROUP BY한 결과를 UNION ALL한 결과와 동일하다다. 
- 빈괄호( )를 추가하여 합계를 표시할 수 있다.
  -  빈괄호(빈 괄호( )가 아닌 NULL, ' ' 등을 넣어도 합계가 나오지만 빈 괄호( )를 권장한다.

```SQL
SELECT 컬럼명,그룹함수(컬럼명), GROUPING(컬럼명)
FROM 테이블명
WHERE 조건
GROUP BY [ROLLUP | CUBE] 그룹핑하고자하는 컬럼명, ...[GROUPING SETS (컬럼명,컬럼명, ...), ...]
HAVING 그룹조건
ORDER BY 컬럼명 또는 위치번호
```
<br/>

### 1-2. 사용 예시

-  deptno + job별 사람수와 deptno별 사람수, job별 사람수를 한번에 구하라.
```SQL
SELECT deptno,job,count(*)
FROM emp
GROUP BY
GROUPING SETS((deptno, job), deptno, job);
```
> OUTPUT : <BR/>
> 
>  ![image](https://user-images.githubusercontent.com/83413923/148670464-7af6c163-0afb-4860-883f-bece2fc89885.png)


<BR/><BR/>

# 2. ROLLUP

### 2-1. 정의 및 사용법 

- 지정된 GROUPING 컬럼의 소계를 생성하는데 사용된다. 간단한 문법으로 다양한 소계를 출력할 수 있다.
- ROLLUP 절은 GROUP BY 절과 함계 사용된다.
 ROLLUP 할 컬럼은 무조건 SELECT 절에 포함되어 있어야 한다.
-ROLLUP 절 컬럼의 지정 순서가 의미 있다.

```SQL
SELECT
  C1, C2, C3,
  집계함수(C4)
FROM
  TABLE_NAME
GROUP BY
  ROLLUP(C1, C2, C3);  -- 소계를 생성할 컬럼을 지정한다.
                       -- 컬럼 지정 순서에 따라 결과값이 달라질 수 있다.
```
<BR/>

### 2-2. 예시

- 부서별, 직업별 뿐만아니라 전체 급여의 합과 부서별 급여의 합을 함께 출력
```SQL
SELECT DEPTNO, JOB, SUM(SAL)
FROM EMP
GROUP BY ROLLUP(DEPTNO, JOB);
```SQL
> OUTPUT <BR/>
> ![image](https://user-images.githubusercontent.com/83413923/148672096-e55ea419-f89d-4b82-9990-ce9f23fd5653.png)

- 전체 급여 합만 출력
```SQL
SELECT
    DEPTNO
    ,JOB
    ,SUM(SAL)
FROM EMP
GROUP BY ROLLUP((DEPTNO, JOB));
```
> OUTPUT <BR/>
> ![image](https://user-images.githubusercontent.com/83413923/148672111-50706448-583c-4c15-a260-17a1846f3af0.png)

<BR/>

### 2-3. 원리 
![image](https://user-images.githubusercontent.com/83413923/148672126-0ccd9524-fc98-48d1-9cd7-44f749dbf971.png)
1. ROLLUP의 인자로 들어온 칼럼을 오른쪽부터 하나씩 빼면서 GROUP을 만듭니다.
2. "()"의 의미는 GROUP이 없는 즉, 전체에 대한 결과를 출력한다는 뜻 입니다. EX(SUM 함수 사용하면 전체 SUM 구한다는 뜻)
3. 괄호로 묶여져 있는 컬럼은 하나로 본다는 뜻 입니다.
4. ROLLUP 이전에 일반 컬럼과 GROUP BY 한다면, 일반 컬럼은 끝까지 남습니다.


<BR/><BR/>



> 참조 :  https://myjamong.tistory.com/191
