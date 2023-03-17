-- 전달된 부서번호의 부서를 삭제하는 프로시저를 작성하시오. 
-- 전달된 부서에 근무하는 모든 사원을 함께 삭제하시오.

-- 셤문제 : 테이블 3개를 지우는 문제 나옴. 어떻게 하면 딜리트할수있는지를 보는 문제나옴. 

-- 셤문제 밑에 실행결과 이미지 나올거임

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

--프로시저를 실행하는 구문
EXECUTE DELETE_PROC(1);
