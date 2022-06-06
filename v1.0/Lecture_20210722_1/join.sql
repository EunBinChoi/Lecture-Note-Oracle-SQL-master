-- [���� (join)]
-- : ���̺��� �����ϴ�

-- RDBMS (Relational DataBase Management System)
-- ���̺��� �������� �ɰ����ִ� Ư¡ (���̺� ���� '����' (�ܷ�Ű�� �⺻Ű�� �Ǿ �˻�!)�� ������)
-- WHY?
-- �������� �ߺ��� �����ϱ� ���� (�ߺ��� �Ǹ� �ߺ��� �����͸�ŭ ����/������ �ʿ���)

SELECT * FROM TAB;
SELECT * FROM EMP;

-- 1) ���� VS ���� ������ (UNION, INTERSECT, MINUS)

-- ���� ������ (�� SELECT���� ����� ���η� ����)
SELECT EMPNO, ENAME
FROM EMP
WHERE ENAME LIKE '%S%'
UNION
SELECT EMPNO, ENAME
FROM EMP
WHERE ENAME LIKE '%A%';

-- ���� (�� ���̺��� �����Ͱ� ���η� ����)
/*
 * WHERE�� �߰�
 * >> �� ���̺��� ������ ������ ����
 * >> �ܷ�Ű (�ܺ�Ű) ���� Ȯ���� ����
 * 
 * */


-- �� ���̺��� ������ �� �̸� (�� �̸��� �ܷ�Ű�� �Ǵ� ���)�� �ִٸ� 
-- ���̺� �̸�.�� �̸� ����
-- ���̺� �̸� ��Ī�� ������ �� ���� (AS ���� ���)

SELECT *
FROM EMP, DEPT
WHERE EMP.DEPTNO = DEPT.DEPTNO
ORDER BY EMPNO;

SELECT *
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO
ORDER BY EMPNO; 
-- �ϳ��ۿ� ����! (EMP ���̺�)

-- SELECT *
-- => ������ �� ��쿡 ����ϰ��� �ϴ� �� �̸��� �� �ۼ����ֽô� �� ����
-- => WHY?
-- 1) ������ �� �̸��� ���� ��쿡 ���� ����
-- 2) SELECT �ڿ� ���常 ������ � ���̺��� �ش� ���� ��µǴ��� Ȯ���ϱ� ����
-- ex) E.EMPNO: E ���̺� EMPNO�� �ֱ���!
-- => �ش� ���̺��� ���� Ȯ�� ���� (���� ���� ������ Ȯ������ �ʾƵ� ������ �� �ְ�)




-- 1) � ���� (equal join) (= ���� ���� (inner join), �ܼ� ���� (simple join))
-- : WHERE ���� �ο� '=' �����ڰ� ���� ���
-- : '����' == '� ����'

-- Q1. ��� ��ȣ, �̸�, �޿� (EMP ���̺�), �ٹ� �μ��̸� (DNAME) (DEPT ���̺�)�� �Բ� ���
--    �޿��� 3000 �̻��� �����͸� ���

SELECT E.EMPNO, E.ENAME, E.SAL, E.DEPTNO, D.DEPTNO, D.DNAME
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO AND E.SAL >= 3000;


-- Q2. ��� ��ȣ, �̸�, �޿� (EMP ���̺�), �ٹ� �μ��̸� (DNAME) (DEPT ���̺�)�� �Բ� ���
--    ��� ��ȣ�� �� �� �ڸ��� 79�� ���� ���

SELECT E.EMPNO, E.ENAME, E.SAL, E.DEPTNO, D.DEPTNO, D.DNAME
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO AND E.EMPNO LIKE '79%';



-- Q3. �� �μ��� �μ� ��ȣ, �μ� �̸�, (�� �̸�) 
-- ������ �Լ�
-- ��� �޿� (�Ҽ��� 2���ڸ����� ǥ�� (�ݿø�)), 
-- �ִ� �޿�, �ּ� �޿�, ������� ���
-- EMP, DEPT ���̺�
SELECT * FROM EMP;
SELECT * FROM DEPT;


