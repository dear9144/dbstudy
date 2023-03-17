-- 테이블 삭제
DROP TABLE STUDENT;
DROP TABLE DEPARTMENT;
DROP TABLE PROFESSOR;

-- 교수 테이블
CREATE TABLE PROFESSOR(
    PROFNO   NUMBER(4)          NOT NULL,
    PNAME     VARCHAR2(10 BYTE),
    USERID   VARCHAR2(10 BYTE),
    POSITION VARCHAR2(20 BYTE),
    SAL      NUMBER(10),
    HIREDATE DATE,
    COMM     NUMBER(2)
);

ALTER TABLE PROFESSOR 
    ADD CONSTRAINT PK_PROFESSOR PRIMARY KEY(PROFNO);

INSERT INTO PROFESSOR VALUES(9901, '김도훈', 'capool', '교수', 500, TO_DATE('24-01-1982','DD-MM-YYYY'), 20);
INSERT INTO PROFESSOR VALUES(9902, '이재우', 'sweat3', '조교수', 320, TO_DATE('12-04-1995','DD-MM-YYYY'), NULL);
INSERT INTO PROFESSOR VALUES(9903, '성연희', 'pascal', '조교수', 360, TO_DATE('17-05-1993','DD-MM-YYYY'), 15);
INSERT INTO PROFESSOR VALUES(9904, '염일웅', 'blue77', '전임강사', 240, TO_DATE('02-12-1998','DD-MM-YYYY'), NULL);
INSERT INTO PROFESSOR VALUES(9905, '권혁일', 'reload', '교수', 450, TO_DATE('08-01-1986','DD-MM-YYYY'), 25);
INSERT INTO PROFESSOR VALUES(9906, '이만식', 'pocari', '부교수', 420, TO_DATE('13-09-1988','DD-MM-YYYY'), NULL);
INSERT INTO PROFESSOR VALUES(9907, '전은지', 'totoro', '전임강사', 210, TO_DATE('01-06-2001','DD-MM-YYYY'), NULL);
INSERT INTO PROFESSOR VALUES(9908, '남은혁', 'bird13', '부교수', 400, TO_DATE('18-11-1990','DD-MM-YYYY'), 17);
COMMIT;

-- 학과 테이블
CREATE TABLE DEPARTMENT(
    DEPTNO  NUMBER(4)          NOT NULL,
    DNAME   VARCHAR2(30 BYTE),
    PROFNO  NUMBER(4),
    LOC     VARCHAR2(10 BYTE)
);

ALTER TABLE DEPARTMENT 
    ADD CONSTRAINT PK_DEPARTMENT PRIMARY KEY(DEPTNO);

ALTER TABLE DEPARTMENT
    ADD CONSTRAINT FK_DEPARTMENT_PROFESSOR FOREIGN KEY(PROFNO)
        REFERENCES PROFESSOR(PROFNO);

INSERT INTO DEPARTMENT VALUES(101, '컴퓨터공학과', 9901, '1호관');
INSERT INTO DEPARTMENT VALUES(102, '멀티미디어학과', 9902, '2호관');
INSERT INTO DEPARTMENT VALUES(201, '전자공학과', 9903, '3호관');
INSERT INTO DEPARTMENT VALUES(202, '기계공학과', 9904, '4호관');
INSERT INTO DEPARTMENT VALUES(100, '정보미디어학과', 9905, '5호관');
INSERT INTO DEPARTMENT VALUES(200, '메카트로닉스학과', 9906, '6호관');
INSERT INTO DEPARTMENT VALUES(300, '빅데이터학과', 9907, '7호관');
INSERT INTO DEPARTMENT VALUES(400, '응용소프트웨어학과', 9908, '8호관');
COMMIT;

