DROP TABLE SAMPLE_TBL;
CREATE TABLE SAMPLE_TBL (
    NAME VARCHAR2(10 BYTE),
    KOR NUMBER(3),
    ENG NUMBER(3),
    MAT NUMBER(3)
);

INSERT INTO SAMPLE_TBL(NAME, KOR, ENG, MAT) VALUES(NULL, 100,100,100);
INSERT INTO SAMPLE_TBL(NAME, KOR, ENG, MAT) VALUES('정숙',NULL, 90,90);
INSERT INTO SAMPLE_TBL(NAME, KOR, ENG, MAT) VALUES('미희',80, NULL,80);
INSERT INTO SAMPLE_TBL(NAME, KOR, ENG, MAT) VALUES('철순',70, 70,NULL);
COMMIT;

-- 집계함수 노션

/*
이름 국어 영어 수학 합계
NULL,100, 100,  100, 300;
'정숙',NULL,90,  90  180;
'미희',80, NULL, 80  160;
'철순',70,  70, NULL 140
*/

--합계

SELECT 
     SUM(KOR)
   , SUM(ENG)
   , SUM(MAT)
   --, SUM(KOR, ENG, MAT) -- SUM 함수의 인수는 1개만 가능
    FROM SAMPLE_TBL;
    

--평균 -- 응시 결과가 없으면 0으로 처리하기
SELECT
    AVG(NVL(KOR,0))
  , AVG(NVL(ENG,0))
  , AVG(NVL(MAT,0))
FROM
    SAMPLE_TBL;
   
--개수
SELECT
        COUNT(KOR) -- 국어 시험 응시한 인원수
      , COUNT(ENG) -- 영어 시험에 응시한 인원수
      , COUNT(MAT) -- 수학 시험에 응시한 인원수 
      --, COUNT(NAME) 이름에 NULL이 있으니 안됨
      , COUNT(*)   -- 에스터리스크 * 모든 칼럼 , 모든 칼럼을 참조해서 어느 한 칼럼이라도 값을 가지고 있으면 개수에 포함
    FROM
        SAMPLE_TBL;
        
-- 문자열 일부 반환 
-- SUBSTR(칼럼, BEGIN, LENGTH)

SELECT
        SUBSTR(EMAIL,1,3) -- 1번째 글자부터 3글자를 가져오시오.
    FROM    
         EMPLOYEES;
    
    
-- 5. 특정 문자열의 위치 반환하기
-- INSTR(칼럼, 찾을 문자열)
-- 반환되는 위치 정보는 INDEX가 아니므로 0부터 시작하지 않고 , 1부터 시작한다 
-- 만약 찾는 값이 없다면 0을 반환한다 
SELECT
        INSTR(EMAIL, 'A') -- 'A'의 위치를 반환 
    FROM 
        EMPLOYEES;

--6. 문자열 채우기(PADDING) 문자열의 패딩 시키는 것 
--  LPAD(칼럼, 전체폭, 채워줄 문자)
--  RPAD(칼럼, 전체폭, 채워줄 문자)

SELECT
         LPAD(NVL(DEPARTMENT_ID, 0), 3, '0')
     , RPAD(SUBSTR(EMAIL, 1, 2), 5, '*')
    FROM
        EMPLOYEES;
        
--ALTER TABLE DEPARTMENTS
  --  MODIFY DEPARTMENT_ID NULL

--7. 불필요한 공백 제거
--     1. LTRIM(칼럼) : 왼쪽 공백 제거 
--     2. RTRIM(칼럼) : 오른쪽 공백 제거 
--     3. TRIM(칼럼)  : 왼쪽, 오른쪽 공백 모두 제거 
SELECT 
        '[' || LTRIM('      HELLO') ||']'
     ,  '[' || RTRIM('HELLO      ') ||']'
     ,  '[' || TRIM('   HELLO   ')  ||']'
     FROM
            DUAL; -- 어떤 특정 테이블을 참고하는 것이 아니기에 DUAL 씀  

