-- 내장 함수 (built-in function): 오라클에서 제공해주는 함수

SELECT * FROM EMP WHERE UPPER(ENAME) LIKE '%A%';

-- 1) 단일행 함수 (single-row function)

-- 문자형 함수
SELECT ENAME, UPPER(ENAME), LOWER(ENAME), LENGTH(ENAME) FROM EMP;
SELECT ENAME, SUBSTR(ENAME, 3) FROM EMP; 
-- SUBSTR(문자열 데이터, 시작 위치): 시작 위치 ~ 문자열 데이터 끝까지 추출
-- SUBSTR(문자열 데이터, 시작 위치, 추출 길이): 시작 위치부터 추출 길이만큼 추출
-- (*) 시작 위치를 지정할 때 0부터가 아니라 1부터 시작
-- EX) SMITH => 3번째 글자 'I'

SELECT * FROM EMP;

-- Q1. MGR에서 뒤에 두 글자 (98, 39 ...)만 추출한 문자열과 원본과 함께 출력
-- (MGR이 NULL값 제외)

-- 문자열의 길이를 알거나 짧을 경우
SELECT MGR, SUBSTR(MGR, 3, 2) FROM EMP WHERE MGR IS NOT NULL;
SELECT MGR, SUBSTR(MGR, 3) FROM EMP WHERE MGR IS NOT NULL;

-- 문자열의 길이를 모르거나 길 경우
-- 7902 => 0의 인덱스: 3, -2, LENGTH(MGR)-1
-- 원소:    7    9    0     2
-- 인덱스:   1    2    3    4
-- 인덱스:  -4   -3   -2   -1
-- 인덱스: l-3   l-2  l-1   l
-- l: LENGTH(MGR) = 4

-- S: 'AAAAABBBBSDQSAD'
-- 맨 뒤에 있는 D 문자의 위치
-- 15, -1, LENGTH(S)

SELECT MGR, SUBSTR(MGR, LENGTH(MGR)-1, 2) FROM EMP WHERE MGR IS NOT NULL;
SELECT MGR, SUBSTR(MGR, LENGTH(MGR)-1) FROM EMP WHERE MGR IS NOT NULL;
SELECT MGR, SUBSTR(MGR, -2) FROM EMP WHERE MGR IS NOT NULL;
SELECT MGR, SUBSTR(MGR, -2, 2) FROM EMP WHERE MGR IS NOT NULL;


-- Q2. ENAME에서 중간 글자 추출한 문자열과 원본과 함께 출력
-- EX) ALLEN => 'L', KING => 'IN'
-- (MOD(숫자, 나눌 숫자) 연산자를 이용)

SELECT EMPNO, ENAME, SUBSTR(ENAME, LENGTH(ENAME)/2+1, 1) AS MIDDLENAME
FROM EMP
WHERE MOD(LENGTH(ENAME), 2) <> 0 -- 문자열의 길이가 홀수
UNION
SELECT EMPNO, ENAME, SUBSTR(ENAME, LENGTH(ENAME)/2, 2) AS MIDDLENAME2
FROM EMP 
WHERE MOD(LENGTH(ENAME), 2) = 0; -- 문자열의 길이가 짝수

-- INSTR 함수
-- : 특정 문자(열)이 어디에 포함되어있는지 알고자 할 때 

-- INSTR(대상 문자열, 찾으려고 하는 문자(열), 시작 인덱스, 몇 번째 글자 (검색 결과가 여러 개일 경우))
-- : 만약에 찾으려고 하는 문자가 없으면 0 반환

-- LIKE '%S%'
-- INSTR(문자열, 'S') > 0

-- : 시작 인덱스를 음수를 쓰면 오른쪽부터 -> 왼쪽 방향으로 검색

-- DUAL
-- : DUMMY TABLE
-- : 연산이나 결과를 잠시 보여주는 데 사용하는 테이블 
SELECT * FROM DUAL;

SELECT INSTR('HELLO', 'L') AS L_INSTR
FROM DUAL;
-- HE(L)LO: 첫번째로 찾은 L의 위치 반환

