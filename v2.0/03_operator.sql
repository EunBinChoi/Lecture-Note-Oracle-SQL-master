-- ������ (OPERATOR)

-- 1) = (����)
SELECT ENAME FROM EMP WHERE DEPTNO = 30;

-- 2 ) !=, ^=, <> (�ٸ���)
-- !=, ^= - ISO ǥ�� X
-- <>      - ISO ǥ�� O
SELECT ENAME, DEPTNO FROM EMP WHERE DEPTNO <> 30;
-- DEPTNO <> 30: 30 �ʰ��̰ų� 30 �̸� (30�� �ƴ� �� ��ȸ)

-- 3) AND, OR
SELECT * FROM EMP WHERE DEPTNO = 30 AND JOB = 'SALESMAN';
-- (**) SQL���� ���ڿ��� �񱳴� =�� ���

SELECT * FROM EMP WHERE DEPTNO = 30 AND JOB = 'salesman'; 
-- ��ȸ ����� �ƹ��͵� �ȳ��� (EMP ���̺��� �����ʹ� �빮�ڷ� ���� �Ǿ�����)

-- SQL ���� ��ɾ�, ���̺� �̸�, �� �̸�: ��ҹ��� ���� X
-- ���̺��� ������: ��ҹ��� ���� O

-- Q1. EMP ���̺��� ��� ��ȣ�� 7499�̰� �μ� ��ȣ�� 30�� 
-- ����� ��� ��ȣ, ��� �̸�, �μ� ��ȣ�� �������� ���
SELECT EMPNO, ENAME, DEPTNO FROM EMP WHERE EMPNO = 7499 AND DEPTNO = 30;

-- Q2. EMP ���̺��� ��� ��ȣ 7698�̰� ������ SALESMAN��
-- ����� ��� �̸��� �������� ���
SELECT ENAME FROM EMP WHERE MGR = 7698 AND JOB = 'SALESMAN';

-- Q3. EMP ���̺��� �μ� ��ȣ 20�̰ų� ������ SALESMAN�� ��� �̸��� �������� ���
SELECT ENAME, DEPTNO, JOB FROM EMP WHERE DEPTNO = 20 OR JOB = 'SALESMAN';

-- Q4. EMP ���̺��� ��� �޿� 2500 �޷� �̻��̰� ������ ANALYST�� 
-- ��� �̸�, �޿�, ���� ���
SELECT ENAME, SAL, JOB FROM EMP WHERE SAL >= 2500 AND JOB = 'ANALYST';

-- Q5. EMP ���̺��� ��� �޿� 2500 �޷� �̻��̰� ������ ANALYST�� 
-- ����� ������ ������ ������� ��� �̸�, �޿�, ���� ��� (NOT �̿�)
SELECT ENAME, SAL, JOB FROM EMP WHERE NOT (SAL >= 2500 AND JOB = 'ANALYST');
-- SAL < 2500 OR NOT JOB = 'ANALYST'

-- �Ʒ��� �� ���� ����
-- NOT JOB = 'ANALYST'
-- JOB <> 'ANALYST'

-- (��� �̸��� �빮�ڷ� �Ǿ��ִٰ� �������� ��)
-- Q6. EMP ���̺��� ��� �̸��� 'J'�� �����ϴ� ��� �̸� ��� (>=, < �̿�)
SELECT ENAME FROM EMP WHERE ENAME >= 'J' AND ENAME < 'K';

-- ��� ������: +, -, *, /
-- �� ������: AND, OR, NOT
-- �� ������: >, <, >=, <=, =, <> (!=, ^=)

-- 4) IN ������
-- : Ư�� ���� �ش��ϴ� ������ ���� �� ������ �� ����
-- �Ʒ��� �ڵ忡�� �ߺ��� 'JOB =' �ٿ��� �� ���� 
-- (**) = �����ڸ� ����� ����
SELECT * FROM EMP WHERE JOB = 'MANAGER' OR JOB = 'SALESMAN' OR JOB = 'CLERK';
SELECT * FROM EMP WHERE JOB IN ('MANAGER', 'SALESMAN', 'CLERK');

