-- EMP ���̺�

-- NAME			NULL		TYPE
-----------------------------------
-- EMPNO		NOT NULL 
-- (��� ��ȣ)

-- ENAME
-- (��� �̸�)

-- JOB
-- (��å)

-- MGR (MANAGER)
-- (�Ŵ����� ��� ��ȣ)

-- HIREDATE
-- (�Ի���)

-- SAL
-- (�޿�)

-- COMM (COMMISSION)
-- (�߰� ����)

-- DEPTNO
-- (�μ� ��ȣ)


-- 1) SELECT���� FROM�� (SELECT ~~~ FROM ~~~~)
-- : �����͸� ��ȸ
-- SELECT [��1 �̸�], [��2 �̸�]... [��N �̸�]
-- FROM [��ȸ�� ���̺� �̸�]; (**)

-- a. EMP ���̺� �� EMPNO�� Ȯ��
-- b. EMP ���̺� �� EMPNO, ENAME, DEPTNO Ȯ��

SELECT * FROM EMP;
SELECT EMPNO FROM EMP;
SELECT EMPNO, ENAME, DEPTNO FROM EMP;

-- 2) SELECT DISTINCT ~~~ FROM ~~~ (�ߺ� ������ ����)
-- : SELECT������ ������ ��ȸ�� �� DISTINCT �ߺ� ������ ����

SELECT DEPTNO FROM EMP;
SELECT DISTINCT DEPTNO FROM EMP;

-- �� ���� ���� ��쿡 (DEPTNO, JOB) �� �� ��ġ�ؾ߸� �ߺ� ����
SELECT DISTINCT DEPTNO, JOB FROM EMP;

-- �ߺ� ���� ���� ���
SELECT DEPTNO FROM EMP;
SELECT ALL DEPTNO FROM EMP;

-- SELECT�� + �����
SELECT * FROM EMP;
SELECT ENAME, SAL, COMM, SAL*12+COMM FROM EMP;

-- ����� ��ſ� ��Ī (alias, as)
SELECT ENAME, SAL, COMM, SAL*12+COMM AS ANNUALSAL FROM EMP;
SELECT ENAME, SAL, COMM, SAL*12+COMM AS "ANNUALSAL" FROM EMP;
-- ex) String sql = 
-- "SELECT ENAME, SAL, COMM, SAL*12+COMM AS "ANNUALSAL" FROM EMP";

-- ��Ī�� ����ϴ� ���� ?
-- A. ������, ������
-- B. ��������
