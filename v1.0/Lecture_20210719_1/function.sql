-- [����Ŭ �Լ�]
-- �Լ� (function): x ���� ���ϸ� y�� ����� �޶����� ����

-- �Լ��� ����
-- 1) ���� �Լ� (built-in function): ����Ŭ���� �⺻ ���� �Լ�

-- a. ������ �Լ� (single-row function)
-- : �� �྿ �Է� => �� ���� ���

-- b. ������ �Լ� (multiple-row function) (ex. ���� �Լ�, aggregate)
-- : ���� �� �Է� => �� ���� ���
-- : ex. AVG(), SUM(), COUNT(), MAX(), MIN()

-- Q1. EMP ���̺��� ���� (SAL * 12 + COMM)�� ���
SELECT AVG(SAL*12+COMM) AS AVG_ANNSAL
FROM EMP;

-- Q2. EMP ���̺��� ��� �̸��� 'E'�� ���� ����� ����
-- * ���� �� �Լ��� ���� �� �Լ� �Ǵ� �Ӽ��� (��)�� ���� �� �� ����
SELECT ENAME
FROM EMP
WHERE ENAME LIKE '%E%';

SELECT COUNT(ENAME) AS COUNT_E 
FROM EMP
WHERE ENAME LIKE '%E%';

-- Q3. EMP ���̺��� �μ� ��ȣ�� 30�� ����� �߿��� ��� �̸��� �ִ�
-- VARCHAR ������������ �ִ� (���������� �ִ�)
SELECT MAX(ENAME) AS MAX_ENAME
FROM EMP
WHERE DEPTNO = 30;

-- Q4. EMP ���̺��� ������ 'SALESMAN'�� ����� �߿��� �Ի����� �ּڰ�
SELECT HIREDATE
FROM EMP
WHERE JOB = 'SALESMAN';

-- DATE ������������ �ּڰ� (DATE���� ���ڿ��� �������� �� �ּڰ�)
SELECT MIN(HIREDATE) AS MIN_HIREDATE
FROM EMP
WHERE JOB = 'SALESMAN';

-- 2) ����� ���� �Լ� (user-defined function)
-- : ����� �ʿ信 ���� ���� ������ �Լ�


-- < ���� �Լ� �߿��� ���� �� �Լ� >

-- [������ �Լ�]
-- 1) ��ҹ��� ��ȯ �Լ�
-- UPPER(���ڿ�): ��� �빮�ڷ� ��ȯ�ؼ� ��ȯ
-- LOWER(���ڿ�): ��� �ҹ��ڷ� ��ȯ�ؼ� ��ȯ
-- INITCAP(���ڿ�): ù ���ڴ� �빮��, �������� �ҹ��ڷ� ��ȯ�ؼ� ��ȯ, "initial capital"

SELECT ENAME, UPPER(ENAME), LOWER(ENAME), INITCAP(ENAME)
FROM EMP;

-- * ���� ����ұ�� ?
-- �������� ���� (�ҹ���, �빮��)�� �ϰ��� �����ؼ� �˻�/��
-- ex) scott, SCOTT, Scott

-- Q1. ��� �̸��� 'A', 'a'��� ���ڰ� �� ��� ���� ��� (��ҹ��� ��ȯ �Լ� ���)
SELECT *
FROM EMP
WHERE UPPER(ENAME) LIKE '%A%';

SELECT *
FROM EMP
WHERE LOWER(ENAME) LIKE '%a%';

-- ��ҹ��� ��ȯ �Լ��� ������� �ʰ� ���
SELECT *
FROM EMP
WHERE ENAME LIKE '%A%'
OR ENAME LIKE '%a%';

-- vs 
SELECT UPPER(ENAME) 
FROM EMP 
WHERE ENAME LIKE '%A%';

-- 2) ���ڿ� ���� �Լ� (LENGTH)
SELECT ENAME, LENGTH(ENAME)
FROM EMP;

-- ����� ���� ���ڿ��� ���̰� 6���� �̻��� �ุ ��� ���� ��ü ���
SELECT *
FROM EMP
WHERE LENGTH(JOB) >= 6;

-- 3) ���ڿ� �Ϻ� ���� �Լ� (SUBSTR)
-- ���� ��� ? 2001"100""003", "881111"-1234567
-- 2021/07/20
-- 2001100003

-- SUBSTR(���ڿ� ������, ���� ��ġ): ���� ��ġ ~ ���ڿ� ������ ������ ����
-- SUBSTR(���ڿ� ������, ���� ��ġ, ���� ����): ���� ��ġ���� ���� ���̸�ŭ ����

SELECT ENAME, SUBSTR(ENAME, 3)
FROM EMP;

SELECT ENAME, SUBSTR(ENAME, 3, 2)
FROM EMP;

-- * ���� �ε����� 0�� �ƴ϶� 1���� ������
-- * EX) SMITH => 3��° ���� 'I' 

-- Q1. MGR���� �տ� �� ���� (79, 76, 78 ..)�� ������ �Բ� ����
SELECT MGR, SUBSTR(MGR, 1, 2)
FROM EMP;

SELECT MGR, SUBSTR(MGR, -LENGTH(MGR), 2)
FROM EMP;


-- Q2. MGR���� �տ� �� ���� (79, 76, 78 ..)�� ������ �Բ� ���� (MGR NULL�� ����)
SELECT MGR, SUBSTR(MGR, 1, 2)
FROM EMP
WHERE MGR IS NOT NULL;

SELECT MGR, SUBSTR(MGR, -LENGTH(MGR), 2)
FROM EMP
WHERE MGR IS NOT NULL;


-- Q3. MGR���� �ڿ� �� ���� (98, 98, 39 ..)�� ������ �Բ� ����
-- ���ڿ��� ���̸� �˰ų� ���ڿ��� ª�� ���
SELECT MGR, SUBSTR(MGR, 3, 2) -- "7998"
FROM EMP;

SELECT MGR, SUBSTR(MGR, 3) -- "7998"
FROM EMP;

SELECT MGR, SUBSTR(MGR, LENGTH(MGR)-1, 2) -- "7998"
FROM EMP;

SELECT MGR, SUBSTR(MGR, LENGTH(MGR)-1) -- "7998"
FROM EMP;


-- ���ڿ��� ���̰� �� ���
SELECT MGR, SUBSTR(MGR, -2) -- "ASDASABASDASCASDAS"
FROM EMP;

SELECT MGR, SUBSTR(MGR, LENGTH(MGR)-1, 2)
FROM EMP;

-- Q4. MGR���� �ڿ� �� ���� (98, 98, 39 ..)�� ������ �Բ� ���� (MGR NULL�� ����)
SELECT MGR, SUBSTR(MGR, 3, 2)
FROM EMP
WHERE MGR IS NOT NULL;

SELECT MGR, SUBSTR(MGR, -2)
FROM EMP
WHERE MGR IS NOT NULL;


-- Q5. ENAME���� �߰� ���� ���� 
-- (Ȧ�� ������ ���ڿ� �߰� ���� 1��)
-- (¦�� ������ ���ڿ� �߰� ���� 2�� �� �ڿ� �� ����)
-- "SMITH" => 'I'
-- "KING" => 'N'
-- "FORD" => 'R'

