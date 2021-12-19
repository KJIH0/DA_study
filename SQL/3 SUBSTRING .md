# 1. SQL SUBSTRING() Function

### 1-1. 정의 및 사용법

SUBSTRING() 함수는 문자열을 받아서 일정한 영역만큼 잘라낸 후 리턴하는 함수입니다.

> Syntax 
> - string(Required) : 추출할 문자열
> - start(Required) : 추출 시작 위치. 양수 또는 음수. 양수인 경우 문자열의 시작 부분에서 추출, 음수인 경우 문자열의 끝에서 추출합니다.
> - lenth(Optional) : 추출할 문자 수. 생략하면 전체 문자열이 반환됩니다.

```sql
SUBSTRING(string, start, length)
```
OR :
```sql
SUBSTRING(string FROM start FOR length)
```

### 1-2. 예시

1. 부분 문자열 추출(두번째 위치에서 시작하여 다섯자 추출)
```sql
SELECT SUBSTRING(CustomerName, 2, 5) AS ExtractString
FROM Customers
```

2. 부분 문자열 추출(끝에서 시작하여 위치 -5에서 다섯자 추출):
```sql
SELECT SUBSTRING("SQL Tutorial", -5, 5) AS ExtractString;
```

3. address 테이블을 이용하여, 우편번호(postal_code) 값이 두번째글자가 1인 우편번호의  address_id, address, district ,postal_code  컬럼 확인.
```sql
SELECT address_id, address, district ,postal_code FROM address 
WHERE substring(postal_code,2,1) ='1'
```
