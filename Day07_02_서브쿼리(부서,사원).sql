/*
    서브쿼리(Sub Query)
    1. 메인 쿼리에(SELECT) 포함하는 하위쿼리를(SELECT) 의미한다  
    2. 일반적으로 하위쿼리는 괄호()로 묶어서 메인쿼리에 포함한다 
    3. 하위쿼리가 항상 메인쿼리보다 먼저 실행된다.
*/

/*
    서브쿼리가 포함되는 위치
    1. SELECT절 : 스칼라 서브쿼리
    2. FROM절   : 인라인 뷰
    3. WHERE절  : 서브쿼리 

*/

/*
    서브쿼리의 실행 결과에 의한 구분 
    1. 단일 행 서브쿼리(SINGLE ROW QURY) 
        1) 결과 행이 1개이다 
            - 당장은 결과가 1개더라도 차후 결과가 다중으로 나올 수 있다
            EX. 학생의 이름이 지금은 1개더라도 나중에 같은 이름의 사람이 생길 수 있으니까 이름을 사용해선 안된다
        2)단일 행 서브쿼리인 대표적인 경우 
             (1) WHERE절에서 사용한 동등비교(=) 칼럼이 PK, 또는 UNIQUE 칼럼인 경우 (중복이 없다)
             (2) 집계함수처럼 결과가 1개의 값을 반환하는 경우 (SUM그런 애들) 
        3) 단일 행 서브쿼리에서 사용하는 연산자
           단일 행 연산자를 사용(=,!=,>,>=,<,<=)
    2. 다중 행 서브쿼리 
             1) 결과 행이 1개 이상이다
             2) FROM절, WHERE절에서 많이 사용된다. 
             3) 다중 행 서브쿼리에서 사용하는 연산자
                다중 행 연산자를 사용(IN ANY ALL등) - IN을 가장 많이 쓴다 
*/

--WRERE 절의 서브쿼리 
--1. 사원번호가 1001인 사원과 동일한 직급(POSITION)을 가진 사원을 조회하시오 

SELECT 사원정보
    FROM 사원테이블 
    WHERE 직급 = (사원번호가 1001인 사원의 직급)
   

SELECT EMP_NO, NAME,DEPART, GENDER, POSITION, HIRE_DATE, SALARY
     FROM EMPLOYEE_TBL
     WHERE POSITION = (SELECT POSITION 
                        FROM EMPLOYEE_TBL 
                      WHERE EMP_NO = 1001);

--2. 부서번호가 2인 부서와 동일한 지역에 있는 부서를 조회하시오 
SELECT 부서정보
    FROM 부서
    WHERE 지역 = (부서번호가 2인 부서의 지역) 
    
SELECT DEPT_NO, DEPT_NAME, LOCATION
    FROM DEPARTMENT_TBL
    WHERE LOCATION = (SELECT LOCATION
                       FROM DEPARTMENT_TBL
                       WHERE DEPT_NO = 2);


--3 가장 높은 급여를 받는 사원을 조회하시오
SELECT 사원정보
    FROM 사원
    WHERE 급여 = (가장높은 급여)
    
SELECT EMP_NO, NAME, SALARY
    FROM EMPLOYEE_TBL
    WHERE SALARY = (SELECT MAX(SALARY)
                    FROM EMPLOYEE_TBL
                     );
--4 평균 급여 이상을 받는 사원을 조회하시오
SELECT 사원정보
    FROM 사원
    WHERE 급여 = (평균 급여 이상)
    
SELECT EMP_NO,NAME, SALARY
    FROM EMPLOYEE_TBL
    WHERE SALARY > (SELECT AVG(SALARY)
                    FROM EMPLOYEE_TBL);

--5 평균 근속 개월 수 이상을 근무한 사원을 조회하시오
SELECT 사원정보
    FROM HIRE_DATE
    WHERE  = (평균 근속 개월수 이상근무)
    
SELECT EMP_NO, NAME, HIRE_DATE
    FROM EMPLOYEE_TBL
    WHERE MONTHS_BETWEEN(SYSDATE, HIRE_DATE)>= (SELECT AVG(MONTHS_BETWEEN(SYSDATE, HIRE_DATE))-- (SYSDATE, HIRE_DATE): 근속 개월수
                    FROM EMPLOYEE_TBL);
                    
--6. 부서번호가 2인 부서에 근무하는 사원들의 직급과 일치하는 사원을 조회하시오 
SELECT 사원정보
    FROM 사원
    WHERE 직급 IN (부서번호가 2인 부서에 근무하는 사원들의 직급) 


