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
