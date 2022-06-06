-- ���� (JOIN)
-- Ư�� ���� �������� ���̺� ����

-- ���� (JOIN) vs ���� ������ UNION
-- ������ �� ���̺��� ���η� ����
-- UNION�� �� ���̺��� ���η� ���� 
-- (�� ���̺��� �� ����, ������ Ÿ�� �����ؾ� ��)
-- (���� �� ���̺��� �� �̸��� �ٸ��� ù��° ���̺��� �� �̸� ����)

-- RDBMS (Relational Database Management System)
-- ���̺��� ���������� �������� �ִ� Ư¡
-- ���̺� ���� ���踦 �ΰ� ����!
-- EX) EMP DEPTNO (�ܷ�Ű)
--    DEPT  DEPTNO (�⺻Ű)
-- WHY? �������� �ߺ��� �����ϱ� ���� (�ߺ��Ǹ� �ߺ��� �����͸�ŭ ����/���� �ʿ�)

SELECT * FROM EMP;
SELECT * FROM DEPT;

SELECT * 
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO
ORDER BY E.EMPNO;

SELECT EMPNO AS NO, ENAME AS NAME
FROM EMP E
WHERE E.NO = 7369;
-- EMPNO�� ��Ī�� NO�� ��� ���̺��� ����� ���� �뵵�̱� ������
-- WHERE���� ����� �� ����!

-- Q1. �����ȣ 7369�� ��� ������ 7369�� �ٹ��ϰ� �ִ� �μ� ���� ���
SELECT EMPNO, ENAME, E.DEPTNO AS E_DEPTNO, D.DEPTNO AS D_DEPTNO, DNAME, LOC 
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO -- ����� (Equal Join)
AND E.EMPNO = 7369;

-- Q2. EMP ���̺��� MGR ��ȣ�� �ش��ϴ� MGR ���� ���
-- EMPNO, ENAME, JOB, MGR, MGR_ENAME, MGR_JOB
SELECT * FROM EMP;
SELECT E.EMPNO, E.ENAME, E.JOB, E.MGR, M.ENAME AS MGR_ENAME, M.JOB AS MGR_JOB
FROM EMP E, EMP M
WHERE E.MGR = M.EMPNO
-- ����� (Equal Join)
-- ��ü ���� (Self Join): ���� ���̺��� �������� �̸��� �ٸ��� �ؼ� �����ϴ� ��
ORDER BY E.EMPNO;

-- Q3. NEW YORK���� ���ϰ� �ִ� ��� ���� ���
SELECT D.LOC, E.EMPNO, E.ENAME
FROM DEPT D, EMP E
WHERE D.DEPTNO = E.DEPTNO -- ����� (Equal Join)
AND D.LOC = 'NEW YORK';

-- Q4. SALES���� �ٹ��ϰ� �ִ� ��� ���� ���
SELECT D.DNAME, D.LOC, E.*
FROM DEPT D, EMP E
WHERE D.DEPTNO = E.DEPTNO -- ����� (Equal Join)
AND D.DNAME = 'SALES';

-- Q5. �� ��� ������ ���� �� ����� �޿� ��� ���
SELECT * FROM EMP;
SELECT * FROM SALGRADE;

-- 1) �� ������
SELECT E.EMPNO, E.ENAME, E.SAL, S.GRADE
FROM EMP E, SALGRADE S
WHERE E.SAL >= S.LOSAL AND E.SAL <= S.HISAL; -- �� ���� (Non-Equal Join)

-- 2) BETWEEN A AND B ������ (>= A, <= B)
SELECT E.EMPNO, E.ENAME, E.SAL, S.GRADE
FROM EMP E, SALGRADE S
WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL; -- �� ���� (Non-Equal Join)
 
-- �߰�) �� ��޿� �ش��ϴ� ��� ��
SELECT S.GRADE, COUNT(*)
FROM EMP E, SALGRADE S
WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL
GROUP BY S.GRADE
ORDER BY S.GRADE;