SELECT EMP_NO, NAME,  SALARY ,POSITION, HIRE_DATE
    FROM EMPLOYEE_TBL
    WHERE POSITION IN (SELECT POSITION
                       FROM EMPLOYEE_TBL
                       WHERE DEPART = 2);
                   --------------------------------------    
                   = ('부장','과장'); -- (=)을쓰면 인 격이라 XXX
                   
                       --WHERE 절에서 사용한 칼럼이 PK나UNIQUE 칼럼이 아니므로 다중 행 서브쿼리이다 
                       --따라서 단일행 연산자 등호(=) 대신 다중 행 연산자(IN)을 사용해야 한다 

--7. 부서명이 '영업부'인 부서에 근무하는 사원을 조회하시오 
--서브쿼리로 잘 안되면 JOIN으로 풀어봐라
SELECT 사원정보
    FROM 사원
    WHERE 

--내가 한거
SELECT D.DEPT_NO , D.DEPT_NAME ,E.DEPART ,NAME
    FROM DEPARTMENT_TBL D RIGHT OUTER JOIN EMPLOYEE_TBL E
    ON E.DEPART = D.DEPT_NO WHERE DEPT_NAME IN (SELECT DEPT_NAME
                        FROM DEPARTMENT_TBL
                        WHERE DEPT_NAME = '영업부');
                        
--선생님이 하신거
SELECT EMP_NO , DEPART ,NAME
    FROM EMPLOYEE_TBL 
    WHERE DEPART IN (SELECT DEPT_NO
                        FROM DEPARTMENT_TBL
                        WHERE DEPT_NAME = '영업부');
                        --서브쿼리의 WHERE절에서 사용한 DEPART_NAME 칼럼은 PK/UNIQUE가 아니므로 다중 행으로 보는게 맞다
 
 
--8. 직급이 '과장'인 사원읃ㄹ이 근무하는 부서 정보를 조회하시오 
SELECT 부서정보
    FROM 부서
    WHERE 
--내가한거   
SELECT DEPT_NAME ,DEPT_NO , LOCATION
    FROM DEPARTMENT_TBL
    WHERE DEPT_NAME IN (SELECT NAME
                        FROM EMPLOYEE_TBL
                        WHERE POSITION = '과장');

-- 이건 틀린거                         
SELECT DEPT_NAME ,DEPT_NO , LOCATION
    FROM DEPARTMENT_TBL
    WHERE DEPT_NO = (SELECT DEPART
                        FROM EMPLOYEE_TBL
                        WHERE POSITION = '과장');
--맞는거 
SELECT DEPT_NAME ,DEPT_NO , LOCATION
    FROM DEPARTMENT_TBL
    WHERE DEPT_NO IN (SELECT DEPART
                        FROM EMPLOYEE_TBL
                        WHERE POSITION = '과장');

--9 영업부에서 가장 높은 급여보다 더 높은 급여를 받는 사원을 조회하시오 
SELECT NAME, POSITION , EMP_NO 
    FROM EMPLOYEE_TBL
    WHERE SALARY > (SELECT MAX(SALARY)
                      FROM EMPLOYEE_TBL
                      WHERE DEPART IN (SELECT DEPT_NO
                                        FROM DEPARTMENT_TBL
                                        WHERE DEPT_NAME = '영업부'));

SELECT NAME, POSITION , EMP_NO 
    FROM EMPLOYEE_TBL
    WHERE SALARY > (SELECT MAX(E.SALARY)
                    FROM DEPARTMENT_TBL D INNER JOIN EMPLOYEE_TBL E
                    ON D.DEPT_NO = E.DEPART
                    WHERE D.DEPT_NAME = '영업부');
                        
--SELECT 절의 서브쿼리


/*
    인라인 뷰(Inline View)
    SELECT의 결과는 TABLE이다 
    SELECT COLUMN
    FROM TABLE
    
    WRERE은 조건식을 써야 하니까 연산자 필요 (크기 비교를 해야하니까) 연산자를 쓰려면 다중행인지 단일행인지 중요하다
    다만, FROM은 원래 테이블이 나오는 곳이기 때문에 어떤 SELECT를 돌리든 TABLE이 나옴 
    ------------------
    SELECT COLUMN
    FROM(SELECT...)
    
    1. 쿼리문에 포함된 뷰(가상 테이블)이다 
    2. FROM절에 포함되는 서브쿼리를 의미한다.
    3. 단일행 /다중행 개념이 필요 없다
    4. 인라인 뷰를 쓸때 인라인(FROM절을 대신하는)뷰에 포함된 칼럼만 메인쿼리에서 사용할 수 있다.(하위쿼리)
    5. 인라인 뷰를 이용해서 SELECT문의 실행 순서를 조정할 수 있다.  
*/

/*
    가상 칼럼
    1. PSEUDO COLUMN(P는 묵음)
    2. 존재하지만 저장되어있지 않은 칼럼을 의미 
    3. 사용할 수 있지만 일부 제약이 있다 
    4. 종류
        1) ROWID : 행 (ROW) 아이디, 어떤 행이 어디에 저장되어 있는지 알고 있는 칼럼(물리적 저장위치)
        2) ROWNUM : 행(ROW) 번호, 어떤 행의 순번
        
*/

--ROWID
SELECT ROWID, EMP_NO, NAME
  FROM EMPLOYEE_TBL; -- 어디에 가면 저 데이터를 찾을 수 있어요 라는 뜻 사람으로 치자면 집주소 
  -- 데이터베이스에서 가장 빠른 검색 , ROWID 검색
  -- 실무에선 사용이 불가능하기 때문에 대신 인덱스(INDEX)를 활용하는 것 
SELECT ROWID, EMP_NO, NAME
  FROM EMPLOYEE_TBL
 WHERE ROWID = 'AAAFExAABAAALDJAAA'; --ROWID 검색, 

--ROWNUM 가상칼럼이기 때문에 일부 제약이 있을 수 있다 
/*
  제약상황
  1. ROWNUM이 1을 포함하는 범위를 조건으로 사용할 수 있다.
  2. ROWNUM이 1을 포함하지 않는 범위를 조건으로 사용할 수 없다.
  3. 모든 ROWNUM을 사용하려면 ROWNUM에 별명을 지정하는 것 (ROWNUM이 1을 포함하지 않는 범위를 못 쓸때 별명을 지정하면 쓸 수 있다는 말이다)
*/

SELECT EMP_NO, NAME
  FROM EMPLOYEE_TBL
  WHERE ROWNUM = 1; 
--1행의 데이터를 보여달라 
-- ROWNUM이 1을 포함한 범위가 사용되므로 가능 
SELECT EMP_NO, NAME
  FROM EMPLOYEE_TBL
  WHERE ROWNUM <= 2;
-- ROWNUM이 1을 포함한 범위가 사용되므로 가능 
SELECT EMP_NO, NAME
  FROM EMPLOYEE_TBL
  WHERE ROWNUM = 2;
-- ROWNUM이 1을 포함한 범위가 아니므로 불가능하다 
SELECT \EMP_NO, NAME, 
  FROM EMPLOYEE_TBL
  ROWNUM AS RN
  WHERE RN = 2; -- 실행순서가 안 맞기 때문에 별명을 사용할 수 없는 거다 
                -- 별명 지정을 WHERE보다 먼저 처리하면 된다
                -- 별명을 지정하는 인라인 뷰를 이용하면 가장 먼저 별명이 지정되므로 해결된다.
                
SELECT E.EMP_NO, E.NAME
  FROM (SELECT ROWNUM AS RN
        , EMP_NO
        , NAME
        FROM
        EMPLOYEE_TBL) E
  WHERE E.RN =2;




-- FROM절의 서브쿼리 
SELECT E.EMP_NO, E.NAME, E.DEPART
    FROM (SELECT EMP_NO, NAME, DEPART
           FROM EMPLOYEE_TBL
           ORDER BY EMP_NO) E;
           
           
--연봉이 2번째로 높은 사원을 조회하라 (1,2,3,4,다 된다는 소리)
--1) 연봉순으로 정렬한다
--2) 정렬결과에 행 번호(ROWNUM)을 붙인다
--3) 원하는 행 번호를 조회한다.


--[많이 연습해보길 바람]
SELECT E.EMP_NO, E.NAME,E.DEPART, E.GENDER, E.POSITION, E.HIRE_DATE, E.SALARY
    FROM(SELECT ROWNUM AS RN, A.EMP_NO, A.NAME,A.DEPART, A.GENDER, A.POSITION, A.HIRE_DATE, A.SALARY
          FROM (SELECT EMP_NO, NAME,DEPART, GENDER, POSITION, HIRE_DATE, SALARY
            FROM EMPLOYEE_TBL L
          ORDER BY SALARY DESC)A) E --연봉순으로 줄을 세웠다
    WHERE E.RN = 2; --
        