SELECT D.DEPTNO, DNAME,
		ROUND(AVG(SAL), 2) AS AVG_SAL,
		MAX(SAL) AS MAX_SAL,
		MIN(SAL) AS MIN_SAL,
		COUNT(*) AS CNT
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO
GROUP BY D.DEPTNO, DNAME;


/* 2) �� ���� (non-equal join)
 * : � ������ �ƴ� ���
 * : ���� ������ Ư�� ���� ��ġ ���θ� Ȯ���ϴ� ���� �ƴ� �ٸ� ��� �̿�
 * 
 * */

SELECT * FROM SALGRADE;
-- �޿� ��� ���̺�

-- EX) �� ��� ������ ���� �� ����� �޿��� ��� ���
SELECT *
FROM EMP E, SALGRADE S
WHERE SAL >= LOSAL AND SAL <= HISAL;

SELECT *
FROM EMP E, SALGRADE S
WHERE SAL BETWEEN LOSAL AND HISAL;

SELECT *
FROM EMP E, SALGRADE S
WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL;



/* 3) ��ü ���� (self join)
 *  : ���� ���̺��� �����ϴ� ��
 *  : ��Ī�� �ٸ��� �־� �������� �ٸ� ���̺��� ��ó�� ���
 *  : EMP ���̺��� ����� ���� ��� ��ȣ (MGR) ����
 *  : ��� ��ȣ�� ���� ��� �̸��� ������ ���
 * */

SELECT * FROM EMP;

SELECT E1.EMPNO, E1.ENAME, E1.MGR,
	E2.EMPNO AS MGR_EMPNO,
	E2.ENAME AS MGR_ENAME
FROM EMP E1, EMP E2
WHERE E1.MGR = E2.EMPNO;
-- EMP ��� 12�� -> 11��
-- ���ǿ� �������� ���� ��찡 �ֱ� ����
-- => ���ǿ� NULL�� ���� ��� �ش� ��� ����


/* 4) �ܺ� ���� (�ƿ��� ����, outer join)
 * : �տ��� MGR�� NULL�� ��� ����
 * : KING ����� PRESIDENT�� ������ ���� ����� ����
 * : ���� ���ǽ��� NULL�� ������ ������ ����
 * : KING�� ���� ����� ������ �������� ������ְ� ���� ��
 * 
 * : ���� ���ǽĿ��� NULL�� ���͵� ������ ���
 * 
 * A. ���� �ܺ� ���� (Left Outer Join)
 * >> WHERE TABEL1.COL1 = TABLE2.COL2(+)
 * 
 * B. ������ �ܺ� ���� (Right Outer Join)
 * >> WHERE TABEL1.COL1(+) = TABLE2.COL2
 * 
 * C. ��ü �ܺ� ���� (Full Outer Join)
 * >> ���� �ܺ� ����, ������ �ܺ� ������ ��� ������
 * 
 * �ܺ� ���� VS ���� ���� (� ����)
 * ���� ����: �ܺ� ������ ������� ���� � ���� (�����Ͱ� ���� ���� ���)
 * 
 * */

SELECT E1.EMPNO, E1.ENAME, E1.MGR,
	E2.EMPNO AS MGR_EMPNO,
	E2.ENAME AS MGR_ENAME
FROM EMP E1, EMP E2
WHERE E1.MGR = E2.EMPNO;

SELECT E1.EMPNO, E1.ENAME, E1.MGR,
	E2.EMPNO AS MGR_EMPNO,
	E2.ENAME AS MGR_ENAME
