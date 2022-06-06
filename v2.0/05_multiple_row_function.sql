-- 2) 다중행 함수 (multiple-row function)
-- : 여러 행 (입력)을 바탕으로 하나의 결과 (출력)값을 도출하는 함수
-- EX) AVG(), SUM(), COUNT(), MIN(), MAX()

-- (**) 데이터 중에 NULL값이 있으면 NULL 제외하고 계산
SELECT MAX(COMM) FROM EMP;
SELECT MIN(COMM) FROM EMP;

-- (**) 데이터 안에 중복 허용
SELECT COUNT(MGR), COUNT(ALL MGR) FROM EMP; 
-- MGR이 NULL인 값을 제외하고 COUNT 계산
-- COUNT(MGR) = COUNT(ALL MGR)

-- 만약 데이터 안에 중복을 제거하고 싶다면 ??
SELECT COUNT(DISTINCT MGR) FROM EMP;

-- 만약 EMP 테이블의 사원 수  (행 개수)가 궁금하면 ??
SELECT COUNT(*) FROM EMP;
SELECT COUNT(ENAME) FROM EMP; 
-- ENAME NULL값을 허용하는 열이기 때문에 사원 수를 확인하기에는 어려움이 있을 수 있음
-- (*) COUNT 하려고 하는 열에 NULL이 있으면 NULL 제외하고 카운트
SELECT COUNT(EMPNO) FROM EMP; 
-- EMPNO PRIMARY KEY (NOT NULL) 설정되어있기 때문에 사원 수를 확인하기에 무리가 없음

-- not a single-group function ...
-- SAL를 조회할 때 필요한 행의 개수 != SUM(SAL)의 행의 개수 => 하나의 테이블로 표현 불가
SELECT SAL, SUM(SAL) FROM EMP; -- ?


-- Q1. EMP 테이블에서 DEPTNO가 30인 사원들 중 근무 일수 최댓값
SELECT ROUND(MAX(SYSDATE-HIREDATE)) FROM EMP WHERE DEPTNO = 30;

-- Q2. EMP 테이블에서 JOB이 SALESMAN인 사원들 중 COMM을 받은 사원수

-- COMM <> 0 : COMM이 0인 사원과 COMM이 NULL인 사원 제외
SELECT COUNT(*) FROM EMP WHERE JOB = 'SALESMAN' AND COMM <> 0;
-- 사원: (PK, NULL, .... NULL): COUNT(*) 포함이 됨
SELECT COUNT(COMM) FROM EMP WHERE JOB = 'SALESMAN' AND COMM <> 0;
-- 사원: (PK, NULL, .... NULL): COUNT(COMM) 포함이 안됨

SELECT COUNT(*) FROM EMP;
SELECT COUNT(COMM) FROM EMP; -- COMM이 NULL인 경우 제외

-- Q3. EMP 테이블에서 사원의 상사 (MGR)가 7698인 사원수
SELECT COUNT(*) FROM EMP WHERE MGR = 7698;

-- Q4. 부서 번호가 30인 사원들 중 제일 최근 입사일 출력
SELECT MAX(HIREDATE) FROM EMP WHERE DEPTNO = 30;

-- 만약 사원의 정보가 같이 나오려면 ? (SUBQUERY)

SELECT * 
FROM EMP 
WHERE HIREDATE 
= (SELECT MAX(HIREDATE) FROM EMP WHERE DEPTNO = 30) AND DEPTNO = 30;

SELECT EMPNO, ENAME, MAX(HIREDATE) OVER() FROM EMP WHERE DEPTNO = 30;
SELECT * FROM EMP;

-- Q5. 부서 번호가 30인 사원들 중 처음으로 입사한 사원의 입사일 출력
SELECT MIN(HIREDATE) FROM EMP WHERE DEPTNO = 30;

-- 만약 사원의 정보가 같이 나오려면 ?
SELECT * 
FROM EMP 
WHERE HIREDATE 
= (SELECT MIN(HIREDATE) FROM EMP WHERE DEPTNO = 30) AND DEPTNO = 30;

-- Q6. 직책이 SALESMAN인 사원들의 SAL 평균 출력
SELECT AVG(SAL) 
FROM EMP 
WHERE JOB = 'SALESMAN'; -- NULL은 알아서 제외 (집계 함수 특징)

SELECT MAX(SAL) FROM EMP;
SELECT ENAME, UPPER(ENAME) FROM EMP; 
-- 단일행 함수: UPPER, LOWER, SUBSTR, INSTR, LPAD, RPAD, TRIM, ........

-- GROUP BY절
-- : 데이터를 그룹으로 묶어서 출력
-- : (+ 다중행 함수)

