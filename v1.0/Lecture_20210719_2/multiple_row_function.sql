-- [������ �Լ��� ������ �׷�ȭ]
-- : ������ �Լ� + ������ �׷�ȭ

-- �� ������ �Լ� (multiple-row function)
-- : �׷��� �Ǵ� ������ �Լ�
-- : ���� �� (�Է�)�� �������� �ϳ��� ��� (���)������ ����Ǵ� �Լ�
-- EX) AVG(), SUM(), COUNT(), MIN(), MAX()

-- �� ������ �Լ� Ư¡
-- : ������ �ȿ� NULL ���� -> NULL �����ϰ� ���
-- : �ߺ��Ǵ� �����Ͱ� ������ �ߺ� ��� (ALL)

-- 1) SUM(): �հ�

SELECT SUM(SAL)
FROM EMP;

SELECT SAL
FROM EMP;

SELECT SAL, SUM(SAL)
FROM EMP;
-- * ORA-00937 (** ���� �߻�)
-- not a single-group function
-- ������ �Լ� (SUM(SAL))�� ���� �� (SAL)�� ���� �� �ִ� 
-- ������/�� �̸��� �Բ� ����ϴ� ���

SELECT SAL, SUM(SAL)
OVER()
FROM EMP;
-- ���� �߻� ����!
-- �����͸� �м��ϱ� ���� ��� (���� �н�!)
-- SUM() �Լ��� �м��ϴ� �뵵�θ� ����Ϸ��� OVER�� ���� �ۼ��� �� ����

SELECT SUM(COMM)
FROM EMP;
-- ���������� ����ɱ�� ? (COMM�� NULL���� �� ����)
-- SUM(): ���࿡ �����Ϳ� NULL���� �����ϸ� NULL�� �����ϰ� �հ� ����
-- (������� NULL�� ������ ���� ����)

SELECT SUM(SAL), SUM(ALL SAL), SUM(DISTINCT SAL)
FROM EMP;
-- DISTINCT: SAL�� �߿��� �ߺ��� ���� (1250�� �ѹ��� ���)
-- �ƹ��� Ű������� ��� - SUM(ALL SAL) = SUM(SAL)

-- ����) SUM([ALL/DISTINCT (����)], [��/������])
--      OVER(�м��� ���� ����) (����)
-- �⺻��: ALL
-- DISTINCT: �ߺ� ����


-- Q1. EMP ���̺��� DEPTNO�� 30�� ������� �ٹ� �ϼ� ����
SELECT SUM(TRUNC(SYSDATE - HIREDATE)) AS SUM_WORKINGDAYS
FROM EMP
WHERE DEPTNO = 30;


-- 2) COUNT(): ����
-- ����) COUNT([ALL/DISTINCT (����)], [��/������])
--      OVER(�м��� ���� ����) (����)
-- �⺻��: ALL
-- DISTINCT: �ߺ� ����
-- COUNT(*): ���ǿ� �´� ���̺� �� ���� ��ȯ


-- ��: NULL, NULL .... NULL 
-- (13�� ����� ���Դµ� ���� � ����� ���� �� �𸣴� ���)

-- COUNT(*)�� ������ �ǳ���?
-- >> COUNT(*) ����

SELECT COUNT(*) AS NUMBEROFEMP
FROM EMP;

-- COUNT(COMM) -> NULL ����
SELECT COUNT(COMM)
FROM EMP;


SELECT COUNT(SAL), COUNT(ALL SAL), COUNT(DISTINCT SAL) 
FROM EMP;



-- 1
SELECT COUNT(*)
FROM EMP
WHERE COMM IS NOT NULL;

-- 2
SELECT COUNT(COMM)
FROM EMP;
-- COUNT([�� �̸�]) �Լ� ����� �� 
-- ���� �ش��ϴ� ������ �� NULL���� ������ NULL ������ �� ������ ��ȯ
-- 1 = 2

-- 3) MAX(), MIN()
-- MAX(): �ִ� ��ȯ
-- MIN(): �ּڰ� ��ȯ

-- ����) MAX([ALL/DISTINCT (����)], [��/������])
--      OVER(�м��� ���� ����) (����)

