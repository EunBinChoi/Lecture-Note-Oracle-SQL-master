-- 2) ������ �Լ� (multiple-row function)
-- : ���� �� (�Է�)�� �������� �ϳ��� ��� (���)���� �����ϴ� �Լ�
-- EX) AVG(), SUM(), COUNT(), MIN(), MAX()

-- (**) ������ �߿� NULL���� ������ NULL �����ϰ� ���
SELECT MAX(COMM) FROM EMP;
SELECT MIN(COMM) FROM EMP;

-- (**) ������ �ȿ� �ߺ� ���
SELECT COUNT(MGR), COUNT(ALL MGR) FROM EMP; 
-- MGR�� NULL�� ���� �����ϰ� COUNT ���
-- COUNT(MGR) = COUNT(ALL MGR)

-- ���� ������ �ȿ� �ߺ��� �����ϰ� �ʹٸ� ??
SELECT COUNT(DISTINCT MGR) FROM EMP;

-- ���� EMP ���̺��� ��� ��  (�� ����)�� �ñ��ϸ� ??
SELECT COUNT(*) FROM EMP;
SELECT COUNT(ENAME) FROM EMP; 
-- ENAME NULL���� ����ϴ� ���̱� ������ ��� ���� Ȯ���ϱ⿡�� ������� ���� �� ����
-- (*) COUNT �Ϸ��� �ϴ� ���� NULL�� ������ NULL �����ϰ� ī��Ʈ
SELECT COUNT(EMPNO) FROM EMP; 
-- EMPNO PRIMARY KEY (NOT NULL) �����Ǿ��ֱ� ������ ��� ���� Ȯ���ϱ⿡ ������ ����

-- not a single-group function ...
-- SAL�� ��ȸ�� �� �ʿ��� ���� ���� != SUM(SAL)�� ���� ���� => �ϳ��� ���̺�� ǥ�� �Ұ�
SELECT SAL, SUM(SAL) FROM EMP; -- ?


-- Q1. EMP ���̺��� DEPTNO�� 30�� ����� �� �ٹ� �ϼ� �ִ�
SELECT ROUND(MAX(SYSDATE-HIREDATE)) FROM EMP WHERE DEPTNO = 30;

-- Q2. EMP ���̺��� JOB�� SALESMAN�� ����� �� COMM�� ���� �����

-- COMM <> 0 : COMM�� 0�� ����� COMM�� NULL�� ��� ����
SELECT COUNT(*) FROM EMP WHERE JOB = 'SALESMAN' AND COMM <> 0;
-- ���: (PK, NULL, .... NULL): COUNT(*) ������ ��
SELECT COUNT(COMM) FROM EMP WHERE JOB = 'SALESMAN' AND COMM <> 0;
-- ���: (PK, NULL, .... NULL): COUNT(COMM) ������ �ȵ�

SELECT COUNT(*) FROM EMP;
SELECT COUNT(COMM) FROM EMP; -- COMM�� NULL�� ��� ����

-- Q3. EMP ���̺��� ����� ��� (MGR)�� 7698�� �����
SELECT COUNT(*) FROM EMP WHERE MGR = 7698;

-- Q4. �μ� ��ȣ�� 30�� ����� �� ���� �ֱ� �Ի��� ���
SELECT MAX(HIREDATE) FROM EMP WHERE DEPTNO = 30;

-- ���� ����� ������ ���� �������� ? (SUBQUERY)

SELECT * 
FROM EMP 
WHERE HIREDATE 
= (SELECT MAX(HIREDATE) FROM EMP WHERE DEPTNO = 30) AND DEPTNO = 30;

SELECT EMPNO, ENAME, MAX(HIREDATE) OVER() FROM EMP WHERE DEPTNO = 30;
SELECT * FROM EMP;

-- Q5. �μ� ��ȣ�� 30�� ����� �� ó������ �Ի��� ����� �Ի��� ���
SELECT MIN(HIREDATE) FROM EMP WHERE DEPTNO = 30;

-- ���� ����� ������ ���� �������� ?
SELECT * 
FROM EMP 
WHERE HIREDATE 
= (SELECT MIN(HIREDATE) FROM EMP WHERE DEPTNO = 30) AND DEPTNO = 30;

-- Q6. ��å�� SALESMAN�� ������� SAL ��� ���
SELECT AVG(SAL) 
FROM EMP 
WHERE JOB = 'SALESMAN'; -- NULL�� �˾Ƽ� ���� (���� �Լ� Ư¡)

SELECT MAX(SAL) FROM EMP;
SELECT ENAME, UPPER(ENAME) FROM EMP; 
-- ������ �Լ�: UPPER, LOWER, SUBSTR, INSTR, LPAD, RPAD, TRIM, ........

-- GROUP BY��
-- : �����͸� �׷����� ��� ���
-- : (+ ������ �Լ�)

