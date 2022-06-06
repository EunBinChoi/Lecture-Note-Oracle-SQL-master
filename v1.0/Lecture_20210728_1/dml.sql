-- [������ ���۾� (DML, Data Manipulation Language)]
-- : ���̺� �����͸� �����ϴ� ��� (������ �߰�, ����, ����)

-- 1) ������ �߰� (INSERT��)
SELECT * FROM TAB;

-- ���̺��� ������ ����
DROP TABLE DEPT_TEMP;
DROP TABLE DEPT_TEMP2;

-- ���̺� ����
CREATE TABLE DEPT_TEMP
AS SELECT * FROM DEPT;

SELECT * FROM DEPT_TEMP;

/* ����)
 * INSERT INTO ���̺� �� [(��1, ��2 ...)]
 * VALUES (��1�� �� ������, ��2�� �� ������ ...)
 * */

-- �μ���ȣ 50, �μ��̸� GOTT, ��ġ SEOUL
INSERT INTO DEPT_TEMP (DEPTNO, DNAME, LOC)
VALUES (50, 'GOTT', 'SEOUL');

SELECT * FROM DEPT_TEMP;

-- INSERT ����
-- A. �� ���� != ������ ����
INSERT INTO DEPT_TEMP (DEPTNO, DNAME, LOC)
VALUES (60, 'GOTT2');

-- �̰� ����!
INSERT INTO DEPT_TEMP (DEPTNO, DNAME)
VALUES (60, 'GOTT2');

SELECT * FROM DEPT_TEMP;

-- B. �ڷ��� ���� ���� ���
INSERT INTO DEPT_TEMP (DEPTNO, DNAME)
VALUES ('GOOD', 'GOTT2'); -- �Ͻ��� �� ��ȯ �Ұ���

-- �̰� ����!
INSERT INTO DEPT_TEMP (DEPTNO, DNAME)
VALUES ('60', 'GOTT2'); -- �Ͻ��� �� ��ȯ ����

-- ECLIPSE���� ���� X
-- DESC DEPT_TEMP; -- SQLPLUS �� X

-- C. ���� ���� ������ �ڸ������� ū ���� �ִ� ���
INSERT INTO DEPT_TEMP (DEPTNO, DNAME)
VALUES ('100', 'GOTT2'); -- DEPTNO (NUMBER(2))

-- TOAD FOR ORACLE (SQL + SQLPLUS)
-- DESC DEPT_TEMP; -- SQLPLUS �� O

-- EX)
-- 1)
INSERT INTO DEPT_TEMP (DEPTNO, DNAME, LOC)
VALUES (100, 'DB', 'BUSAN', 'HI');
-- A. �� ���� != ������ ����
-- B. DEPTNO => NUMBER(2): 3�ڸ� ���� �� �� ����

-- 2)
INSERT INTO DEPT_TEMP (DEPTNO, DNAME, LOC)
VALUES ('HI', 'DB', 'BUSAN');
-- A. DEPTNO = 'HI' (X)

-- 3)
INSERT INTO DEPT_TEMP (DEPTNO, DNAME)
VALUES (800, 'DB');
-- A. DEPTNO => NUMBER(2): 3�ڸ� ���� �� �� ����


-- �����Ͱ� Ȯ������ �ʾ��� ���
-- 1)
INSERT INTO DEPT_TEMP (DEPTNO, DNAME, LOC)
VALUES (70, 'WEB DEVELOP', NULL); 
-- ����� ǥ�� (������)

-- 2)
INSERT INTO DEPT_TEMP (DEPTNO, DNAME, LOC)
VALUES (70, 'WEB DEVELOP', '');

INSERT INTO DEPT_TEMP (DEPTNO, DNAME, LOC)
VALUES ('', 'WEB DEVELOP', 'SEOUL');
-- ������, ������, ����Ʈ�� '' => NULL ��ü ����

-- 3)
INSERT INTO DEPT_TEMP (DEPTNO, DNAME)
VALUES (70, 'WEB DEVELOP');
-- �Ͻ��� ǥ��

-- ���̺� ���� (EMP_TEMP)
-- ���̺��� ������ ��� ���� ����
-- ������ ���� X

CREATE TABLE EMP_TEMP
AS SELECT * FROM EMP WHERE 1 <> 1;
-- ������ false�� �Ǳ� ������ �� �������� �Ͼ�� ����
-- �� �̸��� ������ �� �� ����

SELECT * FROM EMP_TEMP;

-- �����Ϳ� DATE�� �ǽ�
-- ��/��/��, ��-��-��
INSERT INTO EMP_TEMP (EMPNO, ENAME, JOB, HIREDATE)
VALUES (5555, '������', 'PRESIDENT', '2021/12/10');

SELECT * FROM EMP_TEMP;

INSERT INTO EMP_TEMP (EMPNO, ENAME, JOB, HIREDATE)
VALUES (6666, 'ȫ�浿', 'DEVELOPER', '2021-12-10');

-- 1
INSERT INTO EMP_TEMP (EMPNO, ENAME, JOB, HIREDATE)
VALUES (7777, 'ȫ���', 'DEVELOPER', '10/12/2021');

-- 2
INSERT INTO EMP_TEMP (EMPNO, ENAME, JOB, HIREDATE)
VALUES (7777, 'ȫ���', 'DEVELOPER', '10-12-2021');

/* 1�� 2�� �����ұ�� ?
 * ����Ŭ ��ġ ����, �⺻ ��� (��¥ ǥ�� ��� => �ѱ��ĸ� ����)
 * 
 */

INSERT INTO EMP_TEMP (EMPNO, ENAME, JOB, HIREDATE)
VALUES (7777, 'ȫ���', 'DEVELOPER', 
		TO_DATE('10-12-2021', 'DD-MM-YYYY'));
		-- ���� �����ϸ� �̱��� ��¥ ����!
		
SELECT * FROM EMP_TEMP;

INSERT INTO EMP_TEMP (EMPNO, ENAME, JOB, HIREDATE)
VALUES (8888, 'ȫ�湬', 'SALESMAN', SYSDATE);
-- SYSDATE: ���� �ý��� �ð����� ��¥ �Է�
-- �����Ͱ� ���� ������ Ȯ���ϱ� ����

-- ������ �ϰ������� �߰� (��������)
-- VALUES �κ��� ���������� ���
-- �� ����, �ڷ��� ��ġ

-- ��� �޿� ����� 2����� ��� ���� ���̺� �߰�
-- EMP_TEST: EMP ����
-- EMP + SALGRADE ����
INSERT INTO EMP_TEMP (EMPNO, ENAME, JOB, HIREDATE, SAL)
SELECT E.EMPNO, E.ENAME, E.JOB, 
		E.HIREDATE, E.SAL
FROM EMP E, SALGRADE S
WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL
AND S.GRADE = 2;
-- ��������

SELECT * FROM EMP_TEMP;
SELECT * FROM EMP;

-- Q1. 'SMITH'���� SAL�� ���� �ް� �ִ� ����� �߰�
SELECT * FROM TAB;

DROP TABLE EMP_TEMP_Q1;

CREATE TABLE EMP_TEMP_Q1
AS SELECT *
FROM EMP
WHERE 1 <> 1;

INSERT INTO EMP_TEMP_Q1
SELECT *
FROM EMP
WHERE SAL > (SELECT SAL 
			FROM EMP 
			WHERE ENAME = 'SMITH');

SELECT * FROM EMP_TEMP_Q1;

-- Q2. 30�� �μ� ��� �޿����� ���� �ް� �ִ� ����� �߰�
DROP TABLE EMP_TEMP_Q2;

CREATE TABLE EMP_TEMP_Q2
AS SELECT *
FROM EMP
WHERE 1 <> 1;

INSERT INTO EMP_TEMP_Q2
SELECT *
FROM EMP
WHERE SAL < (SELECT AVG(SAL) 
			FROM EMP 
			WHERE DEPTNO = 30);

SELECT * FROM EMP_TEMP_Q2;

