/*
1.
테이블 이름(TABLE_NAME)이 'EMP'인 테이블에 존재하는 인덱스의 이름(INDEX_NAME)과 해당 인덱스가 설정된 칼럼 이름(COLUMN_NAME)을 조회할 수 있는 쿼리문을 작성하시오.
현재 접속한 사용자(USER)가 소유한 인덱스를 대상으로 조회하시오. (10점)
*/
SELECT A.TABLE_NAME,
       A.INDEX_NAME,
       A.COLUMN_NAME 
  FROM ALL_IND_COLUMNS A  
 WHERE A.TABLE_NAME = 'EMP'
 AND A.INDEX_NAME = 'INDEX_NAME'
AND A.COLUMN_NAME = 'COLUMN_NAME';

 

 

/*
2.
현재 접속한 사용자(USER)가 소유한 모든 VIEW의 목록을 조회할 수 있는 쿼리문을 작성하시오. 모든 칼럼(*)을 조회하도록 처리하시오. (10점)
*/
SELECT *
FROM USER_TAB_COLUMNS;
/*
3.
다음 지시사항의 대상 테이블과 대상 칼럼 정보를 이용해서 새로운 인덱스(INDEX)를 생성하는 쿼리문을 작성하시오. (10점)
    1) 대상 테이블 : PRODUCT
    2) 대상 칼럼 : PRODUCT_NAME
    3) 인덱스 이름 : IND_NAME
    4) 고유/비고유 유무 : 비고유 인덱스(고유 인덱스 아님)
*/

CREATE INDEX IND_NAME
    ON PRODUCT(PRODUCT_NAME);


/*
4.
PRODUCT 테이블의 모든 칼럼을 복사하여 NEW_PRODUCT이라는 이름의 새 테이블을 생성하는 쿼리문을 작성하시오.
데이터(행, ROW)는 복사되지 않고 칼럼만 복사되도록 작성하시오.
복사되지 않는 제약조건은 신경쓰지 마시오. (10점)
*/
INSERT INTO NEW_PRODUCT (COL1, COL2) SELECT COL1, COL2 FROM PRODUCT [WHERE];

/*
5.
다음 지시사항의 대상 테이블과 대상 칼럼 정보를 이용해서 새로운 뷰(VIEW)를 생성하는 쿼리문을 작성하시오. (10점)
    1) 대상 테이블 : PRODUCT
    2) 대상 칼럼 : PRODUCT_NAME, PRODUCT_PRICE
    3) 뷰 이름 : V_PRODUCT
*/ 
CREATE OR REPLACE VIEW V_PRODUCT 
AS
SELECT PRODUCT_NAME,
       PRODUCT_PRICE
      FROM PRODUCT;


/*
6.
현재 접속한 사용자(USER)가 소유한 모든 테이블의 이름(TABLE_NAME)을 조회할 수 있는 쿼리문을 작성하시오.
오직 테이블의 이름만 조회되도록 작성하시오. (10점)
*/
SELECT TABLE_NAME FROM USER_TABLES;
/*
7.
현재 접속한 사용자(USER)가 소유한 각종 제약조건을 확인할 수 있는 테이블의 구조(칼럼명, NOT NULL 유무, 타입)를 확인하는 쿼리문을 작성하시오. (5점)
*/
SELECT * FROM COL;


/*
8.
다음과 같은 관계를 가진 테이블이 있다고 가정하고 문제에서 요구하는 올바른 쿼리문 2개를 모두 작성하시오. (각 10점, 총 20점)

<< 데이터베이스 구조 >>
    1) 사원테이블
        EMPLOYEE (EMPID, EMPNAME, SALARY, DEPTID)
    2) 부서테이블
        DEPARTMENT (DEPTID, DEPTNAME)
    3) EMPLOYEE 테이블의 기본키는 EMPID 이다.
    4) DEPARTMENT 테이블의 기본키는 DEPTID 이다.
    5) EMPLOYEE 테이블의 DEPTID 는 DEPARTMENT 테이블의 DEPTID 를 참조하는 외래키이다.

    <<< 문제1 >>>
        가장 높은 연봉(SALARY)을 받는 사원의 부서 이름(DEPTNAME)을 조회하는 쿼리문을 작성하시오.

    <<< 문제2 >>>
        부서 이름(DEPTNAME)이 '총무부'인 사원들의 사원번호(EMPID), 사원명(EMPNAME), 연봉(SALARY)을 조회하는 쿼리문을 작성하시오.
*/
-- 문제1
SELECT DEPTNAME, SALARY
FROM DEPARTMENT
WHERE DEPTNAME = (SELECT MAX(E.SALARY)
        FROM DEPARTMENT D INNER JOIN EMPLOYEE E
        ON D.DEPTID = E.DEPTID);

-- 문제2
SELECT E.EMPID, E.EMPNAME, E.SALARY
FROM DEPARTMENT D INNER JOIN EMPLOYEE E
ON D.DEPTID = E.DEPTID
WHERE D.DEPTNAME = '총무부';


/*
9.
다음 칼럼 정보를 참고하여 BOARD_TBL 테이블을 생성하는 쿼리문을 작성하시오. (10점)

<< 칼럼 정보 >>
    1) BOARD_NO : 글번호, 숫자, 필수, 기본키(제약조건이름 : PK_BOARD)
    2) TITLE : 글제목, 가변길이문자열 최대 1000바이트, 필수
    3) CONTENT : 글내용, 가변길이문자열 최대 4000바이트
    4) HIT : 조회수, 숫자
    5) CREATE_DATE : 작성일, 날짜
*/
DROP TABLE BOARD_TBL;
CREATE TABLE BOARD_TBL(
    BOARD_NO NUMBER NOT NULL,
    TITLE VARCHAR2(1000BYTE) NOT NULL,
    CONTENT VARCHAR(4000BYTE),
    HIT NUMBER,
    CREATE_DATE DATE,
    CONSTRAINT PK_BOARD PRIMARY KEY(BOARD_NO)
);



/*
10.
어떤 테이블에 삽입, 수정, 삭제된 행(ROW) 정보를 실제로 DB에 반영하기 위해서 사용하는 쿼리문을 작성하시오. (5점)
*/
INSERT INTO 테이블_이름
[(칼럼1, 칼럼2,...)]
VALUES
(값1,값2,...)

UPDATE 테이블_이름
SET 칼럼1 = 값1,칼럼2 = 값1
[WHERE 조건식]

DELETE
FROM 테이블_이름
[WHERE 조건식]



