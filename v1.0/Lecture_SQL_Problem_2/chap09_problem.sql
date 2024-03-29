/* Q1. 전체 사원 중 ALLEN과 같은 직책(JOB)인 사원들의 
 사원 정보, 부서 정보를 다음과 같이 출력하는 SQL문을 작성하세요.
*/
SELECT E.JOB, E.EMPNO, E.ENAME, E.SAL, E.DEPTNO, D.DNAME
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO
AND JOB = (SELECT JOB
			FROM EMP
			WHERE ENAME = 'ALLEN');


/* Q2. 전체 사원의 평균 급여(SAL)보다 
 * 높은 급여를 받는 사원들의 사원 정보, 부서 정보, 급여 등급 정보를 
 * 출력하는 SQL문을 작성하세요.
  (단, 출력할 때 급여가 많은 순으로 정렬하되 
  급여가 같을 경우에는 사원 번호를 기준으로 오름차순으로 정렬하세요.) 
* (표준/비표준으로 풀어보기)
*
**/
			
-- 비표준 방식
SELECT E.EMPNO, E.ENAME, D.DNAME, E.HIREDATE, D.LOC,
	E.SAL, S.GRADE
FROM EMP E, DEPT D, SALGRADE S
WHERE E.DEPTNO = D.DEPTNO
AND E.SAL BETWEEN S.LOSAL AND S.HISAL 
AND E.SAL >  (SELECT AVG(SAL) FROM EMP)
ORDER BY E.SAL DESC, E.EMPNO;

-- 표준 방식
SELECT E.EMPNO, E.ENAME, D.DNAME, E.HIREDATE, D.LOC,
	E.SAL, S.GRADE
FROM EMP E JOIN DEPT D ON (E.DEPTNO = D.DEPTNO) 
		JOIN SALGRADE S ON (E.SAL BETWEEN S.LOSAL AND S.HISAL)
--WHERE E.DEPTNO = D.DEPTNO
--AND E.SAL BETWEEN S.LOSAL AND S.HISAL 
WHERE E.SAL >  (SELECT AVG(SAL) FROM EMP)
ORDER BY E.SAL DESC, E.EMPNO;			
			
/* Q3. 10번 부서에 근무하는 사원 중 
 * 30번 부서에는 존재하지 않는 직책을 가진 
 * 사원들의 사원 정보, 부서 정보를 다음과 같이 
 * 출력하는 SQL문을 작성하세요. 
 * 
 * (NOT IN) VS (IN ... WHERE <>)
 * NOT IN: 서브쿼리 안에 나오는 결과값이 모두 아니여야 함
 * JOB = () AND JOB = () AND JOB = ()
 * 
 * IN ... WHERE <>: 서브쿼리 안에 결과값 중에 하나만 아니여도 됨
 * JOB = () OR JOB = () OR JOB = ()
 * 
 * 메인쿼리: 10번 부서에 근무하는 사원 정보, 부서 정보
 * 서브쿼리: 30번 부서에 존재하는 직책
*/

-- 비표준
SELECT
FROM EMP 테이블, DEPT 테이블
WHERE 조인 조건식
AND 10번 부서에 근무
AND E.JOB    (SELECT JOB FROM EMP.....)


SELECT E.EMPNO, E.ENAME, E.JOB, E.DEPTNO,
	D.DNAME, D.LOC
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO
AND E.DEPTNO = 10
AND JOB NOT IN (SELECT DISTINCT JOB FROM EMP WHERE DEPTNO = 30);


/* Q4. 직책이 SALESMAN인 사람들의 
 
 * 최고 급여보다 높은 급여를 받는 사원들의 사원 정보, 급여 등급 정보를 
 * 다음과 같이 출력하는 SQL문을 작성하세요.
  (단, 서브쿼리를 활용할 때 다중행 함수 (MAX())를 사용하는 방법과 
  사용하지 않는 방법 (다중행 서브쿼리 연산자)을 통해 
  사원 번호를 기준으로 오름차순으로 정렬하세요.)
 **/

SELECT E.EMPNO, E.ENAME, E.SAL, S.GRADE
FROM EMP E, SALGRADE S
WHERE (조인 조건식)
AND E.SQL < ANY()

SELECT E.EMPNO, E.ENAME, E.SAL, S.GRADE
FROM EMP E, SALGRADE S
WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL
AND SAL > (SELECT MAX(SAL) FROM EMP WHERE JOB = 'SALESMAN')
ORDER BY E.EMPNO;

SELECT E.EMPNO, E.ENAME, E.SAL, S.GRADE
FROM EMP E, SALGRADE S
WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL
AND SAL > ALL(SELECT DISTINCT SAL FROM EMP WHERE JOB = 'SALESMAN')
ORDER BY E.EMPNO;