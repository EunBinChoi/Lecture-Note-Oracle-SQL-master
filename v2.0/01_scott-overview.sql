-- ORACLE SQL�� �� ��¥�� �ּ� (comment)
/* ORACLE SQL�� ���� ��¥�� �ּ� (comment) */

-- * �����ؾ��� �� *
-- SQL ���� (+ ���̺� �̸�, �Ӽ� (��) �̸�)�� ��ҹ��� ���� X 
-- ���̺� ����� �����ʹ� ��ҹ��� ���� O
----------------------------------------------------------------------

-- ���̺� ���� Ȯ�� (SQL PLUS ��ɾ�, desc, conn, grant, show ... )
DESC EMP

-- SCOTT ������ �ִ� ��� ���̺� ��ȸ
SELECT * FROM TAB;

-- SCOTT ������ ���̺� ��ȸ (������ Ȯ�ο�)
SELECT * FROM EMP;
SELECT * FROM DEPT;
SELECT * FROM BONUS;
SELECT * FROM SALGRADE;

-- SELECT ~~~~ FROM ~~~~
-- : �����͸� ��ȸ
-- : SELECT �� �̸� (���� ��� ���� Ȯ�� (*)) FROM ���̺� �̸�

-- EMP ���̺��� ��� �̸��� �� ����� ��� ��ȣ ��ȸ
SELECT ENAME, MGR FROM EMP;

-- Q1. BONUS, SALGRADE�� � �����Ͱ� �ִ��� ��ȸ
SELECT * FROM BONUS; -- ������ ����
SELECT * FROM SALGRADE;

-- Q2. SMITH�� �μ� �̸�, ��ġ�� ����� ��ȸ
SELECT * FROM EMP; -- SMITH, DEPTNO: 20
SELECT * FROM DEPT; -- 20, RESEARCH, DALLAS
-- RESERACH, DALLAS

-- Q3. JONES�� ���� �������� ��ȸ
SELECT * FROM EMP; 
-- JONES, MGR: 7839
-- 7839, KING, PRESIDENT .....