-- (Ȧ�� ������ ���ڿ� �߰� ���� 1��)
-- (¦�� ������ ���ڿ� �߰� ���� 2��)
-- "SMITH" => 'I'
-- "KING" => 'IN'
-- "FORD" => 'OR'
-- * ����: MOD(����, ���� ����) => MOD(����, 2) == 0 (¦�� �Ǵ�)
-- 							   MOD(����, 2) == 1 (Ȧ�� �Ǵ�)
-- MOD => modulus (������)

SELECT * FROM EMP;

SELECT ENAME, SUBSTR(ENAME, LENGTH(ENAME) / 2 + 1, 1)
FROM EMP;

-- ���ڿ��� ���̰� Ȧ���� ��� 1���� ����
SELECT ENAME, SUBSTR(ENAME, LENGTH(ENAME) / 2 + 1, 1)
FROM EMP
--WHERE MOD(LENGTH(ENAME), 2) = 1
WHERE MOD(LENGTH(ENAME), 2) <> 0

UNION -- �ߺ� ��� X (�ߺ��Ǵ� ������ ��� X)
-- ���ڿ��� ���̰� ¦���� ��� 2���� ����
SELECT ENAME, SUBSTR(ENAME, LENGTH(ENAME) / 2, 2)
FROM EMP
WHERE MOD(LENGTH(ENAME), 2) = 0;

-- UNION �ߺ� ����ϰ� ������ ... ?
-- UNION ALL

-- SELECT (ALL) �ߺ� ��� O
-- SELECT DISTINCT �ߺ� ��� X

--"7908"
--
--1
--SELECT MGR, SUBSTR(MGR, -LENGTH(MGR), 2) 
--FROM EMP 
--WHERE MGR IS NOT NULL;
--
--"79"
--
--2
--SELECT MGR, SUBSTR(MGR, -1, 2) 
--FROM EMP 
--WHERE MGR IS NOT NULL;
--
--"8"
--
--
--3
--SELECT MGR, SUBSTR(MGR, LENGTH(MGR)-1, 2) 
--FROM EMP 
--WHERE MGR IS NOT NULL;
--
--"08"
--
--
--4. 
--SUBSTR(MGR, -1, -2) => ���� X


-- 4) ���ڿ� ������ �ȿ��� Ư�� ��ġ�� ã�� INSTR �Լ�
-- : Ư�� ����(��)�� ��� ���ԵǾ��ִ� �� �˰��� �� ��

SELECT INSTR('HELLO, ORACLE!', 'L') AS INSTR_1
-- 'HE(L)LO, ORACLE!'
FROM DUAL; 
-- �����̳� �Լ��� ����� ��� �����ִ� �� ��� ���̺�
-- DUMMY TABLE

SELECT INSTR('HELLO, ORACLE!', 'L', 5) AS INSTR_1
-- �ټ���° ���� (O)���� L ã��
-- 'HELLO, ORAC(L)E!'
FROM DUAL; 

SELECT INSTR('HELLO, ORACLE!', 'L', 2, 2) AS INSTR_1
-- �� ��° ���� (E)���� �� ��°�� ���� L ã��
-- 'HEL(L)O, ORACLE!'
FROM DUAL; 

SELECT INSTR('HELLO, ORACLE!', 'L', 2, 3) AS INSTR_1
FROM DUAL; 
-- 'HELLO, ORAC(L)E!'

SELECT INSTR('HELLO, ORACLE!', 'L', 2, 4) AS INSTR_1
FROM DUAL; 
-- 'HELLO, ORACLE!' ==> 0 ��ȯ

SELECT INSTR('HELLO, ORACLE!', 'L', -2, 2) AS INSTR_1
FROM DUAL; 
-- 'HEL(L)O, ORACLE!' 

SELECT INSTR('HELLO, ORACLE!', 'L', 
-LENGTH('HELLO, ORACLE!'), 2) AS INSTR_1
FROM DUAL; -- => 0 ��ȯ

-- * ���� ã������ �ϴ� ���ڰ� ������ 0 ��ȯ
-- * ���� ��ġ�� ������ ���� �����ʺ��� -> ���� ���� �˻�
-- (���� �⺻�� ���� -> ������ ����)

-- ���� ����)
-- ����� �̸��� S�� �ִ� (���ǽ�) 
-- ��� ���� ��ü (SELECT �ڿ� ����� �� ����, *) ���

-- LIKE '%S%'
-- INSTR() => ?

SELECT *
FROM EMP
WHERE ENAME LIKE '%S%';

SELECT *
FROM EMP
WHERE INSTR(ENAME, 'S') > 0;
-- 1 ~ LENGTH(ENAME) �� ��ȯ => 'S' ����
-- 0 ��ȯ => 'S' ����


-- ����
-- INSTR([���ڿ�/�� �̸� (�ʼ�)], [�κ� ���� (�ʼ�)]
-- [���� ��ġ (����)], 
-- [ã������ �ϴ� ���ڰ� �� ��°���� ���� (����)])

-- 5) Ư�� ���ڸ� �ٸ� ���ڷ� �ٲٴ� REPLACE �Լ�

-- ����)
-- REPLACE([���ڿ�/�� �̸� (�ʼ�)], 
-- [ã�� ���� (�ʼ�)], [��ü�� ���� (����)])
-- * ��ü�� ���ڰ� ������ ���ڿ� �����Ϳ��� ����

SELECT '801111-1234567' AS REGNUM,
REPLACE('801111-1234567', '-', ' ') AS REGNUM_REPLACE_1,
REPLACE('801111-1234567', '-') AS REGNUM_REPLACE_2 -- ���� ����
FROM DUAL;

-- * ���� ����� ?
-- Ư�� ���ڰ� ���Ե� �����Ϳ��� Ư�� ���ڸ� �����ϰų� ��ü�� ��
-- EX) ���¹�ȣ, �ڵ��� ��ȣ, �ֹι�ȣ


-- 6) �������� �� ������ Ư�� ���ڷ� ä��� (Padding) �Լ� (LPAD, RPAD)
-- LPAD: Left Padding (���� �е�)
-- RPAD: Right Padding (������ �е�)

-- ����)
-- LPAD([���ڿ�/���̸� (�ʼ�)], [������ �ڸ��� (�ʼ�)], 
-- [�е��� ���� (����)])
-- RPAD([���ڿ�/���̸� (�ʼ�)], [������ �ڸ��� (�ʼ�)], 
-- [�е��� ���� (����)])

-- * �е��� ���ڰ� ������ �� ������ �ڸ�����ŭ ���� ���ڷ� ä��

SELECT 'SQL',
LPAD('SQL', 10, '*') AS LPAD_1,
LPAD('SQL', 10) AS LPAD_2,
RPAD('SQL', 10, '*') AS RPAD_1,
RPAD('SQL', 10) AS RPAD_2,
LENGTH(RPAD('SQL', 10)) AS RPAD_2_LENGTH
FROM DUAL;


-- Q1. �ֹε�Ϲ�ȣ ���ڸ��� ���� (SUBSTR)�ؼ� ���ڸ� * ��� (RPAD)
SELECT '901111-1234567' AS REG,
RPAD(SUBSTR('901111-1234567', 1, 7), 
LENGTH('901111-1234567'), '*') AS REG_RPAD
FROM DUAL;

