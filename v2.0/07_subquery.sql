-- 서브쿼리 (SUBQUERY)
-- : SQL문 안에 SQL문
-- : 서브쿼리는 () 안에 작성
-- : 서브쿼리 연산의 결과와 메인쿼리 비교 대상과 같은 자료형/개수를 가짐
-- : 서브쿼리에서는 ORDER BY를 사용할 수 없음

-- 사원번호가 7844인 사원보다 돈을 많이 버는 사원 출력
SELECT SAL FROM EMP WHERE EMPNO = 7844;
SELECT * FROM EMP WHERE SAL > 1500;

-- 단일행 서브쿼리
SELECT * FROM EMP
WHERE SAL >  -- 메인쿼리
(SELECT SAL FROM EMP WHERE EMPNO = 7844); -- 서브쿼리

-- Q1. 사원번호가 7499인 사원의 추가 수당보다 많은 추가 수당을 받는 사원 정보 출력
SELECT * FROM EMP
WHERE COMM > (SELECT COMM FROM EMP WHERE EMPNO = 7499);

-- 추가 문제
-- 사원번호가 7499인 사원의 추가 수당보다 적은 추가 수당을 받는 사원 정보 출력 (NULL 값이 있을 수 있음)
SELECT * FROM EMP
WHERE NVL(COMM, 0) < (SELECT NVL(COMM, 0) FROM EMP WHERE EMPNO = 7499);
-- 1) EMP 테이블에서 비교 대상의 COMM이 NULL일 수 있음 (< 왼쪽, 메인쿼리 내)
-- 2) EMP 테이블에서 7499의 COMM이 NULL일 수 있음 (< 오른쪽, 서브쿼리 내)
DESC EMP;

SELECT * FROM EMP;

-- Q2. 사원번호가 7844인 사원보다 먼저 입사한 사원 목록 조회
SELECT * FROM EMP
WHERE HIREDATE < (SELECT HIREDATE FROM EMP WHERE EMPNO = 7844);

-- Q3. 10번 부서에서 10번 부서의 평균 SAL보다 많이 받는 사원 목록 조회
SELECT * FROM EMP
WHERE SAL > (SELECT AVG(SAL) FROM EMP WHERE DEPTNO = 10) AND DEPTNO = 10;


-- 다중행 서브쿼리
-- : 단일행 서브쿼리에서 사용했던 연산자 (>, <, >=, <=, =, <>) 사용 불가능

-- IN 연산자
-- Q1. 각 부서별 최고 급여를 받는 사원 정보 출력
SELECT * FROM EMP
WHERE (DEPTNO, SAL) IN (SELECT DEPTNO, MAX(SAL) FROM EMP GROUP BY DEPTNO);
-- (30 : 2850, 20 : 3000, 10 : 5000)
-- 20 : 2850

-- Q2. 각 직책별 최저 급여 (SAL)를 받는 사원 정보 출력
SELECT * FROM EMP
WHERE (JOB, SAL) IN (SELECT JOB, MIN(SAL) FROM EMP GROUP BY JOB);

-- Q3. 입사년도가 같은 사원별로 최고 급여 (SAL)를 받는 사원 정보 출력
SELECT * FROM EMP
WHERE (TO_CHAR(HIREDATE, 'YYYY'), SAL) IN
(SELECT TO_CHAR(HIREDATE, 'YYYY'), MAX(SAL) FROM EMP GROUP BY TO_CHAR(HIREDATE, 'YYYY'));


-- SOME, ANY 연산자
-- : SOME == ANY (*ANY를 사용) 
-- : 서브쿼리 결과값 중에서 하나라도 참이면 참을 반환하는 연산자


SELECT * FROM EMP
WHERE (DEPTNO, SAL) = ANY(SELECT DEPTNO, MAX(SAL) FROM EMP GROUP BY DEPTNO);
SELECT DEPTNO, MAX(SAL) FROM EMP GROUP BY DEPTNO;


-- ALL 연산자
-- : 서브쿼리 결과값 중에서 모두 참이면 참을 반환하는 연산자

-- 30번 부서에서 근무하는 사원들 중 SAL의 최솟값보다 더 적은 급여를 받고 있는 사원 조회
SELECT * FROM EMP WHERE SAL < ALL(SELECT SAL FROM EMP WHERE DEPTNO = 30);
SELECT * FROM EMP WHERE SAL < (SELECT MIN(SAL) FROM EMP WHERE DEPTNO = 30);

-- 30번 부서에서 근무하는 사원들 중 SAL의 최댓값보다 더 많은 급여를 받고 있는 사원 조회
SELECT * FROM EMP WHERE SAL > ALL(SELECT SAL FROM EMP WHERE DEPTNO = 30);
SELECT * FROM EMP WHERE SAL > (SELECT MAX(SAL) FROM EMP WHERE DEPTNO = 30);

-- EXISTS 연산자
-- : 서브쿼리 결과 행이 하나 이상 존재하면 참 반환
SELECT * FROM EMP
WHERE EXISTS(SELECT COMM FROM EMP WHERE COMM IS NULL);

-- EXISTS VS IN 연산자
-- EXISTS: 결과행의 값이 NULL이여도 결과행이 존재하기 때문에 TRUE 반환
-- EX) 서브쿼리 결과값의 존재 유무에 따라서 메인쿼리 데이터 노출 여부 결정

-- IN: 결과행의 값이 NULL이면 전체 연산의 결과도 NULL이기 때문에 조건 결과가 FALSE 반환
SELECT * FROM EMP 
WHERE COMM IN (SELECT COMM FROM EMP WHERE COMM IS NULL);


-- 인라인 뷰 (Inline View)
-- : 전체 데이터가 아닌 일부 데이터만 추출해서 가상 테이블 (뷰) 만듦

-- WHY?
-- 1) 테이블이 가지고 있는 데이터 규모가 너무 클 때
-- 2) 원하는 일부 행과 열을 사용하고자 할 때

SELECT * FROM EMP WHERE DEPTNO = 10;
SELECT * FROM EMP;


-- 10번 부서에서 일하고 있는 사원 정보와 10번 부서의 부서정보
SELECT TBL_EMP_DEPTNO10.*, D.* 
FROM (SELECT * FROM EMP WHERE DEPTNO = 10) TBL_EMP_DEPTNO10, DEPT D
WHERE TBL_EMP_DEPTNO10.DEPTNO = D.DEPTNO;

-- WITH ~~ AS ~~~ 구문
-- : 가독성 높임
WITH TBL_EMP_DEPTNO10 AS (SELECT * FROM EMP WHERE DEPTNO = 10)
SELECT TBL_EMP_DEPTNO10.*, D.* 
FROM TBL_EMP_DEPTNO10 JOIN DEPT D ON (TBL_EMP_DEPTNO10.DEPTNO = D.DEPTNO);

WITH TBL_EMP_DEPTNO10 AS (SELECT * FROM EMP WHERE DEPTNO = 10)
SELECT TBL_EMP_DEPTNO10.*
FROM TBL_EMP_DEPTNO10
WHERE TBL_EMP_DEPTNO10.ENAME LIKE '%K%' OR TBL_EMP_DEPTNO10.ENAME LIKE '%S%';

SELECT *
FROM EMP
WHERE DEPTNO = 10 AND (ENAME LIKE '%K%' OR ENAME LIKE '%S%';


-- Q1. 각 부서별로 각 부서의 평균 SAL보다 많이 받는 사원 목록 조회
SELECT * FROM EMP
WHERE SAL > ANY(SELECT AVG(SAL) FROM EMP GROUP BY DEPTNO) ORDER BY DEPTNO;

SELECT DEPTNO, AVG(SAL) FROM EMP GROUP BY DEPTNO;
-- 10 : 2916
-- 20 : 2258
-- 30 : 1566
-- 각 사원의 SAL가 그 사원이 속해있는 부서의 평균 SAL보다 커야하는데
-- WHERE SAL > ANY(2916, 2258, 1566)
-- CLARK SAL의 값은 2450이고 30번 부서 평균 SAL보다는 크니까 같이 조회되고 있음
-- => DEPTNO도 같이 봐야 함!