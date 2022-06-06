-- 1) WHERE��
-- : SELECT������ �����͸� ��ȸ�� �� Ư�� ������ �������� ���ϴ� �� ���

-- ����
-- SELECT [��1 �̸�], [��2 �̸�]... [��N �̸�]
-- FROM [��ȸ�� ���̺� �̸�] 
-- WHERE [��ȸ�� �� �����ϱ� ���� ���ǽ�];

SELECT * FROM EMP;

-- : EMP ���̺��� �μ� ��ȣ (DEPTNO) 30�� �� ��ȸ
SELECT * FROM EMP WHERE DEPTNO = 30;

-- : EMP ���̺��� �μ� ��ȣ (DEPTNO) 30�� �ƴ� �� ��ȸ
SELECT * FROM EMP WHERE DEPTNO != 30; -- ISO ǥ�� X
SELECT * FROM EMP WHERE DEPTNO <> 30; -- ISO ǥ�� O
-- �μ� ��ȣ�� 30 �ʰ��ų� �̸� (30�� �ƴ� �� ��ȸ)

-- 2) AND, OR ������
-- : WHERE���� ���ǽ� �߰�
SELECT * FROM EMP WHERE DEPTNO = 30 AND JOB = 'salesman'; -- �˻� X
select * from emp where deptno = 30 and job = 'SALESMAN'; -- �˻� ����
-- <����!>
-- SQL ������ ��ҹ��� ���� X
-- ���̺� ���� ����(��) �����ʹ� ��ҹ��� ����

SELECT * FROM EMP;
-- �ǽ�)
-- EMP ���̺���
-- ��� ��ȣ�� 7499�̰� (AND) �μ� ��ȣ�� 30�� 
-- ��� ��ȣ, ��� �̸�, �μ� ��ȣ�� �������� ���

SELECT EMPNO, ENAME, DEPTNO 
FROM EMP 
WHERE EMPNO = 7499
AND DEPTNO = 30;

-- EMP ���̺���
-- �μ� ��ȣ�� 20�̰ų� (OR) ������ SALESMAN��
-- ��� ��ȣ, ��� �̸�, �μ� ��ȣ, ������ �������� ���

SELECT EMPNO, ENAME, DEPTNO, JOB 
FROM EMP 
WHERE DEPTNO = 20
OR JOB = 'SALESMAN';


-- 3) ������ ����
-- a. �� ������: AND, OR
-- b. ��� ������: +, -, *, /

SELECT * FROM EMP;

SELECT EMPNO, ENAME, SAL, COMM, SAL * 12 + COMM AS ANNSAL 
FROM EMP;
-- NULL?
-- �����Ͱ� ���� �ǹ� (���� ����)
-- ���� Ȯ������ ���� ��

-- NULL == 0 ??
-- NULL: ������ ��ü�� ����
-- 0: �����ʹ� �ִµ� �� ���� 0 �ǹ�

-- NULL + 1 = NULL
-- ���Ѵ� + 1 = ���Ѵ�
-- NULL > 100 = NULL
-- NULL > NULL = NULL
-- ���Ѵ� > 1000 = ���Ѵ�

-- * NULL�̳� ���Ѵ�� � ���/�� ������ ������ ���� NULL, ���Ѵ� ����


SELECT * 
FROM EMP 
WHERE SAL * 12 = 36000;

-- c. �� ������
-- >, <, >=, <=

SELECT *
FROM EMP
WHERE SAL > 3000;

-- �ǽ�)
-- �޿��� 2500 �޷� �̻��̰� ������ ANALYST�� 
-- ��� ��ȣ, ��� �̸�, �޿�, ���� ���

SELECT EMPNO, ENAME, SAL, JOB
FROM EMP
WHERE SAL >= 2500
AND JOB = 'ANALYST'; 

SELECT *
FROM EMP
WHERE ENAME >= 'F';
-- ���� ������ ���ڿ��� �������� ��
-- ����� �̸��� ù ���ڰ� F�̰ų� F���� ������ �͸� �˻�

-- c. �� ���� ������ (NOT)
-- : ������ ��� T -> F
-- :          F -> T
-- : ��ü ���ǹ� ������Ű�� ������
-- : ������ ���ǹ��� �ٲٴ� �ͺ��� �ۼ� �ð��� �پ��

SELECT *
FROM EMP
WHERE SAL != 3000;

SELECT *
FROM EMP
WHERE NOT SAL = 3000;

SELECT *
FROM EMP
WHERE SAL = 3000
AND JOB = 'SALESMAN';

SELECT * FROM EMP;

SELECT *
FROM EMP
WHERE SAL != 3000
OR JOB != 'SALESMAN';

SELECT *
FROM EMP
WHERE NOT (SAL = 3000
AND JOB = 'SALESMAN');

-- d. IN ������
-- : Ư�� ���� �ش��ϴ� ������ ���� �� ������ �� ����

-- ���ǽ��� �þ���� ���ǽ��� ���� ��� (JOB = )
SELECT *
FROM EMP
WHERE JOB = 'MANAGER'
OR JOB = 'SALESMAN'
OR JOB = 'CLERK';

SELECT *
FROM EMP
WHERE JOB IN ('MANAGER', 'SALESMAN', 'CLERK');


-- ����
-- SELECT [��1 �̸�], ... [��N �̸�]
-- FROM [���̺� ��]
-- WHERE �� �̸� IN (������ 1, ������ 2, ... ������ N);

SELECT *
FROM EMP
WHERE JOB NOT IN ('MANAGER', 'SALESMAN', 'CLERK');

-- �� ������
SELECT *
FROM EMP
WHERE JOB <> 'MANAGER' -- ISO ǥ��
AND JOB != 'SALESMAN'
AND JOB ^= 'CLERK';

-- �ǽ�)
-- IN ������ �̿��ؼ� �μ� ��ȣ�� 20�̰ų� 30�� ��� ������ �������� �ڵ� �ۼ�
SELECT *
FROM EMP
WHERE DEPTNO IN (20, 30);

SELECT *
FROM EMP
WHERE DEPTNO NOT IN (20, 30);


-- e. BETWEEN A AND B ������
-- : Ư�� ���� ������ ������ ��ȸ

-- EX) �޿��� 2000 ~ 3000�� ��� ��ȸ
SELECT *
FROM EMP
WHERE SAL >= 2000
AND SAL <= 3000;


SELECT *
FROM EMP
WHERE SAL BETWEEN 2000 AND 3000; -- 2000, 3000 ����
-- BETWEEN A AND B: A <= SAL <= B

-- �ǽ�)
-- 1)
-- ��� ���� ���̺��� JOB�� 'MANAGER'�ų� (IN)
-- SAL�� 2000 <=  <= 3000 ��� ���� ��ȸ (BETWEEN AND)

-- 2)
-- NOT BETWEEN A AND B �����ڸ� ���� �ʰ�
-- ��� ���� ���̺��� �޿� (SAL) �� ����
-- 2000 �̻� 3000 ���� ���� �̿� �� ������ ���

-- 3) ���� ���� ã��

-- 4) � ���� ã��


-- g. LIKE �����ڿ� ���ϵ� ī��
-- : �Ϻ� ���ڿ� (���ڳ� ����)�� ���Ե� ������ ��ȸ
-- : ������ ��ȸ�� ���ϵ� ī�� (Wild Card) 
-- >> Ư�� ����(��) ��ü�ϰų� 
-- ���ڿ��� ������ ������ ǥ���ϴ� Ư������
-- >> �ڹٿ��� ���ϵ� ī��� '?'
-- �������� �� �������� ���� (������ �� ��ü)
-- 1) _: � ���̵� ������� �� ���� ���� ������
-- 2) %: ���̿� ������� ��� ���� ������

-- ��� �̸� �߿��� ù ���ڰ� s�� �����ϴ� ��� ���� ���
-- s_: sa, sb, sc, ss, .....
-- s%: s, sa, sabc, ssss, sebfd

SELECT *
FROM EMP
WHERE ENAME LIKE 'S%';

-- ��� �߿��� �ش� ����� �Ŵ��� ��ȣ�� 
-- 79�� ���۵Ǵ� ��� ���� ���
SELECT *
FROM EMP;
WHERE MGR LIKE '79%';

SELECT *
FROM EMP;
WHERE MGR LIKE '79__';

-- ��� �̸� �߿��� �� ��° ���ڰ� L�� ��� ������ ��ȸ
SELECT *
FROM EMP
WHERE ENAME LIKE '_l%'; -- ?

select *
from emp
where Ename like '_L%';

-- 1) ��� �̸��� 'E'��� ����(��)�� �����ϴ� �̸� �˻�
SELECT *
FROM EMP
WHERE ENAME LIKE '%E%';


-- 2) �Ի��� 2���� ��� ���� �˻� // ?

-- to_date(): ����(2)/��(2)/��(2)
SELECT *
FROM EMP
WHERE HIREDATE LIKE '%/02/%';

-- Date �ڷ������� �����ϰ� �ִ� �Լ�
SELECT *
FROM EMP
WHERE TO_CHAR(HIREDATE, 'MM') = 2;
-- DATE -> STRING/INT

SELECT *
FROM EMP
WHERE TO_CHAR(HIREDATE) LIKE '%02%';





-- 3) ��� ��å�� �ڿ��� �ι�° ���ڰ� E�� ��� ���� �˻�
SELECT *
FROM EMP
WHERE JOB LIKE '%E_';

-- 4) �Ի��� 1981���� �ƴ� ��� ���� �˻� // ?
SELECT *
FROM EMP
WHERE HIREDATE NOT LIKE '81/%';