-- Q2. �ڵ��� ��ȣ 010-1234-�� ���� (SUBSTR)�ؼ� ���ڸ� * ��� (RPAD)
SELECT '010-1234-5678' AS PHONE_NUM,
RPAD(SUBSTR('010-1234-5678', 1, 9),
LENGTH('010-1234-5678'), '*') AS PHONE_NUM_RPAD
FROM DUAL;

-- * ���࿡ �������� �ϴ� ���ڿ����� �ڸ��� ���� ��쿡��
-- ���ڿ��� �ս� (�߸�)
SELECT 'HELLO!',
LPAD('HELLO!', 4, '#') AS LPAD_1
FROM DUAL;

SELECT 'HELLO!',
RPAD('HELLO!', 4, '#') AS RPAD_1
FROM DUAL;


-- 7) �� ���ڿ��� ��ġ�� CONCAT �Լ� (CONCATENATE)
-- : �� ���ڿ��� �ϳ��� �����ͷ� ����

SELECT * FROM EMP;
-- EMPNO : ENAME

SELECT CONCAT(EMPNO, ENAME)
FROM EMP;

-- 1)
SELECT CONCAT(EMPNO, CONCAT(' : ', ENAME))
FROM EMP;

-- 2)
SELECT CONCAT(CONCAT(EMPNO, ' : '), ENAME)
FROM EMP;

-- 3)
SELECT EMPNO || ' : ' || ENAME -- �������� ����
FROM EMP;

-- ���ڿ� �����ϴ� || ������
SELECT EMPNO || ENAME
FROM EMP;

SELECT EMPNO || ' ' || ENAME
FROM EMP;


-- 8) Ư�� ���ڸ� ����� TRIM, LTRIM, RTRIM
-- : TRIM (�ٵ��)
-- : ���ڿ� ���� Ư�� ���ڸ� ����� ���� ���

-- ����)
-- * ���� ������ ���ڸ� �������� �ʰ� ������ ����µ� ���� ���
-- TRIM([���� �ɼ� (����)][������ ���� (����)] 
-- FROM [���� ���ڿ� (�ʼ�)])
-- ���� �ɼ� (���� �Ⱦ�)
-- 1) LEADING: ���ʿ� �ִ� ���� ����
-- 2) TRAILING: �����ʿ� �ִ� ���� ����
-- 3) BOTH: ���� ���� ����

-- ������ ���ڰ� �������� ������ ������ ����
-- * ������ ������ ���ڸ� �������� �ʰ� ���� ���Ž� ���

-- ���� ���� ���
SELECT TRIM('   �ȳ��ϼ���.   ') AS TRIM_1
FROM DUAL;

SELECT TRIM('_' FROM '__ _�ȳ��ϼ���._ ___') AS TRIM_1
FROM DUAL;

SELECT TRIM(LEADING '_' FROM '__��_���ϼ���.___') AS TRIM_1
FROM DUAL;

SELECT TRIM(TRAILING '_' FROM '__��_���ϼ���.___') AS TRIM_1
FROM DUAL;

SELECT TRIM(BOTH '_' FROM '__��_���ϼ���.___') AS TRIM_1
FROM DUAL;

-- LTRIM, RTRIM �Լ�
-- TRIM �Լ��� �ٸ� ���� ������ ���ڸ� ������ ���� ����
-- LTRIM : LEFT TRIM (���� ���� ���ڸ� ����)
-- RTRIM : RIGHT TRIM (������ ���� ���ڸ� ����)

-- ����)
-- LTRIM([���� ���ڿ�/������ (�ʼ�)], 
-- [���� ���� (������ ���� ����) (����)])
-- RTRIM([���� ���ڿ�/������ (�ʼ�)], 
-- [���� ���� (������ ���� ����) (����)])

SELECT TRIM(' _ORACLE_ ') AS TRIM_1,
LENGTH(TRIM(' _ORACLE_ ')) AS TRIM_1_LENGTH
FROM DUAL;

-- TRIM()�� ���� ���� ���� ������ �Ұ��� (�� ���� ���� ����)
SELECT TRIM(' _' FROM ' _ORACLE_ ') AS TRIM_1
FROM DUAL;


-- ' '�� '_' ����ؼ� ������ �� �ִ� ���ڸ� ��� ���� (�� �� ����ϵ� ��� x)
-- ' _'
-- '_ '
-- ' '
-- '_'
-- '__' (����� 2��)
-- '  ' (�����̽� 2��)

-- ������ ���ڵ�� ������ �� �ִ� ���� ����
-- ������ �� ���� ('O') ���۵Ǹ� ���� �۾� ���� (���ڿ� ����)
SELECT LTRIM(' _ORACLE_ ', ' _') AS TRIM_1
FROM DUAL;

SELECT RTRIM(' _____ORACLE____ _S', ' _') AS TRIM_1
FROM DUAL;



-- <title>A Meaningful Page</title>

SELECT RTRIM(LTRIM('<title>A Meaningful Page</title>', 
'<title>'), '</title>') as TAG_REMOVE
FROM DUAL;

SELECT RTRIM(RTRIM(LTRIM('<title>A Meaningful Page</title>', 
'<title>'), '<title>'), '</') as TAG_REMOVE
FROM DUAL;


-- �Լ� ǥ�� ����: https://docs.oracle.com/cd/E11882_01/server.112/e41085/toc.htm


-- [������ �Լ�]
-- : ���� ������ (NUMBER)�� �����ϴ� �Լ�
-- ROUND: �ݿø� �Լ� ex) 12.5 => 13
-- TRUNC (truncate, ���̸� ���̴�): ���� �Լ� ex) 12.5 => 12
-- CEIL: �ø� �Լ�
-- FLOOR: ���� �Լ�
-- MOD: ������ �Լ�

-- 1) ROUND()
-- : Ư�� ��ġ���� ���ڸ� �ݿø��ϴ� �Լ�
-- : �ݿø��� ��ġ�� �������� ������ �Ҽ��� ù��° �ڸ����� �ݿø�

-- ����)
-- ROUND([���� (�ʼ�)], [�ݿø��� ��ġ (����)])

-- 1235
SELECT ROUND(1234.5678, 0) AS ROUND -- => 1234."5"678 => 1235
FROM DUAL;

-- 1234.6
SELECT ROUND(1234.5678, 1) AS ROUND -- => 1234.5"6"78 => 1234.6 
FROM DUAL;

-- 1234.57
SELECT ROUND(1234.5678, 2) AS ROUND --
FROM DUAL;

-- 1234.568
SELECT ROUND(1234.5678, 3) AS ROUND -- 
FROM DUAL;

-- 1230
SELECT ROUND(1234.5678, -1) AS ROUND -- 
FROM DUAL;

-- 1200
SELECT ROUND(1234.5678, -2) AS ROUND -- 
FROM DUAL;

-- * �ݿø� �� ��ġ�� ������ ������ �� ���� 
-- * �ݿø� ��ġ ���� ������ �ڿ��� ������ �ݿø�

-- 2) TRUNC() (truncate, ���̴�)
-- : ������ �ڸ����� ���� ����
-- : ������ �ڸ����� ���� �� �� ����
-- : ������ �ڸ����� �������� ������ �Ҽ��� ù��° �ڸ����� ����

-- ����)
-- TRUNC([���� (�ʼ�)], [������ ��ġ (����)])



-- 1234.56
SELECT TRUNC(1234.5678, 2) AS TRUNC -- �Ҽ��� �ڸ� 2���� ǥ�� (�Ҽ��� ����° �ڸ����� ����)
FROM DUAL;

-- 1234.5
SELECT TRUNC(1234.5678, 1) AS TRUNC -- �Ҽ��� �ڸ� 1���� ǥ�� (�Ҽ��� �ι�° �ڸ����� ����)
FROM DUAL;


-- 1234
SELECT TRUNC(1234.5678, 0) AS TRUNC -- �Ҽ��� �ڸ� 0���� ǥ�� (�Ҽ��� ù��° �ڸ����� ����)
FROM DUAL;

-- 1230
SELECT TRUNC(1234.5678, -1) AS TRUNC -- �ڿ��� ù��° �ڸ����� ����
FROM DUAL;

-- 1200
SELECT TRUNC(1234.5678, -2) AS TRUNC -- �ڿ��� �ι�° �ڸ����� ����
FROM DUAL;


-- 3) CEIL() (õ��), FLOOR() (�ٴ�)
-- : ������ ���ڿ� ����� (����)�� ã�� �Լ�
-- CEIL([���� (�ʼ�)]): �Է��� ���ڿ� ����� ū ����
-- FLOOR([���� (�ʼ�)]): �Է��� ���ڿ� ����� ���� ����

SELECT CEIL(12.4), FLOOR(12.4)
FROM DUAL;

SELECT CEIL(-12.4), FLOOR(-12.4)
FROM DUAL;

-- 4) MOD() (������ �Լ�, modulus)
-- MOD([�������� �� ���� (�ʼ�)], [���� ���� (�ʼ�)])

SELECT MOD(15, 4)
FROM DUAL;

-- * �ش� ���� ¦������ Ȧ������ ������ �� ���

SELECT * FROM EMP;

-- 1) EMP ���̺��� �����ȣ�� ¦���� ��� ���� ���
SELECT *
FROM EMP
WHERE MOD(EMPNO, 2) = 0;

-- 2) EMP ���̺��� �����ȣ�� Ȧ���� ��� ���� ���
SELECT *
FROM EMP
WHERE MOD(EMPNO, 2) <> 0; -- ISO ǥ�� ��� (���Ǽӵ� ���)
-- != , ^=




-- [��¥�� �Լ�]
-- : ��¥ ������ (DATE) �ٷ�� �Լ�

-- ��¥ ������ + ���� => ��¥ �����ͺ��� ���ڸ�ŭ ���� ��¥ ��ȯ
-- ��¥ ������ - ���� => ��¥ �����ͺ��� ���ڸ�ŭ ���� ��¥ ��ȯ
-- ��¥ ������ + ��¥ ������ => ���� X
-- ��¥ ������ - ��¥ ������ => �� �����Ͱ��� �ϼ� ����

-- 1) SYSDATE ���
-- : Oracle DB�� ��ġ�� OS (�ü��)�� ���� ��¥�� �ð��� ��ȯ

SELECT SYSDATE
FROM DUAL;

SELECT SYSDATE+2
FROM DUAL;

SELECT SYSDATE-2
FROM DUAL;

-- 2) ADD_MONTHS()
-- : Ư�� ��¥�� ������ ���� �� ���� ��¥ ������ ��ȯ
-- ����) ADD_MONTHS([��¥ ������ (�ʼ�)], [���� ���� �� (����) (�ʼ�)])

SELECT SYSDATE, ADD_MONTHS(SYSDATE, 3)
FROM DUAL;

-- ������ ����
SELECT SYSDATE, ADD_MONTHS(SYSDATE, -3)
FROM DUAL;

-- Q1. EMP ���̺��� ������� �ٹ� �ϼ� ���
SELECT ENAME, SYSDATE, HIREDATE, TRUNC(SYSDATE - HIREDATE) AS WORKDAYS
FROM EMP;



-- Q2. EMP ���̺��� ����� �߿��� �Ի����� 40���� �Ѵ� (�ʰ�) ������� �����ؼ� ��� ���� ���
SELECT ENAME, HIREDATE,  ADD_MONTHS(HIREDATE, 40 * 12),
(SYSDATE - HIREDATE) / 365
FROM EMP;

SELECT *
FROM EMP
WHERE ADD_MONTHS(HIREDATE, 40 * 12) < SYSDATE;

SELECT * 
FROM EMP 
WHERE (SYSDATE - HIREDATE) / 365 > 40;

SELECT ENAME, ROUND(SYSDATE - HIREDATE) AS WORK_DATE 
FROM EMP 
WHERE ROUND(SYSDATE - HIREDATE) > 365 * 40;


-- Q3. EMP ���̺��� ������� 10�ֳ��� �Ǵ� ��¥ ��� �̸��� ���� ���
SELECT ENAME, ADD_MONTHS(HIREDATE, 10 * 12) AS WORK_10_YEAR
FROM EMP;



-- 3) ���� �� ���̸� ���ϴ� MONTHS_BETWEEN()
-- : �� ��¥ ������ ���� �� ���̸� ����
-- ����) MONTHS_BETWEEN([��¥ ������1 (�ʼ�)], [��¥ ������2 (�ʼ�)])
-- * ��¥ ������1 - ��¥ ������2 (���� ����!)

-- EX) EMP ���̺��� ����� �Ի糯�� ���� �ý����� ��¥ ���� �� ���̸� ���
SELECT ENAME, HIREDATE, SYSDATE, 
MONTHS_BETWEEN(HIREDATE, SYSDATE) AS MONTH1, -- HIRDATE - SYSDATE (���� ��) (* ����)
MONTHS_BETWEEN(SYSDATE, HIREDATE) AS MONTH2,  -- SYSDATE - HIREDATE (��� ��) (* ����)
TRUNC(MONTHS_BETWEEN(SYSDATE, HIREDATE)) AS MONTH_TRUNC, -- ������� ���� ���� ��
ROUND(TRUNC(MONTHS_BETWEEN(SYSDATE, HIREDATE))/12, 1) AS YEAR_TRUNC -- ������� ���� �� ��
FROM EMP;

-- 4) NEXT_DAY(), LAST_DAY()
-- : NEXT_DAY([��¥ ������ (�ʼ�)], [���� ���� (�ʼ�)])
-- : Ư�� ��¥ �������� ���ƿ��� ���� ��¥ ���
-- : LAST_DAY([��¥ ������ (�ʼ�)])
-- : Ư�� ��¥�� ���� ���� ������ ��¥ ���

SELECT SYSDATE,
NEXT_DAY(SYSDATE, 2),
LAST_DAY(SYSDATE)
FROM DUAL;

-- ���Ϲ���
-- 1 : '��', '�Ͽ���', 'SUN', 'SUNDAY'
-- 2 : '��', '������', 'MON', 'MONDAY'
-- 3 : 'ȭ', 'ȭ����', 'TUE', 'TUESDAY'
-- ....

-- 5) ROUND(), TRUNC()
-- : ���ڿ����� �����ϴ� �Լ� -> ��¥���� ������
-- : �Ҽ��� �ڸ� ǥ������ �ʰ� �ݿø�/������ ������ �� ���� ����

-- ����)
-- ROUND([��¥ ������ (�ʼ�)], [�ݿø� ���� ���� (�ʼ�)])
-- TRUNC([��¥ ������ (�ʼ�)], [���� ���� ���� (�ʼ�)])