FROM EMP E1, EMP E2
WHERE E1.MGR = E2.EMPNO(+); -- ���� �ƿ��� ����
-- 'E1.MGR' ���� ������ 'E2.EMPNO'�� ��� ���Խ�Ű�ڴ�
-- �ش� ������� ����ڰ� �������� ���� ��� ���


SELECT E1.EMPNO, E1.ENAME, E1.MGR,
	E2.EMPNO AS MGR_EMPNO,
	E2.ENAME AS MGR_ENAME
FROM EMP E1, EMP E2
WHERE E1.MGR(+) = E2.EMPNO; -- ������ �ƿ��� ����
-- 'E2.EMPNO'�� 'E1.MGR'�� ��� ���Խ�Ű�ڴ�
-- ���� ������ ���� (���� ���) ��� ���



-- [SQL ǥ�� ����]
-- : ��κ��� RDBMS���� ����� �� ���� (ȣȯ��) (**)
-- : SQL-82 -> SQL-92 -> SQL-99 (9 ��������)
-- : ISO/ANSI���� ����

-- 1) � ����
-- : NATURAL JOIN
-- : ���� ����� �Ǵ� �� ���̺��� �̸�, �ڷ����� ���� ���� ã�� ��
--   �� ���� �������� � ����

SELECT E.EMPNO, E.ENAME, E.DEPTNO, D.DNAME
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO;
-- ** ������ ���� �ִٸ� ���̺� ���� �ٿ��� ��!! **

SELECT E.EMPNO, E.ENAME, DEPTNO, D.DNAME
FROM EMP E NATURAL JOIN DEPT D;
-- ** ǥ�� SQL������ ���� ���� ���̺� ���� ���̸� ���� (DEPTNO) **

SELECT E.EMPNO, E.ENAME, E.DEPTNO, D.DNAME
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO AND SAL >= 3000;
-- ���� ���ǽİ� SELECT ���ǽ��� �򰥸�

SELECT E.EMPNO, E.ENAME, DEPTNO, D.DNAME
FROM EMP E NATURAL JOIN DEPT D
-- DEPTNO ���� �������� �����ϰڴ�! ������� �ʾƵ� ��
WHERE SAL >= 3000;
-- SELECT ���ǽ��� �򰥸��� ����


-- JOIN ~ USING
-- : USING Ű���忡 ���� �������� ����� �� ���
-- : FROM TABLE1 JOIN TABLE2 USING (���� ��)

SELECT E.EMPNO, E.ENAME, DEPTNO, D.DNAME
FROM EMP E JOIN DEPT D USING (DEPTNO)
WHERE SAL >= 3000;

-- ���� (���� ���� ���̺� �̸� ���� �Ұ�)
SELECT E.EMPNO, E.ENAME, DEPTNO, D.DNAME
FROM EMP E JOIN DEPT D USING (E.DEPTNO)
WHERE SAL >= 3000;

-- JOIN ~ ON
-- : ���� ���
-- : ���� ���� ���ǽ� ON �ڿ� ���
-- : ���� ���ǽĿ� ������ �Ǵ� ���� ���̺� �̸��� �ۼ�
SELECT E.EMPNO, E.ENAME, E.DEPTNO, D.DNAME
FROM EMP E JOIN DEPT D ON (E.DEPTNO = D.DEPTNO)
WHERE SAL >= 3000;

-- 2) OUTER JOIN
-- : �ܺ� ����
-- : WHERE���� �ƴ϶� FROM���� ���� ���� �ۼ�
-- : Ű���� �̿�
-- : A. ���� �ƿ��� ���� = LEFT OUTER JOIN
-- : B. ������ �ƿ��� ���� = RIGHT OUTER JOIN
-- : C. ��ü �ƿ��� ���� = FULL OUTER JOIN

-- A. ���� �ƿ��� ���� 
-- (��� ��ȣ, ��� �̸�, �Ŵ��� ��ȣ, �Ŵ��� �̸�)
SELECT E1.EMPNO, E1.ENAME, E1.MGR, 
		E2.EMPNO AS MGR_EMPNO,
		E2.ENAME AS MGR_ENAME
