-- ���� �Լ� (built-in function): ����Ŭ���� �������ִ� �Լ�

SELECT * FROM EMP WHERE UPPER(ENAME) LIKE '%A%';

-- 1) ������ �Լ� (single-row function)

-- ������ �Լ�
SELECT ENAME, UPPER(ENAME), LOWER(ENAME), LENGTH(ENAME) FROM EMP;
SELECT ENAME, SUBSTR(ENAME, 3) FROM EMP; 
-- SUBSTR(���ڿ� ������, ���� ��ġ): ���� ��ġ ~ ���ڿ� ������ ������ ����
-- SUBSTR(���ڿ� ������, ���� ��ġ, ���� ����): ���� ��ġ���� ���� ���̸�ŭ ����
-- (*) ���� ��ġ�� ������ �� 0���Ͱ� �ƴ϶� 1���� ����
-- EX) SMITH => 3��° ���� 'I'

SELECT * FROM EMP;

-- Q1. MGR���� �ڿ� �� ���� (98, 39 ...)�� ������ ���ڿ��� ������ �Բ� ���
-- (MGR�� NULL�� ����)

-- ���ڿ��� ���̸� �˰ų� ª�� ���
SELECT MGR, SUBSTR(MGR, 3, 2) FROM EMP WHERE MGR IS NOT NULL;
SELECT MGR, SUBSTR(MGR, 3) FROM EMP WHERE MGR IS NOT NULL;

-- ���ڿ��� ���̸� �𸣰ų� �� ���
-- 7902 => 0�� �ε���: 3, -2, LENGTH(MGR)-1
-- ����:    7    9    0     2
-- �ε���:   1    2    3    4
-- �ε���:  -4   -3   -2   -1
-- �ε���: l-3   l-2  l-1   l
-- l: LENGTH(MGR) = 4

-- S: 'AAAAABBBBSDQSAD'
-- �� �ڿ� �ִ� D ������ ��ġ
-- 15, -1, LENGTH(S)

SELECT MGR, SUBSTR(MGR, LENGTH(MGR)-1, 2) FROM EMP WHERE MGR IS NOT NULL;
SELECT MGR, SUBSTR(MGR, LENGTH(MGR)-1) FROM EMP WHERE MGR IS NOT NULL;
SELECT MGR, SUBSTR(MGR, -2) FROM EMP WHERE MGR IS NOT NULL;
SELECT MGR, SUBSTR(MGR, -2, 2) FROM EMP WHERE MGR IS NOT NULL;


-- Q2. ENAME���� �߰� ���� ������ ���ڿ��� ������ �Բ� ���
-- EX) ALLEN => 'L', KING => 'IN'
-- (MOD(����, ���� ����) �����ڸ� �̿�)

SELECT EMPNO, ENAME, SUBSTR(ENAME, LENGTH(ENAME)/2+1, 1) AS MIDDLENAME
FROM EMP
WHERE MOD(LENGTH(ENAME), 2) <> 0 -- ���ڿ��� ���̰� Ȧ��
UNION
SELECT EMPNO, ENAME, SUBSTR(ENAME, LENGTH(ENAME)/2, 2) AS MIDDLENAME2
FROM EMP 
WHERE MOD(LENGTH(ENAME), 2) = 0; -- ���ڿ��� ���̰� ¦��

-- INSTR �Լ�
-- : Ư�� ����(��)�� ��� ���ԵǾ��ִ��� �˰��� �� �� 

-- INSTR(��� ���ڿ�, ã������ �ϴ� ����(��), ���� �ε���, �� ��° ���� (�˻� ����� ���� ���� ���))
-- : ���࿡ ã������ �ϴ� ���ڰ� ������ 0 ��ȯ

-- LIKE '%S%'
-- INSTR(���ڿ�, 'S') > 0

-- : ���� �ε����� ������ ���� �����ʺ��� -> ���� �������� �˻�

-- DUAL
-- : DUMMY TABLE
-- : �����̳� ����� ��� �����ִ� �� ����ϴ� ���̺� 
SELECT * FROM DUAL;

SELECT INSTR('HELLO', 'L') AS L_INSTR
FROM DUAL;
-- HE(L)LO: ù��°�� ã�� L�� ��ġ ��ȯ