-- ���� ��
-- CC (century), SCC: �� �ڸ� ���� �� ���ڸ� ����
-- EX) 2020 -> 50 �̻��� �ƴϱ� ������ �ݿø� X -> 2001�� 
-- EX) 2050 -> 50 �̻��̱� ������ �ݿø� O -> 2100��

-- YYYY, YYY, YY, Y
-- : ��¥ �������� ��, ��, ���� 7�� 1�� ����

-- Q (quarter)
-- : �� �б��� �� ��° ���� 16�� ����
-- (1/1 ~ 3/31, 2�� 16��), (4/1 ~ 6/30, 5�� 16��), (7/1 ~ 9/30, 8�� 16��), (10/1 ~ 12/31, 11�� 16��)

-- DD, DDD
-- : �ش� ���� ���� (12:00:00) ����

-- HH (hour), HH12, HH24
-- : �ش� ���� �ð��� ����

SELECT ROUND(SYSDATE, 'CC') AS FORMAT_CC, -- 2001�� ǥ��
ROUND(SYSDATE, 'YYYY') AS FORMAT_YYYY, -- 7�� 1�� �Ѿ��� ������ 2022�� �ݿø�
ROUND(SYSDATE, 'Q') AS FORMAT_Q, -- 8�� 16�� �����̴ϱ� 7�� 1�� �ݿø�
ROUND(SYSDATE, 'DDD') AS FORMAT_DDD, -- �ð��� ���� (12��)�� �Ѿ����ϱ� 7�� 21�Ϸ� �ݿø�
ROUND(SYSDATE, 'HH') AS FORMAT_HH -- ���� 3:44���̴ϱ� 4�÷� �ݿø�
FROM DUAL;

SELECT TRUNC(SYSDATE, 'CC') AS FORMAT_CC,
TRUNC(SYSDATE, 'YYYY') AS FORMAT_YYYY,
TRUNC(SYSDATE, 'Q') AS FORMAT_Q,
TRUNC(SYSDATE, 'DDD') AS FORMAT_DDD,
TRUNC(SYSDATE, 'HH') AS FORMAT_HH
FROM DUAL;


-- [�� ��ȯ �Լ�]
-- : �ڷ��� (������, ������, ��¥��)
-- 1) �Ͻ��� �� ��ȯ

-- ������ (EMPNO) + ���ڿ� ('500') (**)
-- '500'�� ���ڷ� ��ȯ�� ���� => ���� �� ��ȯ �ڵ� (�Ͻ��� �� ��ȯ)
SELECT EMPNO, EMPNO + '500'
FROM EMP;

-- ������ (EMPNO) + ���ڿ� ('ZZZ') (**)
-- 'ZZZ'�� ���ڷ� ��ȯ �Ұ��� => ���ڷ� �ν��� �� ���� (�� ��ȯ X)
SELECT EMPNO, EMPNO + 'ZZZ'
FROM EMP;


-- 2) ����� �� ��ȯ
-- TO_CHAR: ����/��¥�� -> ������
-- ����) TO_CHAR([��¥ ������ (�ʼ�)], '[����ϰ��� �ϴ� ���ڿ� (�ʼ�)]')

-- ��¥�� -> ������
SELECT TO_CHAR(SYSDATE, 'YYYY/MM/DD HH24:MI:SS') -- MINUTE
AS NOW
FROM DUAL;

SELECT TO_CHAR(SYSDATE, 'YYYY/MM/DD HH12:MI:SS PM') -- MINUTE
AS NOW
FROM DUAL;

-- ���� ������
-- CC: ����
-- YYYY, RRRR (ROUNDING, �ݿø�, ��ȸ�ϴ�): �� (4�ڸ� ����)
-- YY, RR: �� (2�ڸ� ����)


-- TO_DATE() (���� ����!)
-- EX) 2020�� => RR => 50 �̻��� ���� �ν� => 1950��
-- EX) 2050�� => RR => 50 �̻��� ���� �ν� => 2050��

-- MM: �� (2�ڸ� ����)
-- MON: �� (�� �̸� ����)
-- MONTH: �� (�� �̸� ��ü)
-- DD: �� (2�ڸ� ����)
-- DDD: 1�� �� ��ĥ (1 ~ 366)
-- DY: ���� (���� �̸� ����)
-- DAY: ���� (���� �̸� ��ü)
-- W: 1�� �� �� ��° ��

SELECT SYSDATE,
TO_CHAR(SYSDATE, 'MM') AS MM,
TO_CHAR(SYSDATE, 'MON') AS MON,
TO_CHAR(SYSDATE, 'MONTH') AS MONTH
FROM DUAL;

SELECT SYSDATE,
TO_CHAR(SYSDATE, 'DD') AS DD,
TO_CHAR(SYSDATE, 'DY') AS DY,
TO_CHAR(SYSDATE, 'DAY') AS DAY
FROM DUAL;

-- Ư�� ��� ���缭 ���
-- 'NLS_DATE_LANGUAGE = ... '

SELECT SYSDATE,
TO_CHAR(SYSDATE, 'MM') AS MM,
TO_CHAR(SYSDATE, 'MON', 'NLS_DATE_LANGUAGE = JAPANESE') AS MON,
TO_CHAR(SYSDATE, 'MONTH', 'NLS_DATE_LANGUAGE = JAPANESE') AS MONTH
FROM DUAL;

SELECT SYSDATE,
TO_CHAR(SYSDATE, 'DD') AS DD,
TO_CHAR(SYSDATE, 'DY', 'NLS_DATE_LANGUAGE = ENGLISH') AS DY,
TO_CHAR(SYSDATE, 'DAY', 'NLS_DATE_LANGUAGE = ENGLISH') AS DAY
FROM DUAL;


-- �ð� ����
-- HH24: 24�ð����� ǥ���� �ð�
-- HH, HH12: 12�ð� ǥ���� �ð�
-- MI: ��
-- SS: ��
-- AM, PM, A.M., P.M.: ���� ���� ǥ��

-- ��¥�� -> ������
SELECT SYSDATE, TO_CHAR(SYSDATE, 'HH:MI:SS P.M.')
FROM DUAL;

-- TO_NUMBER: ������ -> ������
-- 1) �Ͻ��� �� ��ȯ

SELECT 5000 - '$3,000' -- �Ͻ��� �� ��ȯ�� �ȵ� (���ڷθ� ǥ��� �� �ƴ�)
FROM DUAL;

SELECT 5000 - '3000'   
FROM DUAL;

SELECT 5000 - '3.000' -- '3.000' => 3.000 
FROM DUAL;


-- 2) ����� �� ��ȯ (TO_NUMBER())
-- ����) TO_NUMBER([���ڿ� ������ (�ʼ�)], [�νĵǾ���� ���� ���� (�ʼ�)])

SELECT 5000 - TO_NUMBER('$3,000', '$9,999') -- ����� �� ��ȯ �� �Ŀ� ��� (�� �ڸ��� �� �� �ִ� ���� �ִ�)
-- 5000 - '3000' = 2000 (�Ͻ��� �� ��ȯ)
-- 5000 - '3,000' = 2000 (�Ͻ��� �� ��ȯ X)
-- 5000 - TO_NUMBER('$3,000', '$9,999') = 2000 (�Ͻ��� �� ��ȯ X, ����� �� ��ȯ O)
-- 5000 - TO_NUMBER('$9,000', '$9,999') = 2000 (�Ͻ��� �� ��ȯ X, ����� �� ��ȯ O)
FROM DUAL;

