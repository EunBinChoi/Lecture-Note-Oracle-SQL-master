-- ������ ��ȸ (SELECT)

-- 1) SELECT (ALL) ~~ FROM ~~~
SELECT * FROM EMP;
SELECT * FROM DEPT;

-- A. DEPT ���̺��� DEPTNO, DNAME ��ȸ
SELECT DEPTNO, DNAME FROM DEPT;
-- B. EMP ���̺��� EMPNO, ENAME, DEPTNO ��ȸ
SELECT EMPNO, ENAME, DEPTNO FROM EMP;

-- 2) SELECT DISTINCT ~~ FROM ~~~ (�ߺ� ������ �����ϰ� ��ȸ)
SELECT DISTINCT DEPTNO FROM EMP;

-- DEPT ���̺� �����ϴ� �μ��� ������ �ְ� �� �μ����� �ּ� 1���� ����� �ٹ��ϰ� �ִ��� Ȯ��
-- => �� �μ����� �ּ� 1���� ����� ����.
-- => �ֳ��ϸ� �Ʒ��� �ڵ� (1)�� �����غ��� ����� 
-- (� �μ��� ���� ���ϰ� �� ���̳� ���ϴ� ���� ������) 
-- 10, 20, 30 �μ����� ���ϰ� ����
-- => ������ DEPT ���̺��� Ȯ���� �غ��� (�ڵ� (2)) �ش� ȸ�翡 �����ϴ� �μ��� 10, 20, 30, 40�� ����
-- => ��, 40�� �μ����� ���ϰ� �ִ� ����� ����.. (��� 0��...)
SELECT DISTINCT DEPTNO FROM EMP; -- (1)
SELECT DEPTNO FROM DEPT; -- (2)



-- DISTINCT �ڿ� ���� �� �� �̻� ���� ��� (DEPTNO, JOB)���� �� �� ��ġ�ؾ߸� �ߺ��̶�� �Ǵ�  
SELECT DISTINCT DEPTNO, JOB FROM EMP;

-- �ߺ� ���� ���� ���
SELECT DEPTNO FROM EMP;
SELECT ALL DEPTNO FROM EMP;

-- SELECT�� + ����� (AS ��Ī)
-- ����: SAL*12 + COMM
SELECT ENAME, SAL, COMM, SAL*12+COMM AS ANNUALSAL FROM EMP;
-- COMM�� NULL ���� ���� ��쿡�� ����� (SAL*12+COMM)�� ����� NULL�� ����
-- (**) NULL�� ó�� �ʿ�! (���� ���� ���� �̤�)

-- AS ��Ī
-- �� �̸��� ��Ī�� ������ �� ����

-- ��Ī ����ϴ� ����?
-- A. ���� ���� (���� å�� ������� �������� �ʰ� �ϱ� ����)
-- B. ������


-- 3) SELECT ~~~ FROM ~~~ ORDER BY ~~~
-- : SELECT�� �̿��ؼ� �����͸� ��ȸ�� �� Ư�� �������� �����͸� �����ؼ� ���

-- ���� �ɼ�: ASC (��������, �⺻�� (���� ����)), DESC (��������)

-- EMP ���̺��� ��� ������ SAL �������� �������� (�⺻�� = ASC, ���� ����)
SELECT * FROM EMP ORDER BY SAL;
SELECT * FROM EMP ORDER BY SAL ASC;

-- EMP ���̺��� ��� ������ SAL �������� ��������
SELECT * FROM EMP ORDER BY SAL DESC;

-- ���� ����� ���� ���� ��쿡�� ? ���̿� , �ֱ�!
SELECT * FROM EMP ORDER BY SAL DESC, EMPNO ASC; -- ASC�� ���� ����!

-- ** ORDER BY ���ǻ���!
-- ������ �����ϴ� ���� �ð��� �����ɸ��� ������ 
-- ���� �������� �ʾƵ� �Ǵ� �����Ϳ� ���ؼ��� ���ϴ� �� ����
-- SQL ���� �ӵ��� �������� ���� ���� �ð��� ������

-- Q1. EMP ���̺� ��� ����� ��ȸ�ϴµ� HIREDATE ��������, EMPNO ��������
SELECT * FROM EMP ORDER BY HIREDATE, EMPNO;

-- 4) SELECT ~~~ FROM ~~~ WHERE ~~~
-- : SELECT������ �����͸� ��ȸ�� �� Ư�� ������ �������� ���ϴ� �� ���

SELECT EMPNO, ENAME -- �������� (���ϴ� �� ��ȸ)
FROM EMP 
WHERE DEPTNO = 20; -- ������ (���ϴ� �� ��ȸ)

