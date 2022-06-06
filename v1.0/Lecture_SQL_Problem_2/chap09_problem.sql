/* Q1. ��ü ��� �� ALLEN�� ���� ��å(JOB)�� ������� 
 ��� ����, �μ� ������ ������ ���� ����ϴ� SQL���� �ۼ��ϼ���.
*/
SELECT E.JOB, E.EMPNO, E.ENAME, E.SAL, E.DEPTNO, D.DNAME
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO
AND JOB = (SELECT JOB
			FROM EMP
			WHERE ENAME = 'ALLEN');


/* Q2. ��ü ����� ��� �޿�(SAL)���� 
 * ���� �޿��� �޴� ������� ��� ����, �μ� ����, �޿� ��� ������ 
 * ����ϴ� SQL���� �ۼ��ϼ���.
  (��, ����� �� �޿��� ���� ������ �����ϵ� 
  �޿��� ���� ��쿡�� ��� ��ȣ�� �������� ������������ �����ϼ���.) 
* (ǥ��/��ǥ������ Ǯ���)
*
**/
			
-- ��ǥ�� ���
SELECT E.EMPNO, E.ENAME, D.DNAME, E.HIREDATE, D.LOC,
	E.SAL, S.GRADE
FROM EMP E, DEPT D, SALGRADE S
WHERE E.DEPTNO = D.DEPTNO
AND E.SAL BETWEEN S.LOSAL AND S.HISAL 
AND E.SAL >  (SELECT AVG(SAL) FROM EMP)
ORDER BY E.SAL DESC, E.EMPNO;

-- ǥ�� ���
SELECT E.EMPNO, E.ENAME, D.DNAME, E.HIREDATE, D.LOC,
	E.SAL, S.GRADE
FROM EMP E JOIN DEPT D ON (E.DEPTNO = D.DEPTNO) 
		JOIN SALGRADE S ON (E.SAL BETWEEN S.LOSAL AND S.HISAL)
--WHERE E.DEPTNO = D.DEPTNO
--AND E.SAL BETWEEN S.LOSAL AND S.HISAL 
WHERE E.SAL >  (SELECT AVG(SAL) FROM EMP)
ORDER BY E.SAL DESC, E.EMPNO;			
			
/* Q3. 10�� �μ��� �ٹ��ϴ� ��� �� 
 * 30�� �μ����� �������� �ʴ� ��å�� ���� 
 * ������� ��� ����, �μ� ������ ������ ���� 
 * ����ϴ� SQL���� �ۼ��ϼ���. 
 * 
 * (NOT IN) VS (IN ... WHERE <>)
 * NOT IN: �������� �ȿ� ������ ������� ��� �ƴϿ��� ��
 * JOB = () AND JOB = () AND JOB = ()
 * 
 * IN ... WHERE <>: �������� �ȿ� ����� �߿� �ϳ��� �ƴϿ��� ��
 * JOB = () OR JOB = () OR JOB = ()
 * 
 * ��������: 10�� �μ��� �ٹ��ϴ� ��� ����, �μ� ����
 * ��������: 30�� �μ��� �����ϴ� ��å
*/

-- ��ǥ��
SELECT
FROM EMP ���̺�, DEPT ���̺�
WHERE ���� ���ǽ�
AND 10�� �μ��� �ٹ�
AND E.JOB    (SELECT JOB FROM EMP.....)


SELECT E.EMPNO, E.ENAME, E.JOB, E.DEPTNO,
	D.DNAME, D.LOC
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO
AND E.DEPTNO = 10
AND JOB NOT IN (SELECT DISTINCT JOB FROM EMP WHERE DEPTNO = 30);


/* Q4. ��å�� SALESMAN�� ������� 
 
 * �ְ� �޿����� ���� �޿��� �޴� ������� ��� ����, �޿� ��� ������ 
 * ������ ���� ����ϴ� SQL���� �ۼ��ϼ���.
  (��, ���������� Ȱ���� �� ������ �Լ� (MAX())�� ����ϴ� ����� 
  ������� �ʴ� ��� (������ �������� ������)�� ���� 
  ��� ��ȣ�� �������� ������������ �����ϼ���.)
 **/

SELECT E.EMPNO, E.ENAME, E.SAL, S.GRADE
FROM EMP E, SALGRADE S
WHERE (���� ���ǽ�)
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