SELECT INSTR('HELLO', 'L', 1, 2) AS L_INSTR
FROM DUAL;
--  HEL(L)O: 두번째로 찾은 L의 위치 반환

SELECT INSTR('HELLO', 'A') AS L_INSTR
FROM DUAL;
-- 문자열 안에서 찾으려고 하는 문자가 없을 경우에는 0을 반환

-- 시작 인덱스가 음수가 되면 오른쪽 -> 왼쪽
SELECT INSTR('HELLO', 'L', -1) AS L_INSTR
FROM DUAL;
--  HEL(L)O: 뒤에서부터 첫번째로 찾은 L의 위치 반환

SELECT INSTR('HELLO', 'L', -1, 2) AS L_INSTR
FROM DUAL;
--  HE(L)LO: 뒤에서부터 두번째로 찾은 L의 위치 반환

-- EMP 테이블에서 사원 이름에 'K'가 포함되는 사원 이름 출력
-- EX) LIKE '%K%'
SELECT ENAME
FROM EMP
WHERE ENAME LIKE '%K%'; -- INSTR()

SELECT ENAME
FROM EMP
WHERE INSTR(ENAME, 'K') > 0;

-- REPLACE 함수
-- : 특정 문자를 다른 문자로 바꾸는 함수
-- REPLACE(문자열/열 이름, 찾는 문자, 대체할 문자 (선택))
-- (*) 대체할 문자가 없으면 문자열 데이터에서 삭제

SELECT '801111-1234567' AS REGNUM, REPLACE('801111-1234567', '-', ' ') AS REP_REGNUM
FROM DUAL;

-- EX) 계좌번호, 주민등록번호, 핸드폰번호 등에서 특정 문자를 삭제하거나 대체하고 싶을 때


-- 데이터 빈 공간을 특정 문자로 채우는 함수
-- LPAD (Left Padding)
-- RPAD (Right Padding)
-- LPAD/RPAD(문자열/열 이름, 데이터 자릿수, 패딩할 문자 (선택))
-- (*) 패딩할 문자가 없으면 빈 공간의 자릿수만큼 공백 문자로 채움

SELECT 'ORACLE', LPAD('ORACLE', 4, '*'), RPAD('ORACLE', 4, '*') FROM DUAL;
SELECT 'ORACLE', LPAD('ORACLE', 10), RPAD('ORACLE', 10) FROM DUAL;

-- java left padding: String.format("%10s", "ORACLE").replace(' ', '*')
-- java right padding: String.format("%-10s", "ORACLE").replace(' ', '*')

-- Q1. 주민등록번호 '801111-1234567' => '801111-*******'
SELECT '801111-1234567' AS REG, 
RPAD(SUBSTR('801111-1234567', 1, 7), LENGTH('801111-1234567'), '*') AS RPAD_REG 
FROM DUAL;

-- 만약에 넣으려고 하는 문자열보다 데이터 자릿수가 작을 경우에는 문자열 손실 (잘림)
SELECT 'ORACLE', LPAD('ORACLE', 5), RPAD('ORACLE', 5) FROM DUAL;


-- CONCAT 함수
-- : 두 문자열을 하나로 결합

-- 연산자 => ||
SELECT CONCAT(EMPNO, ENAME) AS ID FROM EMP;
SELECT EMPNO || ENAME AS ID FROM EMP;

-- TRIM, LTRIM, RTRIM
-- 문자열 내에 특정 문자를 지우기 위해 사용

-- 기본값: 공백 제거
SELECT TRIM('               안녕하세요!           ') AS TRIM_STR
FROM DUAL;

-- 특정 문자 지우기 (만약에 _가 연속적이지 않은 경우에는 다른 문자가 들어온 순간부터 TRIM 되지 않음)
-- (*) TRIM은 여러 개의 문자 지정 X 
SELECT TRIM('_' FROM '___ ______안녕하세요!_____ ___') AS TRIM_STR
FROM DUAL;

