-- 연산자 (OPERATOR)

-- 1) = (같다)
SELECT ENAME FROM EMP WHERE DEPTNO = 30;

-- 2 ) !=, ^=, <> (다르다)
-- !=, ^= - ISO 표준 X
-- <>      - ISO 표준 O
SELECT ENAME, DEPTNO FROM EMP WHERE DEPTNO <> 30;
-- DEPTNO <> 30: 30 초과이거나 30 미만 (30이 아닌 행 조회)

-- 3) AND, OR
SELECT * FROM EMP WHERE DEPTNO = 30 AND JOB = 'SALESMAN';
-- (**) SQL에서 문자열의 비교는 =을 사용

SELECT * FROM EMP WHERE DEPTNO = 30 AND JOB = 'salesman'; 
-- 조회 결과가 아무것도 안나옴 (EMP 테이블의 데이터는 대문자로 저장 되어있음)

-- SQL 문장 명령어, 테이블 이름, 열 이름: 대소문자 구분 X
-- 테이블의 데이터: 대소문자 구분 O

-- Q1. EMP 테이블에서 사원 번호가 7499이고 부서 번호가 30인 
-- 사원의 사원 번호, 사원 이름, 부서 번호만 나오도록 출력
SELECT EMPNO, ENAME, DEPTNO FROM EMP WHERE EMPNO = 7499 AND DEPTNO = 30;

-- Q2. EMP 테이블에서 상사 번호 7698이고 직무가 SALESMAN인
-- 사원의 사원 이름만 나오도록 출력
SELECT ENAME FROM EMP WHERE MGR = 7698 AND JOB = 'SALESMAN';

-- Q3. EMP 테이블에서 부서 번호 20이거나 직업이 SALESMAN인 사원 이름만 나오도록 출력
SELECT ENAME, DEPTNO, JOB FROM EMP WHERE DEPTNO = 20 OR JOB = 'SALESMAN';

-- Q4. EMP 테이블에서 사원 급여 2500 달러 이상이고 직업이 ANALYST인 
-- 사원 이름, 급여, 직업 출력
SELECT ENAME, SAL, JOB FROM EMP WHERE SAL >= 2500 AND JOB = 'ANALYST';

-- Q5. EMP 테이블에서 사원 급여 2500 달러 이상이고 직업이 ANALYST인 
-- 사원을 제외한 나머지 사원들의 사원 이름, 급여, 직업 출력 (NOT 이용)
SELECT ENAME, SAL, JOB FROM EMP WHERE NOT (SAL >= 2500 AND JOB = 'ANALYST');
-- SAL < 2500 OR NOT JOB = 'ANALYST'

-- 아래의 두 식은 같음
-- NOT JOB = 'ANALYST'
-- JOB <> 'ANALYST'

-- (사원 이름이 대문자로 되어있다고 가정했을 때)
-- Q6. EMP 테이블에서 사원 이름이 'J'로 시작하는 사원 이름 출력 (>=, < 이용)
SELECT ENAME FROM EMP WHERE ENAME >= 'J' AND ENAME < 'K';

-- 산술 연산자: +, -, *, /
-- 논리 연산자: AND, OR, NOT
-- 비교 연산자: >, <, >=, <=, =, <> (!=, ^=)

-- 4) IN 연산자
-- : 특정 열에 해당하는 조건을 여러 개 지정할 수 있음
-- 아래의 코드에서 중복된 'JOB =' 줄여줄 수 있음 
-- (**) = 연산자만 사용이 가능
SELECT * FROM EMP WHERE JOB = 'MANAGER' OR JOB = 'SALESMAN' OR JOB = 'CLERK';
SELECT * FROM EMP WHERE JOB IN ('MANAGER', 'SALESMAN', 'CLERK');

-- NOT의 위치
SELECT * FROM EMP WHERE JOB NOT IN ('MANAGER', 'SALESMAN', 'CLERK');
-- JOB != 'MANAGER' AND JOB != 'SALESMAN' AND JOB != 'CLERK'
SELECT * FROM EMP WHERE NOT JOB IN ('MANAGER', 'SALESMAN', 'CLERK');

