/*
사용자 함수(FUNCTION)
1. 어떤값을 반환할때 사용하는 DB 객체 
2. 실제로 함수를 만들어서 사용하는 개념
3. RETURN 개념이 존재 
4. 함수의 결과 값을 확인할 수 있도록 주로 많이 하는 곳이 SELECT문 
5. 형식
    CREATE [OR REPLACE] FUNCTION 함수명[(매개변수)]
    RETURN 반환타입 
    IS -- AS도 가능하다 (무엇을? 변수선언을)
    BEGIN 
        함수 본문 
    [EXCEPTION 
        예외처리 ] 
        END;
*/


-- 사용자 함수 FUNC1 정의
CREATE OR REPLACE FUNCTION FUNC1
RETURN VARCHAR2 -- 반환타입에서는 크기를 명시하지 않아도 됨 
IS 
BEGIN
    RETURN 'Hello World';
END;

-- 사용자 함수 FUNC1 호출
--FUNC1(); -- 이것만 실행하면 안됨 왜냐면 호출부분이 잘못 만들어졌기때문에 

SELECT FUNC1() FROM DUAL; -- 이렇게 만들어서 호출해야 함 
-- FUNC1은 FROM을 요구하고 HELLOWORLD가 들어간 테이블이 없기 때문에 DUAL 사용 
SELECT CEIL(1.1) FROM DUAL;


-- 사용자 함수 FUNC2 정의
-- 사원번호를 전달하면 해당 사원의 FIRST_NAME을 반환하는 함수

-- 사용자 함수의 파라미터는 IN/OUT 표기가 없다 
-- 입력 파라미터 형식으로 사용된다 
CREATE OR REPLACE FUNCTION FUNC2(EMP_ID EMPLOYEES.EMPLOYEE_ID%TYPE)
RETURN VARCHAR2
IS
    FNAME EMPLOYEES.FIRST_NAME%TYPE;
    LNAME EMPLOYEES.LAST_NAME%TYPE;
BEGIN

    SELECT FIRST_NAME, LAST_NAME
      INTO FNAME, LNAME
      FROM EMPLOYEES
     WHERE EMPLOYEE_ID = EMP_ID;

    RETURN FNAME || ' ' || LNAME;

END;
-- 사용자 함수 FUNC2 호출 

SELECT EMPLOYEE_ID, FUNC2(EMPLOYEE_ID)
  FROM EMPLOYEES;
 
 

-- 사용자 함수FUNC3 정의
-- 사원번호를 전달하면 해당 사원의 연봉이 15000 이상으로 '고액연봉', 아니면 '보통연봉'을 반환하는 함수
/*SELECT FUNC3(100)
  FROM EMPLOYEES
  WHERE EMPLOYEE_ID = (SELECT SALARY    
                        FROM EMPLOYEES
                        WHERE SALARY > (SELECT SALARY
                                        FROM EMPLOYEES
                                        WHERE SALARY = 15000
                                         IF SALARY >= 15000 THEN
                                            MESSAGE := '고액연봉';
                                        ELSE
                                            MESSAGE := '보통연봉';
                                        END IF;
                                        )));
                        */
                        
CREATE OR REPLACE FUNCTION FUNC3(EMP_ID EMPLOYEES.EMPLOYEE_ID%TYPE)
RETURN VARCHAR2
IS
    SAL EMPLOYEES.SALARY%TYPE;
    MESSAGE VARCHAR2(12 BYTE);
BEGIN
    
    SELECT SALARY
      INTO SAL
      FROM EMPLOYEES
     WHERE EMPLOYEE_ID = EMP_ID;
    
    IF SAL >= 15000 THEN
        MESSAGE := '고액연봉';
    ELSE
        MESSAGE := '보통연봉';
    END IF;
    
    RETURN MESSAGE;
    
END;
      




--사용자 함수 FUNC3 호출
SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME , SALARY, FUNC3(EMPLOYEE_ID)
    FROM EMPLOYEES;
    
    
-- 함수 MY_CEIL 정의
CREATE OR REPLACE FUNCTION MY_CEIL(N NUMBER , DEGIT NUMBER)
RETURN NUMBER 
IS 
BEGIN 
    RETURN CEIL(N * POWER(10, DEGIT)) / POWER(10, DEGIT);
END;
--함수 MY_CEIL 호출 
SELECT 
        MY_CEIL(111.111,2) -- 소수2자리 올림 
      , MY_CEIL(111.111,1) -- 소수1자리 올림
      , MY_CEIL(111.111,0) -- 정수로 올림
      , MY_CEIL(111.111,-1) -- 일의자리 올림
      , MY_CEIL(111.111,-2) -- 십의자리 올림
FROM DUAL;
-- 내림
CREATE OR REPLACE FUNCTION MY_FLO(N NUMBER, DEGIT NUMBER)
RETURN NUMBER
IS
BEGIN
    RETURN FLOOR(N * POWER(10, DEGIT)) / POWER(10, DEGIT);
    END;
    
-- 호출 
SELECT
      MY_FLO(111.111,2)
     ,MY_FLO(111.111,1)
     ,MY_FLO(111.111,0)
     ,MY_FLO(111.111,-1)
     ,MY_FLO(111.111,-2)
FROM DUAL;



    