-- (*) LTRIM, RTRIM은 여러 개의 문자 지정 O
SELECT LTRIM('___ ______안녕하세요!_____ ___', '_ ') AS TRIM_STR
FROM DUAL;
SELECT RTRIM('___ ______안녕하세요!_____ ___', '_ ') AS TRIM_STR
FROM DUAL;


SELECT TRIM(LEADING '_' FROM '___ ______안녕하세요!_____ ___') AS TRIM_STR
FROM DUAL;
SELECT TRIM(TRAILING '_' FROM '___ ______안녕하세요!_____ ___') AS TRIM_STR
FROM DUAL;

-- Q1. <title>My Page</title> => My Page
SELECT RTRIM(LTRIM('<title>My Page</title>', '<title>'), '</title>') AS CRAWLING FROM DUAL;
-- My Page에 e가 같이 사라짐 => '</title>'에 e가 포함이 되어있기 때문에 같이 사라짐


-- 숫자형 함수
-- ROUND: 반올림 함수 
SELECT ROUND(12.54, 0) AS ROUND FROM DUAL; -- 소수점 0번째까지 표현!
SELECT ROUND(15.54, -1) AS ROUND FROM DUAL; -- 소수점 -1번째까지 표현!

-- TRUNC: 버림 함수
-- : 지정된 자리에서 숫자 버림 (버림할 자릿수를 지정할 수 있음)
-- : 만약 버림할 자릿수를 지정하지 않으면 소수점 0번째 자리까지 표현
SELECT TRUNC(1234.5678, 2) AS TRUNC FROM DUAL; -- 소수점 두번째 자리까지 표현
SELECT TRUNC(1236.5678, -1) AS TRUNC FROM DUAL; -- 소수점 -1번째 자리까지 표현

-- FLOOR: 내림 함수 
SELECT FLOOR(1234.5678) AS FLOOR FROM DUAL; -- 소수점 밑을 내림 (가까운 작은 정수로 표현)

-- CEIL: 올림 함수
SELECT CEIL(1234.4678) AS CEIL FROM DUAL; -- 소수점 밑을 올림 (가까운 큰 정수로 표현)

-- MOD: 나머지 함수
SELECT MOD(10, 2) AS MOD FROM DUAL;


-- 날짜형 함수
-- SYSDATE
-- : ORACLE DB가 설치된 OS (운영체제)의 시간
SELECT SYSDATE FROM DUAL;

-- ADD_MONTHS
-- : 특정 날짜에 지정한 개월 수만큼 더한 날짜 데이터 반환
-- ADD_MONTHS(날짜 데이터, 더할 개월 수)
SELECT SYSDATE, ADD_MONTHS(SYSDATE, 3) FROM DUAL; -- 현재 시스템 시간의 3개월 후
SELECT SYSDATE, ADD_MONTHS(SYSDATE, -3) FROM DUAL; -- 현재 시스템 시간의 3개월 전

-- Q1. EMP 테이블에서 사원들의  근무 일수 계산
SELECT ROUND(SYSDATE - HIREDATE) AS WORKDAYS FROM EMP;

-- Q2. EMP 테이블에서 입사한지 40년이 넘는 사원들의 모든 정보 출력
SELECT * FROM EMP WHERE ADD_MONTHS(HIREDATE, 40 * 12) < SYSDATE;
SELECT * FROM EMP WHERE (SYSDATE - HIREDATE) / 365 > 40;

-- Q3. EMP 테이블에서 사원들의 10주년이 되는 날짜를 사원 이름과 같이 출력
SELECT ENAME, HIREDATE, ADD_MONTHS(HIREDATE, 10 * 12) 
AS WORK_10_YEAR 
FROM EMP;

-- MONTHS_BETWEEN
-- : 두 날짜 사이의 개월 수 차이 계산 함수
-- (*) MONTHS_BETWEEN(날짜 데이터1, 날짜 데이터2)
-- 날짜 데이터1 - 날짜 데이터2로 개월 수를 계산하기 때문에 순서 조심!