select * from emp; 
select count(*) from emp where empno not in ( select mgr from emp ); 
select count(*) from emp T1 where not exists ( select null from emp T2 where t2.mgr = t1.empno );

select null from emp T1, emp T2 where t1.mgr = t2.empno;


-- 5) BETWEEN 연산자 
-- : 특정 범위 내에서 데이터 조회

SELECT * FROM EMP WHERE SAL >= 2000 AND SAL <= 3000;
SELECT * FROM EMP WHERE SAL BETWEEN 2000 AND 3000; -- 2000, 3000 포함

-- NOT의 위치
SELECT * FROM EMP WHERE SAL NOT BETWEEN 2000 AND 3000;
SELECT * FROM EMP WHERE NOT SAL BETWEEN 2000 AND 3000;

-- Q1. EMP 테이블에서 JOB이 'MANAGER'거나 SAL가 2000 <=  <= 3000 사원 정보 조회
SELECT * FROM EMP WHERE JOB IN ('MANAGER') OR SAL BETWEEN 2000 AND 3000;

-- Q2 . Q1 연산 결과를 반전
SELECT * FROM EMP WHERE NOT (JOB IN ('MANAGER') OR SAL BETWEEN 2000 AND 3000);
SELECT * FROM EMP WHERE JOB NOT IN ('MANAGER') AND SAL NOT BETWEEN 2000 AND 3000;


-- 6) LIKE 연산자 (+ 와일드 카드, WILD CARD)
-- : 일부 문자열 (숫자나 문자)이 포함된 데이터 조회
-- : 데이터 조회시 와일드 카드를 사용 (특정 문자(열)을 대체하는 특수문자)

-- 와일드 카드
-- A. _: 어떤 값이든 상관없이 한 개의 문자
-- B. %: 어떤 값이든 상관없고 길이도 상관이 없는 문자 (0개도 가능)

-- EX) 사원 이름 검색
-- s_: sa, sb, sc .... sz 
-- s%: s, sa, saa, saaaaaa, sabababababzzzzzzzzz

-- (*) 만약에 와일드 카드에서 사용되는 특수기호 (%, _)가 데이터의 일부라면?
-- EX) 30\%, 50\%, gil\_dong (\: escape 문자)
SELECT * FROM EMP WHERE SAL LIKE '28\%'; -- SAL가 28% 인 사원을 찾아줘!
SELECT * FROM EMP WHERE SAL LIKE '28%'; -- SAL의 28로 시작하는 사원을 찾아줘!


DROP TABLE ESCAPETEST;
CREATE TABLE ESCAPETEST
      ( NO VARCHAR(10),
	ITEMNAME VARCHAR(100),
	PRICE NUMBER,
    SALES VARCHAR(10));
INSERT INTO ESCAPETEST VALUES (1, 'COSMETIC', 30000, '30%');
INSERT INTO ESCAPETEST VALUES (2, 'T_SHIRT', 50000, '20%');
COMMIT;

SELECT * FROM ESCAPETEST;
SELECT * FROM ESCAPETEST WHERE SALES = '20%';

SELECT * FROM ESCAPETEST WHERE ITEMNAME LIKE '%\_%' ESCAPE '\';
SELECT * FROM ESCAPETEST WHERE SALES LIKE '%2\%%' ESCAPE '\';

-- EX) EMP 테이블에서 사원 이름이 'J'로 시작하는 사원 이름 출력 (>=, < 이용)
SELECT * FROM EMP WHERE ENAME LIKE 'J%'; -- 길이 제한 X
SELECT * FROM EMP WHERE ENAME LIKE 'J_'; -- 길이 제한 O (무조건 한자리 문자)
SELECT * FROM EMP;

