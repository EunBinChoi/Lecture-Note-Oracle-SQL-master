-- �������� (SUBQUERY)
-- : SQL�� �ȿ� SQL��
-- : ���������� () �ȿ� �ۼ�
-- : �������� ������ ����� �������� �� ���� ���� �ڷ���/������ ����
-- : �������������� ORDER BY�� ����� �� ����

-- �����ȣ�� 7844�� ������� ���� ���� ���� ��� ���
SELECT SAL FROM EMP WHERE EMPNO = 7844;
SELECT * FROM EMP WHERE SAL > 1500;

-- ������ ��������
SELECT * FROM EMP
WHERE SAL >  -- ��������
(SELECT SAL FROM EMP WHERE EMPNO = 7844); -- ��������

-- Q1. �����ȣ�� 7499�� ����� �߰� ���纸�� ���� �߰� ������ �޴� ��� ���� ���
SELECT * FROM EMP
WHERE COMM > (SELECT COMM FROM EMP WHERE EMPNO = 7499);

-- �߰� ����
-- �����ȣ�� 7499�� ����� �߰� ���纸�� ���� �߰� ������ �޴� ��� ���� ��� (NULL ���� ���� �� ����)
SELECT * FROM EMP
WHERE NVL(COMM, 0) < (SELECT NVL(COMM, 0) FROM EMP WHERE EMPNO = 7499);
-- 1) EMP ���̺��� �� ����� COMM�� NULL�� �� ���� (< ����, �������� ��)
-- 2) EMP ���̺��� 7499�� COMM�� NULL�� �� ���� (< ������, �������� ��)
DESC EMP;

SELECT * FROM EMP;

-- Q2. �����ȣ�� 7844�� ������� ���� �Ի��� ��� ��� ��ȸ
SELECT * FROM EMP
WHERE HIREDATE < (SELECT HIREDATE FROM EMP WHERE EMPNO = 7844);

-- Q3. 10�� �μ����� 10�� �μ��� ��� SAL���� ���� �޴� ��� ��� ��ȸ
SELECT * FROM EMP
WHERE SAL > (SELECT AVG(SAL) FROM EMP WHERE DEPTNO = 10) AND DEPTNO = 10;


-- ������ ��������
-- : ������ ������������ ����ߴ� ������ (>, <, >=, <=, =, <>) ��� �Ұ���

-- IN ������
-- Q1. �� �μ��� �ְ� �޿��� �޴� ��� ���� ���
SELECT * FROM EMP
WHERE (DEPTNO, SAL) IN (SELECT DEPTNO, MAX(SAL) FROM EMP GROUP BY DEPTNO);
-- (30 : 2850, 20 : 3000, 10 : 5000)
-- 20 : 2850

-- Q2. �� ��å�� ���� �޿� (SAL)�� �޴� ��� ���� ���
SELECT * FROM EMP
WHERE (JOB, SAL) IN (SELECT JOB, MIN(SAL) FROM EMP GROUP BY JOB);

-- Q3. �Ի�⵵�� ���� ������� �ְ� �޿� (SAL)�� �޴� ��� ���� ���
SELECT * FROM EMP
WHERE (TO_CHAR(HIREDATE, 'YYYY'), SAL) IN
(SELECT TO_CHAR(HIREDATE, 'YYYY'), MAX(SAL) FROM EMP GROUP BY TO_CHAR(HIREDATE, 'YYYY'));


-- SOME, ANY ������
-- : SOME == ANY (*ANY�� ���) 
-- : �������� ����� �߿��� �ϳ��� ���̸� ���� ��ȯ�ϴ� ������


SELECT * FROM EMP
WHERE (DEPTNO, SAL) = ANY(SELECT DEPTNO, MAX(SAL) FROM EMP GROUP BY DEPTNO);
SELECT DEPTNO, MAX(SAL) FROM EMP GROUP BY DEPTNO;


-- ALL ������
-- : �������� ����� �߿��� ��� ���̸� ���� ��ȯ�ϴ� ������

-- 30�� �μ����� �ٹ��ϴ� ����� �� SAL�� �ּڰ����� �� ���� �޿��� �ް� �ִ� ��� ��ȸ
SELECT * FROM EMP WHERE SAL < ALL(SELECT SAL FROM EMP WHERE DEPTNO = 30);
SELECT * FROM EMP WHERE SAL < (SELECT MIN(SAL) FROM EMP WHERE DEPTNO = 30);

-- 30�� �μ����� �ٹ��ϴ� ����� �� SAL�� �ִ񰪺��� �� ���� �޿��� �ް� �ִ� ��� ��ȸ
SELECT * FROM EMP WHERE SAL > ALL(SELECT SAL FROM EMP WHERE DEPTNO = 30);
SELECT * FROM EMP WHERE SAL > (SELECT MAX(SAL) FROM EMP WHERE DEPTNO = 30);

-- EXISTS ������
-- : �������� ��� ���� �ϳ� �̻� �����ϸ� �� ��ȯ
SELECT * FROM EMP
WHERE EXISTS(SELECT COMM FROM EMP WHERE COMM IS NULL);

-- EXISTS VS IN ������
-- EXISTS: ������� ���� NULL�̿��� ������� �����ϱ� ������ TRUE ��ȯ
-- EX) �������� ������� ���� ������ ���� �������� ������ ���� ���� ����

-- IN: ������� ���� NULL�̸� ��ü ������ ����� NULL�̱� ������ ���� ����� FALSE ��ȯ
SELECT * FROM EMP 
WHERE COMM IN (SELECT COMM FROM EMP WHERE COMM IS NULL);


-- �ζ��� �� (Inline View)
-- : ��ü �����Ͱ� �ƴ� �Ϻ� �����͸� �����ؼ� ���� ���̺� (��) ����

-- WHY?
-- 1) ���̺��� ������ �ִ� ������ �Ը� �ʹ� Ŭ ��
-- 2) ���ϴ� �Ϻ� ��� ���� ����ϰ��� �� ��

SELECT * FROM EMP WHERE DEPTNO = 10;
SELECT * FROM EMP;


-- 10�� �μ����� ���ϰ� �ִ� ��� ������ 10�� �μ��� �μ�����
SELECT TBL_EMP_DEPTNO10.*, D.* 
FROM (SELECT * FROM EMP WHERE DEPTNO = 10) TBL_EMP_DEPTNO10, DEPT D
WHERE TBL_EMP_DEPTNO10.DEPTNO = D.DEPTNO;

-- WITH ~~ AS ~~~ ����
-- : ������ ����
WITH TBL_EMP_DEPTNO10 AS (SELECT * FROM EMP WHERE DEPTNO = 10)
SELECT TBL_EMP_DEPTNO10.*, D.* 
FROM TBL_EMP_DEPTNO10 JOIN DEPT D ON (TBL_EMP_DEPTNO10.DEPTNO = D.DEPTNO);

WITH TBL_EMP_DEPTNO10 AS (SELECT * FROM EMP WHERE DEPTNO = 10)
SELECT TBL_EMP_DEPTNO10.*
FROM TBL_EMP_DEPTNO10
WHERE TBL_EMP_DEPTNO10.ENAME LIKE '%K%' OR TBL_EMP_DEPTNO10.ENAME LIKE '%S%';

SELECT *
FROM EMP
WHERE DEPTNO = 10 AND (ENAME LIKE '%K%' OR ENAME LIKE '%S%';


-- Q1. �� �μ����� �� �μ��� ��� SAL���� ���� �޴� ��� ��� ��ȸ
SELECT * FROM EMP
WHERE SAL > ANY(SELECT AVG(SAL) FROM EMP GROUP BY DEPTNO) ORDER BY DEPTNO;

SELECT DEPTNO, AVG(SAL) FROM EMP GROUP BY DEPTNO;
-- 10 : 2916
-- 20 : 2258
-- 30 : 1566
-- �� ����� SAL�� �� ����� �����ִ� �μ��� ��� SAL���� Ŀ���ϴµ�
-- WHERE SAL > ANY(2916, 2258, 1566)
-- CLARK SAL�� ���� 2450�̰� 30�� �μ� ��� SAL���ٴ� ũ�ϱ� ���� ��ȸ�ǰ� ����
-- => DEPTNO�� ���� ���� ��!