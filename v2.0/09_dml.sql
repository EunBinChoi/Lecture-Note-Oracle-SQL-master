-- 데이터 조작어 (DML, Data Manipulation Language)
-- : 테이블에 데이터를 추가/수정/삭제하는 언어
-- : INSERT, UPDATE, DELETE (DML) -- > 수동 COMMIT
-- : CREATE, DROP, ALTER (DDL) --> 자동 COMMIT

SELECT * FROM TAB;

-- INSERT (데이터 추가)
-- INSERT INTO 테이블명 (특정 열 이름) VALUES (데이터)
-- (*) 열 자료형 = 데이터 자료형
-- (*) 열의 개수 = 데이터 개수

-- INSERT INTO 테이블명 VALUES (데이터)
-- : 테이블이 가진 모든 열에 대해서 모든 데이터를 작성

-- 기존 테이블의 데이터를 수정하지 않기 위해서 새로운 테이블 만듦 (기존 테이블 구조, 내용 복사)
CREATE TABLE EMP_TEMP
AS SELECT * FROM EMP;

CREATE TABLE DEPT_TEMP
AS SELECT * FROM DEPT;


INSERT INTO EMP_TEMP (EMPNO, ENAME) VALUES (8000, 'GOOTT');
COMMIT;

INSERT INTO EMP_TEMP (EMPNO, ENAME) VALUES (8001, 'GOOTT2');
ROLLBACK; -- 이전 커밋 상태로 되돌림

INSERT INTO EMP_TEMP VALUES (8001, 'GOOTT2', 'SALESMAN', 7698, SYSDATE, 3000, 0, 30);
COMMIT;

INSERT INTO EMP_TEMP VALUES (8002, 'GOOTT3', 'SALESMAN', 7698, 3000, 0, 30);
-- 오류 발생: 열의 개수 != 데이터 개수
-- 만약 특정 열에 데이터를 추가하고 싶으면 () 안에 열 이름을 작성해줘야 함!

INSERT INTO EMP_TEMP VALUES ('AAAA', 'GOOTT3', 'SALESMAN', 7698, SYSDATE, 3000, 0, 30);
-- 오류 발생: 열의 자료형 != 데이터 자료형

-- Q1. 오늘 날짜 (2022/01/05)로 데이터 넣어보기
INSERT INTO EMP_TEMP VALUES (8002, 'GOOTT3', 'SALESMAN', 7698,  TO_DATE('2022/01/05', 'YYYY/MM/DD') , 3000, 0, 30);
COMMIT;

-- Q2. 테이블 생성 (EMP_TEMP2)을 하는데 구조만 복사를 하고 데이터는 복사하지 않으려면 ?
CREATE TABLE EMP_TEMP2
AS SELECT * FROM EMP WHERE 1 <> 1; -- 조건절에 조건식이 False가 되면 셀렉한 결과 행이 없음

-- Q3. EMP 테이블에서 DEPTNO = 30번인 사원만 EMP_TEMP2에 INSERT
INSERT INTO EMP_TEMP2 
SELECT *
FROM EMP
WHERE DEPTNO = 30;
COMMIT;

-- Q4. EMP 테이블에서 구조만 복사한 EMP_TEMP3
-- EMP, SALGRADE 테이블을 이용하여 사원의 SAL 등급이 1등급인 사원만 EMP_TEMP3에 복사
-- (EMPNO, ENAME, SAL, COMM)
CREATE TABLE EMP_TEMP3
AS SELECT * FROM EMP WHERE 1 <> 1;

-- ISO 비표준
INSERT INTO EMP_TEMP3 (EMPNO, ENAME, SAL, COMM)
SELECT E.EMPNO, E.ENAME, E.SAL, E.COMM
FROM EMP E, SALGRADE S
WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL AND S.GRADE = 1;
COMMIT;

-- ISO 표준
INSERT INTO EMP_TEMP3 (EMPNO, ENAME, SAL, COMM)
SELECT E.EMPNO, E.ENAME, E.SAL, E.COMM
FROM EMP E JOIN SALGRADE S ON (E.SAL BETWEEN S.LOSAL AND S.HISAL)
WHERE S.GRADE = 1;
COMMIT;

-- Q5. EMP 테이블에서 구조만 복사한 EMP_TEMP4
-- SMITH의 SAL보다 많은 SAL를 받고 있는 사원들의 모든 정보 복사
CREATE TABLE EMP_TEMP4
AS SELECT * FROM EMP WHERE 1 <> 1;

INSERT INTO EMP_TEMP4
SELECT *
FROM EMP
WHERE SAL > (SELECT SAL FROM EMP WHERE ENAME = 'SMITH');
SELECT * FROM EMP_TEMP4;
COMMIT;

-- Q6. EMP 테이블에서 구조만 복사한 EMP_TEMP5
-- 30번 부서의 평균 SAL보다 많은 SAL를 받고 있는 30번 부서 사원들의 모든 정보 복사
CREATE TABLE EMP_TEMP5
AS SELECT * FROM EMP WHERE 1 <> 1;