FROM EMP E1, EMP E2
WHERE E1.MGR = E2.EMPNO(+);

-- SQL-99 ǥ��
SELECT E1.EMPNO, E1.ENAME, E1.MGR, 
		E2.EMPNO AS MGR_EMPNO,
		E2.ENAME AS MGR_ENAME
FROM EMP E1 LEFT OUTER JOIN EMP E2 ON (E1.MGR = E2.EMPNO);




-- B. ������ �ƿ��� ����
-- (��� ��ȣ, ��� �̸�, �Ŵ��� ��ȣ, �Ŵ��� �̸�)
SELECT E1.EMPNO, E1.ENAME, E1.MGR, 
		E2.EMPNO AS MGR_EMPNO,
		E2.ENAME AS MGR_ENAME
FROM EMP E1, EMP E2
WHERE E1.MGR(+) = E2.EMPNO

-- SQL-99 ǥ��
SELECT E1.EMPNO, E1.ENAME, E1.MGR, 
		E2.EMPNO AS MGR_EMPNO,
		E2.ENAME AS MGR_ENAME
FROM EMP E1 RIGHT OUTER JOIN EMP E2 ON (E1.MGR = E2.EMPNO);

-- C. ��ü �ƿ��� ����
-- (��� ��ȣ, ��� �̸�, �Ŵ��� ��ȣ, �Ŵ��� �̸�)
SELECT E1.EMPNO, E1.ENAME, E1.MGR, 
		E2.EMPNO AS MGR_EMPNO,
		E2.ENAME AS MGR_ENAME
FROM EMP E1, EMP E2
WHERE E1.MGR(+) = E2.EMPNO(+);
-- ���� ����

SELECT E1.EMPNO, E1.ENAME, E1.MGR, 
		E2.EMPNO AS MGR_EMPNO,
		E2.ENAME AS MGR_ENAME
FROM EMP E1, EMP E2
WHERE E1.MGR = E2.EMPNO(+)
UNION
SELECT E1.EMPNO, E1.ENAME, E1.MGR, 
		E2.EMPNO AS MGR_EMPNO,
		E2.ENAME AS MGR_ENAME
FROM EMP E1, EMP E2
WHERE E1.MGR(+) = E2.EMPNO;

-- SQL-99 ǥ��
SELECT E1.EMPNO, E1.ENAME, E1.MGR, 
		E2.EMPNO AS MGR_EMPNO,
		E2.ENAME AS MGR_ENAME
FROM EMP E1 FULL OUTER JOIN EMP E2 ON (E1.MGR = E2.EMPNO);



-- SQL-99 ����ϴ� ����?
-- 1) ����, ����� (� ������ �������� Ȯ�� ����)
-- 2) ���� ���ǽ� (ON)�� ��� ���� �����ϴ� ���ǽ� (WHERE)�� ������ �� ����


-- �� �� �̻��� ���̺� ����
/* [���� SQL]
 * FROM TABLE1, TABLE2, TABLE3
 * WHERE TABLE1.COL = TABLE2.COL
 * AND TABLE2.COL = TABLE3.COL
 * 
 * [SQL-99]
 * FROM TABLE1 JOIN TABLE2 ON (���ǽ�)
 * 			   JOIN TABLE3 ON (���ǽ�)
 * 
 * */



-- (�� SQL-99 ���� ��İ� SQL-99 ����� ���� ����Ͽ� �ۼ��ϼ���)
-- Q1 ~ Q4. å�� �ִ� ����
-- Q1. �޿� (SAL) �� 2000 �ʰ��� ������� 
-- �μ� ����, ��� ������ ���� ����� ������.
-- DEPTNO, DNAME, EMPNO, ENAME, SAL
-- EMP ���̺�: EMPNO, ENAME, SAL, DEPTNO
-- DEPT ���̺�: DEPTNO, DNAME


