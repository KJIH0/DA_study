# SQL MOD() function

MOD() 함수는 다른 숫자로 나눈 숫자의 나머지를 반환합니다.

MOD와 함께, DISTINCT는 지정된 열 또는 표현식에 따라 고유값을 검색하는 데 사용됩니다.

```sql
MOD(dividend, divider)
```

### SQL MOD Examples

**1. 나머지 구하기**

```sql
SELECT MOD(3,2) 
  FROM DUAL

-- 결과값 : 1
```

**2. 초를 분으로 변경하기**

```sql
-- 150초를 분/초로 변경
SELECT trunc(150/60)||'분'||MOD(150,60)||'초'
  FROM DUAL

--결과값 : 2분 30초
```