-- 학생 테이블
CREATE TABLE STUDENT(
    STUDNO    NUMBER(5)          NOT NULL,
    SNAME      VARCHAR2(20 BYTE),
    USERID    VARCHAR2(10 BYTE),
    GRADE     VARCHAR2(1 BYTE),
    IDNUM     VARCHAR2(13 BYTE),
    BIRTHDATE DATE,
    TEL       VARCHAR2(13 BYTE),
    HEIGHT    NUMBER(5,2),
    WEIGHT    NUMBER(5,2),
    DEPTNO    NUMBER(4)
);

ALTER TABLE STUDENT
    ADD CONSTRAINT PK_STUDENT PRIMARY KEY(STUDNO);

ALTER TABLE STUDENT
    ADD CONSTRAINT FK_STUDENT_DEPARTMENT FOREIGN KEY(DEPTNO)
        REFERENCES DEPARTMENT(DEPTNO);

INSERT INTO STUDENT VALUES(10101, '전인하', 'jun123', '4', '7907021369824', TO_DATE('02-01-1979','DD-MM-YYYY'), '051)781-2158', 176, 72, 101);
INSERT INTO STUDENT VALUES(20101, '이동훈', 'dals', '1', '8312101128467', TO_DATE('10-12-1983','DD-MM-YYYY'), '055)426-1752', 172, 64, 201);
INSERT INTO STUDENT VALUES(10102, '박미경', 'ansel', '1', '8405162123648', TO_DATE('16-05-1984','DD-MM-YYYY'), '055)261-8947', 168, 52, 101);
INSERT INTO STUDENT VALUES(10103, '김영균', 'mandu', '3', '8103211063421', TO_DATE('11-01-1981','DD-MM-YYYY'), '051)824-9637', 170, 88 ,101);
INSERT INTO STUDENT VALUES(20102, '박동진', 'ping', '1', '8511241639826', TO_DATE('24-11-1985','DD-MM-YYYY'), '051)742-6384', 182, 70, 201);
INSERT INTO STUDENT VALUES(10201, '김진영', 'simply', '2', '8206062186327', TO_DATE('06-06-1982','DD-MM-YYYY'), '055)419-6328', 164, 48, 102);
INSERT INTO STUDENT VALUES(10104, '지은경', 'gomodo', '2', '8004122298371', TO_DATE('12-04-1980','DD-MM-YYYY'), '055)418-9627', 161, 42, 101);
INSERT INTO STUDENT VALUES(10202, '오유석', 'yousuk', '4', '7709121128379', TO_DATE('12-10-1977','DD-MM-YYYY'), '051)724-9618', 177, 92, 102);
INSERT INTO STUDENT VALUES(10203, '하나리', 'hansol', '1', '8501092378641', TO_DATE('18-12-1984','DD-MM-YYYY'), '055)296-3784', 160, 68, 102);
INSERT INTO STUDENT VALUES(10105, '임유진', 'youjin12', '2', '8301212196482', TO_DATE('21-01-1983','DD-MM-YYYY'), '02)312-9838', 171, 54, 101);
INSERT INTO STUDENT VALUES(10106, '서재진', 'seolly', '1', '8511291186273', TO_DATE('29-11-1985','DD-MM-YYYY'), '051)239-4861', 186, 72, 101);
INSERT INTO STUDENT VALUES(10204, '윤진욱', 'samba7', '3', '7904021358671', TO_DATE('02-04-1979','DD-MM-YYYY'), '053)487-2698', 171, 70, 102);
INSERT INTO STUDENT VALUES(10107, '이광훈', 'huriky', '4', '8109131276431', TO_DATE('13-10-1981','DD-MM-YYYY'), '055)736-4981', 175, 92, 101);
INSERT INTO STUDENT VALUES(20103, '김진경', 'lovely', '2', '8302282169387', TO_DATE('28-02-1983','DD-MM-YYYY'), '052)175-3941', 166, 51, 201);
INSERT INTO STUDENT VALUES(20104, '조명훈', 'rader214', '1', '8412141254963', TO_DATE('16-09-1984','DD-MM-YYYY'), '02)785-6984', 184, 62, 201);
INSERT INTO STUDENT VALUES(10108, '류민정', 'cleansky', '2', '8108192157498', TO_DATE('19-08-1981','DD-MM-YYYY'), '055)248-3679', 162, 72, 101);
COMMIT;