SELECT INSTR('HELLO', 'L', 1, 2) AS L_INSTR
FROM DUAL;
--  HEL(L)O: �ι�°�� ã�� L�� ��ġ ��ȯ

SELECT INSTR('HELLO', 'A') AS L_INSTR
FROM DUAL;
-- ���ڿ� �ȿ��� ã������ �ϴ� ���ڰ� ���� ��쿡�� 0�� ��ȯ

-- ���� �ε����� ������ �Ǹ� ������ -> ����
SELECT INSTR('HELLO', 'L', -1) AS L_INSTR
FROM DUAL;
--  HEL(L)O: �ڿ������� ù��°�� ã�� L�� ��ġ ��ȯ

SELECT INSTR('HELLO', 'L', -1, 2) AS L_INSTR
FROM DUAL;
--  HE(L)LO: �ڿ������� �ι�°�� ã�� L�� ��ġ ��ȯ

-- EMP ���̺��� ��� �̸��� 'K'�� ���ԵǴ� ��� �̸� ���
-- EX) LIKE '%K%'
SELECT ENAME
FROM EMP
WHERE ENAME LIKE '%K%'; -- INSTR()

SELECT ENAME
FROM EMP
WHERE INSTR(ENAME, 'K') > 0;

-- REPLACE �Լ�
-- : Ư�� ���ڸ� �ٸ� ���ڷ� �ٲٴ� �Լ�
-- REPLACE(���ڿ�/�� �̸�, ã�� ����, ��ü�� ���� (����))
-- (*) ��ü�� ���ڰ� ������ ���ڿ� �����Ϳ��� ����

SELECT '801111-1234567' AS REGNUM, REPLACE('801111-1234567', '-', ' ') AS REP_REGNUM
FROM DUAL;

-- EX) ���¹�ȣ, �ֹε�Ϲ�ȣ, �ڵ�����ȣ ��� Ư�� ���ڸ� �����ϰų� ��ü�ϰ� ���� ��


-- ������ �� ������ Ư�� ���ڷ� ä��� �Լ�
-- LPAD (Left Padding)
-- RPAD (Right Padding)
-- LPAD/RPAD(���ڿ�/�� �̸�, ������ �ڸ���, �е��� ���� (����))
-- (*) �е��� ���ڰ� ������ �� ������ �ڸ�����ŭ ���� ���ڷ� ä��

SELECT 'ORACLE', LPAD('ORACLE', 4, '*'), RPAD('ORACLE', 4, '*') FROM DUAL;
SELECT 'ORACLE', LPAD('ORACLE', 10), RPAD('ORACLE', 10) FROM DUAL;

-- java left padding: String.format("%10s", "ORACLE").replace(' ', '*')
-- java right padding: String.format("%-10s", "ORACLE").replace(' ', '*')

-- Q1. �ֹε�Ϲ�ȣ '801111-1234567' => '801111-*******'
SELECT '801111-1234567' AS REG, 
RPAD(SUBSTR('801111-1234567', 1, 7), LENGTH('801111-1234567'), '*') AS RPAD_REG 
FROM DUAL;

-- ���࿡ �������� �ϴ� ���ڿ����� ������ �ڸ����� ���� ��쿡�� ���ڿ� �ս� (�߸�)
SELECT 'ORACLE', LPAD('ORACLE', 5), RPAD('ORACLE', 5) FROM DUAL;


-- CONCAT �Լ�
-- : �� ���ڿ��� �ϳ��� ����

-- ������ => ||
SELECT CONCAT(EMPNO, ENAME) AS ID FROM EMP;
SELECT EMPNO || ENAME AS ID FROM EMP;

-- TRIM, LTRIM, RTRIM
-- ���ڿ� ���� Ư�� ���ڸ� ����� ���� ���

-- �⺻��: ���� ����
SELECT TRIM('               �ȳ��ϼ���!           ') AS TRIM_STR
FROM DUAL;

-- Ư�� ���� ����� (���࿡ _�� ���������� ���� ��쿡�� �ٸ� ���ڰ� ���� �������� TRIM ���� ����)
-- (*) TRIM�� ���� ���� ���� ���� X 
SELECT TRIM('_' FROM '___ ______�ȳ��ϼ���!_____ ___') AS TRIM_STR
FROM DUAL;

