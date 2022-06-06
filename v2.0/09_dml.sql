-- ������ ���۾� (DML, Data Manipulation Language)
-- : ���̺� �����͸� �߰�/����/�����ϴ� ���
-- : INSERT, UPDATE, DELETE (DML) -- > ���� COMMIT
-- : CREATE, DROP, ALTER (DDL) --> �ڵ� COMMIT

SELECT * FROM TAB;

-- INSERT (������ �߰�)
-- INSERT INTO ���̺�� (Ư�� �� �̸�) VALUES (������)
-- (*) �� �ڷ��� = ������ �ڷ���
-- (*) ���� ���� = ������ ����

-- INSERT INTO ���̺�� VALUES (������)
-- : ���̺��� ���� ��� ���� ���ؼ� ��� �����͸� �ۼ�

-- ���� ���̺��� �����͸� �������� �ʱ� ���ؼ� ���ο� ���̺� ���� (���� ���̺� ����, ���� ����)
CREATE TABLE EMP_TEMP
AS SELECT * FROM EMP;

CREATE TABLE DEPT_TEMP
AS SELECT * FROM DEPT;


INSERT INTO EMP_TEMP (EMPNO, ENAME) VALUES (8000, 'GOOTT');
COMMIT;

INSERT INTO EMP_TEMP (EMPNO, ENAME) VALUES (8001, 'GOOTT2');
ROLLBACK; -- ���� Ŀ�� ���·� �ǵ���

INSERT INTO EMP_TEMP VALUES (8001, 'GOOTT2', 'SALESMAN', 7698, SYSDATE, 3000, 0, 30);
COMMIT;

INSERT INTO EMP_TEMP VALUES (8002, 'GOOTT3', 'SALESMAN', 7698, 3000, 0, 30);
-- ���� �߻�: ���� ���� != ������ ����
-- ���� Ư�� ���� �����͸� �߰��ϰ� ������ () �ȿ� �� �̸��� �ۼ������ ��!

INSERT INTO EMP_TEMP VALUES ('AAAA', 'GOOTT3', 'SALESMAN', 7698, SYSDATE, 3000, 0, 30);
-- ���� �߻�: ���� �ڷ��� != ������ �ڷ���

-- Q1. ���� ��¥ (2022/01/05)�� ������ �־��
INSERT INTO EMP_TEMP VALUES (8002, 'GOOTT3', 'SALESMAN', 7698,  TO_DATE('2022/01/05', 'YYYY/MM/DD') , 3000, 0, 30);
COMMIT;

-- Q2. ���̺� ���� (EMP_TEMP2)�� �ϴµ� ������ ���縦 �ϰ� �����ʹ� �������� �������� ?
CREATE TABLE EMP_TEMP2
AS SELECT * FROM EMP WHERE 1 <> 1; -- �������� ���ǽ��� False�� �Ǹ� ������ ��� ���� ����

-- Q3. EMP ���̺��� DEPTNO = 30���� ����� EMP_TEMP2�� INSERT
INSERT INTO EMP_TEMP2 
SELECT *
FROM EMP
WHERE DEPTNO = 30;
COMMIT;

-- Q4. EMP ���̺��� ������ ������ EMP_TEMP3
-- EMP, SALGRADE ���̺��� �̿��Ͽ� ����� SAL ����� 1����� ����� EMP_TEMP3�� ����
-- (EMPNO, ENAME, SAL, COMM)
CREATE TABLE EMP_TEMP3
AS SELECT * FROM EMP WHERE 1 <> 1;

-- ISO ��ǥ��
INSERT INTO EMP_TEMP3 (EMPNO, ENAME, SAL, COMM)
SELECT E.EMPNO, E.ENAME, E.SAL, E.COMM
FROM EMP E, SALGRADE S
WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL AND S.GRADE = 1;
COMMIT;

-- ISO ǥ��
INSERT INTO EMP_TEMP3 (EMPNO, ENAME, SAL, COMM)
SELECT E.EMPNO, E.ENAME, E.SAL, E.COMM
FROM EMP E JOIN SALGRADE S ON (E.SAL BETWEEN S.LOSAL AND S.HISAL)
WHERE S.GRADE = 1;
COMMIT;

-- Q5. EMP ���̺��� ������ ������ EMP_TEMP4
-- SMITH�� SAL���� ���� SAL�� �ް� �ִ� ������� ��� ���� ����
CREATE TABLE EMP_TEMP4
AS SELECT * FROM EMP WHERE 1 <> 1;

INSERT INTO EMP_TEMP4
SELECT *
FROM EMP
WHERE SAL > (SELECT SAL FROM EMP WHERE ENAME = 'SMITH');
SELECT * FROM EMP_TEMP4;
COMMIT;

-- Q6. EMP ���̺��� ������ ������ EMP_TEMP5
-- 30�� �μ��� ��� SAL���� ���� SAL�� �ް� �ִ� 30�� �μ� ������� ��� ���� ����
CREATE TABLE EMP_TEMP5
AS SELECT * FROM EMP WHERE 1 <> 1;