SELECT 5000 - TO_NUMBER('$333,000', '$99,999') -- ����� �� ��ȯ �� �Ŀ� ��� (�� �ڸ��� �� �� �ִ� ���� �ִ�)
FROM DUAL;
-- * ���� ���� �ۼ��� �����ؾ��� ��
-- 1) �ڸ��� Ȯ��
-- 2) �� �ڸ����� �ִ�� ǥ���� �� �ִ� �� �ȿ� ����� Ȯ��

-- Q1. 200000 - '123,500' 
SELECT 200000 - TO_NUMBER('123,500', '999,999') AS RES 
FROM DUAL;

-- Q2. 5000 - '$3,000'  
SELECT 5000 - TO_NUMBER('$3,000', '$9,999') AS RES
FROM DUAL;


-- TO_DATE: ������ -> ��¥�� 
-- : scott.sql ���Ͽ��� ��¥�� ���� ���·� ������ �� ���
-- : ���ڿ� �����͸� �Է��� �Ŀ� �� �����͸� ��¥ ���·� ��ȯ�� ��

-- ����) TO_DATE([���ڿ� ������ (�ʼ�)], [�νĵǾ���� ��¥ ���� (�ʼ�)])


SELECT TO_DATE('2018-07-20', 'YYYY-MM-DD') AS TODATE
FROM DUAL;

SELECT TO_DATE('2021/07/22', 'YYYY/MM/DD') AS TODATE
FROM DUAL;

-- Q1. EMP ���̺��� �Ի糯�� 1981�� 7�� 20�� ������ ��� ���� ��� �� ���
SELECT *
FROM EMP
WHERE HIREDATE > TO_DATE('1981/07/20', 'YYYY/MM/DD'); -- DATE�� DATE ���̵� ũ�� ��

SELECT *
FROM EMP
WHERE HIREDATE > TO_DATE('1981-07-20', 'YYYY-MM-DD');

-- ��¥ ������ ���� ������ ��
-- YYYY, RRRR: �� �ڸ� ����
-- YY, RR: �� �ڸ� ����

SELECT TO_DATE('49/12/10', 'YY/MM/DD') AS YY_YEAR_49,
TO_DATE('49/12/10', 'RR/MM/DD') AS RR_YEAR_49,
TO_DATE('50/12/10', 'YY/MM/DD') AS YY_YEAR_50,
TO_DATE('50/12/10', 'RR/MM/DD') AS RR_YEAR_50,
TO_DATE('51/12/10', 'YY/MM/DD') AS YY_YEAR_51,
TO_DATE('51/12/10', 'RR/MM/DD') AS RR_YEAR_51
FROM DUAL;

-- 1950�⵵ �������� YY, RR �ٸ��� �ν�
-- YY: �� ������ ������ ������ ���� ��� (EX. 2021)
-- RR: �� ������ ���� �� ���ڸ� �� (20(21))��  0 ~ 49 => 1900 ���
									--  50 ~ 99 => 2000 ���


-- [NULL ó�� �Լ�]
-- : ������ NULL �� (���� Ȯ������ ���� ��, ������ �Է� �ȵ� ��) => ���/�� ������ => ��� NULL
-- : �����Ͱ� NULL�� ���, ���� ������ ���� NULL �ƴ� �ٸ� ������ ��ü

-- 1) NVL (NULL VALUE)
-- ����)
-- NVL ([NULL���� ���θ� �˻��� ������/�� (�ʼ�)], [���� �����Ͱ� NULL�� ��� ��ü�� ������ (�ʼ�)])
-- : NULL�� �ƴϸ� �״�� ��ȯ
-- : NULL�̸� �� ��° ���ڷ� ������ ������ ��ȯ
-- : ��ü�� �����Ͱ� �˻��� �����Ϳ� ���� ������ Ÿ�� 

SELECT ENAME, SAL, COMM, SAL*12+COMM AS ANNSAL, SAL*12 + NVL(COMM, 0) AS ANNSAL_NVL
FROM EMP;


-- 2) NVL2 (NULL VALUE)
-- ����)
-- NVL2 ([NULL���� ���θ� �˻��� ������/�� (�ʼ�)], 
-- [���� �����Ͱ� NULL�� �ƴ� ��� ��ü�� ������ �Ǵ� ���� (�ʼ�)],
-- [���� �����Ͱ� NULL�� ��� ��ü�� ������ �Ǵ� ���� (�ʼ�)])

SELECT ENAME, SAL, COMM, SAL*12+COMM AS ANNSAL, NVL2(COMM, SAL*12+COMM, SAL*12) AS ANNSAL_NVL2
FROM EMP;


SELECT ENAME, SAL, COMM, SAL*12+COMM AS ANNSAL, NVL2(COMM, 'O', 'X') AS ISCOMM
FROM EMP;

-- NVL VS NVL2
-- NVL2 : NULL�� �ƴ� ��쿡 ��ȯ �����ͱ��� ������ �� ����
-- NVL�� �� ���� ���


-- [DECODE �Լ�, CASE ��]
-- : if, switch���� ���
-- : NVL, NVL2�� ���� NULL�� ��쿡�� ó��
-- : NULL ���� �ƴ� ��쿡�� Ư�� �� / ������ ���� ���� ��ȯ�� ������ ����


-- 1) DECODE �Լ�

-- EX) EMP ���̺��� ��å�� ���� �޿��� �λ���� �޸��� �� ����
-- a. MANAGER: 10% => 0.1
-- b. SALESMAN: 5% ==> 0.05
-- c. �� �� ��å: 3% ==> 0.03
-- => �λ���� ������ �޿��� ���

-- * ������ ���� (=)�� ����
-- JOB = 'MANAGER'
-- JOB = 'SALESMAN'
-- 

SELECT EMPNO, ENAME, JOB, SAL, 
	DECODE(JOB, 
		'MANAGER', SAL + SAL * 0.1, -- SAL * 1.1
		'SALESMAN', SAL + SAL * 0.05,
		SAL + SAL * 0.03
	) AS UPSAL
FROM EMP;


SELECT EMPNO, ENAME, JOB, SAL, 
	DECODE(JOB, 
		'MANAGER', SAL + SAL * 0.1, -- SAL * 1.1
		'SALESMAN', SAL + SAL * 0.05,
--		SAL + SAL * 0.03
	) AS UPSAL
FROM EMP;
-- ���ǿ� ���� ���� ���� �� (else��) ��ȯ���� �������� ������ NULL ��ȯ 

-- ����)
-- DECODE([�˻��� �� / ������], 
--		[���� 1], [���� 1�� ���],
--      [���� 2], [���� 2�� ���],
--      ...
--      [���� N], [���� N�� ���],
--      [�� ���ǿ� �ش��ϴ� ��찡 ���� �� ��ȯ ���]
--)

-- 2) CASE �� (�Լ� �ƴ�, CASE ()�� ����)
-- : DECODE �Լ������� ���ǽĿ� �� ������ (=)�� ����
-- : CASE �������� �پ��� ���ǽ��� �� �� ����
-- : DECODE �Լ��� ���� Ȱ�뵵 ����

-- ����)
-- CASE [�˻��� �� / ������ (����)]
-- WHEN [���� 1] THEN [���� 1�� ���]
-- WHEN [���� 2] THEN [���� 2�� ���]
-- ...
-- WHEN [���� N] THEN [���� N�� ���]
-- ELSE [�� ���ǿ� �ش��ϴ� ��찡 ���� �� ��ȯ ���]
-- END
-- * CASE���� �˻��� ���� ������ �Ǿ�������
-- => �˻��� �� = ���� 1
-- => �˻��� �� = ���� 2

-- CASE []
-- WHEN [���� 1] THEN [���� 1�� ���]
-- WHEN [���� 2] THEN [���� 2�� ���]
-- ...
-- WHEN [���� N] THEN [���� N�� ���]
-- ELSE [�� ���ǿ� �ش��ϴ� ��찡 ���� �� ��ȯ ���]
-- END

-- * CASE���� �˻��� ���� �������� ���� ���� ����
-- => ���ǿ� �˻��� ���� ����

-- EX) EMP ���̺��� ��å�� ���� �޿��� �λ���� �޸��� �� ����
-- a. MANAGER: 10% => 0.1
-- b. SALESMAN: 5% ==> 0.05
-- c. �� �� ��å: 3% ==> 0.03
-- => �λ���� ������ �޿��� ���

SELECT EMPNO, ENAME, JOB, SAL,
	CASE JOB -- 'JOB =' ���� (���� '='�� �ϰ� ������ �˻��� �� ����)
		WHEN 'MANAGER' THEN SAL + SAL * 0.1
		WHEN 'SALESMAN' THEN SAL + SAL * 0.05
		ELSE SAL + SAL * 0.03
	END AS UPSAL
FROM EMP;

-- Q1. EMP ���̺��� SAL�� ������ ���� �޿��� ������ �����Ѵٰ� ����
-- a. SAL <= 1000 => 8%
-- b. SAL <= 3000 => 10%
-- c. SAL <= 5000 => 13%
-- d. �̿��� SAL => 15%
-- => ���� ���
SELECT EMPNO, ENAME, JOB, SAL,
	CASE -- ������'='�� �ƴ� �ٸ� �������� �ϰ� ������ �˻��� �� ���� X
		WHEN SAL <= 1000 THEN SAL * 0.08 -- ���ǽĿ��� �˻��� �� ����
		WHEN SAL <= 3000 THEN SAL * 0.1
		WHEN SAL <= 5000 THEN SAL * 0.13
		ELSE SAL * 0.15
	END AS TAX
FROM EMP;

SELECT EMPNO, ENAME, JOB, SAL,
	CASE -- ������'='�� �ƴ� �ٸ� �������� �ϰ� ������ �˻��� �� ���� X
		WHEN SAL <= 1000 THEN '1000 ����' -- ���ǽĿ��� �˻��� �� ����
		-- SAL > 1000
		WHEN SAL <= 3000 THEN '1000 �ʰ� ~ 3000 ����'
		--- SAL > 3000
		WHEN SAL <= 5000 THEN '3000 �ʰ� ~ 5000 ����'
		ELSE '5000 �ʰ�'
	END AS TAX
FROM EMP;

-- Q2. EMP ���̺��� ENAME�� 'A'��� ���ڰ� �� �ִٸ� '�����մϴ�', 
-- 'A'��� ���ڰ� �� ���� �ʴٸ� '�������� �ʽ��ϴ�'�� ��� �̸��� �Բ� ���
-- LIKE + wildcard, INSTR()

-- a. LIKE
SELECT ENAME, 
	CASE
		WHEN ENAME LIKE '%A%' THEN '�����մϴ�'
		ELSE '�������� �ʽ��ϴ�'
	END AS ISAINCLUDED
FROM EMP;

-- ��� �̸� (��ҹ��� �������� �ʰ�) �� �� ���� 'A'('a')�� ���ִ��� Ȯ��
SELECT ENAME, 
	CASE
		WHEN ENAME LIKE '%A%' OR ENAME LIKE '%a%' THEN '�����մϴ�'
		ELSE '�������� �ʽ��ϴ�'
	END AS ISAINCLUDED
FROM EMP;

SELECT ENAME, 
	CASE
		WHEN UPPER(ENAME) LIKE '%A%' THEN '�����մϴ�'
		ELSE '�������� �ʽ��ϴ�'
	END AS ISAINCLUDED
FROM EMP;

-- b. INSTR()
-- : ã������ �ϴ� ���ڰ� �˻��� �Ǹ� ã������ �ϴ� ���ڰ� �˻��� �ε��� ��ȯ
-- : ã�� ���ϸ� 0�� ��ȯ
-- => INSTR() > 0 : ã������ �ϴ� ���ڸ� ã�Ҵ� !!
SELECT ENAME, 
	CASE
		WHEN INSTR(ENAME, 'A') > 0 THEN '�����մϴ�'
		ELSE '�������� �ʽ��ϴ�'
	END AS ISAINCLUDED
FROM EMP;

-- ��� �̸��� ��ҹ��� �������� 'A'('a') ��� �˻� �����ϰ� ������� ... ?
SELECT ENAME, 
	CASE
		WHEN INSTR(UPPER(ENAME), 'A') > 0 THEN '�����մϴ�'
		ELSE '�������� �ʽ��ϴ�'
	END AS ISAINCLUDED
FROM EMP;

-- ���� ����� �� ������� ..?
-- EX) ��� �̸��� Ư�� ���� �ִ��� �˻��ϰ� ���� ���
-- EX) {'ABC', 'abc', 'ccc', 'ddd',  'qwf'}: �ߺ��� �̸� �˻� 'ABC', 'abc' 
-- 'Eunbin', 'eunbin', 'EUNBIN'




-- Q3. EMP ���̺��� �߰� ���� (COMM)�� ���� 
-- ���࿡ COMM�� NULL�̸� '�ش���� ����'
-- ���࿡ COMM = 0�̸� '�߰����� ����'
-- ���࿡ COMM�� 0���� ũ�� �߰� ������ ���
SELECT EMPNO, ENAME, COMM, 
	CASE
		WHEN COMM IS NULL THEN '�ش���� ����' -- VARCHAR
		WHEN COMM = 0 THEN '�߰����� ����' -- VARCHAR
		WHEN COMM > 0 THEN COMM -- NUMBER
		-- **DECODE(), CASE���� ��ȯ���� ���������� ��ġ!**
		-- WHY ? 
		-- ������ ���� ����� �������� ������ ����
	END AS COMM_STR
FROM EMP;
-- => ���� �߻�: ORA-00932: ��ġ���� ���� ������ Ÿ��!

SELECT EMPNO, ENAME, COMM, 
	CASE
		WHEN COMM IS NULL THEN '�ش���� ����' -- VARCHAR
		WHEN COMM = 0 THEN '�߰����� ����' -- VARCHAR
		WHEN COMM > 0 THEN '' || COMM -- NUMBER -> VARCHAR �Ͻ��� �� ��ȯ
		-- **DECODE(), CASE���� ��ȯ���� ���������� ��ġ!**
		-- WHY ? 
		-- ������ ���� ����� �������� ������ ����
	END AS COMM_STR
FROM EMP;

SELECT EMPNO, ENAME, COMM, 
	CASE
		WHEN COMM IS NULL THEN '�ش���� ����' -- VARCHAR
		WHEN COMM = 0 THEN '�߰����� ����' -- VARCHAR
		WHEN COMM > 0 THEN TO_CHAR(COMM) -- NUMBER -> VARCHAR ����� �� ��ȯ
		-- **DECODE(), CASE���� ��ȯ���� ���������� ��ġ!**
		-- WHY ? 
		-- ������ ���� ����� �������� ������ ����
	END AS COMM_STR
FROM EMP;

-- Q4. EMP ���̺��� �Ի��� (HIREDATE)�� ���� (ADD_MONTHS(), /, MONTHS_BETWEEN())
-- ���࿡ �ش� ����� 40�� �̻� '40�ֳ� �̻�'
-- ���࿡ �ش� ����� 40�� �̸� '40�ֳ� �̸�' ���


SELECT EMPNO, ENAME, HIREDATE, 
	CASE
		WHEN TO_CHAR(ADD_MONTHS(HIREDATE, 40*12), 'YYYY/MM/DD') 
			<= TO_CHAR(SYSDATE, 'YYYY/MM/DD')
		THEN '40�ֳ� �̻�'
		ELSE '40�ֳ� �̸�'
	END AS ISYEAR40
FROM EMP;

-- 1�� 365��, 366�� => ��Ȯ���� ����
SELECT EMPNO, ENAME, HIREDATE, 
	CASE
		WHEN TRUNC((SYSDATE - HIREDATE)) / 365 >= 40 THEN '40�ֳ� �̻�'
		ELSE '40�ֳ� �̸�'
	END AS ISYEAR40
FROM EMP;

SELECT EMPNO, ENAME, TO_CHAR(HIREDATE, 'YYYY/MM/DD') AS HIREDATE_WOCLOCK, 
	CASE
		WHEN TRUNC(MONTHS_BETWEEN(SYSDATE, HIREDATE)) >= 40 * 12 THEN '40�ֳ� �̻�'
		ELSE '40�ֳ� �̸�'
	END AS ISYEAR40
FROM EMP;



-- Q5. EMP ���̺��� ��� ��ȣ (EMPNO)�� �� �� �ڸ��� �����Ͽ� (SUBSTR())
-- ���࿡ �� ���ڸ��� 73�̸� 3333���� ���
-- ���࿡ �� ���ڸ��� 74�̸� 4444���� ���
-- ���࿡ �� ���ڸ��� 75�̸� 5555���� ���
-- �̿��� �� ���ڸ��� ��� ���� �����ȣ �״�� ���
SELECT EMPNO, 
	CASE
		WHEN SUBSTR(EMPNO, 1, 2) = '73' THEN '3333' 
		-- SUBSTR(������) => ������ -> ������ (�Ͻ��� �� ��ȯ)
		WHEN SUBSTR(EMPNO, 1, 2) = '74' THEN '4444'
		WHEN SUBSTR(EMPNO, 1, 2) = '75' THEN '5555'
		ELSE '' || EMPNO -- NUMBER -> CHAR (TO_CHAR(), ||, CONCAT())
	END AS EMPNO_REVISED
FROM EMP;

SELECT EMPNO, 
	CASE
		WHEN SUBSTR(EMPNO, 1, 2) = '73' THEN 3333
		WHEN SUBSTR(EMPNO, 1, 2) = '74' THEN 4444
		WHEN SUBSTR(EMPNO, 1, 2) = '75' THEN 5555
		ELSE EMPNO
	END AS EMPNO_REVISED
FROM EMP;

SELECT EMPNO, 
	CASE
		WHEN EMPNO LIKE '73%' THEN 3333
		WHEN EMPNO LIKE '74%' THEN 4444
		WHEN EMPNO LIKE '75%' THEN 5555
		ELSE EMPNO
	END AS EMPNO_REVISED
FROM EMP;

SELECT EMPNO, 
	CASE SUBSTR(EMPNO, 1, 2)
		WHEN '73' THEN 3333
		WHEN '74' THEN 4444
		WHEN '75' THEN 5555
		ELSE EMPNO
	END AS EMPNO_REVISED
FROM EMP;

SELECT EMPNO, 
	DECODE (SUBSTR(EMPNO, 1, 2),
		'73', '3333',
		'74', '4444',
		'75', '5555',
		EMPNO) -- '����' => '����' (�Ͻ��� �� ��ȯ)
	AS EMPNO_REVISED
FROM EMP;


-- �Ѱι �ڵ�
SELECT EMPNO, -- ������
       CASE 
            WHEN SUBSTR(EMPNO,1,2) = '73' THEN '3333'
            WHEN SUBSTR(EMPNO,1,2) = '74' THEN '4444'
            WHEN SUBSTR(EMPNO,1,2) = '75' THEN '5555'
            WHEN EMPNO IS NULL THEN 'N/A'
            ELSE TO_CHAR(EMPNO)
        END AS EMPNO_REVISED
FROM EMP;

SELECT EMPNO, -- ������
       CASE
	        WHEN SUBSTR(EMPNO,1,2) = '73' THEN 3333
	        WHEN SUBSTR(EMPNO,1,2) = '74' THEN 4444
	        WHEN SUBSTR(EMPNO,1,2) = '75' THEN 5555
	    	WHEN EMPNO IS NULL THEN 0000
	        ELSE EMPNO
        END AS EMPNO_REVISED
FROM EMP;

-- DECODE() VS CASE��
-- DECODE() => ���� �߿� =�� ���� �� ����
-- CASE�� => ���ǽĿ� �پ��� ������ ���� �� ���� (���� ���� ���)
-- CASE ������ ��� (�� �̸�, ����)
--  	WHEN A
--      WHEN B
-- ������ ��� = 'A'
-- ������ ��� = 'B'





-- "��ȯ�� ����"
-- '3333' => VARCHAR
-- TO_CHAR(EMPNO) => NUMBER -> VARCHAR

-- 3333 => NUMBER
-- EMPNO => NUMBER


-- * CASE, DECODE() ���Ǻ��� ��ȯ���� "������ ������ Ÿ��"
-- * CASE�� �پ��� ���� ��� ���� (IS NULL�� NULL�� Ȯ�� ����)


-- ����� ����
SELECT EMPNO, ENAME, MGR, 
	CASE SUBSTR(MGR, 1, 2)
		WHEN '75' THEN 5555
		WHEN '76' THEN 6666
		WHEN '77' THEN 7777
		WHEN '78' THEN 8888
		WHEN NULL THEN 0000 -- IS NULL�� �ν� X
		ELSE MGR
	END AS CHG_MGR
FROM EMP;


SELECT EMPNO, ENAME, MGR, 
	CASE 
		WHEN SUBSTR(MGR, 1, 2) = '75' THEN 5555
		WHEN SUBSTR(MGR, 1, 2) = '76' THEN 6666
		WHEN SUBSTR(MGR, 1, 2) = '77' THEN 7777
		WHEN SUBSTR(MGR, 1, 2) = '78' THEN 8888
		WHEN SUBSTR(MGR, 1, 2) IS NULL THEN 0000 
		ELSE MGR
	END AS CHG_MGR
FROM EMP;

SELECT EMPNO, ENAME, MGR, 
	DECODE(SUBSTR(MGR, 1, 2),
		75, 5555,
		76, 6666, 
		77, 7777,
		78, 8888,
		NULL, 0000, -- IS NULL�� �ν� O
		MGR
	) AS CHG_MGR
FROM EMP;