SELECT *
FROM EMP
WHERE NOT TO_CHAR(HIREDATE, 'YYYY') = 1981;


SELECT *
FROM EMP
WHERE NOT TO_CHAR(HIREDATE, 'YY') = 81;

-- * ���࿡ ���ϵ� ī�� ���ڰ� ������ �Ϻ��� ���:
-- ������ ��ü�� _, % ����
-- "A_A", "30%" >> ���ϵ� ī�� (wild card?)
-- >> "gil\_dong" (\: escape ����)
-- >> "30\%" (\: escape ����)


-- g. IS NULL ������

SELECT *
FROM EMP
WHERE COMM = NULL; -- �Ұ���

-- COMM = NULL ?
-- NULL + ������ (��/���) => NULL

-- Ư�� �� �����Ͱ� NULL �����ϱ� ���ؼ� IS NULL ������ �̿�
SELECT ENAME, SAL*12+COMM AS ANNSAL
FROM EMP;

SELECT *
FROM EMP
WHERE COMM IS NULL;

SELECT *
FROM EMP
WHERE COMM IS NOT NULL;

SELECT ENAME, SAL*12+COMM AS ANNSAL
FROM EMP
WHERE SAL*12+COMM IS NOT NULL;

-- ���ǽĿ� NULL�� ���� �ʵ��� ����!
SELECT *
FROM EMP
WHERE SAL > NULL
AND COMM IS NULL;

SELECT *
FROM EMP
WHERE SAL > NULL
OR COMM IS NULL;

-- i. ���� ������
-- : SELECT���� ���� ��ȸ�� ����� �������� ǥ�� ������

-- [UNION]
-- ������
-- ������ ����� ���������� ������
-- ����Ϸ��� �ϴ� �� ����, �� ���� �ڷ����� ���ƾ� ��

-- 1) ������ �ڷ����� ��� ������ �����Ͱ� �ٸ�
-- 2) ���� ù��° SELECT�� ����
-- 3) ���� X
SELECT EMPNO, ENAME, SAL, DEPTNO
FROM EMP
WHERE DEPTNO = 10
UNION
SELECT SAL, ENAME, EMPNO, DEPTNO
FROM EMP
WHERE DEPTNO = 20;

-- 1) ���� �ٸ� ==> ���� �߻�!
SELECT EMPNO, ENAME, SAL, DEPTNO
FROM EMP
WHERE DEPTNO = 10
UNION
SELECT SAL, ENAME, EMPNO
FROM EMP
WHERE DEPTNO = 20;

-- 1) �� ������ ����
-- 2) ������ �ڷ��� ������ �ٸ� ==> ���� �߻�!
SELECT EMPNO, ENAME, SAL, DEPTNO
FROM EMP
WHERE DEPTNO = 10
UNION
SELECT ENAME, SAL, EMPNO, DEPTNO
FROM EMP
WHERE DEPTNO = 20;

-- class Employee
-- public Employee(int id, int sal) {...}
-- public Employee(int sal, int id) {...}

SELECT EMPNO, ENAME, SAL, DEPTNO
FROM EMP
WHERE DEPTNO = 10
UNION
SELECT EMPNO, ENAME, SAL, DEPTNO
FROM EMP
WHERE DEPTNO = 10;
-- �ߺ� ���� O

SELECT EMPNO, ENAME, SAL, DEPTNO
FROM EMP
WHERE DEPTNO = 10
UNION ALL
SELECT EMPNO, ENAME, SAL, DEPTNO
FROM EMP
WHERE DEPTNO = 10;
-- �ߺ� ���� X


-- [INTERSECT]
-- ������
-- �� SELECT ������ ��� ���� ���� �����͸� ���

SELECT * FROM EMP;

-- SELECT ù��°: ��� ���� �߿��� �̸��� A�� ���� ��� ���
-- SELECT �ι�°: ��� ���� �߿��� DEPTNO 30�� ��� ���

SELECT EMPNO, ENAME, DEPTNO
FROM EMP
WHERE ENAME LIKE '%A%'
INTERSECT
SELECT EMPNO, ENAME, DEPTNO
FROM EMP
WHERE DEPTNO = 30;


-- [MINUS]
-- A
-- MINUS
-- B

-- A - B
-- ������
-- A�� ��� �� B�� �������� ���� �����͸� ���


-- WHY????
-- 1) �ٸ� ���̺��� ��� ���� 

SELECT EMPNO, ENAME, JOB, DEPTNO
FROM EMP
WHERE JOB = 'SALESMAN'
MINUS
SELECT EMPNO, ENAME, JOB, DEPTNO
FROM EMP
WHERE ENAME LIKE '%T%';

-- i. ������ �켱����
-- WHERE�� ���ǽĿ� ���� ������ ��� �ϴ� ���
-- () �켱���� ���� ����!



