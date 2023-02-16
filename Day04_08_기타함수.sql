-- 기타 함수 



--1. 순위 구하기
--      1) RANK() OVER(ORDER BY 순위구할칼럼 ASC) : 오름차순 순위 - 낮아야 1등 EX. 스포츠 등수 같은 
--      2) RANK() OVER(ORDER BY 순위구할칼럼 DESC) : 내림차순 순위 - 높은 값이 1등 
--      3) 동점자는 같은 등수로 처리 EX. 5명 중 3등이 2명 1,2,3,3,5 이런 식 
--      4) 순위 순으로 정렬된 상태로 조회 

SELECT 
        EMPLOYEE_ID
    ,   FIST_NAME || ' ' || LAST_NAME AS NAME -- ||  ' ' || 는 연결할때 쓰는데 이 상황의 경우 공백을 연결하려고 사용 
    ,   SALARY 
    ,   RANK() OVER(ORDER BY SALARY DESC) AS 연봉순위 
    FROM 
        EMPLOYEES;
        

--2. 분기 처리하기 
-- 1) DECODE(표현식 
--      , 값1, 결과1
--      , 값2, 결과2
--      , ...)      -계속된다 
--  표현식=값1이면 결과 1을 반환, 표현식=값2이면 결과2를 반환, ...
--  표현식과 값의 동등 비교(=)만 가능하다. [크다,작다 안됨]

SELECT
        EMPLOYEE_ID
     ,  FIRST_NAME
     ,  LAST_NAME
     ,  DEPARTMENT_ID
     ,  DECODE(DEPARTMENT_ID
          , 10, 'Administration' --디파트먼트아이디가 10이면 Administration다 
          , 20, 'Marceting' 
          , 30, 'Purchasing'
          , 40, 'Human Resources'
          , 50, 'Shipping'
          , 60, 'IT') AS DEPARTMENT_NAME
    FROM
        EMPLOYEES
    WHERE
        DEPARTMENT_ID IN(10,20,30,40,50,60);
        

--분기 표현식
--CASE
--      WHEN 조건식1 THEN 결과값1
--      WHEN 조건식2 THEN 결과값2
--      ...
--      ELSE 결과값N
-- END

SELECT
        EMPLOYEE_ID
     ,  FIRST_NAME
     ,  LAST_NAME
     ,  SALARY
     ,  CASE 
             WHEN SALARY >= 15000 THEN 'A'
             WHEN SALARY >= 10000 THEN 'B'
             WHEN SALARY >= 5000  THEN 'C'
             ELSE 'D'
        END AS GRADE
    FROM
        EMPLOYEES;
        
--3. 행 번호 반환하기 RANK랑 똑같지만 행 번호 반환하는 걸 더 잘 사용해야 한다 
--      ROW_NUMBER() OVER(ORDER BY 칼럼 ASC|DESC) : ASC DESC 둘 중 하나
--      정렬한 결과에 행 번호를 추가해서 반환하는 함수 
SELECT
        ROW_NUMBER() OVER(ORDER BY SALARY DESC) AS 행번호 
    ,   EMPLOYEE_ID
    ,   FIRST_NAME
    ,   LAST_NAME
    ,   SALARY
  FROM 
        EMPLOYEES;
        
-- 결과에서 RANK와 다른 점은 17000의 샐러리가 둘다 2였음 지금은 2,3으로 나눔 
-- 언제 쓰이나요?