SET SERVEROUTPUT ON;

/*
1.
학생(STUDENT) 테이블의 생일(BIRTHDATE) 칼럼은 현재 'YY/MM/DD' 형식으로 저장되어 있다.
생일(BIRTHDATE) 칼럼 데이터를 'YYYY-MM-DD' 형식으로 조회하는 쿼리문을 작성하시오. (5점)
*/

SELECT BIRTHDATE
FROM STUDENT




/*
2.
교수(PROFESSOR) 테이블의 고용일(HIREDATE) 칼럼을 이용하여 현재까지 근무한 일수를 조회하는 쿼리문을 작성하시오.
결과는 정수로 내림 또는 절사(소수점 잘라 버리기)하여 표시하시오. (5점)
*/
SELECT HIREDATE
FROM PROFESSOR
WHERE TO_DATE(HIREDATE, 'YY/MM/DD') BETWEEN TO_DATE('82/01/24','YY/MM/DD') AND TO_DATE('99/06/01','YY/MM/DD');


/*
3.
학생(STUDENT) 테이블의 키(HEIGHT) 칼럼의 데이터 중에서 가장 높은 키를 조회하는 쿼리문을 작성하시오. (5점)
*/
SELECT HEIGHT  
FROM STUDENT
WHERE HEIGHT = (SELECT MAX(HEIGHT)
                FROM STUDENT);


/*
4.
학생(STUDENT) 테이블에 있는 전체 학생수를 조회하는 쿼리문을 작성하시오. (5점)
*/
SELECT COUNT(*) FROM STUDENT;

/*
5.
오라클 데이터베이스에 이미 설치되어 있는 스키마(사용자) HR계정을 사용하기 위해서 HR계정의 LOCK을 풀고 새로운 비밀번호 '123456'을 지정하는 쿼리문을 작성하시오.
HR계정의 LOCK을 푸는 쿼리문과 HR계정에 새로운 비밀번호를 지정하는 쿼리문을 각각 작성하시오.
작성한 쿼리문을 실행하지는 마시오. (5점)
*/
ALTER USER HR ACCOUNT UNLOCK;
ALTER USER HR IDENTIFIED BY 123456;


/*
6.
다음 사용자를 생성하는 쿼리문과 생성된 사용자에 권한을 부여하는 쿼리문을 각각 작성하시오.
작성한 쿼리문을 실행하지는 마시오. (5점)
    1) 사용자명 : WEBMASTER
    2) 비밀번호 : 1111
    3) 사용권한 : CONNECT, RESOURCE
*/
DROP USER WEBMASTER CASCADE;
CREATE USER WEBMASTER IDENTIFIED BY 1111;
GRANT CONNECT, RESOURCE TO GDJ61;



/*
7.
모든 학생의 학생명, 학과명, 담당교수명을 조회하시오. (10점)

*/
SELECT  D.DNAME, 
FROM DEPARTMENT D INNER JOIN STUDENT S
WHERE 

SELECT S.SNAME,  D.DNAME, P.PNAME
FROM PROFESSOR P INNER JOIN DEPARTMENT D
ON P.PROFNO = D.PROFNO INNER JOIN STUDENT S
ON D.DEPTNO = S.DEPTNO;

/*
8.
모든 학과의 학과별 학생수를 조회하시오. 소속 학생이 없으면 0으로 조회하시오. (10점)
*/
SELECT DNAME , COUNT(*) AS 학과
FROM
STUDENT
WHERE
DNAME IS NOT NULL
GROUP BY
DNAME;






/*
9.
모든 교수들의 연봉순위, 교수명, 연봉을 조회하시오. 연봉순으로 조회하시오. (10점)
*/
SELECT PNAME, SAL,
    RANK() OVER(ORDER BY SAL DESC) AS 연봉순위 
  FROM PROFESSOR;