-- NOT�� ��ġ
SELECT * FROM EMP WHERE JOB NOT IN ('MANAGER', 'SALESMAN', 'CLERK');
-- JOB != 'MANAGER' AND JOB != 'SALESMAN' AND JOB != 'CLERK'
SELECT * FROM EMP WHERE NOT JOB IN ('MANAGER', 'SALESMAN', 'CLERK');

select * from emp; 
select count(*) from emp where empno not in ( select mgr from emp ); 
select count(*) from emp T1 where not exists ( select null from emp T2 where t2.mgr = t1.empno );

select null from emp T1, emp T2 where t1.mgr = t2.empno;


-- 5) BETWEEN ������ 
-- : Ư�� ���� ������ ������ ��ȸ

SELECT * FROM EMP WHERE SAL >= 2000 AND SAL <= 3000;
SELECT * FROM EMP WHERE SAL BETWEEN 2000 AND 3000; -- 2000, 3000 ����

-- NOT�� ��ġ
SELECT * FROM EMP WHERE SAL NOT BETWEEN 2000 AND 3000;
SELECT * FROM EMP WHERE NOT SAL BETWEEN 2000 AND 3000;

-- Q1. EMP ���̺��� JOB�� 'MANAGER'�ų� SAL�� 2000 <=  <= 3000 ��� ���� ��ȸ
SELECT * FROM EMP WHERE JOB IN ('MANAGER') OR SAL BETWEEN 2000 AND 3000;

-- Q2 . Q1 ���� ����� ����
SELECT * FROM EMP WHERE NOT (JOB IN ('MANAGER') OR SAL BETWEEN 2000 AND 3000);
SELECT * FROM EMP WHERE JOB NOT IN ('MANAGER') AND SAL NOT BETWEEN 2000 AND 3000;


-- 6) LIKE ������ (+ ���ϵ� ī��, WILD CARD)
-- : �Ϻ� ���ڿ� (���ڳ� ����)�� ���Ե� ������ ��ȸ
-- : ������ ��ȸ�� ���ϵ� ī�带 ��� (Ư�� ����(��)�� ��ü�ϴ� Ư������)

-- ���ϵ� ī��
-- A. _: � ���̵� ������� �� ���� ����
-- B. %: � ���̵� ������� ���̵� ����� ���� ���� (0���� ����)

-- EX) ��� �̸� �˻�
-- s_: sa, sb, sc .... sz 
-- s%: s, sa, saa, saaaaaa, sabababababzzzzzzzzz

-- (*) ���࿡ ���ϵ� ī�忡�� ���Ǵ� Ư����ȣ (%, _)�� �������� �Ϻζ��?
-- EX) 30\%, 50\%, gil\_dong (\: escape ����)
SELECT * FROM EMP WHERE SAL LIKE '28\%'; -- SAL�� 28% �� ����� ã����!
SELECT * FROM EMP WHERE SAL LIKE '28%'; -- SAL�� 28�� �����ϴ� ����� ã����!


DROP TABLE ESCAPETEST;
CREATE TABLE ESCAPETEST
      ( NO VARCHAR(10),
	ITEMNAME VARCHAR(100),
	PRICE NUMBER,
    SALES VARCHAR(10));
INSERT INTO ESCAPETEST VALUES (1, 'COSMETIC', 30000, '30%');
INSERT INTO ESCAPETEST VALUES (2, 'T_SHIRT', 50000, '20%');
COMMIT;

SELECT * FROM ESCAPETEST;
SELECT * FROM ESCAPETEST WHERE SALES = '20%';

SELECT * FROM ESCAPETEST WHERE ITEMNAME LIKE '%\_%' ESCAPE '\';
SELECT * FROM ESCAPETEST WHERE SALES LIKE '%2\%%' ESCAPE '\';

-- EX) EMP ���̺��� ��� �̸��� 'J'�� �����ϴ� ��� �̸� ��� (>=, < �̿�)
SELECT * FROM EMP WHERE ENAME LIKE 'J%'; -- ���� ���� X
SELECT * FROM EMP WHERE ENAME LIKE 'J_'; -- ���� ���� O (������ ���ڸ� ����)
SELECT * FROM EMP;