-- Q2-1. 30�� �μ� ����� �߿� 30�� �μ� ��� �޿����� 
-- ���� �ް� �ִ� ����� �߰�
DROP TABLE EMP_TEMP_Q2_1;

CREATE TABLE EMP_TEMP_Q2_1
AS SELECT *
FROM EMP
WHERE 1 <> 1;

INSERT INTO EMP_TEMP_Q2_1
WITH
E30 AS (SELECT * FROM EMP WHERE DEPTNO = 30)
SELECT *
FROM E30
WHERE E30.SAL < (SELECT AVG(SAL) 
			FROM EMP 
			WHERE DEPTNO = 30);

SELECT * FROM EMP_TEMP_Q2_1;

-- Q3. 'KING'���� �Ի����� ���� ����� �߰�

DROP TABLE EMP_TEMP_Q3;

CREATE TABLE EMP_TEMP_Q3
AS SELECT *
FROM EMP
WHERE 1 <> 1;

INSERT INTO EMP_TEMP_Q3
SELECT *
FROM EMP
WHERE HIREDATE < (SELECT HIREDATE
			FROM EMP
			WHERE ENAME = 'KING');

SELECT * FROM EMP_TEMP_Q3;


-- Q4. �Ŵ��� �̸��� 'BLAKE'�� ����� �߰�

DROP TABLE EMP_TEMP_Q4;

CREATE TABLE EMP_TEMP_Q4
AS SELECT *
FROM EMP
WHERE 1 <> 1;

INSERT INTO EMP_TEMP_Q4
SELECT E.EMPNO, E.ENAME, E.JOB, E.MGR, 
	E.HIREDATE, E.SAL, E.COMM, E.DEPTNO
FROM EMP E, EMP E2
WHERE E.MGR = E2.EMPNO
AND E2.ENAME = 'BLAKE';

INSERT INTO EMP_TEMP_Q4
SELECT *
FROM EMP 
WHERE MGR = (SELECT EMPNO 
			FROM EMP 
			WHERE ENAME = 'BLAKE');

SELECT * FROM EMP_TEMP_Q4;

-- Q5. �޿� ����� 1����� ����� �߰�
DROP TABLE EMP_TEMP_Q5;

CREATE TABLE EMP_TEMP_Q5
AS SELECT *
FROM EMP
WHERE 1 <> 1;

-- ���� ���̺��� ������ ������ �ͼ� ���̺� �߰�
INSERT INTO EMP_TEMP_Q5
SELECT E.EMPNO, E.ENAME, E.JOB, E.MGR, 
	E.HIREDATE, E.SAL, E.COMM, E.DEPTNO
FROM EMP E, SALGRADE S
WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL
AND S.GRADE = 1

-- �������� ���� ���̺��� (���������̿�) 
-- ������ ������ �ͼ� ���̺� �߰�
INSERT INTO EMP_TEMP_Q5
SELECT *
FROM EMP
WHERE SAL BETWEEN (SELECT LOSAL FROM SALGRADE WHERE GRADE = 1) 
AND (SELECT HISAL FROM SALGRADE WHERE GRADE = 1);

INSERT INTO EMP_TEMP_Q5
SELECT *
FROM EMP
WHERE SAL IN (SELECT SAL
			FROM EMP, SALGRADE
			WHERE SAL BETWEEN LOSAL AND HISAL
			AND GRADE = 1);


SELECT * FROM EMP_TEMP_Q5;

-- [������ ����]
-- DB ���̺� ����� ������ ���� UPDATE

/* ����)
 * UPDATE [���̺��]
 * SET [������ ��1] = [������], [������ ��2] = [������], ...
 * [WHERE ������ ���� ��� ������ (�ɼ�)]
 * 
 * WHERE�� ����
 * : ������ ���� ��� ������ ����
 * 
 * */

SELECT * FROM TAB;
CREATE TABLE DEPT_TEMP2
AS SELECT * FROM DEPT;

SELECT * FROM DEPT_TEMP2;

UPDATE DEPT_TEMP2
SET LOC = 'SEOUL';
-- WHERE���� ����

UPDATE DEPT_TEMP2
SET LOC = 'CHICAGO', DNAME = 'FACTORY'
WHERE DEPTNO = 40;


