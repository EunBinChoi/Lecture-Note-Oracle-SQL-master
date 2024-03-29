-- 분석 함수 (Analytical Function)
-- : 여러 행에 대한 데이터를 분석하고 현재 형에 대한 결과 반환하는데 사용
-- : 집계 함수는 행을 그룹화하고 전체 결과 집합에 대해 출력 반환 (그룹화 + 분석)
-- : 분석 함수는 집계된 출력을 반환하지만 결과 집합을 그룹화하지 않음 (분석, 행의 개수 유지)
-- : 분석 함수는 집계 함수와 동일한 기능을 담당하지만 분석 함수가 간단하고 더 빠름

-- 분석 함수 + OVER()
-- AVG(), SUM(), MIN(), MAX(), COUNT(), RANK() OVER(ORDER BY ...), DENSE_RANK() OVER(ORDER BY ....)

-- Q1. 부서별로 사원 평균 SAL
-- 집계 함수
SELECT DEPTNO, AVG(SAL), COMM -- 그룹핑에 기준이 되지 않는 열은 사용 불가
FROM EMP
GROUP BY DEPTNO
ORDER BY DEPTNO;

SELECT *
FROM EMP
ORDER BY DEPTNO;

-- 분석 함수
SELECT EMPNO, ENAME, DEPTNO, SAL, AVG(SAL) OVER( PARTITION BY DEPTNO ) AS AVG, COMM -- 그룹핑에 기준이 되지 않는 열도 사용 가능
FROM EMP;
WHERE ENAME = 'SMITH'; 

SELECT E.DEPTNO, E.AVG  -- 그룹핑에 기준이 되지 않는 열도 사용 가능
FROM ( SELECT DEPTNO, ENAME, AVG(SAL) OVER( PARTITION BY DEPTNO ) AS AVG, COMM FROM EMP ) E

WHERE E.ENAME = 'SMITH'; 

SELECT DEPTNO, AVG(SAL)
FROM EMP
GROUP BY DEPTNO
HAVING DEPTNO = (SELECT DEPTNO FROM EMP WHERE ENAME = 'SMITH');

SELECT DEPTNO, AVG(SAL)
FROM EMP
WHERE DEPTNO = (SELECT DEPTNO FROM EMP WHERE ENAME = 'SMITH')
GROUP BY DEPTNO;


-- Q1. 분석 함수 MAX() 이용해서 부서별 최대 월급을 받고 있는 사원 정보와 JOB별로 최대 월급을 받고 있는 사원 정보
SELECT ENAME, SAL, JOB, DEPTNO, 
MAX(SAL) OVER(PARTITION BY DEPTNO) AS MAX_SAL_DEPTNO, 
MAX(SAL) OVER(PARTITION BY JOB) AS MAX_SAL_JOB
FROM EMP;


SELECT ENAME, SAL, RANK() OVER (ORDER BY SAL DESC) AS RANKING
FROM EMP;

-- Q2. 부서별 평균 SAL의 RANKING (내림차순)
-- DEPTNO   AVG(SAL)     RANKING
-- 10                               
-- 20           
-- 30    
SELECT DEPTNO, ROUND(AVG(SAL)), RANK() OVER (ORDER BY AVG(SAL) DESC) AS RANKING
FROM EMP
GROUP BY DEPTNO;

-- Q3. 입사일이 빠른 순서대로 RANKING (오름차순)
-- EMPNO, ENAME, HIREDATE, RANKING

-- 중복 순위가 있으면 중복 순위 있는 만큼 증가 (+2)
SELECT EMPNO, ENAME, HIREDATE, RANK() OVER(ORDER BY HIREDATE) AS RANKING
FROM EMP;

-- 중복 순위가 있어도 1씩 증가 (+1)
SELECT EMPNO, ENAME, HIREDATE, DENSE_RANK() OVER(ORDER BY HIREDATE) AS RANKING
FROM EMP;


-- WINDOW절
-- : 분석할 때 같이 분석할 범위 지정

-- [ROWS OR RANGE] BETWEEN START_POINT AND END_POINT
-- START_POINT: UNBOUNDED PRECEDING, CURRENT ROW, n PRECEDING or FOLLOWING
-- END_POINT: UNBOUNDED FOLLOWING, CURRENT ROW, n PRECEDING or FOLLOWING
-- (*) ROWS: 행 번호 구분
-- (*) RANGE: 값 구분