-- EX)
-- 10번 부서의 평균 SAL
-- 20번 부서의 평균 SAL
-- 30번 부서의 평균 SAL
SELECT DEPTNO, AVG(SAL) OVER() FROM EMP WHERE DEPTNO = 10
UNION
SELECT DEPTNO, AVG(SAL) OVER() FROM EMP WHERE DEPTNO = 20
UNION
SELECT DEPTNO, AVG(SAL) OVER() FROM EMP WHERE DEPTNO = 30;
-- OVER(): 프로그래머들이 데이터를 분석하기 위해서 사용하는 함수
-- 10 2916.666...
-- 10 2916.666...
-- 10 2916.666...

SELECT DEPTNO, AVG(SAL) 
-- GROUP BY 기준에 사용하는 열 이름은 SELECT 문장에서 다중행 함수랑 같이 쓸 수 있음
-- => (*) DEPTNO 그룹 개수만큼 AVG(SAL) 개수가 나옴
-- GROUP BY 기준에 사용하지 않는 열 이름은 SELECT 문장에서 다중행 함수랑 같이 쓸 수 없음
FROM EMP
GROUP BY DEPTNO
ORDER BY DEPTNO;

-- Q1. 아래의 두 질의문 차이점을 생각해보고 실행순서를 설명해보기
SELECT DEPTNO, JOB, AVG(SAL) -- 4
FROM EMP
GROUP BY DEPTNO, JOB -- 1
HAVING AVG(SAL) >= 2000  -- 2
-- 그룹 기준 추가
-- (*) 다중행 함수 사용 가능
ORDER BY DEPTNO, JOB; -- 3
-- 그룹핑할 때 쓰이는 GROUP BY, HAVING절은 AS (별칭) 사용 불가능!

SELECT DEPTNO, JOB, AVG(SAL) -- 4
FROM EMP
WHERE SAL >= 2000 -- 1
-- 셀렉션 기준 추가 (각 행에 대해 조사)
-- (*) 다중행 함수 사용 불가
GROUP BY DEPTNO, JOB -- 2
ORDER BY DEPTNO, JOB; -- 3

-- Q2. 같은 직책에 종사하는 사원이 3명 이상인 직책과 인원 수를 출력
SELECT JOB, COUNT(*) AS COUNT
FROM EMP
GROUP BY JOB
HAVING COUNT(*) >= 3;

-- Q3. 이름의 길이가 같은 사원별로 그룹핑해서 
-- 동일한 이름의 길이를 가진 이름의 길이와 사원수 출력
SELECT LENGTH(ENAME), COUNT(*)
FROM EMP
GROUP BY LENGTH(ENAME)
ORDER BY LENGTH(ENAME);

-- Q4. 사원의 입사일을 통해 입사년도 (YYYY)를 구하고 
-- 해당 연도에 부서별 몇 명이 입사했는지 출력
-- 그룹 기준: 입사년도, 부서
SELECT TO_CHAR(HIREDATE, 'YYYY') AS HIREYEAR, DEPTNO, COUNT(*) AS COUNT
FROM EMP
GROUP BY TO_CHAR(HIREDATE, 'YYYY'), DEPTNO
ORDER BY TO_CHAR(HIREDATE, 'YYYY'), DEPTNO;
-- TO_CHAR(): DATE형 (년도/월/일 시:분:초) -> 문자형

-- Q5. 부서별 추가수당 (COMM) 여부에 따른 사원 수 출력
-- 추가수당 (COMM) : NULL인 사람만 포함
SELECT DEPTNO, NVL2(COMM, 'O', 'X') AS ISCOMM, COUNT(*)
FROM EMP
GROUP BY DEPTNO, NVL2(COMM, 'O', 'X')
ORDER BY DEPTNO, NVL2(COMM, 'O', 'X');

-- 추가수당 (COMM) : 0인 사람도 포함하기 위함 
-- 1) REPLACE() 사용 (0 -> NULL 변경)
SELECT DEPTNO, NVL2(REPLACE(COMM, 0, NULL), 'O', 'X') AS ISCOMM, COUNT(*)
FROM EMP
GROUP BY DEPTNO, NVL2(REPLACE(COMM, 0, NULL), 'O', 'X')
ORDER BY DEPTNO, NVL2(REPLACE(COMM, 0, NULL), 'O', 'X');

-- 2) DECODE(), CASE문 사용 (0 -> NULL 변경)
SELECT DEPTNO, DECODE(COMM, 0, 'X', NULL, 'X', 'O') AS ISCOMM, COUNT(*)
FROM EMP
GROUP BY DEPTNO,  DECODE(COMM, 0, 'X', NULL, 'X', 'O')
ORDER BY DEPTNO,  DECODE(COMM, 0, 'X', NULL, 'X', 'O');

SELECT DEPTNO, CASE  
                            WHEN COMM = 0 THEN 'X'
                            WHEN COMM IS NULL THEN 'X'
                            ELSE 'O' END
                        AS ISCOMM, COUNT(*)