/*
10.
학년별 평균키와 평균몸무게를 조회하시오. 학년을 기준으로 오름차순 정렬하고, 평균키와 평균몸무게는 모두 소수점 1자리만 남기고 반올림하시오. (10점)
*/
SELECT HEIGHT, GRADE  
FROM STUDENT
WHERE HEIGHT = (SELECT AVG(HEIGHT)
                FROM STUDENT);



/*
11.
다음 설명을 읽고 올바른 사용자 함수를 작업하시오.
    1) 학생(STUDENT) 테이블에서 학생의 아이디(USERID)를 전달하면 해당 아이디를 가진 학생의 학번(STUDNO)을 반환하는 GET_STUDENT() 사용자 함수를 작성하시오. (8점)
    2) 아이디가 'jun123'인 학생의 학번을 조회하는 쿼리문을 작성하시오. (2점)
*/



/*
12.
학생(STUDENT) 테이블의 어떤 행(Row)을 삭제(DELETE)하거나 수정(UPDATE)하면 '학생 데이터가 삭제되거나 수정되었습니다.'라는 서버메시지가 나타나는 STUD_TRIG 트리거를 작성하시오.
AFTER 트리거로 작성하시오. (10점)
(참고. 서버메시지의 확인이 안 되는 경우에는 SET SERVEROUTPUT ON 명령을 실행하시오.)
*/
CREATE OR REPLACE FUNCTION DELETE_ROW(DEL_ROW STUDENT.STUDNO%TYPE) -- 이름이 충돌나만 안되니까. 잘보고 하기
RETURN VARCHAR2 -- 리턴타입작성할때 사이즈 안적는다
IS 
    NEWID STUDENT.STUDNO%TYPE;
BEGIN
     SELECT DEPTNO
        INTO NEWID
        FROM STUDENT
        WHERE STUDNO = DEL_ROW;
        RETURN NEWID;
        END;

SET SERVEROUTPUT ON;

CREATE OR REPLACE TRIGGER ST_TRIGGER
    AFTER
    INSERT OR DELETE OR UPDATE --OR로 연결하기 
    ON DEPARTMENT
    FOR EACH ROW
BEGIN
    DBMS_OUTPUT.PUT_LINE('학생 데이터가 삭제되거나 수정되었습니다.');
END;



/*
13. 
학과번호를 전달하면 해당 학과에 소속된 학생, 교수, 학과를 모두 삭제하는 MY_PROC 프로시저를 작성하시오.
예외가 발생할 경우를 대비해 예외코드와 예외메시지를 출력할 수 있도록 프로시저를 작성하시오.
프로시저가 정상 동작하면 COMMIT, 예외가 발생하면 ROLLBACK 처리하시오.
   1) 프로시저를 작성하시오. (8점)
   2) 학과번호가 101인 학과를 대상으로 프로시저 실행 방법을 작성하시오. (2점)
*/

CREATE OR REPLACE PROCEDURE DELETE_PROC(DEPTNO IN DEPARTMENT_TBL.DEPT_NO%TYPE) -- 셤문제 아웃은 안나옴 
IS -- 혹 변수가 필요하면 is밑에다가 선언하고 사용하면 됨. 
BEGIN
    DELETE-- 사원부터 지워야한다. 포린키부터 지워야해 . 그래서 사원에서 부서 순서로 지워야해 . 딜리트순서잘못잡으면 익셉션으로떨어지고 지워지는거아무것도 없음.
      FROM EMPLOYEE_TBL
     WHERE DEPART = DEPTNO;
    DELETE
      FROM DEPARTMENT_TBL
     WHERE DEPT_NO = DEPTNO;
    COMMIT; -- 딜리트마다 붙여놔도 되는데 한번만해도됨. 
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(SQLCODE); -- 예외코드 
        DBMS_OUTPUT.PUT_LINE(SQLERRM); -- 예외코드 
        ROLLBACK;                      --예외가 발생했을때.
END;