-- (*) LTRIM, RTRIM�� ���� ���� ���� ���� O
SELECT LTRIM('___ ______�ȳ��ϼ���!_____ ___', '_ ') AS TRIM_STR
FROM DUAL;
SELECT RTRIM('___ ______�ȳ��ϼ���!_____ ___', '_ ') AS TRIM_STR
FROM DUAL;


SELECT TRIM(LEADING '_' FROM '___ ______�ȳ��ϼ���!_____ ___') AS TRIM_STR
FROM DUAL;
SELECT TRIM(TRAILING '_' FROM '___ ______�ȳ��ϼ���!_____ ___') AS TRIM_STR
FROM DUAL;

-- Q1. <title>My Page</title> => My Page
SELECT RTRIM(LTRIM('<title>My Page</title>', '<title>'), '</title>') AS CRAWLING FROM DUAL;
-- My Page�� e�� ���� ����� => '</title>'�� e�� ������ �Ǿ��ֱ� ������ ���� �����


-- ������ �Լ�
-- ROUND: �ݿø� �Լ� 
SELECT ROUND(12.54, 0) AS ROUND FROM DUAL; -- �Ҽ��� 0��°���� ǥ��!
SELECT ROUND(15.54, -1) AS ROUND FROM DUAL; -- �Ҽ��� -1��°���� ǥ��!

-- TRUNC: ���� �Լ�
-- : ������ �ڸ����� ���� ���� (������ �ڸ����� ������ �� ����)
-- : ���� ������ �ڸ����� �������� ������ �Ҽ��� 0��° �ڸ����� ǥ��
SELECT TRUNC(1234.5678, 2) AS TRUNC FROM DUAL; -- �Ҽ��� �ι�° �ڸ����� ǥ��
SELECT TRUNC(1236.5678, -1) AS TRUNC FROM DUAL; -- �Ҽ��� -1��° �ڸ����� ǥ��

-- FLOOR: ���� �Լ� 
SELECT FLOOR(1234.5678) AS FLOOR FROM DUAL; -- �Ҽ��� ���� ���� (����� ���� ������ ǥ��)

-- CEIL: �ø� �Լ�
SELECT CEIL(1234.4678) AS CEIL FROM DUAL; -- �Ҽ��� ���� �ø� (����� ū ������ ǥ��)

-- MOD: ������ �Լ�
SELECT MOD(10, 2) AS MOD FROM DUAL;


-- ��¥�� �Լ�
-- SYSDATE
-- : ORACLE DB�� ��ġ�� OS (�ü��)�� �ð�
SELECT SYSDATE FROM DUAL;

-- ADD_MONTHS
-- : Ư�� ��¥�� ������ ���� ����ŭ ���� ��¥ ������ ��ȯ
-- ADD_MONTHS(��¥ ������, ���� ���� ��)
SELECT SYSDATE, ADD_MONTHS(SYSDATE, 3) FROM DUAL; -- ���� �ý��� �ð��� 3���� ��
SELECT SYSDATE, ADD_MONTHS(SYSDATE, -3) FROM DUAL; -- ���� �ý��� �ð��� 3���� ��

-- Q1. EMP ���̺��� �������  �ٹ� �ϼ� ���
SELECT ROUND(SYSDATE - HIREDATE) AS WORKDAYS FROM EMP;

-- Q2. EMP ���̺��� �Ի����� 40���� �Ѵ� ������� ��� ���� ���
SELECT * FROM EMP WHERE ADD_MONTHS(HIREDATE, 40 * 12) < SYSDATE;
SELECT * FROM EMP WHERE (SYSDATE - HIREDATE) / 365 > 40;

-- Q3. EMP ���̺��� ������� 10�ֳ��� �Ǵ� ��¥�� ��� �̸��� ���� ���
SELECT ENAME, HIREDATE, ADD_MONTHS(HIREDATE, 10 * 12) 
AS WORK_10_YEAR 
FROM EMP;

-- MONTHS_BETWEEN
-- : �� ��¥ ������ ���� �� ���� ��� �Լ�
-- (*) MONTHS_BETWEEN(��¥ ������1, ��¥ ������2)
-- ��¥ ������1 - ��¥ ������2�� ���� ���� ����ϱ� ������ ���� ����!

