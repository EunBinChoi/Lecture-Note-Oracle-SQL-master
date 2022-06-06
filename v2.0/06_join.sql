-- 조인 (JOIN)
-- 특정 열을 기준으로 테이블 결합

-- 조인 (JOIN) vs 집합 연산자 UNION
-- 조인은 두 테이블을 가로로 연결
-- UNION은 두 테이블을 세로로 연결 
-- (두 테이블의 열 개수, 데이터 타입 동일해야 함)
-- (만약 두 테이블의 열 이름이 다르면 첫번째 테이블의 열 이름 따름)

-- RDBMS (Relational Database Management System)
-- 테이블이 독립적으로 나뉘어져 있는 특징
-- 테이블 간에 관계를 맺고 있음!
-- EX) EMP DEPTNO (외래키)
--    DEPT  DEPTNO (기본키)
-- WHY? 데이터의 중복을 제거하기 위해 (중복되면 중복된 데이터만큼 수정/삭제 필요)

SELECT * FROM EMP;
SELECT * FROM DEPT;

SELECT * 
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO
ORDER BY E.EMPNO;

SELECT EMPNO AS NO, ENAME AS NAME
FROM EMP E
WHERE E.NO = 7369;
-- EMPNO의 별칭인 NO는 결과 테이블을 만들기 위한 용도이기 때문에
-- WHERE절에 사용할 수 없음!

-- Q1. 사원번호 7369인 사원 정보와 7369가 근무하고 있는 부서 정보 출력
SELECT EMPNO, ENAME, E.DEPTNO AS E_DEPTNO, D.DEPTNO AS D_DEPTNO, DNAME, LOC 
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO -- 등가조인 (Equal Join)
AND E.EMPNO = 7369;

-- Q2. EMP 테이블에서 MGR 번호에 해당하는 MGR 정보 출력
-- EMPNO, ENAME, JOB, MGR, MGR_ENAME, MGR_JOB
SELECT * FROM EMP;
SELECT E.EMPNO, E.ENAME, E.JOB, E.MGR, M.ENAME AS MGR_ENAME, M.JOB AS MGR_JOB
FROM EMP E, EMP M
WHERE E.MGR = M.EMPNO
-- 등가조인 (Equal Join)
-- 자체 조인 (Self Join): 같은 테이블을 논리적으로 이름만 다르게 해서 조인하는 것
ORDER BY E.EMPNO;

-- Q3. NEW YORK에서 일하고 있는 사원 정보 출력
SELECT D.LOC, E.EMPNO, E.ENAME
FROM DEPT D, EMP E
WHERE D.DEPTNO = E.DEPTNO -- 등가조인 (Equal Join)
AND D.LOC = 'NEW YORK';

-- Q4. SALES에서 근무하고 있는 사원 정보 출력
SELECT D.DNAME, D.LOC, E.*
FROM DEPT D, EMP E
WHERE D.DEPTNO = E.DEPTNO -- 등가조인 (Equal Join)
AND D.DNAME = 'SALES';

-- Q5. 각 사원 정보에 대해 각 사원의 급여 등급 출력
SELECT * FROM EMP;
SELECT * FROM SALGRADE;

-- 1) 비교 연산자
SELECT E.EMPNO, E.ENAME, E.SAL, S.GRADE
FROM EMP E, SALGRADE S
WHERE E.SAL >= S.LOSAL AND E.SAL <= S.HISAL; -- 비등가 조인 (Non-Equal Join)

-- 2) BETWEEN A AND B 연산자 (>= A, <= B)
SELECT E.EMPNO, E.ENAME, E.SAL, S.GRADE
FROM EMP E, SALGRADE S
WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL; -- 비등가 조인 (Non-Equal Join)
 
-- 추가) 각 등급에 해당하는 사원 수
SELECT S.GRADE, COUNT(*)
FROM EMP E, SALGRADE S
WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL
GROUP BY S.GRADE
ORDER BY S.GRADE;

-- 외부 조인 (Outer Join) ↔ 내부 조인 (Inner Join) (등가 조인, 비등가 조인, 자체 조인)
-- Q2. EMP 테이블에서 MGR 번호에 해당하는 MGR 정보 출력
-- EMPNO, ENAME, JOB, MGR, MGR_ENAME, MGR_JOB
SELECT E.EMPNO, E.ENAME, E.JOB, E.MGR, M.ENAME AS MGR_ENAME, M.JOB AS MGR_JOB
FROM EMP E, EMP M
WHERE E.MGR = M.EMPNO 
ORDER BY E.EMPNO;
-- KING이 제외 (KING의 MGR은 NULL이기 때문에 조인 조건식 NULL이 되기 때문)
-- KING의 MGR이 없어도 출력하고 싶다면 ? 외부 조인!
-- 1) 왼쪽 외부 조인 (Left Outer Join = Left Join)
-- >> WHERE TABLE1.COL1 = WHERE TABLE2.COL2(+)
-- >> TABLE1.COL1가 TABLE2.COL2에 없어도 포함시키겠다!
SELECT E.EMPNO, E.ENAME, E.JOB, E.MGR, M.ENAME AS MGR_ENAME, M.JOB AS MGR_JOB
FROM EMP E, EMP M
WHERE E.MGR = M.EMPNO(+)
ORDER BY E.EMPNO;
-- E.MGR 값과 동일한 M.EMPNO에 없어도 E.MGR를 결과 테이블에 포함하겠다!
-- 해당 사원보다 상급자가 존재하지 않은 사원 출력 (EX. KING)


-- 2) 오른쪽 외부 조인 (Right Outer Join = Right Join)
-- >> WHERE TABLE1.COL1(+) = WHERE TABLE2.COL2
-- >> TABLE2.COL2가 TABLE1.COL1에 없어도 포함시키겠다!
SELECT E.EMPNO, E.ENAME, E.JOB, E.MGR, M.EMPNO AS MGR_EMPNO, M.ENAME AS MGR_ENAME, M.JOB AS MGR_JOB
FROM EMP E, EMP M
WHERE E.MGR(+) = M.EMPNO 
ORDER BY E.EMPNO;
-- M.EMPNO 값과 동일한 E.MGR에 없어도 M.EMPNO를 결과 테이블에 포함하겠다!
-- 해당 사원이 누군가의 매니저가 아닌 사원 (막내 사원) 출력 
-- (JAMES, MILLER, SMITH, ALLEN, TURNER, WARD)

-- 3) 전체 외부 조인 (Full Outer Join = Full Join)
SELECT E.EMPNO, E.ENAME, E.JOB, E.MGR, M.EMPNO AS MGR_EMPNO, M.ENAME AS MGR_ENAME, M.JOB AS MGR_JOB
FROM EMP E, EMP M
WHERE E.MGR(+) = M.EMPNO 
UNION
SELECT E.EMPNO, E.ENAME, E.JOB, E.MGR, M.EMPNO AS MGR_EMPNO, M.ENAME AS MGR_ENAME, M.JOB AS MGR_JOB
FROM EMP E, EMP M
WHERE E.MGR = M.EMPNO(+);

SELECT E.EMPNO, E.ENAME, E.JOB, E.MGR, M.EMPNO AS MGR_EMPNO, M.ENAME AS MGR_ENAME, M.JOB AS MGR_JOB
FROM EMP E, EMP M
WHERE E.MGR(+) = M.EMPNO(+); -- 지원 X

-- 외부 조인 VS 내부 조인
-- 외부 조인: 데이터가 없어도 출력하겠다!
-- 내부 조인: 데이터가 없으면 출력하지 않음 (외부 조인을 사용하지 않는 조인)


-- SQL 표준 문법
-- ISO에서 지정
-- 대부분의 RDBMS에서 사용할 수 있음 (호환성)

-- 등가 조인
-- NATURAL JOIN
-- 조인 대상이 되는 두 테이블에서 열 이름, 자료형이 같은 열을 찾아 등가 조인
-- (**) 조인 대상이 되는 열의 테이블 명을 붙이면 오류
SELECT E.EMPNO, E.ENAME, DEPTNO, D.DNAME
FROM EMP E NATURAL JOIN DEPT D;

-- JOIN ~ USING (기준 열)
-- (**) 조인 대상이 되는 열의 테이블 명을 붙이면 오류
SELECT E.EMPNO, E.ENAME, DEPTNO, D.DNAME
FROM EMP E JOIN DEPT D USING (DEPTNO);

-- JOIN ~ ON (조인 조건식)
-- 자주 사용
-- (**) 조인 대상이 되는 열의 테이블 명을 붙이면 오류 X
SELECT E.EMPNO, E.ENAME, E.DEPTNO, D.DNAME
FROM EMP E JOIN DEPT D ON (E.DEPTNO = D.DEPTNO);

SELECT E.EMPNO, E.ENAME, E.DEPTNO, D.DNAME
FROM EMP E, DEPT D 
WHERE E.DEPTNO = D.DEPTNO;

-- OUTER JOIN
SELECT E.EMPNO, E.ENAME, E.MGR, M.EMPNO AS MGR_EMPNO, M.ENAME AS MGR_ENAME
FROM EMP E LEFT OUTER JOIN EMP M ON (E.MGR = M.EMPNO);

SELECT E.EMPNO, E.ENAME, E.MGR, M.EMPNO AS MGR_EMPNO, M.ENAME AS MGR_ENAME
FROM EMP E LEFT  JOIN EMP M ON (E.MGR = M.EMPNO);


SELECT E.EMPNO, E.ENAME, E.MGR, M.EMPNO AS MGR_EMPNO, M.ENAME AS MGR_ENAME
FROM EMP E RIGHT OUTER JOIN EMP M ON (E.MGR = M.EMPNO);

SELECT E.EMPNO, E.ENAME, E.MGR, M.EMPNO AS MGR_EMPNO, M.ENAME AS MGR_ENAME
FROM EMP E RIGHT JOIN EMP M ON (E.MGR = M.EMPNO);

-- FULL OUTER JOIN
-- LEFT OUTER JOIN UNION RIGHT OUTER JOIN
SELECT E.EMPNO, E.ENAME, E.MGR, M.EMPNO AS MGR_EMPNO, M.ENAME AS MGR_ENAME
FROM EMP E FULL OUTER JOIN EMP M ON (E.MGR = M.EMPNO)
ORDER BY E.EMPNO;

SELECT E.EMPNO, E.ENAME, E.MGR, M.EMPNO AS MGR_EMPNO, M.ENAME AS MGR_ENAME
FROM EMP E FULL JOIN EMP M ON (E.MGR = M.EMPNO)
ORDER BY E.EMPNO;