--2. 3~4번째로 입사한 사원을 조회하시오 
SELECT E.EMP_NO, E.NAME,E.DEPART, E.GENDER, E.POSITION, E.HIRE_DATE, E.SALARY
    FROM(SELECT ROWNUM AS RN, A.EMP_NO, A.NAME,A.DEPART, A.GENDER, A.POSITION, A.HIRE_DATE, A.SALARY
          FROM (SELECT EMP_NO, NAME,DEPART, GENDER, POSITION, HIRE_DATE, SALARY
            FROM EMPLOYEE_TBL L
          ORDER BY HIRE_DATE ASC)A) E --연봉순으로 줄을 세웠다
    WHERE E.RN = 3 OR E.RN = 4; 
    
    혹은 WHERE E.RN BETWEEN 3 AND 4
         WHERE E.RN IN(3,4)
         
         
--2) ROW_NUMBER() 함수 사용하기 
SELECT E.EMP_NO, E.NAME,E.DEPART, E.GENDER, E.POSITION, E.HIRE_DATE, E.SALARY
    FROM(SELECT ROW_NUMBER() OVER(ORDER BY SALARY DESC) AS RN, EMP_NO, NAME,DEPART, GENDER, POSITION, HIRE_DATE, SALARY
          FROM EMPLOYEE_TBL) E --연봉순으로 줄을 세웠다
    WHERE E.RN = 3; 
    
    
SELECT E.EMP_NO, E.NAME,E.DEPART, E.GENDER, E.POSITION, E.HIRE_DATE, E.SALARY
    FROM(SELECT ROW_NUMBER() OVER(ORDER BY SALARY DESC) AS RN, EMP_NO, NAME,DEPART, GENDER, POSITION, HIRE_DATE, SALARY
            FROM EMPLOYEE_TBL) E  --연봉순으로 줄을 세웠다
    WHERE E.RN = 3 OR E.RN = 4; 
    


--부서번호가 1인 부서에 근무하는 사원번호, 사원명,부서번호,부서명을 조회하시오 

--상관 커리
--메인 커리에 영향을 받아서 서브쿼리가 달라지는 것
--조인으로도 해결 가능 

/*
스칼라 서브쿼리
SELECT절에서 하나의 값을 반환하는 서브쿼리 
일치하지 않는 정보는 NULL값을 반환합니다 
유사한 방식의 조인은 외부조인입니다 

*/

SELECT 
        E.EMP_NO 
     ,  E.NAME
     , E.DEPART
     , (SELECT D.DEPT_NAME
        FROM DEPARTMENT_TBL D
        WHERE DEPT_NO = E.DEPART
        AND D.DEPT_NO = 1) -- 서브쿼리를 스칼라 서브쿼리라고도 부름 
     
  FROM
        EMPLOYEE_TBL E;
--조인으로 풀어보기         
SELECT E.EMP_NO,E.NAME,D.DEPT_NAME
FROM DEPARTMENT_TBL D RIGHT OUTER JOIN EMPLOYEE_TBL E
ON D.DEPT_NO = E.DEPART AND D.DEPT_NO = 1;

SELECT (SELECT COUNT(*) FROM EMPLOYEE_TBL)
 FROM DUAL;
 
 
/*
뷰(VIEW)
테이블이나 뷰를 이용해서 만들어 낸 가상 테이블
쿼리문 자체를 저장하고 있다 
자주 사용하는 복잡한 쿼리문이 있다면 뷰로 만들어 두고 편하게 호출한다
뷰로인한 성능상의 이점은 없다 (사용자를 위한 기능이다)
*/

-- 뷰 만들기
CREATE VIEW VIEW_EMP
AS (SELECT E.EMP_NO, E.NAME, E.DEPART, D.DEPT_NAME, E.GENDER, E.POSITION, E.HIRE_DATE, E.SALARY
    FROM DEPARTMENT_TBL D INNER JOIN EMPLOYEE_TBL E
    ON D.DEPT_NO = E.DEPART); --이너조인 결과를 뷰로 만듬 (뷰 호출로 이너조인을 끝낼 수 있다)

DESCRIBE VIEW_EMP;
    
-- 뷰 조회하기
SELECT EMP_NO, NAME, DEPT_NAME 
 FROM VIEW_EMP
 WHERE DEPART = 1;       

--뷰 삭제하기
DROP VIEW VIEW_EMP;

-- 뷰는 안 써도 됨 참고용으로 알아둘 것 
-- Day08_02_뷰 로 저장     