INSERT INTO EMP_TEMP5
SELECT *
FROM EMP
WHERE SAL > (SELECT AVG(SAL) FROM EMP WHERE DEPTNO = 30) AND DEPTNO = 30; 
COMMIT;

CREATE TABLE EMP_TEMP5_2
AS SELECT * FROM EMP WHERE 1 <> 1;

INSERT INTO EMP_TEMP5_2
SELECT *
FROM (SELECT * FROM EMP WHERE DEPTNO = 30) EMP_DEPTNO30
WHERE EMP_DEPTNO30.SAL > (SELECT AVG(SAL) FROM EMP WHERE DEPTNO = 30); 
COMMIT;


-- 데이터 일괄 삽입
-- .CSV 파일을 직접 INSERT 해서 테이블 POP_IN_SEOUL 생성 (데이터 임포트 마법사 이용)
DROP TABLE POP_IN_SEOUL;
SELECT * FROM POP_IN_SEOUL;
DESC POP_IN_SEOUL;

-- Q1. 고령자가 가장 많은 자치구 출력
SELECT 자치구
FROM POP_IN_SEOUL
WHERE 고령자 = (SELECT MAX(고령자) FROM POP_IN_SEOUL);

-- Q2. 외국인 (남성, 여성 포함)이 가장 많은 자치구 출력
SELECT 자치구
FROM POP_IN_SEOUL
WHERE 외국인남성 + 외국인여성 = (SELECT MAX(외국인남성 + 외국인여성) FROM POP_IN_SEOUL);

-- Q3. 각 자치구의 한국인 합계, 외국인 합계, 각 자치구의 총 인원 계산해서 열로 출력
SELECT 자치구, 한국인남성+한국인여성 AS 한국인합계, 외국인남성+외국인여성 AS 외국인합계,
한국인남성+한국인여성+외국인남성+외국인여성 AS 합계
FROM POP_IN_SEOUL;


-- Q4. 각 자치구의 한국인 남성과 한국인 여성수를 비교했을 때 
--      한국인 남성이 더 많으면 M, 한국인 여성이 더 많으면 F을 출력
SELECT 자치구, 한국인남성, 한국인여성, 
    CASE 
        WHEN 한국인남성 > 한국인여성 THEN 'M'
        WHEN 한국인남성 < 한국인여성 THEN 'F'
        END AS 남녀비율
FROM POP_IN_SEOUL;


-- INSERT ALL
CREATE TABLE EMP_TEMP6
AS SELECT * FROM EMP WHERE 1 <> 1;

INSERT ALL
INTO EMP_TEMP6 (EMPNO, ENAME) VALUES (1111, 'SALLY')
INTO EMP_TEMP6 (EMPNO, ENAME) VALUES (2222, 'JONES')
INTO EMP_TEMP6 (EMPNO, ENAME) VALUES (3333, 'GILDONG')
SELECT * FROM DUAL;
COMMIT;

-- INSERT INTO + UNION ALL
INSERT INTO EMP_TEMP6 (EMPNO, ENAME)
WITH NAMES AS (
    SELECT 4444, 'SMITH' FROM DUAL UNION ALL
    SELECT 5555, 'JAVA' FROM DUAL UNION ALL
    SELECT 6666, 'ORACLE' FROM DUAL
)
SELECT * FROM NAMES;
COMMIT;

-- SQL LOADER 이용 (.CSV 파일, .CTL 파일)
-- cmd, terminal 창에서
-- sqlldr scott control="pop_in_seoul.ctl"
/*
load data
infile 'pop_in_seoul_wo_comma.csv'
into table POP_IN_SEOUL2
fields terminated by "," optionally enclosed by '"'
(자치구, 한국인남성, 한국인여성, 외국인남성, 외국인여성, 고령자 terminated by whitespace)
*/

CREATE TABLE POP_IN_SEOUL2
AS SELECT * FROM POP_IN_SEOUL WHERE 1 <> 1;
SELECT * FROM POP_IN_SEOUL2;


-- UPDATE (데이터 수정)
-- UPDATE 테이블 이름 SET 변경할 열 이름 = 값 WHERE 조건식

SELECT * FROM EMP_TEMP;

--  Q1. EMP_TEMP 테이블에서 이름에 GOOTT 포함된 사원들의 SAL 5000 변경
UPDATE EMP_TEMP 
SET SAL = 5000
WHERE ENAME LIKE '%GOOTT%';
SELECT * FROM EMP_TEMP;
COMMIT;

-- Q2. EMP_TEMP 테이블에서 급여가 2500 이하인 사원들의 COMM을 1000 변경
UPDATE EMP_TEMP
SET COMM = 1000
WHERE SAL <= 2500;
SELECT * FROM EMP_TEMP;
COMMIT;

-- Q3. DEPT_TEMP 테이블에서 부서이름이 SALES인 부서의 위치를 SEOUL로 변경
UPDATE DEPT_TEMP
SET LOC = 'SEOUL'
WHERE DNAME = 'SALES';
SELECT * FROM DEPT_TEMP;
COMMIT;