-- EX)
-- 10�� �μ��� ��� SAL
-- 20�� �μ��� ��� SAL
-- 30�� �μ��� ��� SAL
SELECT DEPTNO, AVG(SAL) OVER() FROM EMP WHERE DEPTNO = 10
UNION
SELECT DEPTNO, AVG(SAL) OVER() FROM EMP WHERE DEPTNO = 20
UNION
SELECT DEPTNO, AVG(SAL) OVER() FROM EMP WHERE DEPTNO = 30;
-- OVER(): ���α׷��ӵ��� �����͸� �м��ϱ� ���ؼ� ����ϴ� �Լ�
-- 10 2916.666...
-- 10 2916.666...
-- 10 2916.666...

SELECT DEPTNO, AVG(SAL) 
-- GROUP BY ���ؿ� ����ϴ� �� �̸��� SELECT ���忡�� ������ �Լ��� ���� �� �� ����
-- => (*) DEPTNO �׷� ������ŭ AVG(SAL) ������ ����
-- GROUP BY ���ؿ� ������� �ʴ� �� �̸��� SELECT ���忡�� ������ �Լ��� ���� �� �� ����
FROM EMP
GROUP BY DEPTNO
ORDER BY DEPTNO;

-- Q1. �Ʒ��� �� ���ǹ� �������� �����غ��� ��������� �����غ���
SELECT DEPTNO, JOB, AVG(SAL) -- 4
FROM EMP
GROUP BY DEPTNO, JOB -- 1
HAVING AVG(SAL) >= 2000  -- 2
-- �׷� ���� �߰�
-- (*) ������ �Լ� ��� ����
ORDER BY DEPTNO, JOB; -- 3
-- �׷����� �� ���̴� GROUP BY, HAVING���� AS (��Ī) ��� �Ұ���!

SELECT DEPTNO, JOB, AVG(SAL) -- 4
FROM EMP
WHERE SAL >= 2000 -- 1
-- ������ ���� �߰� (�� �࿡ ���� ����)
-- (*) ������ �Լ� ��� �Ұ�
GROUP BY DEPTNO, JOB -- 2
ORDER BY DEPTNO, JOB; -- 3

-- Q2. ���� ��å�� �����ϴ� ����� 3�� �̻��� ��å�� �ο� ���� ���
SELECT JOB, COUNT(*) AS COUNT
FROM EMP
GROUP BY JOB
HAVING COUNT(*) >= 3;

-- Q3. �̸��� ���̰� ���� ������� �׷����ؼ� 
-- ������ �̸��� ���̸� ���� �̸��� ���̿� ����� ���
SELECT LENGTH(ENAME), COUNT(*)
FROM EMP
GROUP BY LENGTH(ENAME)
ORDER BY LENGTH(ENAME);

-- Q4. ����� �Ի����� ���� �Ի�⵵ (YYYY)�� ���ϰ� 
-- �ش� ������ �μ��� �� ���� �Ի��ߴ��� ���
-- �׷� ����: �Ի�⵵, �μ�
SELECT TO_CHAR(HIREDATE, 'YYYY') AS HIREYEAR, DEPTNO, COUNT(*) AS COUNT
FROM EMP
GROUP BY TO_CHAR(HIREDATE, 'YYYY'), DEPTNO
ORDER BY TO_CHAR(HIREDATE, 'YYYY'), DEPTNO;
-- TO_CHAR(): DATE�� (�⵵/��/�� ��:��:��) -> ������

-- Q5. �μ��� �߰����� (COMM) ���ο� ���� ��� �� ���
-- �߰����� (COMM) : NULL�� ����� ����
SELECT DEPTNO, NVL2(COMM, 'O', 'X') AS ISCOMM, COUNT(*)
FROM EMP
GROUP BY DEPTNO, NVL2(COMM, 'O', 'X')
ORDER BY DEPTNO, NVL2(COMM, 'O', 'X');

-- �߰����� (COMM) : 0�� ����� �����ϱ� ���� 
-- 1) REPLACE() ��� (0 -> NULL ����)
SELECT DEPTNO, NVL2(REPLACE(COMM, 0, NULL), 'O', 'X') AS ISCOMM, COUNT(*)
FROM EMP
GROUP BY DEPTNO, NVL2(REPLACE(COMM, 0, NULL), 'O', 'X')
ORDER BY DEPTNO, NVL2(REPLACE(COMM, 0, NULL), 'O', 'X');

-- 2) DECODE(), CASE�� ��� (0 -> NULL ����)
SELECT DEPTNO, DECODE(COMM, 0, 'X', NULL, 'X', 'O') AS ISCOMM, COUNT(*)
FROM EMP
GROUP BY DEPTNO,  DECODE(COMM, 0, 'X', NULL, 'X', 'O')
ORDER BY DEPTNO,  DECODE(COMM, 0, 'X', NULL, 'X', 'O');

SELECT DEPTNO, CASE  
                            WHEN COMM = 0 THEN 'X'
                            WHEN COMM IS NULL THEN 'X'
                            ELSE 'O' END
                        AS ISCOMM, COUNT(*)