-- ����) MIN([ALL/DISTINCT (����)], [��/������])
--      OVER(�м��� ���� ����) (����)

-- ALL/DISTINCT��
-- MAX(), MIN() ����� ��� ..?
-- => ����� ���� (��� ���ǹ���)

-- Q1. �μ� ��ȣ�� 30�� ����� �� ���� �ֱ� �Ի��� ��� (MAX())
SELECT MAX(HIREDATE)
FROM EMP
WHERE DEPTNO = 30;

-- Q2. �μ� ��ȣ�� 10�� ����� �� ���� ������ �Ի��� ��� (MIN())
SELECT MIN(HIREDATE)
FROM EMP
WHERE DEPTNO = 10;

-- 4) AVG()
-- : ��հ� ��ȯ
-- ����) AVG([ALL/DISTINCT (����)], [��/������])
--      OVER(�м��� ���� ����) (����)
-- �⺻��: ALL

SELECT AVG(SAL), AVG(ALL SAL), AVG(DISTINCT SAL)
FROM EMP;


-- �� GROUP BY��
-- : �����͸� �׷����� ��� ���
-- : ������ �Լ��� �Բ� ����ؼ� �����͸� �ϳ��� ����� ���
-- EX) �μ����� ��� �޿� ����
SELECT DEPTNO, AVG(SAL) OVER() FROM EMP WHERE DEPTNO = 10
UNION
SELECT DEPTNO, AVG(SAL) OVER() FROM EMP WHERE DEPTNO = 20
UNION
SELECT DEPTNO, AVG(SAL) OVER() FROM EMP WHERE DEPTNO = 30;
-- OVER() : ���α׷��ӵ��� �м��ϱ� ���� ����ϴ� �Լ�
-- �ڵ尡 ���� (SELECT 3�� UNION)

SELECT *
FROM EMP
ORDER BY DEPTNO;


SELECT DEPTNO, AVG(SAL)
FROM EMP
GROUP BY DEPTNO; 
-- ���� ����
-- 1. DEPTNO �������� ������ ���� (10, 20, 30 �׷캰�� ����)
-- 2. ���� �׷� (���� DEPTNO)�� AVG�� ����
-- * GROUP BY�� ���ؿ� �ش��ϴ� �� �̸��� SELECT ���忡 ������ �Լ��� ���� �ۼ��� �� ���� **
-- * ���ؿ� �ش��ϴ� ���� �̸��� �ƴϸ� SELECT ���忡 �ۼ��� �� ���� (SAL ����!)
-- * GROUP BY ���� ���� SELECT �κе� Ȯ�� �ʿ�!

SELECT DEPTNO, JOB,  AVG(SAL)
FROM EMP
GROUP BY DEPTNO, JOB
ORDER BY DEPTNO, JOB;

-- ������ ���� (GROUP BY + CASE��)
SELECT DEPTNO, JOB, 
   CASE 
   WHEN AVG(SAL) <= 1000 THEN '1000 ����'
   WHEN AVG(SAL) <= 3000 THEN '1000 �ʰ� ~ 3000 ����'
   WHEN AVG(SAL) <= 5000 THEN '3000 �ʰ� ~ 5000 ����'
   ELSE '5000 �ʰ�'
   END AS AVG_STR
FROM EMP
GROUP BY DEPTNO, JOB
ORDER BY DEPTNO, JOB;


-- ���� ����
-- 1. DEPTNO �������� ������ ���� (10, 20, 30 �׷캰�� ����)
-- 2. ���� DEPTNO�� ���� ����� �߿� JOB���� �ٽ� ����
-- 3. ���� �׷� (������ DEPTNO - ������ JOB)�� AVG�� ����

-- ��� ���
-- DEPTNO�� �������� ��������, JOB�� �������� ��������


-- �� GROUP BY���� ���ǽ��� �����ϴ� HAVING��
-- : GROUP BY�� ���� �׷����� �� �׷쿡 ���� ���� �߰�

SELECT DEPTNO, JOB, AVG(SAL)
FROM EMP
GROUP BY DEPTNO, JOB
HAVING AVG(SAL) >= 2000
ORDER BY DEPTNO, JOB;