-- Q4. DEPT_TEMP 테이블에서 30번 부서의 부서 이름과 위치를 40번 부서와 동일하게 변경
UPDATE DEPT_TEMP
SET (DNAME, LOC) = (SELECT DNAME, LOC FROM DEPT_TEMP WHERE DEPTNO = 40)
WHERE DEPTNO = 30;
SELECT * FROM DEPT_TEMP;
COMMIT;

-- UPDATE할 때 WHERE절 생략되어있으면 ..? 
-- => 지정된 열의 모든 데이터가 40번 부서의 DNAME, LOC과 동일하게 변경
UPDATE DEPT_TEMP
SET (DNAME, LOC) = (SELECT DNAME, LOC FROM DEPT_TEMP WHERE DEPTNO = 40);
SELECT * FROM DEPT_TEMP;
COMMIT;

-- DELETE (데이터 삭제)
-- DELETE FROM 테이블 명 WHERE 조건식

-- DELETE할 때 WHERE절 생략되어있으면 ...?
-- => 테이블 전체 데이터 삭제
DELETE FROM DEPT_TEMP;
SELECT * FROM DEPT_TEMP;
COMMIT;

-- Q1. EMP_TEMP6에서 이름에 O가 들어간 사원 삭제
DELETE FROM EMP_TEMP6
WHERE ENAME LIKE '%O%';
SELECT * FROM EMP_TEMP6;
COMMIT;

-- Q2. EMP_TEMP 테이블에서 급여 등급이 3등급인 사원들 삭제
-- 급여 등급은 SALGRADE를 이용

DELETE FROM EMP_TEMP
WHERE SAL BETWEEN (SELECT LOSAL FROM SALGRADE WHERE GRADE = 3) 
        AND (SELECT HISAL FROM SALGRADE WHERE GRADE = 3);
SELECT * FROM EMP_TEMP;
COMMIT;

-- 조인 이용
DELETE FROM EMP_TEMP
WHERE SAL IN (SELECT E.SAL FROM EMP_TEMP E JOIN SALGRADE S ON (E.SAL BETWEEN S.LOSAL AND HISAL) 
                        WHERE S.GRADE = 3);
SELECT * FROM EMP_TEMP;
COMMIT;


-- Q3. EMP_TEMP 테이블에서 DEPTNO가 20인 사원들의 MGR, SAL, COMM을 NULL로 변경
-- (*) DELETE: 조건을 만족하는 행 자체 삭제
-- (*) UPDATE 테이블명 SET 열 이름 = NULL: 조건을 만족하는 행의 일부 데이터만 NULL로 변경
UPDATE EMP_TEMP
SET MGR = NULL, SAL = NULL, COMM = NULL
WHERE DEPTNO = 20;
SELECT * FROM EMP_TEMP;
COMMIT;

-- Q4. EMP_TEMP2 테이블에서 근무지가 'NEW YORK'인 부서에서 일하는 사원 삭제 
-- 근무지 검색은 DEPT를 이용
DELETE FROM EMP_TEMP2
WHERE DEPTNO = (SELECT DEPTNO FROM DEPT WHERE LOC = 'NEW YORK');
SELECT * FROM EMP_TEMP2;
COMMIT;

-- 조인 이용
DELETE FROM EMP_TEMP2
WHERE DEPTNO IN (SELECT E.DEPTNO FROM EMP_TEMP2 E  JOIN DEPT D ON (E.DEPTNO = D.DEPTNO) 
                            WHERE D.LOC = 'NEW YORK');
SELECT * FROM EMP_TEMP2;
COMMIT;

-- Q5. EMP 테이블의 구조와 데이터를 복사한 EMP_TEMP7를 만들고 
-- 부서별 SAL가 가장 높은 사람을 제외하고 모든 사원 삭제
CREATE TABLE EMP_TEMP7
AS SELECT * FROM EMP;

DELETE FROM EMP_TEMP7
WHERE (DEPTNO, SAL) NOT IN (SELECT DEPTNO, MAX(SAL) OVER(PARTITION BY DEPTNO) FROM EMP_TEMP7);
SELECT * FROM EMP_TEMP7;
COMMIT;

-- SQL 논리적 오류 (아래 예제에서 1번 사원은 2번 부서의 MAX(SAL)이기 때문에 같이 선택)
-- DEPTNO, MAX(SAL)를 같이 비교해야 함!
DELETE FROM EMP_TEMP7
WHERE SAL NOT IN (SELECT MAX(SAL) OVER(PARTITION BY DEPTNO) FROM EMP_TEMP7);
SELECT * FROM EMP_TEMP7;
COMMIT;
-- EX)
-- 1 - A - 10 - 3000
-- 2 - B - 10 - 5000
-- 3 - C - 20 - 3000
-- 4 - D - 30 - 6000

-- 10 - 5000
-- 20 - 3000
-- 30 - 6000

-- 삭제된 테이블 영구 삭제
SELECT * FROM RECYCLEBIN;
PURGE RECYCLEBIN;