INSERT INTO EMP_TEMP5
SELECT *
FROM EMP
WHERE SAL > (SELECT AVG(SAL) FROM EMP WHERE DEPTNO = 30) AND DEPTNO = 30; 
COMMIT;

CREATE TABLE EMP_TEMP5_2
AS SELECT * FROM EMP WHERE 1 <> 1;

INSERT INTO EMP_TEMP5_2
SELECT *
FROM (SELECT * FROM EMP WHERE DEPTNO = 30) EMP_DEPTNO30
WHERE EMP_DEPTNO30.SAL > (SELECT AVG(SAL) FROM EMP WHERE DEPTNO = 30); 
COMMIT;


-- ������ �ϰ� ����
-- .CSV ������ ���� INSERT �ؼ� ���̺� POP_IN_SEOUL ���� (������ ����Ʈ ������ �̿�)
DROP TABLE POP_IN_SEOUL;
SELECT * FROM POP_IN_SEOUL;
DESC POP_IN_SEOUL;

-- Q1. ����ڰ� ���� ���� ��ġ�� ���
SELECT ��ġ��
FROM POP_IN_SEOUL
WHERE ����� = (SELECT MAX(�����) FROM POP_IN_SEOUL);

-- Q2. �ܱ��� (����, ���� ����)�� ���� ���� ��ġ�� ���
SELECT ��ġ��
FROM POP_IN_SEOUL
WHERE �ܱ��γ��� + �ܱ��ο��� = (SELECT MAX(�ܱ��γ��� + �ܱ��ο���) FROM POP_IN_SEOUL);

-- Q3. �� ��ġ���� �ѱ��� �հ�, �ܱ��� �հ�, �� ��ġ���� �� �ο� ����ؼ� ���� ���
SELECT ��ġ��, �ѱ��γ���+�ѱ��ο��� AS �ѱ����հ�, �ܱ��γ���+�ܱ��ο��� AS �ܱ����հ�,
�ѱ��γ���+�ѱ��ο���+�ܱ��γ���+�ܱ��ο��� AS �հ�
FROM POP_IN_SEOUL;


-- Q4. �� ��ġ���� �ѱ��� ������ �ѱ��� �������� ������ �� 
--      �ѱ��� ������ �� ������ M, �ѱ��� ������ �� ������ F�� ���
SELECT ��ġ��, �ѱ��γ���, �ѱ��ο���, 
    CASE 
        WHEN �ѱ��γ��� > �ѱ��ο��� THEN 'M'
        WHEN �ѱ��γ��� < �ѱ��ο��� THEN 'F'
        END AS �������
FROM POP_IN_SEOUL;


-- INSERT ALL
CREATE TABLE EMP_TEMP6
AS SELECT * FROM EMP WHERE 1 <> 1;

INSERT ALL
INTO EMP_TEMP6 (EMPNO, ENAME) VALUES (1111, 'SALLY')
INTO EMP_TEMP6 (EMPNO, ENAME) VALUES (2222, 'JONES')
INTO EMP_TEMP6 (EMPNO, ENAME) VALUES (3333, 'GILDONG')
SELECT * FROM DUAL;
COMMIT;

-- INSERT INTO + UNION ALL
INSERT INTO EMP_TEMP6 (EMPNO, ENAME)
WITH NAMES AS (
    SELECT 4444, 'SMITH' FROM DUAL UNION ALL
    SELECT 5555, 'JAVA' FROM DUAL UNION ALL
    SELECT 6666, 'ORACLE' FROM DUAL
)
SELECT * FROM NAMES;
COMMIT;

-- SQL LOADER �̿� (.CSV ����, .CTL ����)
-- cmd, terminal â����
-- sqlldr scott control="pop_in_seoul.ctl"
/*
load data
infile 'pop_in_seoul_wo_comma.csv'
into table POP_IN_SEOUL2
fields terminated by "," optionally enclosed by '"'
(��ġ��, �ѱ��γ���, �ѱ��ο���, �ܱ��γ���, �ܱ��ο���, ����� terminated by whitespace)
*/

CREATE TABLE POP_IN_SEOUL2
AS SELECT * FROM POP_IN_SEOUL WHERE 1 <> 1;
SELECT * FROM POP_IN_SEOUL2;


-- UPDATE (������ ����)
-- UPDATE ���̺� �̸� SET ������ �� �̸� = �� WHERE ���ǽ�

SELECT * FROM EMP_TEMP;

--  Q1. EMP_TEMP ���̺��� �̸��� GOOTT ���Ե� ������� SAL 5000 ����
UPDATE EMP_TEMP 
SET SAL = 5000
WHERE ENAME LIKE '%GOOTT%';
SELECT * FROM EMP_TEMP;
COMMIT;

-- Q2. EMP_TEMP ���̺��� �޿��� 2500 ������ ������� COMM�� 1000 ����
UPDATE EMP_TEMP
SET COMM = 1000
WHERE SAL <= 2500;
SELECT * FROM EMP_TEMP;
COMMIT;

-- Q3. DEPT_TEMP ���̺��� �μ��̸��� SALES�� �μ��� ��ġ�� SEOUL�� ����
UPDATE DEPT_TEMP
SET LOC = 'SEOUL'
WHERE DNAME = 'SALES';
SELECT * FROM DEPT_TEMP;
COMMIT;