-- 1) ��ǥ�� ���
SELECT D.DEPTNO, D.DNAME, E.EMPNO, E.ENAME, E.SAL
FROM EMP E, DEPT D
WHERE D.DEPTNO = E.DEPTNO
AND E.SAL > 2000;
--ORDER BY DEPTNO;

-- 2) ǥ�� ���
-- � ���� (NATURAL JOIN, JOIN USING (���� ���� �� �̸�), JOIN ON (���� ���ǽ�))
SELECT DEPTNO, D.DNAME, E.EMPNO, E.ENAME, E.SAL
FROM EMP E NATURAL JOIN DEPT D
WHERE E.SAL > 2000;


-- Q2. �����ʰ� ���� 
-- �� �μ��� ��� �޿�, �ִ� �޿�, �ּ� �޿�, ������� ����� ������.
-- �μ��� �μ� ��ȣ, �μ� �̸� (DEPT)
-- �޿� (EMP)
-- GROUP BY DEPTNO, DNAME

-- 1) ��ǥ�� ���
SELECT D.DEPTNO, D.DNAME,
	TRUNC(AVG(SAL)) AS AVG_SAL,
	MAX(SAL) AS MAX_SAL,
	MIN(SAL) AS MIN_SAL,
	COUNT(*) AS CNT
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO
GROUP BY D.DEPTNO, D.DNAME;


-- 2) ǥ�� ���
SELECT DEPTNO, D.DNAME,
	TRUNC(AVG(SAL)) AS AVG_SAL,
	MAX(SAL) AS MAX_SAL,
	MIN(SAL) AS MIN_SAL,
	COUNT(*) AS CNT
FROM EMP E JOIN DEPT D USING (DEPTNO) -- ��ȣ ���� �Ұ�!
GROUP BY DEPTNO, D.DNAME;


-- Q3. ��� �μ� ������ ��� ������ �����ʰ� ���� 
-- �μ� ��ȣ, ��� �̸������� �����Ͽ� ����� ������.
-- �μ� ���� (DEPT)
-- ��� ���� (EMP)

SELECT D.DEPTNO, D.DNAME, E.ENAME
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO;

SELECT DEPTNO, DNAME
FROM DEPT;
SELECT DEPTNO
FROM EMP;

-- ������ ��쿡 ���� 40���� ��� ��� ���� �ٶ� (CROSS JOIN, ��ī��Ʈ ��)
SELECT D.DEPTNO, D.DNAME, E.EMPNO, E.ENAME, E.JOB, E.SAL
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO
OR D.DEPTNO = 40;
--ORDER BY D.DEPTNO, E.ENAME;

-- 1) ��ǥ�� ���
SELECT D.DEPTNO, D.DNAME, E.EMPNO, E.ENAME, E.JOB, E.SAL
FROM EMP E, DEPT D
WHERE E.DEPTNO(+) = D.DEPTNO
ORDER BY D.DEPTNO, E.ENAME;

-- 2) ǥ�� ���
SELECT D.DEPTNO, D.DNAME, E.EMPNO, E.ENAME, E.JOB, E.SAL
FROM EMP E RIGHT OUTER JOIN DEPT D ON (E.DEPTNO = D.DEPTNO)
ORDER BY D.DEPTNO, E.ENAME;



-- Q4. ������ ���� ��� �μ� ����, ��� ����, �޿� ��� ����, 
--     �� ����� ���� ����� ������ 
--     �μ� ��ȣ, ��� ��ȣ ������ �����Ͽ� ����� ������.
-- 1) ��ǥ�� ���
-- 2) ǥ�� ��� (����)

SELECT * FROM EMP; -- E
SELECT * FROM DEPT; -- D
SELECT * FROM SALGRADE; -- S