-- Q1. EMP 테이블에서 사원 이름이 'A'를 포함하는 사원 이름 출력
SELECT ENAME FROM EMP WHERE ENAME LIKE '%A%';
-- Q2. EMP 테이블에서 해당 사원의 상사 번호가 79로 시작되는 사원 정보 모두 출력
SELECT * FROM EMP WHERE MGR LIKE '79__'; -- 사원 번호, 상사 번호는 4자리라는 것을 고려
SELECT * FROM EMP WHERE MGR LIKE '79%';
-- Q3. EMP 테이블에서 사원 이름의 두 번째 글자가 'L'인 사원 정보 모두 출력
SELECT * FROM EMP WHERE ENAME LIKE '_L%';
-- Q4. EMP 테이블에서 사원의 입사일이 2월인 사원 정보 모두 출력
-- HINT) YY/MM/DD
SELECT * FROM EMP WHERE HIREDATE LIKE '%/02/%'; 
-- DATE의 한국 표기 방법에서만 가능
-- NLS_TERRITORY = 'KOREA'
SELECT * FROM EMP WHERE TO_CHAR(HIREDATE, 'MM') = '02';

-- 7) IS NULL 연산자
-- : NULL 판단 연산자

-- EX) 열 이름 = NULL ?
SELECT * FROM EMP WHERE COMM = NULL; -- 불가능!
-- NULL은 어떤 연산자를 만나든 연산의 결과가 NULL

SELECT * FROM EMP WHERE COMM IS NULL;
SELECT * FROM EMP WHERE COMM IS NOT NULL;
SELECT * FROM EMP WHERE NOT COMM IS  NULL;

-- 연봉 계산 방법: SAL*12+COMM
-- 연봉 계산의 오류가 있는 사원들의 모든 정보 출력

SELECT ENAME, SAL, COMM, SAL*12+COMM AS ANNUALSAL
FROM EMP WHERE SAL*12+COMM IS NULL;


-- 8) 집합연산자
-- : SELECT문을 통해 조회한 결과를 집합으로 표현 연산자
-- (**) 출력하려고 하는 결과 테이블의 열 개수, 각 열의 자료형이 같아야 함
-- (**) 열의 이름은 첫번째 SELECT문 따라감
-- (**) 조회하려고 하는 테이블이 여러 개이고 결과 데이터를 합집합, 교집합, 차집합할 때 의미있음
-- (=> 잘 쓰이진 않는다! WHY? 결과 테이블의 열 구조 동일하기 어려움)

-- [ UNION ] (합집합)
SELECT * FROM SALGRADE;

CREATE TABLE SALGRADE2
      ( GRADE NUMBER,
	LOSAL NUMBER,
	HISAL NUMBER );
INSERT INTO SALGRADE2 VALUES (6,10000,20000);
INSERT INTO SALGRADE2 VALUES (7,20001,30000);
COMMIT;

SELECT * FROM SALGRADE2;
SELECT * FROM TAB;

-- UNION 불가! (왜냐하면 열의 개수가 맞지 않기 때문)
SELECT GRADE FROM SALGRADE
UNION
SELECT * FROM SALGRADE2;

SELECT * FROM SALGRADE
UNION
SELECT * FROM SALGRADE2;

-- [ INTERSECT ] (교집합)
-- 두 SELECT 문장의 결과 값이 같은 데이터만 출력

SELECT EMPNO, ENAME, DEPTNO FROM EMP WHERE ENAME LIKE '%A%'
INTERSECT
SELECT EMPNO, ENAME, DEPTNO FROM EMP WHERE DEPTNO = 30;

SELECT EMPNO, ENAME, DEPTNO FROM EMP WHERE ENAME LIKE '%A%' AND DEPTNO = 30;

-- [ MINUS ] (차집합)
-- A - B: A의 결과 중에서 B에 존재하지 않은 데이터만 출력 (순수하게 A에게만 포함된 데이터)

SELECT * FROM EMP WHERE JOB = 'SALESMAN'
MINUS
SELECT * FROM EMP WHERE ENAME LIKE '%T%';

--------------------------------------------------------
-- NULL VS 0
-- NULL: 데이터 자체가 없음 (빈 칸)
-- (** NULL / 무한대은 어떤 연산자를 만나도 연산 결과가 NULL / 무한대)
-- 0: 데이터가 있는데 그 값이 0 의미

