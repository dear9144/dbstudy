-- 사원 번호를 전달하면 해당 사원의 이름을 반환하는 함수 만들기.
-- 사용자 정의 함수. 
-- 만드는거 실행하는거 둘다 해야함 8 2 = 10 

CREATE OR REPLACE FUNCTION GET_NAME(EMPNO EMPLOYEE_TBL.EMP_NO%TYPE) -- 이름이 충돌나만 안되니까. 잘보고 하기
RETURN VARCHAR2 -- 리턴타입작성할때 사이즈 안적는다
IS 
    EMPNAME EMPLOYEE_TBL.NAME%TYPE;
BEGIN
    SELECT NAME
      INTO EMPNAME
      FROM EMPLOYEE_TBL
     WHERE EMP_NO = EMPNO;
     RETURN EMPNAME;
END;

--사원명
--구창민 


SELECT GET_NAME(1001) AS 사원명
  FROM EMPLOYEE_TBL 
 WHERE EMP_NO =1001; -- 특정한명만 뽑을때 ''SELECT GET_NAME(1001) AS 사원명
 
SELECT DISTINCT GET_NAME(1001) AS 사원명
  FROM EMPLOYEE_TBL;
 
 
SELECT GET_NAME(EMP_NO) AS 사원명
  FROM EMPLOYEE_TBL;-- 전체 넘기기 
  


  
  
--삽입/수정/삭제하면 메시지를 출력하는 트리거 만들기
SET SERVEROUTPUT ON;

-- 에프터트리거 또는 비포트리거로 만들라는 문제 나옴
CREATE OR REPLACE TRIGGER MY_TRIGGER
    AFTER
    INSERT OR DELETE OR UPDATE --OR로 연결하기 
    ON DEPARTMENT_TBL
    FOR EACH ROW
BEGIN
    DBMS_OUTPUT.PUT_LINE('하하하하하');
END;
    

INSERT INTO DEPARTMENT_TBL(DEPT_NO, DEPT_NAME, LOCATION) VALUES(5, '개발부', '서울');
-- 이건 평가 안됨 트리거만 제출이고. 이문은 트리거 동작을 확인하기위해서 쓴거임.














