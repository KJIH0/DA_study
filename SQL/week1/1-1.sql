# 문제1번) dvd 렌탈 업체의  dvd 대여가 있었던 날짜를 확인해주세요.
# 일반적으로 select문에서는 중복여부에 상관없이 모든 자료를 요청하므로, distinct를 사용하여 고유한 날짜만 출력한다.

SELECT DISTINCT DATE(rental_date) 
FROM rental