SELECT DEPTNO, JOB, AVG(SAL)
FROM EMP
GROUP BY DEPTNO, JOB AS GROUP_STD
HAVING AVG(SAL) >= 2000 AS GROUP_FILTER
ORDER BY DEPTNO, JOB;
-- GROUP �� �� ��� ���̴� GROUP BY, HAVING�� AS�� �Ұ���!

SELECT DEPTNO, JOB, AVG(SAL)
FROM EMP
WHERE SAL >= 2000
GROUP BY DEPTNO, JOB
ORDER BY DEPTNO, JOB;


SELECT DEPTNO, AVG(SAL) 
FROM EMP 
WHERE AVG(SAL) >= 2000 
-- �� �࿡ ���� ����
-- group function�� WHERE�� ���� �� �� ����
-- ORA-00934
GROUP BY DEPTNO, JOB  
ORDER BY DEPTNO, JOB;


/* HAVING�� ����
 * 
 * SELECT [�� �̸�], [�� �̸�] ...
 * FROM [���̺� �̸�]
 * GROUP BY [�׷�ȭ�� �� (���� �� ���� ����)]
 * HAVING [�׷�ȭ ���ǽ�]
 * ORDER BY [������ ��]
 * */

/* WHERE VS HAVING 
 * - HAVING VS WHERE
	- HAVING ���� ����: GROUP BY (���� �� ����) -> HAVING (�׷� ����) -> ���
	- WHERE ���� ����: WHERE (�� ����) -> ���
	- HAVING + WHERE: WHERE (�� ����) 
					-> GROUP BY (���� �� ����) 
					-> HAVING (�׷� ����)
					-> ��� 
 					>> WHERE���� HAVING���� ���� ����
 * * 
 * */

SELECT DEPTNO, JOB, AVG(SAL)
FROM EMP
GROUP BY DEPTNO, JOB
HAVING AVG(SAL) >= 2000
--ORDER BY DEPTNO, JOB
MINUS
SELECT DEPTNO, JOB, AVG(SAL)
FROM EMP
WHERE SAL <= 3000 -- 1
GROUP BY DEPTNO, JOB
HAVING AVG(SAL) >= 2000 -- 2
ORDER BY DEPTNO, JOB;

-- Q1. ���� ��å (JOB)�� �����ϴ� ����� 3�� �̻��� ��å�� �ο��� ���
-- �׷� ����: ��å

SELECT JOB, COUNT(*) AS COUNT_SAME_JOB
FROM EMP
GROUP BY JOB
HAVING COUNT(*) >= 3;

-- Q2. �̸��� ���̰� ���� ������� �׷����ؼ� ������ �̸��� ���̸� ���� �̸� ���̿� ����� ��� 
-- �׷� ����: LENGTH(ENAME)

SELECT LENGTH(ENAME), COUNT(*) AS COUNT_SAME_LENGTH_ENAME
FROM EMP
GROUP BY LENGTH(ENAME);

SELECT * FROM EMP;



-- Q3. ����� �Ի��� (HIREDATE)�� �������� �Ի翬�� (HIREYEAR)�� ���ϰ�
--     �ش� ������ �μ��� �� ���� �Ի��ߴ� �� ���
-- �׷� ����: �Ի翬��, �μ�

-- HIREDATE : DATE -> CHAR
-- DATE -> NUMBER (�ٷ� �� ��ȯ �Ұ�)
SELECT TO_CHAR(HIREDATE, 'YYYY') AS HIREYEAR,
		DEPTNO,
		COUNT(*) AS COUNT
FROM EMP
GROUP BY TO_CHAR(HIREDATE, 'YYYY'), DEPTNO
ORDER BY TO_CHAR(HIREDATE, 'YYYY'), DEPTNO;
-- GROUP BY, HAVING���� AS ��Ī ������ �� ����!

-- Q4. �μ��� �߰����� (COMM) ���ο� ���� ����� ���
-- �׷� ����: �μ�, �߰����� ���� (NVL2)
SELECT * FROM EMP;	

