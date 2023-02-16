--  내부조인 (PK를 먼저 적는건 성능 때문이다 그게 더 좋음),JOIN작성시에도 PK먼저 
--        ANSI 문법(두 테이블에 일치하는 정보를 조인한다)
--                 1) 표준문법
SELECT E.EMP_NO, E.NAME, D.DEPT_NO, D.DEPT_NAME --어떤 사원이 어떤 부서에서 일하는지 확인 가능 
    FROM DEPARTMENT_TBL D INNER JOIN EMPLOYEE_TBL E
     ON D.DEPT_NO = E.DEPART; --D,E 뒤에오는건 칼럼 이름이고 참조하고 있음 
     

    
--                2)오라클 문법
SELECT E.EMP_NO, E.NAME, D.DEPT_NO, D.DEPT_NAME
  FROM DEPARTMENT_TBL D, EMPLOYEE_TBL E
  WHERE D.DEPT_NO = E.DEPART;
  

--   왼쪽 외부 조인( 왼쪽에 있는 테이블은 일치하는 정보가 없어도 무조건 조인한다)
--1) 표준 문법
SELECT D.DEPT_NO, D.DEPT_NAME, E.EMP_NO, E.NAME
  FROM DEPARTMENT_TBL D LEFT OUTER JOIN EMPLOYEE_TBL E
    ON D.DEPT_NO = E.DEPART; --오른쪽 테이블과 일치하는 정보가 없더라도 LEFT라고 했으니 왼쪽에 있는 테이블은 조회를 해라 
    --일치하는 정보가 없는 3,4도 나오는 것을 볼 수 있음 
    -- 회사에서 외부 조인은 많이 중요할까?

--2) 오라클 문법   
SELECT D.DEPT_NO, D.DEPT_NAME, E.EMP_NO, E.NAME
  FROM DEPARTMENT_TBL D, EMPLOYEE_TBL E
 WHERE D.DEPT_NO = E.DEPART(+); -- 왼쪽 조인을 할거면 오른쪽 조인에 괄호 플러스를 붙여줘라 오른쪽 조인을 할거면 왼쪽에     


--외래키 제약 조건의 비활성화 (일시 중지)
--제약조건이름 : PK_EMP_DEPT
ALTER TABLE EMPLOYEE_TBL
   DISABLE CONSTRAINT FK_EMP_DEPT;
   
-- 외래키 제약 조건이 없는 상태이므로 제약조건을 위배하는 데이터를 입력할 수 있다 
INSERT INTO EMPLOYEE_TBL(EMP_NO,NAME,DEPART,POSITION, GENDER, HIRE_DATE, SALARY) --칼럼이름을 괄호에 써준다 
VALUES(EMPLOYEE_SEQ.NEXTVAL, '김성실',5,'대리', 'F', '98/12/01', 3500000); --값을 넣어준다 오라클에선 날짜 디폴트가 슬래시 (/)   
COMMIT;
--이건 일단 머리속에서 잊기 (선생님께서 따로 찾아보신다고)

--외래키 제약조건을 위반하는 데이터 삭제하기
-- PK를 조건으로 사용하면 인덱스를 타기 때문에 빠르다
DELETE FROM EMPLOYEE_TBL WHERE EMP_NO = 1005; --PK 조건, 인덱스를 타기 때문에 빠르다 
DELETE FROM EMPLOYEE_TBL WHERE NAME = '김성실';--일반 칼럼 , 인덱스를 타지 않는 일반 칼럼은 느리게 동작한다 
COMMIT;
-- 외래키 제약조건의 활성화(다시 시작)
-- 제약 조건 이름 : FK_EMP_DEPT
ALTER TABLE EMPLOYEE_TBL
    ENABLE CONSTRAINT FK_EMP_DEPT;
    

--  오른쪽 외부 조인( 왼쪽에 있는 테이블은 일치하는 정보가 없어도 무조건 조인한다)
--1) 표준 문법
SELECT D.DEPT_NO, D.DEPT_NAME , E.EMP_NO, E.NAME
    FROM DEPARTMENT_TBL D RIGHT OUTER JOIN EMPLOYEE_TBL E
      ON D.DEPT_NO = E.DEPART;
      
--2) 오라클 문법
SELECT D.DEPT_NO, D.DEPT_NAME , E.EMP_NO, E.NAME
    FROM DEPARTMENT_TBL D , EMPLOYEE_TBL E
      WHERE D.DEPT_NO(+) = E.DEPART;
      
      
      