-- ������� �� ���� ���ߴ��� ��� 
SELECT MONTHS_BETWEEN(HIREDATE, SYSDATE) AS MONTH1, -- HIREDATE - SYSDATE
MONTHS_BETWEEN(SYSDATE, HIREDATE) AS MONTH2 -- SYSDATE - HIREDATE
FROM EMP;


-- NEXT_DAY(), LAST_DAY()
-- NEXT_DAY(��¥ ������, ���� ����) 
-- : Ư�� ��¥�� �������� ���ƿ��� ���� ��¥ ���
-- EX) 2021/12/27 => 2: 2022/1/3
--                            1: 2022/1/2
--                            3: 2021/12/28
-- ���� ����
-- 1: '��'
-- 2: '��'
-- 3: 'ȭ'
-- .....

-- LAST_DAY(��¥ ������)
-- : Ư�� ��¥�� ���� ���� ������ ��¥ ���

SELECT SYSDATE, NEXT_DAY(SYSDATE, 5), LAST_DAY(SYSDATE) FROM DUAL;


-- ROUND, TRUNC
-- : ���ڿ��� �����ϴ� �Լ� -> ��¥������ ����!
-- (*) �Ҽ��� �ڸ��� ǥ������ �ʰ� �ݿø�/������ ������ �� ���� ����

-- ROUND(��¥ ������, �ݿø� ���� ����)
-- TRUNC(��¥ ������, ���� ���� ����)

-- ���˰�
-- YYYY, YYY, YY, Y: ��¥ �����Ϳ��� 7�� 1�� ����
-- DD, DDD: �ش� �Ͽ��� ���� (12:00:00) ����
-- HH, HH12, HH24: �ش� ���� �ð� ����


SELECT ROUND(SYSDATE, 'YYYY') AS FORMAT_YYYY FROM DUAL; 
-- 7�� 1���� �Ѿ��� ������ 2022������ �ݿø�

SELECT ROUND(SYSDATE, 'DD') AS FORMAT_DD FROM DUAL; 
-- �ð��� ������ ���� �ʾұ� ������ 12�� 27�Ϸ� �ݿø�

SELECT ROUND(SYSDATE, 'HH') AS FORMAT_DD FROM DUAL; 
-- ���� �ð��� 11:40���̴ϱ� 12�÷� �ݿø�

-- �� ��ȯ
-- 1) �Ͻ��� �� ��ȯ
-- ������ + ������ -> ���� �������� ���ڷ� ��ȯ�� ������ ��쿡�� ������ �ڵ� ����ȯ
SELECT EMPNO + '500' FROM EMP; -- EMPNO (����) + '500' (���ڷ� �ν� ����) => ���� O
SELECT EMPNO + 'AAA' FROM EMP; -- EMPNO (����) + 'AAA' (���ڷ� �ν� �Ұ�) => ���� X
SELECT EMPNO || 'AAA' FROM EMP; -- EMPNO (���ڷ� �ν� ����) || 'AAA' (����) => ���� O


-- 2) ����� �� ��ȯ
-- �� ��ȯ �Լ� 
-- ��¥�� -> ������: TO_CHAR
-- (*) TO_CHAR(��¥ ������, ����ϰ��� �ϴ� ���ڿ�)
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS') AS NOW FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'YYYY/MM/DD HH12:MI:SS AM') AS NOW FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'YYYY/MM/DD HH12:MI:SS AM DAY') AS NOW FROM DUAL;
SELECT TO_CHAR(HIREDATE, 'YYYY/MM/DD W') AS NOW FROM EMP;
SELECT TO_CHAR(SYSDATE, 'YYYY/MM/DD HH12:MI:SS AM DAY',
'NLS_DATE_LANGUAGE = AMERICAN') AS DAY FROM DUAL;

-- ������ -> ��¥��: TO_DATE
-- (*) TO_DATE(���ڿ� ������, �νĵǾ�� �� ���� ����)
SELECT TO_DATE('2021-12-27', 'YYYY-MM-DD') AS TODATE FROM DUAL;
SELECT TO_DATE('2021/12/27', 'YYYY/MM/DD') AS TODATE FROM DUAL;