FROM EMP
GROUP BY DEPTNO,  CASE  
                            WHEN COMM = 0 THEN 'X'
                            WHEN COMM IS NULL THEN 'X'
                            ELSE 'O' END
ORDER BY DEPTNO,  CASE  
                            WHEN COMM = 0 THEN 'X'
                            WHEN COMM IS NULL THEN 'X'
                            ELSE 'O' END;
                          



-- Q6. 추가수당 (COMM)을 받는 사원수와 받지 않은 사원수 출력
-- 추가수당 (COMM) : NULL인 사람만 포함
SELECT NVL2(COMM, 'O', 'X') AS ISCOMM, COUNT(*) AS COUNT
FROM EMP
GROUP BY NVL2(COMM, 'O', 'X');

SELECT * FROM EMP;

-- 추가수당 (COMM) : 0인 사람도 포함
-- 1) REPLACE()
SELECT NVL2(REPLACE(COMM, 0, NULL), 'O', 'X') AS ISCOMM, COUNT(*) AS COUNT
FROM EMP
GROUP BY NVL2(REPLACE(COMM, 0, NULL), 'O', 'X');

-- 2) DECODE(), CASE문
SELECT DECODE(COMM, 0,  'X', NULL, 'X', 'O') AS ISCOMM, COUNT(*) AS COUNT
FROM EMP
GROUP BY DECODE(COMM, 0,  'X', NULL, 'X', 'O');

SELECT CASE
            WHEN COMM = 0 THEN 'X'
            WHEN COMM IS NULL THEN 'X'
            ELSE 'O' END AS ISCOMM, COUNT(*) AS COUNT
FROM EMP
GROUP BY CASE
            WHEN COMM = 0 THEN 'X'
            WHEN COMM IS NULL THEN 'X'
            ELSE 'O' END;
        
-- 오류!
SELECT CASE COMM
            WHEN 0 THEN 'X'
            WHEN NULL THEN 'X' -- COMM = NULL -> NULL
            ELSE 'O' END AS ISCOMM, COUNT(*) AS COUNT
FROM EMP
GROUP BY CASE COMM
            WHEN 0 THEN 'X'
            WHEN NULL THEN 'X'
            ELSE 'O' END;


DECODE(열 이름, -- 연산식이 = 만 쓸 수 있음
            값, 반환할 값,
            NULL, 반환할 값, -- 열 이름 = NULL (X) -> 열 이름 IS NULL
            반환할 값)
            
CASE 열 이름
    WHEN 값 THEN 반환할 값
    WHEN NULL THEN 반환할 값 -- 열 이름 = NULL (연산 결과 NULL)
    ELSE 반환할 값 END

CASE 
    WHEN 열 이름 = 값 THEN 반환할 값
    WHEN 열 이름 >= 값 AND 열 이름 <= 값 THEN 반환할 값
    WHEN 열 이름 IS NULL THEN 반환할 값
    ELSE 반환할 값 END
-- (***) CASE에서 열이 NULL인지 판단할 때는 IS NULL을 다 써줘야 함!




-- 열로 추가하는 방법
-- Q5. 부서별 COMM 여부에 따른 사원 수 출력
-- 1)
SELECT DEPTNO, COUNT(DECODE(COMM,
    0, NULL,
    COMM)) AS HASCOMM ,
       COUNT(DEPTNO) - COUNT(DECODE(COMM,
    0, NULL,
    COMM)) AS HASNOTCOMM
FROM EMP
    GROUP BY DEPTNO;
-- 2)
SELECT DEPTNO, NVL2(DECODE(COMM,
    0, NULL,
    COMM), 'HASCOMM', 'HASNOTCOMM'), COUNT(*)
FROM EMP
    GROUP BY DEPTNO, NVL2(DECODE(COMM,
    0, NULL,
    COMM), 'HASCOMM', 'HASNOTCOMM')
ORDER BY DEPTNO, NVL2(DECODE(COMM,
    0, NULL,
    COMM), 'HASCOMM', 'HASNOTCOMM');

-- Q6. 추가수당 (COMM)을 받는 사원수와 받지 않은 사원수 출력
-- 1)
SELECT COUNT(DECODE(COMM,
    0, NULL,
    COMM)) AS HASCOMM,
    COUNT(*) - COUNT(DECODE(COMM,
    0, NULL,
    COMM)) AS HASNOTCOMM
FROM EMP;
-- 2)
SELECT NVL2(DECODE(COMM,
    0, NULL,
    COMM), 'HASCOMM', 'HASNOTCOMM'), COUNT(*)
FROM EMP
    GROUP BY NVL2(DECODE(COMM,
    0, NULL,
    COMM), 'HASCOMM', 'HASNOTCOMM')
ORDER BY NVL2(DECODE(COMM,
    0, NULL,
    COMM), 'HASCOMM', 'HASNOTCOMM');
    