-- Q1. EMP_TEMP ���̺��� ��� �� 
-- �޿��� 2500 ������ �����
-- �߰������� 50���� ����

SELECT * FROM EMP_TEMP;

DROP TABLE EMP_TEMP;

CREATE TABLE EMP_TEMP
AS SELECT * FROM EMP;

UPDATE EMP_TEMP
SET COMM = 50
WHERE SAL <= 2500;


-- ������ ���� (�������� �̿�)
SELECT * FROM DEPT;
SELECT * FROM DEPT_TEMP2;

UPDATE DEPT_TEMP2
SET (DNAME, LOC) = (SELECT DNAME, LOC -- ������ Ÿ��, ����!
					FROM DEPT
					WHERE DEPTNO = 40)
WHERE DEPTNO = 40;

UPDATE DEPT_TEMP2
SET (DNAME) = (SELECT DNAME -- ������ Ÿ��, ����!
				FROM DEPT
				WHERE DEPTNO = 40),
	(LOC) = (SELECT LOC -- ������ Ÿ��, ����!
				FROM DEPT
				WHERE DEPTNO = 40)				
					
WHERE DEPTNO = 40;


-- [������ ����]
/* ����)
 * 
 * DELETE [FROM] [���̺� ��]
 * [WHERE ������ ��� ������ ���ǽ� (�ɼ�)]
 * 
 * - WHERE���� �Ⱦ��� ���̺� ��ü ������ ����
 * - Ư�� �� �����ϰ� ������ WHERE�� �߰�!
 * */

SELECT * FROM EMP_TEMP2;

DROP TABLE EMP_TEMP2;

CREATE TABLE EMP_TEMP2
	AS SELECT * FROM EMP;

-- Q1. �̸��� M�� �� ��� ����
DELETE FROM EMP_TEMP2
WHERE ENAME LIKE '%M%';


-- Q2. �޿� ��� 3��� (SALGRADE, EMP_TEMP2)�� 
-- ��� �߿� 30�� �μ� ��� ����
DELETE FROM EMP_TEMP2
WHERE EMPNO IN (SELECT E.EMPNO
				FROM EMP_TEMP2 E JOIN SALGRADE S
				ON (E.SAL BETWEEN S.LOSAL AND S.HISAL)
				WHERE S.GRADE = 3
				AND E.DEPTNO = 30);
SELECT *
FROM EMP_TEMP2 E JOIN SALGRADE S
ON (E.SAL BETWEEN S.LOSAL AND S.HISAL);

-- Q3. �߰� ������ NULL�� ��� ����
DELETE FROM EMP_TEMP2
WHERE COMM IS NULL;

-- Q4. �μ� �ٹ����� 'NEW YORK'�� �μ����� ���ϴ� ��� ����
-- (DEPT, EMP_TEMP2)
DELETE FROM EMP_TEMP2
WHERE DEPTNO IN (SELECT D.DEPTNO
			FROM EMP_TEMP2 E JOIN DEPT D
			ON (E.DEPTNO = D.DEPTNO)
			WHERE D.LOC = 'NEW YORK');

SELECT *
FROM EMP_TEMP2 E JOIN DEPT D
ON (E.DEPTNO = D.DEPTNO) AND (D.LOC = 'NEW YORK');
-- 'NEW YORK' -> �μ� ��ȣ: 10
-- 'NEW YORK' -> �μ� ��ȣ: 20
-- 'NEW YORK' -> �μ� ��ȣ: 30

-- Q5. �μ��� ���� ������ ���� ����� �����ϰ� ��� ����
-- GROUP BY, MAX()
DELETE FROM EMP_TEMP2
WHERE SAL NOT IN (SELECT MAX(SAL)
				FROM EMP_TEMP2 E
				GROUP BY E.DEPTNO);
-- SAL != 10�� �μ� �ִ� ���� AND
-- SAL != 20�� �μ� �ִ� ���� AND
-- SAL != 30�� �μ� �ִ� ����




SELECT * FROM DEPT;
SELECT * FROM EMP;
	
	