-- Q1. EMP ���̺��� �Ի����� 1981�� 7�� 20�� ������ ��� ���� ���
-- (*) DATE������ ũ�� �� ������ ����, >, <, >=, <=
SELECT * FROM EMP WHERE HIREDATE > TO_DATE('1981-07-20', 'YYYY-MM-DD');


-- ������ -> ������: TO_NUMBER
-- TO_NUMBER(���ڿ� ������, �νĵǾ�� �� ���� ����)

SELECT 5000 - TO_NUMBER('$3000', '$9,999') FROM DUAL; 
-- ���� (FORMAT�� ���� ����)
SELECT 5000 - TO_NUMBER('$3,000', '$9,999') FROM DUAL; 
SELECT 5000 - TO_NUMBER('$300', '$9,999') FROM DUAL; 
-- 9: �� �ڸ����� �� �� �ִ� ���� �ִ� 
SELECT 5000 - TO_NUMBER('$3,000', '$1,000') FROM DUAL; 
-- ���� (�ִ�� ǥ���� �� �ִ� �� �ȿ� ���� ����)

-- ���� ���� �ۼ��� �� �����ؾ��� ��
-- 1) �ڸ��� Ȯ��
-- 2) �� �ڸ����� �ִ�� ǥ���� �� �ִ� �� �ȿ� ����� Ȯ��

-- NULL ó�� �Լ�
-- (*) ���/�� �����ڿ��� NULL�� ������ ������ ��� NULL
SELECT ENAME, SAL, COMM, SAL*12+COMM AS ANNUALSAL FROM EMP;

-- 1) NVL (NULL VALUE)
-- NVL(NULL���� ���θ� �˻��� ������/��, ���� ���ڰ� NULL�� ��� ��ü�� ������)
-- : NULL�� �ƴϸ� �����Ͱ� �״�� ��ȯ
-- : NULL�̸� �� ��° ���ڷ� NULL���� ��ü�� �� ����
-- (*) ��ü�� ������ �ڷ��� == ���� ������ �ڷ���

SELECT ENAME, SAL, COMM, 
SAL*12+COMM AS ANNUALSAL,
SAL*12+NVL(COMM, 0) AS ANNUALSAL_NVL
FROM EMP;

-- 2) NVL2
-- NVL2(NULL���� ���θ� �˻��� ������/��, 
-- ���� ���ڰ� NULL�� �ƴ� ��� ��ü�� ������, 
-- ���� ���ڰ� NULL�� ��� ��ü�� ������)
SELECT ENAME, SAL, COMM, 
SAL*12+COMM AS ANNUALSAL,
SAL*12+NVL(COMM, 0) AS ANNUALSAL_NVL,
SAL*12+NVL2(COMM, COMM, 0) AS ANNUALSAL_NVL2,
NVL2(COMM, 'O', 'X') AS ISCOMM
FROM EMP;

-- Q1. COMM NULL, 0 => 'X', ������ ���� => 'O'
SELECT ENAME, SAL, COMM, 
REPLACE(COMM, 0, NULL) AS REPLACE_ORIGINAL,
RPAD(REPLACE(COMM, 0, NULL), LENGTH(COMM), 0) AS REPLACE, 
NVL2(RPAD(REPLACE(COMM, 0, NULL), LENGTH(COMM), 0), 'O', 'X') AS ISCOMM 
FROM EMP;
-- 301�̶�� ���ڴ� ������ ���� �� ����

SELECT ENAME, SAL, COMM, NVL2(COMM, 'O', 'X') AS ISCOMM FROM EMP;

-- NVL VS NVL2
-- NVL2: NULL�� �ƴ� ��쿡�� ��ȯ �����ͱ��� ������ �� ����
-- NVL�� �� ���� ���

-- ���ǹ� (DECODE �Լ�, CASE��)
-- : NULL ���� �ƴ� ��쿡�� Ư�� �� / ������ ���� ���� ��ȯ�� �����͸� ����
-- (Java���� if, switch-case���� ���)

-- DECODE
-- : �˻��� �� / �����Ϳ� ���� ��ȣ ���� �ۿ� ������ �� ���� (switch-case��)