-- Q1. EMP ���̺��� ��� �̸��� 'A'�� �����ϴ� ��� �̸� ���
SELECT ENAME FROM EMP WHERE ENAME LIKE '%A%';
-- Q2. EMP ���̺��� �ش� ����� ��� ��ȣ�� 79�� ���۵Ǵ� ��� ���� ��� ���
SELECT * FROM EMP WHERE MGR LIKE '79__'; -- ��� ��ȣ, ��� ��ȣ�� 4�ڸ���� ���� ���
SELECT * FROM EMP WHERE MGR LIKE '79%';
-- Q3. EMP ���̺��� ��� �̸��� �� ��° ���ڰ� 'L'�� ��� ���� ��� ���
SELECT * FROM EMP WHERE ENAME LIKE '_L%';
-- Q4. EMP ���̺��� ����� �Ի����� 2���� ��� ���� ��� ���
-- HINT) YY/MM/DD
SELECT * FROM EMP WHERE HIREDATE LIKE '%/02/%'; 
-- DATE�� �ѱ� ǥ�� ��������� ����
-- NLS_TERRITORY = 'KOREA'
SELECT * FROM EMP WHERE TO_CHAR(HIREDATE, 'MM') = '02';

-- 7) IS NULL ������
-- : NULL �Ǵ� ������

-- EX) �� �̸� = NULL ?
SELECT * FROM EMP WHERE COMM = NULL; -- �Ұ���!
-- NULL�� � �����ڸ� ������ ������ ����� NULL

SELECT * FROM EMP WHERE COMM IS NULL;
SELECT * FROM EMP WHERE COMM IS NOT NULL;
SELECT * FROM EMP WHERE NOT COMM IS  NULL;

-- ���� ��� ���: SAL*12+COMM
-- ���� ����� ������ �ִ� ������� ��� ���� ���

SELECT ENAME, SAL, COMM, SAL*12+COMM AS ANNUALSAL
FROM EMP WHERE SAL*12+COMM IS NULL;


-- 8) ���տ�����
-- : SELECT���� ���� ��ȸ�� ����� �������� ǥ�� ������
-- (**) ����Ϸ��� �ϴ� ��� ���̺��� �� ����, �� ���� �ڷ����� ���ƾ� ��
-- (**) ���� �̸��� ù��° SELECT�� ����
-- (**) ��ȸ�Ϸ��� �ϴ� ���̺��� ���� ���̰� ��� �����͸� ������, ������, �������� �� �ǹ�����
-- (=> �� ������ �ʴ´�! WHY? ��� ���̺��� �� ���� �����ϱ� �����)

-- [ UNION ] (������)
SELECT * FROM SALGRADE;

CREATE TABLE SALGRADE2
      ( GRADE NUMBER,
	LOSAL NUMBER,
	HISAL NUMBER );
INSERT INTO SALGRADE2 VALUES (6,10000,20000);
INSERT INTO SALGRADE2 VALUES (7,20001,30000);
COMMIT;

SELECT * FROM SALGRADE2;
SELECT * FROM TAB;

-- UNION �Ұ�! (�ֳ��ϸ� ���� ������ ���� �ʱ� ����)
SELECT GRADE FROM SALGRADE
UNION
SELECT * FROM SALGRADE2;

SELECT * FROM SALGRADE
UNION
SELECT * FROM SALGRADE2;

-- [ INTERSECT ] (������)
-- �� SELECT ������ ��� ���� ���� �����͸� ���

SELECT EMPNO, ENAME, DEPTNO FROM EMP WHERE ENAME LIKE '%A%'
INTERSECT
SELECT EMPNO, ENAME, DEPTNO FROM EMP WHERE DEPTNO = 30;

SELECT EMPNO, ENAME, DEPTNO FROM EMP WHERE ENAME LIKE '%A%' AND DEPTNO = 30;

-- [ MINUS ] (������)
-- A - B: A�� ��� �߿��� B�� �������� ���� �����͸� ��� (�����ϰ� A���Ը� ���Ե� ������)

SELECT * FROM EMP WHERE JOB = 'SALESMAN'
MINUS
SELECT * FROM EMP WHERE ENAME LIKE '%T%';

--------------------------------------------------------
-- NULL VS 0
-- NULL: ������ ��ü�� ���� (�� ĭ)
-- (** NULL / ���Ѵ��� � �����ڸ� ������ ���� ����� NULL / ���Ѵ�)
-- 0: �����Ͱ� �ִµ� �� ���� 0 �ǹ�

