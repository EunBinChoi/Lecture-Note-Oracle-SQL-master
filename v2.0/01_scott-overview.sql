-- ORACLE SQL의 한 줄짜리 주석 (comment)
/* ORACLE SQL의 여러 줄짜리 주석 (comment) */

-- * 주의해야할 점 *
-- SQL 문장 (+ 테이블 이름, 속성 (열) 이름)은 대소문자 구분 X 
-- 테이블에 저장된 데이터는 대소문자 구분 O
----------------------------------------------------------------------

-- 테이블 구조 확인 (SQL PLUS 명령어, desc, conn, grant, show ... )
DESC EMP

-- SCOTT 계정에 있는 모든 테이블 조회
SELECT * FROM TAB;

-- SCOTT 계정의 테이블 조회 (데이터 확인용)
SELECT * FROM EMP;
SELECT * FROM DEPT;
SELECT * FROM BONUS;
SELECT * FROM SALGRADE;

-- SELECT ~~~~ FROM ~~~~
-- : 데이터를 조회
-- : SELECT 열 이름 (만약 모든 열을 확인 (*)) FROM 테이블 이름

-- EMP 테이블에서 사원 이름과 그 사원의 상사 번호 조회
SELECT ENAME, MGR FROM EMP;

-- Q1. BONUS, SALGRADE에 어떤 데이터가 있는지 조회
SELECT * FROM BONUS; -- 데이터 없음
SELECT * FROM SALGRADE;

-- Q2. SMITH의 부서 이름, 위치가 어딘지 조회
SELECT * FROM EMP; -- SMITH, DEPTNO: 20
SELECT * FROM DEPT; -- 20, RESEARCH, DALLAS
-- RESERACH, DALLAS

-- Q3. JONES의 상사는 누구인지 조회
SELECT * FROM EMP; 
-- JONES, MGR: 7839
-- 7839, KING, PRESIDENT .....