-- DECODE(�˻��� �� / ������,
--                ����1, ��ȯ ��,
--                ����2, ��ȯ ��,
--                ......
--                ���� ���ǿ� �ش����� ���� �� ��ȯ�� ��)
-- * ���� ���ǿ� �ش����� ���� �� ��ȯ�� �� (else��)�� �������� ������ NULL�� ��ȯ


-- EX) EMP ���̺��� ��å�� ���� �޿� �λ���� ����
-- A. MANAGER: 10% -> 0.1
-- B. SALESMAN: 5% -> 0.05
-- C. ������ �� ���� ��å: 3% -> 0.03

SELECT EMPNO, ENAME, JOB, SAL,
    ROUND(DECODE(JOB,
                'MANAGER', SAL+SAL*0.1, -- SAL*1.1
                'SALESMAN', SAL+SAL*0.05, -- SAL*1.05
                SAL+SAL*0.03)) -- SAL*1.03
    AS NEWSAL
FROM EMP;

-- Q1. COMM NULL, 0 => 'X', ������ ���� => 'O'
SELECT EMPNO, ENAME, SAL, COMM,
    DECODE(COMM,
                NULL, 'X', -- COMM IS NULL (COMM = NULL (X))
                0, 'X',
                'O')
    AS ISCOMM
FROM EMP;


-- CASE �� (�Լ� �ƴ�)
-- : CASE ������ �پ��� ���ǽ��� �� ���� ����
-- : CASE ���� �� ���� ����� (DECODE�� ����)
-- * ���� ���ǿ� �ش����� ���� �� ��ȯ�� �� (else��)�� �������� ������ NULL�� ��ȯ

-- CASE �˻��� �� / ������
-- WHEN ����1 THEN ��ȯ��
-- WHEN ����2 THEN ��ȯ��
-- .....
-- ELSE ���� ���ǿ� �ش����� ���� �� ��ȯ�� ��
-- END

-- CASE 
-- WHEN ����1 (�˻��� �� / ������) THEN ��ȯ��
-- WHEN ����2 (�˻��� �� / ������) THEN ��ȯ��
-- .....
-- ELSE ���� ���ǿ� �ش����� ���� �� ��ȯ�� ��
-- END

-- EX) EMP ���̺��� ��å�� ���� �޿� �λ���� ����
-- A. MANAGER: 10% -> 0.1
-- B. SALESMAN: 5% -> 0.05
-- C. ������ �� ���� ��å: 3% -> 0.03
SELECT EMPNO, ENAME, JOB, SAL,
    CASE JOB -- 'JOB =' ����
        WHEN 'MANAGER' THEN ROUND(SAL+SAL*0.1)
        WHEN 'SALESMAN' THEN ROUND(SAL+SAL*0.05)
        ELSE ROUND(SAL+SAL*0.03)
    END AS NEWSAL
FROM EMP;

SELECT EMPNO, ENAME, JOB, SAL,
    CASE 
        WHEN JOB = 'MANAGER' THEN ROUND(SAL+SAL*0.1)
        WHEN JOB = 'SALESMAN' THEN ROUND(SAL+SAL*0.05)
        ELSE ROUND(SAL+SAL*0.03)
    END AS NEWSAL
FROM EMP;

-- Q1. SAL�� ������ ����� ���� ���� �����Ѵٰ� ����
-- SAL <= 1000 => 8%
-- SAL <= 3000 => 10%
-- SAL <= 5000 => 13%
-- �̿��� SAL => 15%
SELECT EMPNO, ENAME, SAL,
    CASE
        WHEN SAL <= 1000 THEN SAL*0.08 -- SAL <= 1000
        WHEN SAL <= 3000 THEN SAL*0.1 -- 1000 < SAL <= 3000
        WHEN SAL <= 5000 THEN SAL*0.13 -- 3000 < SAL <= 5000
        ELSE SAL*0.15 -- SAL > 5000
    END AS TAX
FROM EMP;


-- Q2. EMP ���̺��� ENAME�� 'A'��� ���ڰ� �� ������ 'A�� �����մϴ�'
-- 'A'��� ���ڰ� �� ���� �ʴٸ� 'A�� �������� �ʽ��ϴ�'�� ��� �̸��� �Բ� ���
-- (�������� ��ҹ��� �������� �ʰ� ���ĺ� A(a)�� ���ԵǾ��ִ��� Ȯ��)

