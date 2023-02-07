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