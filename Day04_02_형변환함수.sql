-- DUAL테이블  
-- 노션

--1. 숫자로 변환 (TO_NUMBER)
    
    --‘100’ ⇒ 100
SELECT '100', TO_NUMBER('100')
FROM DUAL;

--심화.
SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME
    FROM EMPLOYEES
  WHERE EMPLOYEE_ID = '150'; -- EMPLOYEE_ID = TO_NUMBER('150')으로 자동으로 변환한 뒤 처리한다 
  
--2. 문자로 변환하기(TO_CHAR) 

-- 1) 숫자를 문자로 변환하기
-- 100 -> '100'
-- 1000 -> '1,000'
SELECT
        TO_CHAR(100)    --'100'
     ,  TO_CHAR(100, '999999') -- '   100' : 6자리 칼럼 폭으로 맞춰달라 ,9는 공백
     ,  TO_CHAR(100, '000000') -- '000100' : 모자란 부분은 0으로 채운다 
     ,  TO_CHAR(1234, '9,999') -- '1,234'
     ,  TO_CHAR(12345, '9,999') -- ######## : 답이 안나옴 , 5자리 숫자인데 12345를 4자리 형식으로 9,999 에 맞출 수 없다 
     ,  TO_CHAR(12345, '99,999') -- 이렇게 해야 '12,345' 가 나옴 
     ,  TO_CHAR(0.123, '0.00')   -- '0.12'(반올림) 소수점 둘째자리까지 만드는데 반올림 하시오 
     ,  TO_CHAR(0.125, '0.00') -- '0.13'(반올림)
     
    FROM DUAL;
     
-- 2) 날짜를 문자로 변환하기 (쭝요)
-- 2023-02-07 -> '2023년 02월 07일'

SELECT
       SYSDATE -- DATE 타입의 현재 날짜와 시간 
    ,  SYSTIMESTAMP -- TIMESTAMP 타입의 현재 날짜와 시간 
    FROM
        DUAL;

-- 원하는 형식으로 현재 날짜와 시간 확인하기 

SELECT
       TO_CHAR(SYSDATE, 'YYYY-MM-DD')
     , TO_CHAR(SYSDATE, 'AM HH:MI:SS')
     , TO_CHAR(SYSDATE, 'HH24:MI:SS')
  FROM
       DUAL;
       
-- 날짜로 변환하기 
-- 날짜를 원하는 형식으로 표시하는것이 아님을 주의
-- '05/06/07' 이 날짜는 언제일까 

SELECT
       TO_DATE('05/06/07', 'YY/MM/DD')
    ,  TO_DATE('05/06/07', 'MM/DD/YY')
  FROM
       DUAL;

--언제 쓰일까? EMPLOYEES 테이블에서 2000/01/01 ~2005/12/31 사이에 입사한 사원을 조회 
SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, HIRE_DATE
    FROM EMPLOYEES
  WHERE TO_DATE(HIRE_DATE, 'YY/MM/DD') BETWEEN TO_DATE('00/01/01','YY/MM/DD') AND TO_DATE('05/12/31','YY/MM/DD');

-- 날짜 비교는 TO_DATE 함수를 이용하자 
DROP TABLE SAMPLE_TBL;
CREATE TABLE SAMPLE_TBL(
    DT1 DATE
);

INSERT INTO SAMPLE_TBL(DT1) VALUES(SYSDATE); -- DATE 타입은 SYSDATE TIMESTAMP 타입은 ?
COMMIT;
--안됨
SELECT DT1
  FROM SAMPLE_TBL 
WHERE DT1 = '23/02/07';

--안됨
SELECT DT1
  FROM SAMPLE_TBL
 WHERE DT1 = TO_DATE('23/02/07', 'YY/MM/DD');
 --됨
 SELECT DT1
  FROM SAMPLE_TBL
 WHERE TO_DATE(DT1, 'YY/MM/DD') = TO_DATE('23/02/07', 'YY/MM/DD');
 
 --안됨 날짜가 변경되는 것이 아님
SELECT 
     TO_DATE(DT1, 'YYYY-MM-DD')
   , TO_CHAR(DT1, 'YYYY-MM-DD')
   FROM SAMPLE_TBL