-- �ܺ� ���� (Outer Join) �� ���� ���� (Inner Join) (� ����, �� ����, ��ü ����)
-- Q2. EMP ���̺��� MGR ��ȣ�� �ش��ϴ� MGR ���� ���
-- EMPNO, ENAME, JOB, MGR, MGR_ENAME, MGR_JOB
SELECT E.EMPNO, E.ENAME, E.JOB, E.MGR, M.ENAME AS MGR_ENAME, M.JOB AS MGR_JOB
FROM EMP E, EMP M
WHERE E.MGR = M.EMPNO 
ORDER BY E.EMPNO;
-- KING�� ���� (KING�� MGR�� NULL�̱� ������ ���� ���ǽ� NULL�� �Ǳ� ����)
-- KING�� MGR�� ��� ����ϰ� �ʹٸ� ? �ܺ� ����!
-- 1) ���� �ܺ� ���� (Left Outer Join = Left Join)
-- >> WHERE TABLE1.COL1 = WHERE TABLE2.COL2(+)
-- >> TABLE1.COL1�� TABLE2.COL2�� ��� ���Խ�Ű�ڴ�!
SELECT E.EMPNO, E.ENAME, E.JOB, E.MGR, M.ENAME AS MGR_ENAME, M.JOB AS MGR_JOB
FROM EMP E, EMP M
WHERE E.MGR = M.EMPNO(+)
ORDER BY E.EMPNO;
-- E.MGR ���� ������ M.EMPNO�� ��� E.MGR�� ��� ���̺� �����ϰڴ�!
-- �ش� ������� ����ڰ� �������� ���� ��� ��� (EX. KING)


-- 2) ������ �ܺ� ���� (Right Outer Join = Right Join)
-- >> WHERE TABLE1.COL1(+) = WHERE TABLE2.COL2
-- >> TABLE2.COL2�� TABLE1.COL1�� ��� ���Խ�Ű�ڴ�!
SELECT E.EMPNO, E.ENAME, E.JOB, E.MGR, M.EMPNO AS MGR_EMPNO, M.ENAME AS MGR_ENAME, M.JOB AS MGR_JOB
FROM EMP E, EMP M
WHERE E.MGR(+) = M.EMPNO 
ORDER BY E.EMPNO;
-- M.EMPNO ���� ������ E.MGR�� ��� M.EMPNO�� ��� ���̺� �����ϰڴ�!
-- �ش� ����� �������� �Ŵ����� �ƴ� ��� (���� ���) ��� 
-- (JAMES, MILLER, SMITH, ALLEN, TURNER, WARD)

-- 3) ��ü �ܺ� ���� (Full Outer Join = Full Join)
SELECT E.EMPNO, E.ENAME, E.JOB, E.MGR, M.EMPNO AS MGR_EMPNO, M.ENAME AS MGR_ENAME, M.JOB AS MGR_JOB
FROM EMP E, EMP M
WHERE E.MGR(+) = M.EMPNO 
UNION
SELECT E.EMPNO, E.ENAME, E.JOB, E.MGR, M.EMPNO AS MGR_EMPNO, M.ENAME AS MGR_ENAME, M.JOB AS MGR_JOB
FROM EMP E, EMP M
WHERE E.MGR = M.EMPNO(+);

SELECT E.EMPNO, E.ENAME, E.JOB, E.MGR, M.EMPNO AS MGR_EMPNO, M.ENAME AS MGR_ENAME, M.JOB AS MGR_JOB
FROM EMP E, EMP M
WHERE E.MGR(+) = M.EMPNO(+); -- ���� X

-- �ܺ� ���� VS ���� ����
-- �ܺ� ����: �����Ͱ� ��� ����ϰڴ�!
-- ���� ����: �����Ͱ� ������ ������� ���� (�ܺ� ������ ������� �ʴ� ����)


-- SQL ǥ�� ����
-- ISO���� ����
-- ��κ��� RDBMS���� ����� �� ���� (ȣȯ��)

-- � ����
-- NATURAL JOIN
-- ���� ����� �Ǵ� �� ���̺��� �� �̸�, �ڷ����� ���� ���� ã�� � ����
-- (**) ���� ����� �Ǵ� ���� ���̺� ���� ���̸� ����
SELECT E.EMPNO, E.ENAME, DEPTNO, D.DNAME
FROM EMP E NATURAL JOIN DEPT D;

-- JOIN ~ USING (���� ��)
-- (**) ���� ����� �Ǵ� ���� ���̺� ���� ���̸� ����
SELECT E.EMPNO, E.ENAME, DEPTNO, D.DNAME
FROM EMP E JOIN DEPT D USING (DEPTNO);

-- JOIN ~ ON (���� ���ǽ�)
-- ���� ���
-- (**) ���� ����� �Ǵ� ���� ���̺� ���� ���̸� ���� X
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