-- 사원들이 몇 개월 일했는지 출력 
SELECT MONTHS_BETWEEN(HIREDATE, SYSDATE) AS MONTH1, -- HIREDATE - SYSDATE
MONTHS_BETWEEN(SYSDATE, HIREDATE) AS MONTH2 -- SYSDATE - HIREDATE
FROM EMP;


-- NEXT_DAY(), LAST_DAY()
-- NEXT_DAY(날짜 데이터, 요일 문자) 
-- : 특정 날짜를 기준으로 돌아오는 요일 날짜 출력
-- EX) 2021/12/27 => 2: 2022/1/3
--                            1: 2022/1/2
--                            3: 2021/12/28
-- 요일 문자
-- 1: '일'
-- 2: '월'
-- 3: '화'
-- .....

-- LAST_DAY(날짜 데이터)
-- : 특정 날짜가 속한 달의 마지막 날짜 출력

SELECT SYSDATE, NEXT_DAY(SYSDATE, 5), LAST_DAY(SYSDATE) FROM DUAL;


-- ROUND, TRUNC
-- : 숫자에서 지원하는 함수 -> 날짜에서도 지원!
-- (*) 소수점 자리를 표현하지 않고 반올림/버림의 기준이 될 포맷 지정

-- ROUND(날짜 데이터, 반올림 기준 포맷)
-- TRUNC(날짜 데이터, 버림 기준 포맷)

-- 포맷값
-- YYYY, YYY, YY, Y: 날짜 데이터에서 7월 1일 기준
-- DD, DDD: 해당 일에서 정오 (12:00:00) 기준
-- HH, HH12, HH24: 해당 일의 시간 기준


SELECT ROUND(SYSDATE, 'YYYY') AS FORMAT_YYYY FROM DUAL; 
-- 7월 1일이 넘었기 때문에 2022년으로 반올림

SELECT ROUND(SYSDATE, 'DD') AS FORMAT_DD FROM DUAL; 
-- 시간이 정오를 넘지 않았기 때문에 12월 27일로 반올림

SELECT ROUND(SYSDATE, 'HH') AS FORMAT_DD FROM DUAL; 
-- 현재 시간이 11:40분이니까 12시로 반올림

-- 형 변환
-- 1) 암시적 형 변환
-- 숫자형 + 문자형 -> 만약 문자형이 숫자로 변환이 가능한 경우에는 숫자형 자동 형변환
SELECT EMPNO + '500' FROM EMP; -- EMPNO (숫자) + '500' (숫자로 인식 가능) => 연산 O
SELECT EMPNO + 'AAA' FROM EMP; -- EMPNO (숫자) + 'AAA' (숫자로 인식 불가) => 연산 X
SELECT EMPNO || 'AAA' FROM EMP; -- EMPNO (문자로 인식 가능) || 'AAA' (문자) => 연산 O


-- 2) 명시적 형 변환
-- 형 변환 함수 
-- 날짜형 -> 문자형: TO_CHAR
-- (*) TO_CHAR(날짜 데이터, 출력하고자 하는 문자열)
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS') AS NOW FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'YYYY/MM/DD HH12:MI:SS AM') AS NOW FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'YYYY/MM/DD HH12:MI:SS AM DAY') AS NOW FROM DUAL;
SELECT TO_CHAR(HIREDATE, 'YYYY/MM/DD W') AS NOW FROM EMP;
SELECT TO_CHAR(SYSDATE, 'YYYY/MM/DD HH12:MI:SS AM DAY',
'NLS_DATE_LANGUAGE = AMERICAN') AS DAY FROM DUAL;

-- 문자형 -> 날짜형: TO_DATE
-- (*) TO_DATE(문자열 데이터, 인식되어야 할 숫자 형태)
SELECT TO_DATE('2021-12-27', 'YYYY-MM-DD') AS TODATE FROM DUAL;
SELECT TO_DATE('2021/12/27', 'YYYY/MM/DD') AS TODATE FROM DUAL;

-- Q1. EMP 테이블에서 입사일이 1981년 7월 20일 이후인 사원 정보 출력
-- (*) DATE끼리는 크기 비교 연산자 지원, >, <, >=, <=
SELECT * FROM EMP WHERE HIREDATE > TO_DATE('1981-07-20', 'YYYY-MM-DD');


-- 문자형 -> 숫자형: TO_NUMBER
-- TO_NUMBER(문자열 데이터, 인식되어야 할 숫자 형태)

SELECT 5000 - TO_NUMBER('$3000', '$9,999') FROM DUAL; 
-- 오류 (FORMAT이 맞지 않음)
SELECT 5000 - TO_NUMBER('$3,000', '$9,999') FROM DUAL; 
SELECT 5000 - TO_NUMBER('$300', '$9,999') FROM DUAL; 
-- 9: 각 자리수에 들어갈 수 있는 숫자 최댓값 
SELECT 5000 - TO_NUMBER('$3,000', '$1,000') FROM DUAL; 
-- 오류 (최대로 표현할 수 있는 수 안에 들지 않음)

-- 숫자 형태 작성할 때 조심해야할 점
-- 1) 자릿수 확인
-- 2) 각 자리수에 최대로 표현할 수 있는 수 안에 드는지 확인

-- NULL 처리 함수
-- (*) 산술/비교 연산자에서 NULL를 만나면 연산의 결과 NULL
SELECT ENAME, SAL, COMM, SAL*12+COMM AS ANNUALSAL FROM EMP;

-- 1) NVL (NULL VALUE)
-- NVL(NULL인지 여부를 검사할 데이터/열, 앞의 인자가 NULL일 경우 대체할 데이터)
-- : NULL이 아니면 데이터가 그대로 반환
-- : NULL이면 두 번째 인자로 NULL값을 대체할 값 지정
-- (*) 대체할 데이터 자료형 == 기존 데이터 자료형

SELECT ENAME, SAL, COMM, 
SAL*12+COMM AS ANNUALSAL,
SAL*12+NVL(COMM, 0) AS ANNUALSAL_NVL
FROM EMP;

-- 2) NVL2
-- NVL2(NULL인지 여부를 검사할 데이터/열, 
-- 앞의 인자가 NULL이 아닌 경우 대체할 데이터, 
-- 앞의 인자가 NULL일 경우 대체할 데이터)
SELECT ENAME, SAL, COMM, 
SAL*12+COMM AS ANNUALSAL,
SAL*12+NVL(COMM, 0) AS ANNUALSAL_NVL,
SAL*12+NVL2(COMM, COMM, 0) AS ANNUALSAL_NVL2,
NVL2(COMM, 'O', 'X') AS ISCOMM
FROM EMP;

-- Q1. COMM NULL, 0 => 'X', 나머지 경우는 => 'O'
SELECT ENAME, SAL, COMM, 
REPLACE(COMM, 0, NULL) AS REPLACE_ORIGINAL,
RPAD(REPLACE(COMM, 0, NULL), LENGTH(COMM), 0) AS REPLACE, 
NVL2(RPAD(REPLACE(COMM, 0, NULL), LENGTH(COMM), 0), 'O', 'X') AS ISCOMM 
FROM EMP;
-- 301이라는 숫자는 오류가 생길 수 있음

SELECT ENAME, SAL, COMM, NVL2(COMM, 'O', 'X') AS ISCOMM FROM EMP;

-- NVL VS NVL2
-- NVL2: NULL이 아닌 경우에도 반환 데이터까지 지정할 수 있음
-- NVL를 더 많이 사용

-- 조건문 (DECODE 함수, CASE문)
-- : NULL 값이 아닌 경우에도 특정 열 / 데이터 값에 따라 반환할 데이터를 결정
-- (Java에서 if, switch-case문과 비슷)

-- DECODE
-- : 검사할 열 / 데이터에 대한 등호 연산 밖에 수행할 수 없음 (switch-case문)

-- DECODE(검사할 열 / 데이터,
--                조건1, 반환 값,
--                조건2, 반환 값,
--                ......
--                위의 조건에 해당하지 않을 때 반환할 값)
-- * 위의 조건에 해당하지 않을 때 반환할 값 (else문)을 지정하지 않으면 NULL로 반환


-- EX) EMP 테이블에서 직책에 따라 급여 인상률을 변경
-- A. MANAGER: 10% -> 0.1
-- B. SALESMAN: 5% -> 0.05
-- C. 나머지 이 외의 직책: 3% -> 0.03

SELECT EMPNO, ENAME, JOB, SAL,
    ROUND(DECODE(JOB,
                'MANAGER', SAL+SAL*0.1, -- SAL*1.1
                'SALESMAN', SAL+SAL*0.05, -- SAL*1.05
                SAL+SAL*0.03)) -- SAL*1.03
    AS NEWSAL
FROM EMP;

-- Q1. COMM NULL, 0 => 'X', 나머지 경우는 => 'O'
SELECT EMPNO, ENAME, SAL, COMM,
    DECODE(COMM,
                NULL, 'X', -- COMM IS NULL (COMM = NULL (X))
                0, 'X',
                'O')
    AS ISCOMM
FROM EMP;


-- CASE 문 (함수 아님)
-- : CASE 문에는 다양한 조건식이 올 수가 있음
-- : CASE 문을 더 많이 사용함 (DECODE에 비해)
-- * 위의 조건에 해당하지 않을 때 반환할 값 (else문)을 지정하지 않으면 NULL로 반환

-- CASE 검사할 열 / 데이터
-- WHEN 조건1 THEN 반환값
-- WHEN 조건2 THEN 반환값
-- .....
-- ELSE 위의 조건에 해당하지 않을 때 반환할 값
-- END

-- CASE 
-- WHEN 조건1 (검사할 열 / 데이터) THEN 반환값
-- WHEN 조건2 (검사할 열 / 데이터) THEN 반환값
-- .....
-- ELSE 위의 조건에 해당하지 않을 때 반환할 값
-- END

-- EX) EMP 테이블에서 직책에 따라 급여 인상률을 변경
-- A. MANAGER: 10% -> 0.1
-- B. SALESMAN: 5% -> 0.05
-- C. 나머지 이 외의 직책: 3% -> 0.03
SELECT EMPNO, ENAME, JOB, SAL,
    CASE JOB -- 'JOB =' 생략
        WHEN 'MANAGER' THEN ROUND(SAL+SAL*0.1)
        WHEN 'SALESMAN' THEN ROUND(SAL+SAL*0.05)
        ELSE ROUND(SAL+SAL*0.03)
    END AS NEWSAL
FROM EMP;

SELECT EMPNO, ENAME, JOB, SAL,
    CASE 
        WHEN JOB = 'MANAGER' THEN ROUND(SAL+SAL*0.1)
        WHEN JOB = 'SALESMAN' THEN ROUND(SAL+SAL*0.05)
        ELSE ROUND(SAL+SAL*0.03)
    END AS NEWSAL
FROM EMP;

-- Q1. SAL의 범위가 어떤지에 따라서 세금 결정한다고 가정
-- SAL <= 1000 => 8%
-- SAL <= 3000 => 10%
-- SAL <= 5000 => 13%
-- 이외의 SAL => 15%
SELECT EMPNO, ENAME, SAL,
    CASE
        WHEN SAL <= 1000 THEN SAL*0.08 -- SAL <= 1000
        WHEN SAL <= 3000 THEN SAL*0.1 -- 1000 < SAL <= 3000
        WHEN SAL <= 5000 THEN SAL*0.13 -- 3000 < SAL <= 5000
        ELSE SAL*0.15 -- SAL > 5000
    END AS TAX
FROM EMP;


-- Q2. EMP 테이블에서 ENAME에 'A'라는 문자가 들어가 있으면 'A를 포함합니다'
-- 'A'라는 문자가 들어가 있지 않다면 'A를 포함하지 않습니다'를 사원 이름과 함께 출력
-- (데이터의 대소문자 구분하지 않고 알파벳 A(a)가 포함되어있는지 확인)

-- 테이블 이름이나 열 이름은 대소문자 구분 X
select * from emp WHERE EMPNO = 7369;
SELECT * FROM EmP WHERE empno = 7369;
SELECT * FROM EMP where EmpNo = 7369;

-- 테이블에 들어간 데이터 자체는 대소문자 구분 O
-- (테이블에 데이터를 어떻게 삽입했는 지에 따라 달라짐)

--  1) LIKE 연산자 + 와일드 카드
SELECT ENAME, 
    CASE
        WHEN UPPER(ENAME) LIKE '%A%' THEN 'A(a)를 포함합니다'
        ELSE 'A(a)를 포함하지 않습니다'
    END AS CONTAINSA
FROM EMP;

--  2) INSTR()
SELECT ENAME, 
    CASE
        WHEN INSTR(UPPER(ENAME), 'A') > 0 THEN 'A(a)를 포함합니다'
        ELSE 'A(a)를 포함하지 않습니다'
    END AS CONTAINSA
FROM EMP;


select hiredate from emp where ename = 'KING';
-- Q3. KING의 HIREDATE와 비교하여 
-- KING의 입사날보다 먼저 들어왔다면 'PREV'를 출력
-- KING의 입사날보다 나중에 들어왔다면 'AFTER'를 사원 번호, 사원 이름, 입사일자와 함께 출력
SELECT HIREDATE FROM EMP;

SELECT EMPNO, ENAME, HIREDATE, 
    CASE     
    WHEN HIREDATE < (SELECT HIREDATE FROM EMP WHERE ENAME = 'KING') THEN 'PREV'
    WHEN HIREDATE > (SELECT HIREDATE FROM EMP WHERE ENAME = 'KING') THEN 'AFTER'
    END AS HIREDATE_COMPARE_KING
FROM EMP;

SELECT EMPNO, ENAME, HIREDATE, 
    CASE     
    WHEN HIREDATE < TO_DATE('1981/11/17', 'YYYY/MM/DD') THEN 'PREV'
    WHEN HIREDATE > TO_DATE('1981/11/17', 'YYYY/MM/DD') THEN 'AFTER'
    END AS HIREDATE_COMPARE_KING
FROM EMP;

SELECT TO_DATE('81/11/17', 'YY/MM/DD') FROM DUAL;

-- Q4. EMP 테이블에서 COMM에 따라
-- 만약 COMM이 NULL이면 '해당사항 없음'
-- 만약 COMM = 0이면 '추가수당 없음'
-- 만약 COMM이 0보다 크면 추가수당 (COMM)을 출력
SELECT ENAME, COMM, 
    CASE
        WHEN COMM IS NULL THEN '해당사항 없음'
        WHEN COMM = 0 THEN '추가수당 없음'
        WHEN COMM > 0 THEN COMM || '' -- TO_CHAR(COMM)
    END AS ISCOMM
FROM EMP;


SELECT ENAME, COMM, 
    CASE COMM
        WHEN NULL THEN '해당사항 없음'    -- COMM = NULL (잘못된 연산)
        WHEN 0 THEN '추가수당 없음'
        ELSE TO_CHAR(COMM)
    END AS ISCOMM
FROM EMP;

SELECT ENAME, COMM, 
    DECODE(COMM, 
                NULL, '해당사항 없음',        -- COMM IS NULL
                0, '추가수당 없음',
                TO_CHAR(COMM)) AS ISCOMM
FROM EMP;

-- Q5. EMP 테이블에서 HIREDATE에 따라 
-- 만약 해당 사원이 40년 이상 '40주년 이상'
-- 만약 해당 사원이 40년 미만 '40주년 미만' 출력
SELECT ENAME, HIREDATE, 
    CASE
        WHEN ADD_MONTHS(HIREDATE, 40 * 12) <= SYSDATE THEN '40주년 이상'
        ELSE '40주년 미만'
    END AS ISOVER40YEAR
FROM EMP;

SELECT * FROM EMP;
