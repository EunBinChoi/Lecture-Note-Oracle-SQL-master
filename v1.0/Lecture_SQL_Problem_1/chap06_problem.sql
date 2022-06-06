--# 문제 풀어보기
--
--1. EMPNO 열에는 EMP 테이볼에서 사원 이름(ENAME) 이 다섯 글자 이상이며 여섯 글자 미만인 사원 정보를 출력합니다. 
--   MASKING_EMPNO 열에는 사원 번호(EMPNO) 앞 두 자리 외 뒷자리를 * 기호로 출력합니다. 
--   그리고 MASKING_ENAME 열에는 사원 이름의 첫 글자만 보여 주고 나머지 글자수만큼 * 기호로 출력하세요.
--   
--   ::결과 화면
--      
--   EMPNO	MASKING_EMPNO	ENAME	MASKING_ENAME
--   7369		73**			SMITH	S****
--   7499		74**			ALLEN	A****
--   7566		75**			JONES	J****
--   ...
--

SELECT EMPNO, RPAD(SUBSTR(EMPNO, 1, 2), 4, '*') AS MASKING_EMPNO, 
ENAME,  RPAD(SUBSTR(ENAME, 1, 1), LENGTH(ENAME), '*') AS MAKSING_ENAME
FROM EMP
WHERE LENGTH(ENAME) >= 5 AND LENGTH(ENAME) < 6;


--2. EMP 테이블에서 사원들의 월 평균 근무일 수는 21.5일입니다. 
--   하루 근무 시간을 8시간으로 보았을 때 사원들의 하루 급여 (DAY_PAY)와 
--   시급 (TIME_PAY)을 계산하여 결과를 출력합니다.  
--   단 하루 급여 (DAY_PAY)는 소수점 세 번째 자리에서 버리고, 
--   시급 (TIME_PAY)은 두 번째 소수점에서 반올림하세요.
--   
--   ::결과 화면
--
--   EMPNO 	ENAME	SAL 	DAY_PAY		TIME_PAY
--   7369		SMITH	800		37.2		4.7
--   7499		ALLEN	1600	74.41		9.3
--   7521		WARD	1250	58.13		7.3
--   ...
--   
SELECT EMPNO, ENAME, SAL,
TRUNC((SAL / 21.5), 2) AS DAY_PAY,
ROUND((SAL / 21.5) / 8, 1) AS TIME_PAY
FROM EMP;
 
 
 --3. 오른쪽과 같은 결과가 나오도록 SQL문을 작성해보세요.
--   EMP 테이블에서 사원들은 입사일 (HIREDATE)을 기준으로 3개월이 지난 후 첫 월요일에 정직원이 됩니다.
--   사원들이 정직원이 되는 날짜(R_JOB)를 YYYY-MM-DD 형식으로 오른쪽과 같이 출력해 주세요. 
--   단, 추가 수당(COMM)이 없는 사원의 추가 수당은 N/A로 출력하세요.
--
--   ::결과 화면
--   
--   EMPNO 	ENAME	HIREDATE	R_JOB		COMM
--   7369		SMITH	1980/12/17	1981-03-23	N/A
--   7499		ALLEN	1981/02/20	1981-05-25	300
--   7521		WARD	1981/02/22	1981-05-25  500
--   7566		JONES	1981/04/02	1981-07-06	N/A
--   ...