SELECT DEPTNO, ENAME, JOB, SAL, AVG(SAL) OVER( PARTITION BY DEPTNO ORDER BY SAL
ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW ) AS AVG_SAL
FROM EMP;

SELECT DEPTNO, ENAME, JOB, SAL, AVG(SAL) OVER( PARTITION BY DEPTNO ORDER BY SAL
ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING ) AS AVG_SAL
FROM EMP;

-- 행 번호 구분 (행 번호가 다르면 서로 다른 행이라는 것을 알고 있음)
SELECT DEPTNO, ENAME, JOB, SAL, SUM(SAL) OVER( PARTITION BY JOB ORDER BY SAL
ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW ) AS SUM_SAL
FROM EMP;

SELECT DEPTNO, ENAME, JOB, SAL, COUNT(SAL) OVER( PARTITION BY JOB ORDER BY SAL
ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW ) AS SUM_SAL
FROM EMP;

-- 값 구분 (값이 같으면 서로 같은 행이라고 생각을 함)
-- : 값의 중복이 있을 경우 같은 값을 갖는 행을 하나의 행이라고 생각해서 분석
SELECT DEPTNO, ENAME, JOB, SAL, SUM(SAL) OVER( PARTITION BY JOB ORDER BY SAL
RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW ) AS SUM_SAL
FROM EMP;

SELECT DEPTNO, ENAME, JOB, SAL, COUNT(SAL) OVER( PARTITION BY JOB ORDER BY SAL
RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW ) AS SUM_SAL
FROM EMP;


