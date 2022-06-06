--# ���� Ǯ���
--
--1. EMPNO ������ EMP ���̺����� ��� �̸�(ENAME) �� �ټ� ���� �̻��̸� ���� ���� �̸��� ��� ������ ����մϴ�. 
--   MASKING_EMPNO ������ ��� ��ȣ(EMPNO) �� �� �ڸ� �� ���ڸ��� * ��ȣ�� ����մϴ�. 
--   �׸��� MASKING_ENAME ������ ��� �̸��� ù ���ڸ� ���� �ְ� ������ ���ڼ���ŭ * ��ȣ�� ����ϼ���.
--   
--   ::��� ȭ��
--      
--   EMPNO	MASKING_EMPNO	ENAME	MASKING_ENAME
--   7369		73**			SMITH	S****
--   7499		74**			ALLEN	A****
--   7566		75**			JONES	J****
--   ...
--

SELECT EMPNO, RPAD(SUBSTR(EMPNO, 1, 2), 4, '*') AS MASKING_EMPNO, 
ENAME,  RPAD(SUBSTR(ENAME, 1, 1), LENGTH(ENAME), '*') AS MAKSING_ENAME
FROM EMP
WHERE LENGTH(ENAME) >= 5 AND LENGTH(ENAME) < 6;


--2. EMP ���̺��� ������� �� ��� �ٹ��� ���� 21.5���Դϴ�. 
--   �Ϸ� �ٹ� �ð��� 8�ð����� ������ �� ������� �Ϸ� �޿� (DAY_PAY)�� 
--   �ñ� (TIME_PAY)�� ����Ͽ� ����� ����մϴ�.  
--   �� �Ϸ� �޿� (DAY_PAY)�� �Ҽ��� �� ��° �ڸ����� ������, 
--   �ñ� (TIME_PAY)�� �� ��° �Ҽ������� �ݿø��ϼ���.
--   
--   ::��� ȭ��
--
--   EMPNO 	ENAME	SAL 	DAY_PAY		TIME_PAY
--   7369		SMITH	800		37.2		4.7
--   7499		ALLEN	1600	74.41		9.3
--   7521		WARD	1250	58.13		7.3
--   ...
--   
SELECT EMPNO, ENAME, SAL,
TRUNC((SAL / 21.5), 2) AS DAY_PAY,
ROUND((SAL / 21.5) / 8, 1) AS TIME_PAY
FROM EMP;
 
 
 --3. �����ʰ� ���� ����� �������� SQL���� �ۼ��غ�����.
--   EMP ���̺��� ������� �Ի��� (HIREDATE)�� �������� 3������ ���� �� ù �����Ͽ� �������� �˴ϴ�.
--   ������� �������� �Ǵ� ��¥(R_JOB)�� YYYY-MM-DD �������� �����ʰ� ���� ����� �ּ���. 
--   ��, �߰� ����(COMM)�� ���� ����� �߰� ������ N/A�� ����ϼ���.
--
--   ::��� ȭ��
--   
--   EMPNO 	ENAME	HIREDATE	R_JOB		COMM
--   7369		SMITH	1980/12/17	1981-03-23	N/A
--   7499		ALLEN	1981/02/20	1981-05-25	300
--   7521		WARD	1981/02/22	1981-05-25  500
--   7566		JONES	1981/04/02	1981-07-06	N/A
--   ...