-- Q4. DEPT_TEMP ���̺��� 30�� �μ��� �μ� �̸��� ��ġ�� 40�� �μ��� �����ϰ� ����
UPDATE DEPT_TEMP
SET (DNAME, LOC) = (SELECT DNAME, LOC FROM DEPT_TEMP WHERE DEPTNO = 40)
WHERE DEPTNO = 30;
SELECT * FROM DEPT_TEMP;
COMMIT;

-- UPDATE�� �� WHERE�� �����Ǿ������� ..? 
-- => ������ ���� ��� �����Ͱ� 40�� �μ��� DNAME, LOC�� �����ϰ� ����
UPDATE DEPT_TEMP
SET (DNAME, LOC) = (SELECT DNAME, LOC FROM DEPT_TEMP WHERE DEPTNO = 40);
SELECT * FROM DEPT_TEMP;
COMMIT;

-- DELETE (������ ����)
-- DELETE FROM ���̺� �� WHERE ���ǽ�

-- DELETE�� �� WHERE�� �����Ǿ������� ...?
-- => ���̺� ��ü ������ ����
DELETE FROM DEPT_TEMP;
SELECT * FROM DEPT_TEMP;
COMMIT;

-- Q1. EMP_TEMP6���� �̸��� O�� �� ��� ����
DELETE FROM EMP_TEMP6
WHERE ENAME LIKE '%O%';
SELECT * FROM EMP_TEMP6;
COMMIT;

-- Q2. EMP_TEMP ���̺��� �޿� ����� 3����� ����� ����
-- �޿� ����� SALGRADE�� �̿�

DELETE FROM EMP_TEMP
WHERE SAL BETWEEN (SELECT LOSAL FROM SALGRADE WHERE GRADE = 3) 
        AND (SELECT HISAL FROM SALGRADE WHERE GRADE = 3);
SELECT * FROM EMP_TEMP;
COMMIT;

-- ���� �̿�
DELETE FROM EMP_TEMP
WHERE SAL IN (SELECT E.SAL FROM EMP_TEMP E JOIN SALGRADE S ON (E.SAL BETWEEN S.LOSAL AND HISAL) 
                        WHERE S.GRADE = 3);
SELECT * FROM EMP_TEMP;
COMMIT;


-- Q3. EMP_TEMP ���̺��� DEPTNO�� 20�� ������� MGR, SAL, COMM�� NULL�� ����
-- (*) DELETE: ������ �����ϴ� �� ��ü ����
-- (*) UPDATE ���̺�� SET �� �̸� = NULL: ������ �����ϴ� ���� �Ϻ� �����͸� NULL�� ����
UPDATE EMP_TEMP
SET MGR = NULL, SAL = NULL, COMM = NULL
WHERE DEPTNO = 20;
SELECT * FROM EMP_TEMP;
COMMIT;

-- Q4. EMP_TEMP2 ���̺��� �ٹ����� 'NEW YORK'�� �μ����� ���ϴ� ��� ���� 
-- �ٹ��� �˻��� DEPT�� �̿�
DELETE FROM EMP_TEMP2
WHERE DEPTNO = (SELECT DEPTNO FROM DEPT WHERE LOC = 'NEW YORK');
SELECT * FROM EMP_TEMP2;
COMMIT;

-- ���� �̿�
DELETE FROM EMP_TEMP2
WHERE DEPTNO IN (SELECT E.DEPTNO FROM EMP_TEMP2 E  JOIN DEPT D ON (E.DEPTNO = D.DEPTNO) 
                            WHERE D.LOC = 'NEW YORK');
SELECT * FROM EMP_TEMP2;
COMMIT;

-- Q5. EMP ���̺��� ������ �����͸� ������ EMP_TEMP7�� ����� 
-- �μ��� SAL�� ���� ���� ����� �����ϰ� ��� ��� ����
CREATE TABLE EMP_TEMP7
AS SELECT * FROM EMP;

DELETE FROM EMP_TEMP7
WHERE (DEPTNO, SAL) NOT IN (SELECT DEPTNO, MAX(SAL) OVER(PARTITION BY DEPTNO) FROM EMP_TEMP7);
SELECT * FROM EMP_TEMP7;
COMMIT;

-- SQL ���� ���� (�Ʒ� �������� 1�� ����� 2�� �μ��� MAX(SAL)�̱� ������ ���� ����)
-- DEPTNO, MAX(SAL)�� ���� ���ؾ� ��!
DELETE FROM EMP_TEMP7
WHERE SAL NOT IN (SELECT MAX(SAL) OVER(PARTITION BY DEPTNO) FROM EMP_TEMP7);
SELECT * FROM EMP_TEMP7;
COMMIT;
-- EX)
-- 1 - A - 10 - 3000
-- 2 - B - 10 - 5000
-- 3 - C - 20 - 3000
-- 4 - D - 30 - 6000

-- 10 - 5000
-- 20 - 3000
-- 30 - 6000

-- ������ ���̺� ���� ����
SELECT * FROM RECYCLEBIN;
PURGE RECYCLEBIN;

