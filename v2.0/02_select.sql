-- 데이터 조회 (SELECT)

-- 1) SELECT (ALL) ~~ FROM ~~~
SELECT * FROM EMP;
SELECT * FROM DEPT;

-- A. DEPT 테이블에서 DEPTNO, DNAME 조회
SELECT DEPTNO, DNAME FROM DEPT;
-- B. EMP 테이블에서 EMPNO, ENAME, DEPTNO 조회
SELECT EMPNO, ENAME, DEPTNO FROM EMP;

-- 2) SELECT DISTINCT ~~ FROM ~~~ (중복 데이터 제외하고 조회)
SELECT DISTINCT DEPTNO FROM EMP;

-- DEPT 테이블에 존재하는 부서는 무엇이 있고 각 부서마다 최소 1명의 사원이 근무하고 있는지 확인
-- => 각 부서마다 최소 1명의 사원은 없다.
-- => 왜냐하면 아래의 코드 (1)을 실행해보면 사원은 
-- (어떤 부서에 누가 일하고 몇 명이나 일하는 지는 모르지만) 
-- 10, 20, 30 부서에서 일하고 있음
-- => 하지만 DEPT 테이블에서 확인을 해보면 (코드 (2)) 해당 회사에 존재하는 부서는 10, 20, 30, 40이 있음
-- => 즉, 40번 부서에는 일하고 있는 사원이 없다.. (사원 0명...)
SELECT DISTINCT DEPTNO FROM EMP; -- (1)
SELECT DEPTNO FROM DEPT; -- (2)



-- DISTINCT 뒤에 열이 두 개 이상 나올 경우 (DEPTNO, JOB)에는 둘 다 일치해야만 중복이라고 판단  
SELECT DISTINCT DEPTNO, JOB FROM EMP;

-- 중복 제거 없이 출력
SELECT DEPTNO FROM EMP;
SELECT ALL DEPTNO FROM EMP;

-- SELECT문 + 연산식 (AS 별칭)
-- 연봉: SAL*12 + COMM
SELECT ENAME, SAL, COMM, SAL*12+COMM AS ANNUALSAL FROM EMP;
-- COMM이 NULL 값을 가질 경우에는 연산식 (SAL*12+COMM)의 결과가 NULL이 나옴
-- (**) NULL값 처리 필요! (아직 공부 안함 ㅜㅜ)

-- AS 별칭
-- 열 이름에 별칭을 지어줄 수 있음

-- 별칭 사용하는 이유?
-- A. 정보 보안 (연봉 책정 방법으로 노출하지 않게 하기 위함)
-- B. 가독성


-- 3) SELECT ~~~ FROM ~~~ ORDER BY ~~~
-- : SELECT문 이용해서 데이터를 조회할 때 특정 기준으로 데이터를 정렬해서 출력

-- 정렬 옵션: ASC (오름차순, 기본값 (생략 가능)), DESC (내림차순)

-- EMP 테이블의 사원 정보를 SAL 기준으로 오름차순 (기본값 = ASC, 생략 가능)
SELECT * FROM EMP ORDER BY SAL;
SELECT * FROM EMP ORDER BY SAL ASC;

-- EMP 테이블의 사원 정보를 SAL 기준으로 내림차순
SELECT * FROM EMP ORDER BY SAL DESC;

-- 정렬 방식이 여러 개인 경우에는 ? 사이에 , 넣기!
SELECT * FROM EMP ORDER BY SAL DESC, EMPNO ASC; -- ASC은 생략 가능!

-- ** ORDER BY 주의사항!
-- 데이터 정렬하는 것은 시간이 오래걸리기 때문에 
-- 굳이 정렬하지 않아도 되는 데이터에 대해서는 안하는 게 나음
-- SQL 질의 속도가 느려지면 서비스 응답 시간이 느려짐

-- Q1. EMP 테이블에 모든 사원을 조회하는데 HIREDATE 오름차순, EMPNO 오름차순
SELECT * FROM EMP ORDER BY HIREDATE, EMPNO;

-- 4) SELECT ~~~ FROM ~~~ WHERE ~~~
-- : SELECT문으로 데이터를 조회할 때 특정 조건을 기준으로 원하는 행 출력

SELECT EMPNO, ENAME -- 프로젝션 (원하는 열 조회)
FROM EMP 
WHERE DEPTNO = 20; -- 셀렉션 (원하는 행 조회)