-- ���̺� �̸��̳� �� �̸��� ��ҹ��� ���� X
select * from emp WHERE EMPNO = 7369;
SELECT * FROM EmP WHERE empno = 7369;
SELECT * FROM EMP where EmpNo = 7369;

-- ���̺� �� ������ ��ü�� ��ҹ��� ���� O
-- (���̺� �����͸� ��� �����ߴ� ���� ���� �޶���)

--  1) LIKE ������ + ���ϵ� ī��
SELECT ENAME, 
    CASE
        WHEN UPPER(ENAME) LIKE '%A%' THEN 'A(a)�� �����մϴ�'
        ELSE 'A(a)�� �������� �ʽ��ϴ�'
    END AS CONTAINSA
FROM EMP;

--  2) INSTR()
SELECT ENAME, 
    CASE
        WHEN INSTR(UPPER(ENAME), 'A') > 0 THEN 'A(a)�� �����մϴ�'
        ELSE 'A(a)�� �������� �ʽ��ϴ�'
    END AS CONTAINSA
FROM EMP;


select hiredate from emp where ename = 'KING';
-- Q3. KING�� HIREDATE�� ���Ͽ� 
-- KING�� �Ի糯���� ���� ���Դٸ� 'PREV'�� ���
-- KING�� �Ի糯���� ���߿� ���Դٸ� 'AFTER'�� ��� ��ȣ, ��� �̸�, �Ի����ڿ� �Բ� ���
SELECT HIREDATE FROM EMP;

SELECT EMPNO, ENAME, HIREDATE, 
    CASE     
    WHEN HIREDATE < (SELECT HIREDATE FROM EMP WHERE ENAME = 'KING') THEN 'PREV'
    WHEN HIREDATE > (SELECT HIREDATE FROM EMP WHERE ENAME = 'KING') THEN 'AFTER'
    END AS HIREDATE_COMPARE_KING
FROM EMP;

SELECT EMPNO, ENAME, HIREDATE, 
    CASE     
    WHEN HIREDATE < TO_DATE('1981/11/17', 'YYYY/MM/DD') THEN 'PREV'
    WHEN HIREDATE > TO_DATE('1981/11/17', 'YYYY/MM/DD') THEN 'AFTER'
    END AS HIREDATE_COMPARE_KING
FROM EMP;

SELECT TO_DATE('81/11/17', 'YY/MM/DD') FROM DUAL;

-- Q4. EMP ���̺��� COMM�� ����
-- ���� COMM�� NULL�̸� '�ش���� ����'
-- ���� COMM = 0�̸� '�߰����� ����'
-- ���� COMM�� 0���� ũ�� �߰����� (COMM)�� ���
SELECT ENAME, COMM, 
    CASE
        WHEN COMM IS NULL THEN '�ش���� ����'
        WHEN COMM = 0 THEN '�߰����� ����'
        WHEN COMM > 0 THEN COMM || '' -- TO_CHAR(COMM)
    END AS ISCOMM
FROM EMP;


SELECT ENAME, COMM, 
    CASE COMM
        WHEN NULL THEN '�ش���� ����'    -- COMM = NULL (�߸��� ����)
        WHEN 0 THEN '�߰����� ����'
        ELSE TO_CHAR(COMM)
    END AS ISCOMM
FROM EMP;

SELECT ENAME, COMM, 
    DECODE(COMM, 
                NULL, '�ش���� ����',        -- COMM IS NULL
                0, '�߰����� ����',
                TO_CHAR(COMM)) AS ISCOMM
FROM EMP;

-- Q5. EMP ���̺��� HIREDATE�� ���� 
-- ���� �ش� ����� 40�� �̻� '40�ֳ� �̻�'
-- ���� �ش� ����� 40�� �̸� '40�ֳ� �̸�' ���
SELECT ENAME, HIREDATE, 
    CASE
        WHEN ADD_MONTHS(HIREDATE, 40 * 12) <= SYSDATE THEN '40�ֳ� �̻�'
        ELSE '40�ֳ� �̸�'
    END AS ISOVER40YEAR
FROM EMP;

SELECT * FROM EMP;