SELECT DEPTNO, NVL2(COMM, 'O', 'X') AS ISCOMM, COUNT(*) AS COUNT
FROM EMP
GROUP BY DEPTNO, NVL2(COMM, 'O', 'X')
ORDER BY DEPTNO, NVL2(COMM, 'O', 'X'); 
-- �߰������� 0�� ����� ����
-- NVL2: NULL�� ���ο� ���� ��ȯ�� ���� 

-- �߰����� 0�� ��� ���ܽ�Ű��! (DECODE(), CASE��)
SELECT DEPTNO, DECODE(COMM, 
						0, 'X', 
						NULL, 'X', 
						'O') AS ISCOMM, 
		COUNT(*) AS COUNT
FROM EMP
GROUP BY DEPTNO, DECODE(COMM, 
						0, 'X', 
						NULL, 'X', 
						'O') -- ('X', 'O')
ORDER BY DEPTNO, DECODE(COMM, 
						0, 'X',
						NULL, 'X', 
						'O');
-- DECODE()
-- 1) COMM = NULL (X) => COMM IS NULL
-- 2) ��ȯ�Ǵ� ���� ������ Ÿ�� �޶� ���������� �Ͻ��� �� ��ȯ (���� �����ϸ�)
-- NUMBER, NUMBER, '1111' => 1111
-- => ���� ������ ����
-- => DECODE() -> CASE�� ��ü

SELECT DEPTNO, (CASE COMM
				WHEN NULL THEN 'X'
				WHEN 0 THEN 'X'
				ELSE 'O'
			  END) AS ISCOMM, 
		COUNT(*) AS COUNT
FROM EMP
GROUP BY DEPTNO, (CASE COMM
				WHEN NULL THEN 'X'
				WHEN 0 THEN 'X'
				ELSE 'O'
			  END) AS ISCOMM
ORDER BY DEPTNO, (CASE COMM
				WHEN NULL THEN 'X'
				WHEN 0 THEN 'X'
				ELSE 'O'
			  END) AS ISCOMM; 
			  

SELECT DEPTNO, (CASE 
				WHEN COMM IS NULL THEN 'X'
				WHEN COMM = 0 THEN 'X'
				ELSE 'O'
			  END) AS ISCOMM, 
		COUNT(*) AS COUNT
FROM EMP
GROUP BY DEPTNO, (CASE 
				WHEN COMM IS NULL THEN 'X'
				WHEN COMM = 0 THEN 'X'
				ELSE 'O'
			  END)
ORDER BY DEPTNO, (CASE 
				WHEN COMM IS NULL THEN 'X'
				WHEN COMM = 0 THEN 'X'
				ELSE 'O'
			  END);
	
SELECT DEPTNO, (CASE 
				WHEN COMM > 0 THEN 'O'
				ELSE 'X'
			  END) AS ISCOMM, 
		COUNT(*) AS COUNT
FROM EMP
GROUP BY DEPTNO, (CASE 
				WHEN COMM > 0 THEN 'O'
				ELSE 'X'
			  END)
ORDER BY DEPTNO, (CASE 
				WHEN COMM > 0 THEN 'O'
				ELSE 'X'
			  END);
			  

-- Q5. �߰����� (COMM)�� �޴� ������� ���� �ʴ� ����� ���
-- �׷� ����: �߰� ���� ����

SELECT NVL2(COMM, 'O', 'X') AS ISCOMM, COUNT(*) AS COUNT
FROM EMP
GROUP BY NVL2(COMM, 'O', 'X');

SELECT * FROM EMP;

-- Q5-1. �߰����� (COMM)�� �޴� ������� ���� �ʴ� ����� ��� (0�� �����Ϸ��� ?)
-- �׷� ����

SELECT (CASE 
		WHEN COMM IS NULL THEN 'X'
		WHEN COMM = 0 THEN 'X'
		ELSE 'O'
	  END) AS ISCOMM, COUNT(*) AS COUNT
FROM EMP
GROUP BY (CASE 
		WHEN COMM IS NULL THEN 'X'
		WHEN COMM = 0 THEN 'X'
		ELSE 'O'
	  END);