-- n PRECEDING or FOLLOWING
-- : 현재 행을 기준으로 같이 분석할 이전 행, 이후 행의 개수를 지정
SELECT DEPTNO, ENAME, JOB, SAL, SUM(SAL) OVER(PARTITION BY DEPTNO ORDER BY SAL
ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS SUM_UP_DOWN
FROM EMP;


SELECT DEPTNO, ENAME, JOB, SAL, COUNT(SAL) 
    OVER(PARTITION BY DEPTNO ORDER BY SAL 
    ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS COUNT_UP_DOWN,
    MIN(SAL)  
    OVER(PARTITION BY DEPTNO) AS MIN_SAL_BY_DEPTNO
FROM EMP;

WITH TBL_MIN_SAL_BY_DEPTNO 
AS (SELECT DEPTNO, ENAME, JOB, SAL, MIN(SAL) OVER(PARTITION BY DEPTNO) AS MIN_SAL_BY_DEPTNO FROM EMP)
SELECT TBL_MIN_SAL_BY_DEPTNO.*, COUNT(SAL) OVER(PARTITION BY DEPTNO ORDER BY SAL 
    ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS COUNT_WITHOUT_MIN_SAL
FROM TBL_MIN_SAL_BY_DEPTNO
WHERE (DEPTNO, SAL) <> ANY((DEPTNO, MIN_SAL_BY_DEPTNO));

SELECT DEPTNO, ENAME, JOB, SAL, MIN(SAL) OVER(PARTITION BY DEPTNO) AS MIN_SAL_BY_DEPTNO
FROM EMP;


SELECT DEPTNO, ENAME, JOB, SAL, COUNT(SAL) OVER(PARTITION BY DEPTNO ORDER BY SAL
ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS COUNT_UP_DOWN
FROM EMP;

-- DEPTNO : 10
-- : 1 - 1300 + 2450 = 3750
-- : 2 - 1300 + 2450 + 5000 = 8750
-- : 3 - 2450 + 5000 = 7450

-- DEPTNO : 20
-- : 4 - 800 + 2975 = 3775
-- : 5 - 800 + 2975 + 3000 = 6775
-- : 6 - 2975 + 3000 = 5975

-- DEPTNO : 30
-- : 7 - 950 + 1250 = 2200
-- : 8 - 950 + 1250 + 1250 = 3450
-- : 9 - 1250 + 1250 + 1500 = 4000
-- : 10 - 1250 + 1500 + 1600 = 4350
-- : 11 - 1500 + 1600 + 2850 = 5950
-- : 12 - 1600 + 2850 = 4450


-- Q4. 현재 행을 기준으로 현재 행 이전의 행 중의 최고 월급 출력 (입사 순서, 사원 이름 오름차순 정렬)
SELECT ENAME, HIREDATE, SAL, MAX(SAL) OVER( ORDER BY HIREDATE, ENAME
ROWS BETWEEN UNBOUNDED PRECEDING AND 1 PRECEDING ) AS MAX_SAL_BEFORE
FROM EMP;


-- RANK() VS ROW_NUMBER()
-- RANK: 행이 중복되면 각 행에 대해 같은 번호 부여 (다음 행 번호 : + 중복된 행의 개수)
-- DENSE_RANK: 행이 중복되면 각 행에 대해 같은 번호 부여 (다음 행 번호 : + 1)
-- ROW_NUMBER: 행이 중복되면 각 행에 대해 다른 번호 부여
SELECT ENAME, HIREDATE, DEPTNO, ROW_NUMBER() OVER(ORDER BY HIREDATE) AS ROW_NUM,
RANK() OVER(ORDER BY HIREDATE) AS RANK_NUM, DENSE_RANK() OVER(ORDER BY HIREDATE) AS DENSE_RANK_NUM
FROM EMP;

-- ROWNUM (분석용 함수 아님)
-- : TOP-N Query
-- EX) TOP 3 SAL 사원 출력

-- SELECT (ROWNUM: EMPNO의 순서에 맞게 매겨짐) -> ORDER BY HIREDATE
SELECT *
FROM EMP;

SELECT ROWNUM, EMP.*
FROM EMP
ORDER BY HIREDATE;

-- EMPNO (기본키) 오름차순으로 출력
SELECT *
FROM EMP;

-- 오류 (*은 다른 열과 함께 쓸 수 없음)
SELECT ROWNUM, *
FROM EMP;

-- *과 다른 열과 함께 사용할 때는 테이블 이름.*으로 사용
SELECT ROWNUM, EMP.*
FROM EMP;

-- ORDER BY HIREDATE -> SELECT (ROWNUM: HIREDATE 순서에 맞게 매기기)
-- Q1. 가장 이전에 입사한 TOP10 출력
WITH TBL_HIREDATE_ASC AS (SELECT * FROM EMP ORDER BY HIREDATE)
SELECT ROWNUM, TBL_HIREDATE_ASC.*
FROM TBL_HIREDATE_ASC
WHERE ROWNUM < 11;

-- 생각해보기!
WITH TBL_HIREDATE_ASC AS (SELECT * FROM EMP ORDER BY HIREDATE)
SELECT ROWNUM, TBL_HIREDATE_ASC.*
FROM TBL_HIREDATE_ASC
WHERE ROWNUM BETWEEN 5 AND 10;

WITH TBL_HIREDATE_ASC AS (SELECT * FROM EMP ORDER BY HIREDATE)
SELECT TBL_HIREDATE_ASC_ROWNUM.*
FROM (SELECT ROWNUM AS ROW_NUM, TBL_HIREDATE_ASC.* FROM TBL_HIREDATE_ASC) TBL_HIREDATE_ASC_ROWNUM
WHERE ROW_NUM BETWEEN 5 AND 10;

-- Q2. 연봉의 최댓값 (MAX() 이용하지 않고 ROWNUM, ROW_NUMBER(), RANK())
SELECT MAX(SAL) FROM EMP;

-- ROWNUM
WITH TBL_SAL_DESC AS (SELECT * FROM EMP ORDER BY SAL DESC)
SELECT SAL
FROM TBL_SAL_DESC
WHERE ROWNUM = 1;

-- ROW_NUMBER()
WITH TBL_SAL_DESC AS (SELECT ROW_NUMBER() OVER(ORDER BY SAL DESC) ROW_NUM, SAL FROM EMP)
SELECT SAL
FROM TBL_SAL_DESC
WHERE ROW_NUM = 1;

-- RANK()
WITH TBL_SAL_DESC AS (SELECT RANK() OVER(ORDER BY SAL DESC) ROW_NUM, SAL FROM EMP)
SELECT SAL
FROM TBL_SAL_DESC
WHERE ROW_NUM = 1;