FROM EMP
GROUP BY DEPTNO,  CASE  
                            WHEN COMM = 0 THEN 'X'
                            WHEN COMM IS NULL THEN 'X'
                            ELSE 'O' END
ORDER BY DEPTNO,  CASE  
                            WHEN COMM = 0 THEN 'X'
                            WHEN COMM IS NULL THEN 'X'
                            ELSE 'O' END;
                          



-- Q6. �߰����� (COMM)�� �޴� ������� ���� ���� ����� ���
-- �߰����� (COMM) : NULL�� ����� ����
SELECT NVL2(COMM, 'O', 'X') AS ISCOMM, COUNT(*) AS COUNT
FROM EMP
GROUP BY NVL2(COMM, 'O', 'X');

SELECT * FROM EMP;

-- �߰����� (COMM) : 0�� ����� ����
-- 1) REPLACE()
SELECT NVL2(REPLACE(COMM, 0, NULL), 'O', 'X') AS ISCOMM, COUNT(*) AS COUNT
FROM EMP
GROUP BY NVL2(REPLACE(COMM, 0, NULL), 'O', 'X');

-- 2) DECODE(), CASE��
SELECT DECODE(COMM, 0,  'X', NULL, 'X', 'O') AS ISCOMM, COUNT(*) AS COUNT
FROM EMP
GROUP BY DECODE(COMM, 0,  'X', NULL, 'X', 'O');

SELECT CASE
            WHEN COMM = 0 THEN 'X'
            WHEN COMM IS NULL THEN 'X'
            ELSE 'O' END AS ISCOMM, COUNT(*) AS COUNT
FROM EMP
GROUP BY CASE
            WHEN COMM = 0 THEN 'X'
            WHEN COMM IS NULL THEN 'X'
            ELSE 'O' END;
        
-- ����!
SELECT CASE COMM
            WHEN 0 THEN 'X'
            WHEN NULL THEN 'X' -- COMM = NULL -> NULL
            ELSE 'O' END AS ISCOMM, COUNT(*) AS COUNT
FROM EMP
GROUP BY CASE COMM
            WHEN 0 THEN 'X'
            WHEN NULL THEN 'X'
            ELSE 'O' END;


DECODE(�� �̸�, -- ������� = �� �� �� ����
            ��, ��ȯ�� ��,
            NULL, ��ȯ�� ��, -- �� �̸� = NULL (X) -> �� �̸� IS NULL
            ��ȯ�� ��)
            
CASE �� �̸�
    WHEN �� THEN ��ȯ�� ��
    WHEN NULL THEN ��ȯ�� �� -- �� �̸� = NULL (���� ��� NULL)
    ELSE ��ȯ�� �� END

CASE 
    WHEN �� �̸� = �� THEN ��ȯ�� ��
    WHEN �� �̸� >= �� AND �� �̸� <= �� THEN ��ȯ�� ��
    WHEN �� �̸� IS NULL THEN ��ȯ�� ��
    ELSE ��ȯ�� �� END
-- (***) CASE���� ���� NULL���� �Ǵ��� ���� IS NULL�� �� ����� ��!




-- ���� �߰��ϴ� ���
-- Q5. �μ��� COMM ���ο� ���� ��� �� ���
-- 1)
SELECT DEPTNO, COUNT(DECODE(COMM,
    0, NULL,
    COMM)) AS HASCOMM ,
       COUNT(DEPTNO) - COUNT(DECODE(COMM,
    0, NULL,
    COMM)) AS HASNOTCOMM
FROM EMP
    GROUP BY DEPTNO;
-- 2)
SELECT DEPTNO, NVL2(DECODE(COMM,
    0, NULL,
    COMM), 'HASCOMM', 'HASNOTCOMM'), COUNT(*)
FROM EMP
    GROUP BY DEPTNO, NVL2(DECODE(COMM,
    0, NULL,
    COMM), 'HASCOMM', 'HASNOTCOMM')
ORDER BY DEPTNO, NVL2(DECODE(COMM,
    0, NULL,
    COMM), 'HASCOMM', 'HASNOTCOMM');

-- Q6. �߰����� (COMM)�� �޴� ������� ���� ���� ����� ���
-- 1)
SELECT COUNT(DECODE(COMM,
    0, NULL,
    COMM)) AS HASCOMM,
    COUNT(*) - COUNT(DECODE(COMM,
    0, NULL,
    COMM)) AS HASNOTCOMM
FROM EMP;
-- 2)
SELECT NVL2(DECODE(COMM,
    0, NULL,
    COMM), 'HASCOMM', 'HASNOTCOMM'), COUNT(*)
FROM EMP
    GROUP BY NVL2(DECODE(COMM,
    0, NULL,
    COMM), 'HASCOMM', 'HASNOTCOMM')
ORDER BY NVL2(DECODE(COMM,
    0, NULL,
    COMM), 'HASCOMM', 'HASNOTCOMM');
    