-- 1) E - D (RIGHT OUTER JOIN)
-- 2) E - S (LEFT OUTER JOIN)
-- 3) E - E1 (LEFT OUTER JOIN)
-- (�Ŵ����� ��� ���)

-- ��ǥ�� ���
SELECT D.DEPTNO, D.DNAME, E.EMPNO, E.ENAME, E.MGR, E.SAL,
	E.DEPTNO, S.LOSAL, S.HISAL, S.GRADE, 
	E2.EMPNO AS MGR_EMPNO, E2.ENAME AS MGR_ENAME
FROM EMP E, DEPT D, SALGRADE S, EMP E2
WHERE E.DEPTNO(+) = D.DEPTNO 
	AND E.SAL BETWEEN S.LOSAL(+) AND S.HISAL(+)
	AND E.MGR = E2.EMPNO(+)
ORDER BY D.DEPTNO, E.EMPNO;



-- SQL-99 ǥ�� ���
SELECT D.DEPTNO, D.DNAME, E.EMPNO, E.ENAME, E.MGR, E.SAL,
	E.DEPTNO, S.LOSAL, S.HISAL, S.GRADE, 
	E2.EMPNO AS MGR_EMPNO, E2.ENAME AS MGR_ENAME
FROM EMP E RIGHT OUTER JOIN DEPT D
			ON (E.DEPTNO = D.DEPTNO)
		   LEFT OUTER JOIN SALGRADE S
		 	ON (E.SAL BETWEEN S.LOSAL AND S.HISAL)
		   LEFT OUTER JOIN EMP E2
		 	ON (E.MGR = E2.EMPNO)
ORDER BY D.DEPTNO, E.EMPNO;



-- Q5. JOIN ~ USING Ű���带 �̿��ؼ� ����� �ۼ�
-- ���� 1. EMP ���̺�� DEPT ���̺��� ���� ������ 
-- �μ� ��ȣ (DEPTNO) ���� ��
-- ���� 2. �޿��� 3000 �̻��̸� �Ŵ����� �ݵ�� �־�� ��
-- ���� 3. ��� ������ DEPTNO ��������, EMPNO ��������

-- 1) ǥ�� ���
-- JOIN ~ ON ()
SELECT E.EMPNO, E.ENAME, E.DEPTNO, D.DEPTNO, E.SAL, E.MGR
FROM EMP E JOIN DEPT D ON (E.DEPTNO = D.DEPTNO) -- ���� ���ǽ� 
WHERE E.SAL >= 3000 AND E.MGR IS NOT NULL
ORDER BY E.DEPTNO, E.EMPNO DESC;

-- JOIN ~ USING ()
SELECT E.EMPNO, E.ENAME, DEPTNO, E.SAL, E.MGR
FROM EMP E JOIN DEPT D USING (DEPTNO) -- ���� �� �̸� (���ǽ� X) 
WHERE E.SAL >= 3000 AND E.MGR IS NOT NULL
ORDER BY DEPTNO, E.EMPNO DESC;

-- NATURAL JOIN
-- ����� 
-- ���� ���� �ۼ����� �ʾƵ� �� ���̺��� ����� �� (�̸�, �ڷ���) ã��
-- ���� ���� ���̺� �̸� �ۼ� X
SELECT E.EMPNO, E.ENAME, DEPTNO, E.SAL, E.MGR
FROM EMP E NATURAL JOIN DEPT D
WHERE E.SAL >= 3000 AND E.MGR IS NOT NULL
ORDER BY DEPTNO, E.EMPNO DESC;


-- 2) ��ǥ�� ���
SELECT E.EMPNO, E.ENAME, E.DEPTNO, D.DEPTNO, E.SAL, E.MGR
FROM EMP E, DEPT D 
WHERE E.DEPTNO = D.DEPTNO -- ���� ���ǽ� 
AND E.SAL >= 3000 AND E.MGR IS NOT NULL
ORDER BY E.DEPTNO, EMPNO DESC;
