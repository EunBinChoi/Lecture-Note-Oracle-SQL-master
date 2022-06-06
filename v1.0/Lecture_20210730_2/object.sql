/* ��ü (object) ����
 * 
 * - ���̺� (table): ������ ���� ����
 * - ������ ���� (data dictionary)
 * - �ε��� (index)
 * - �� (view)
 * - ������ (sequence)
 * - ���Ǿ� (synonym)
 * 
 * */

-- [������ ����]
-- DB ��ϴµ� �߿��� ������ ����
-- ������ ����� DB ��� �Ұ���
-- ������ ���� �� (view)�� ����
-- �� �� (view): ���̺� �Ϻ�/��ü�� ������ ���̺�� �� �� �ְ� ��ü

-- USER_XXXX: DB ���� ���� ����� ��ü ����
-- ALL_XXXX: ��� ��� ������ ��ü ����
-- DBA_XXXX: DB ����/����� ���� ���� 
		-- (SYSTEM, SYS�� ���� DBA ���� ����)
-- V$_XXXX: DB ���� ���� (X$_XXXX ���̺� ��)

-- SCOTT �������� ��� ������ ������ ����
SELECT * FROM DICT;
SELECT * FROM DICTIONARY;

SELECT * FROM DBA_USERS;


-- USER_: SCOTT�� ������ �ִ� ��ü
SELECT TABLE_NAME
FROM USER_TABLES;

-- ALL_: SCOTT ������ �� �� �ִ� ��� ��ü
SELECT OWNER, TABLE_NAME
FROM ALL_TABLES;

-- DBA_: DBA�� ���� ����ڸ� �� �� �ִ� ��ü
-- SCOTT DBA ������ ���� ��쿡�� TABLE DOES NOT EXIST!
-- "���� ���̺��� ������ �� �� �� ����!"
SELECT *
FROM DBA_TABLES;

-- DBA ������ ������ �ִ� ���� Ȯ��
SELECT *
FROM DBA_USERS;


-- [�ε��� (index)]
-- : DB���� ������ �˻� ���� ���
-- "INDEX SCAN" (�ε����� ���� ������ Ȯ��)
-- VS "TABLE FULL SCAN" (���� �� Ȯ��)

-- ���̺� �ε����� ������� ?
-- => �⺻Ű (primary key)

-- SCOTT ������ ���� �ε��� ���� Ȯ��
-- �ε����� ���� ���̺� �˻� 
SELECT *
FROM USER_INDEXES;

-- �ε����� ������ �� �̸� Ȯ��
SELECT *
FROM USER_IND_COLUMNS;

-- * �ε��� ���� ���� �������� ������
-- �⺻Ű�� �ڵ����� ����

-- 1) �ε��� ����
/* ����)
 * 
 * CREATE INDEX �ε��� �̸�
 * ON ���̺� �̸� (�� �̸�1 ASC OR DESC, -- �⺻: ASC
 * 				�� �̸�2 ASC OR DESC,
 * 				...
 * 				�� �̸�N ASC OR DESC)
 * 
 * */
SELECT * FROM EMP;

CREATE INDEX IDX_EMP_ENAME
ON EMP(ENAME);

SELECT * FROM USER_IND_COLUMNS;

-- SAL, COMM �ε����� ���� (IDX_EMP_SAL_COMM)
CREATE INDEX IDX_EMP_SAL_COMM
ON EMP(SAL, COMM);

SELECT * FROM USER_IND_COLUMNS;


-- �ε��� ����
-- ����) DROP INDEX �ε��� �̸�;
DROP INDEX IDX_EMP_SAL_COMM;
SELECT * FROM USER_IND_COLUMNS;

DROP INDEX IDX_EMP_ENAME;

-- �ε��� �߰�: CREATE
-- �ε��� ����: DROP
-- �ε��� �̸� ����: ALTER
-- �ε��� �� ����: �Ұ� (DROP -> CREATE)

/* �ε��� ��� ���� 
 * : ������ ��ȸ �ӵ� (SELECT) ���
 * : �ý����� ���� ���� �� ����
 * : ����� ū ���̺� ����
 * : �߰�/����/���� ���� �߻����� ���� ��
 * : JOIN, WHERE�� ���� ���Ǵ� ��
 * 
 * �ε��� ��� ����
 * : �߰� �۾��� �ʿ�
 * : �ε����� ���� ��������� ���� �ʿ� (10%)
 * : �ε��� �߸� ����� ��� ���� ������ ��ȿ��
 * */

-- ������ ���� �Ӽ� (��)�� �ε��� ����ϰ� �Ǹ�
-- �ε����� ũ�Ⱑ Ŀ�� (�ٷ� �����Ǵ� �� �ƴ϶� �α׿� ����)


-- [�� (view)]
-- : ���� ���̺�
-- : �ϳ� �̻��� ������ ��ȸ (SELECT) ������ ��ü

/* �� ����� ? 
 * 1. SELECT ������ ��������
 * 2. ���ȼ�: ���̺��� Ư�� ���� ����� ���� �� (������ȣ)
 * ex) EMP ���̺��� SAL, COMM
 * 
 * */

SELECT * FROM DEPT; -- ���� ���̺�
SELECT * FROM EMP; -- ���� ���̺�

-- VIEW�� �ٰ� ���� (VM_DEPT)
SELECT DEPTNO, DNAME -- LOC�� (������ȣ)�� �ܺο� ���� �� ����
FROM DEPT
WHERE DEPTNO = 10;

-- �� ���� �� ���� (Ư�� ���� ������ �� ����)
SELECT *
FROM VW_DEPT;

-- => ���������� ����� ��ó�� ǥ��
SELECT *
FROM (SELECT DEPTNO, DNAME
	FROM DEPT
	WHERE DEPTNO = 10);


-- 1) �� ����
-- : �� ���� ���� (SCOTT �� ���� ������ ��� ��)

-- scott ������ �� ���� ���� �ִ� ���
-- cmd â����
-- sqlplus
-- system/oracle
-- grant create view to scott;
-- exit;

/* ����)
 * 
 * CREATE [OR REPLACE (����)] [FORCE | NOFORCE (����)] 
 * VIEW �� �̸�
 * (�� �̸�1, �� �̸� 2 ... (����))
 * AS (SELECT ����)
 * 
 * [WITH CHECK OPTION (CONSTRAINT ��������) (����)]
 * [WITH READ ONLY (CONSTRAINT ��������) (����)]
 * 
 * 
 * * OR REPLACE: ���� �̸��� ������ ��� �ش� �̸����� �� ��ü (����)
 * * FORCE: SELECT�� ��� ���̺��� ��� ���� ���� (����)
 * * NOFORCE: SELECT�� ��� ���̺��� ������ ���� X (�⺻��) (����)
 * * �� �̸�: ������ �� �̸� ���� (�ʼ�)
 * * �� �̸�: SELECT�� ��õ� �̸� ��� ����� �� �̸� ���� (��������, ����)
 * * ������ SELECT��: ������ �信 ������ SELECT�� (�ʼ�)
 * * WITH CHECK OPTION: DML �۾� �����ϵ��� �� ���� (����)
 * * WITH READ ONLY: �� ������ �����ϵ��� �� ���� (����)
 * */

-- �� ����
SELECT * FROM EMP;

CREATE VIEW VW_EMP
AS (SELECT EMPNO, ENAME, JOB, MGR, HIREDATE, DEPTNO
	FROM EMP);

-- USER_VIEWS ������ ���� ��ȸ
SELECT * FROM USER_VIEWS; 


SELECT * FROM VW_EMP;

-- 2) �� ���� (=> EMP ���̺� �����Ǵ� �� �ƴ�!)
DROP VIEW VW_EMP;

SELECT * FROM USER_VIEWS;
SELECT * FROM VW_EMP;

-- Q1. �� (VW_EMP) ����
-- EMPNO, ENAME, HIREDATE => NO, NAME, HDATE (�� �� �̸� ����)
-- WITH READ ONLY
-- EMPNO, ENAME, HIREDATE (1500 <= SAL <= 2500)
SELECT * FROM EMP;

CREATE OR REPLACE VIEW VW_EMP (NO, NAME, HDATE)
AS (SELECT EMPNO, ENAME, HIREDATE
	FROM EMP
	WHERE SAL BETWEEN 1500 AND 2500)
WITH READ ONLY; -- SELECT�� ������ �� ���� (�� ������ ����)

SELECT * FROM VW_EMP;


-- 02. �� (VW_EMP) ����
-- ������ �̸��� �ִٸ� REPLACE �ɼ��� ���� VW_EMP ���� �並 ��ü
-- WITH CHECK OPTION (DML ��� ����)
-- SMITH���� ���� (SAL * 12 + COMM)�� 
-- ���� �޴� EMPNO, ENAME, SAL ���� ���� �� ����

-- WITH CHECK OPTION ����� VIEW�� DML ��� ����
-- 1) �信 ������ ���� �׽�Ʈ �غ��� (2021, GILDONG, 1000) -- ERROR
-- 2) �信 ������ ���� �׽�Ʈ �غ��� (2025, GILSUN, 500) -- ERROR
DROP VIEW VW_EMP;

CREATE OR REPLACE VIEW VW_EMP
AS (SELECT EMPNO, ENAME, SAL
	FROM EMP
	WHERE SAL * 12 + NVL(COMM, 0) 
	< (SELECT SAL * 12 + NVL(COMM, 0)
		FROM EMP
		WHERE ENAME = 'SMITH'))
WITH CHECK OPTION CONSTRAINT VIEW_CHECK_OPTION; 


-- DML ������ ���� ����! (�������� �����ϸ�!)

SELECT * FROM  EMP;
SELECT * FROM  VW_EMP;

INSERT INTO VW_EMP
VALUES (2021, 'GILDONG', 1000); -- ����! (�������� �������� ����)

INSERT INTO VW_EMP
VALUES (3001, 'GILDONG2', 1000);

INSERT INTO VW_EMP
VALUES (2025, 'GILSUN', 500); -- ������ (�������� ������)

INSERT INTO VW_EMP
VALUES (3000, 'GILSUN2', 500); -- ������ (�������� ������)

DROP VIEW VW_EMP;

CREATE OR REPLACE VIEW VW_EMP
AS (SELECT EMPNO, ENAME, SAL
	FROM EMP
	WHERE SAL * 12 + NVL(COMM, 0) 
	< (SELECT SAL * 12 + NVL(COMM, 0)
		FROM EMP
		WHERE ENAME = 'SMITH'));
	
INSERT INTO VW_EMP
VALUES (2010, 'GILSUN', 2000); 
-- CHECK OPTION�� ��� ���� �߻� X

SELECT * FROM VW_EMP;
DROP VIEW VW_EMP;

-- 3) �ζ��� �並 �̿��� TOP-N SQL��
-- : �ζ��� �� (inline view) (VS ��)
-- : ��ȸ������ ���� ����ϴ� �� (WITH ~~ AS ~~)
COMMIT
-- 1-1. �ζ��� �� + ROWNUM ���
SELECT ROWNUM, E.*
FROM EMP E;

-- �ǻ� �� (PSEUDO COLUMN) (ROWNUM)
-- ���� ���̺� ���������� ������ Ư�� ������ ���ؼ� ��ó�� ���

-- cf) �ǻ� �ڵ� (PSEUDO CODE)
-- : ���� �ڵ�� �ƴϰ� �˰��� (���)�� ǥ���ϱ� ���� ���

-- �ζ��� �並 �̿��� TOP-N ����
-- ex) �޿��� ���� ���� �� �� ������ ��� (ROWNUM)

-- �ζ��� �� (WHERE) => ������ ������
SELECT ROWNUM, E.*
FROM (SELECT *
	FROM EMP
	ORDER BY SAL DESC) E
WHERE ROWNUM <= 3;

-- �ζ��� �� (WITH ~ AS) => ������ ����
WITH E AS (SELECT * FROM EMP ORDER BY SAL DESC)
SELECT ROWNUM, E.*
FROM E
WHERE ROWNUM <= 3;

-- Q1. ����� �ų����� �Ի����� �ֱ� 5�� ���� (DESC)
WITH E AS (SELECT * FROM EMP E1 JOIN EMP E2 
			ON (E1.MGR = E2.EMPNO) ORDER BY E2.HIREDATE DESC)
SELECT ROWNUM, E.*
FROM E
WHERE ROWNUM <= 5;

-- ROWNUM : �� ��ȣ

-- Q2. COMM�� NULL�� ����� �߿� EMPNO�� ���� ��� 3�� ���� (DESC)
WITH E AS (SELECT * FROM EMP 
			WHERE COMM IS NULL 
			ORDER BY EMPNO DESC)
SELECT ROWNUM, E.*
FROM E
WHERE ROWNUM <= 3;


SELECT * FROM EMP;


/* ������ (sequence)
 * : ���ӵǴ� ���� ���� ��ü
 * : ���������� ȿ������ ��ȣ ���� ����
 * 
 * ex) �Խ��� �� ��� 1, 2, 3, 4...
 * 	���θ� ��ٱ���, �� ��� 1, 2, 3, 4..
 * 
 * SELECT MAX(���) + 1
 * FROM �Խ��� ���̺� 
 * 
 * ������ ?
 * - MAX(���): �Խ��� �� 1000�� �Ѿ (1000���� �� ������)
 * >> ���̺��� ����� Ŀ���� ���� �ӵ� ������
 * */

/* ������ ����
 * 
 * ����)
 * CREATE SEQUENCE ������ �̸�
 * [INCREMENT BY n] - ��ȣ�� ������ (�⺻�� 1) (����)
 * [START WITH n] - ��ȣ ���۰� (�⺻�� 1) (����)
 * [MAXVALUE n | NOMAXVALUE] (����) 
 * - MAXVALUE: �������� �ִ�
 * - NOMAXVALUE: �������� 10^27, �������� -1 
 * [MINVALUE n | NOMINVALUE] (����)
 * - MINVALUE: �������� �ּڰ�
 * - NOMINVALUE: �������� 1, �������� 10^-26 == 1/10^26
 * [CYCLE | NOCYCLE] (����)
 * - CYCLE: �ִ� �������� ��� �ٽ� ���۰����� ���ư�
 * - NOCYCLE: �ִ� �������� ��� ��ȣ ���� �ߴ� (���� �߻�)
 * [CACHE n | NOCACHE] (����) (�⺻�� 20)
 * - CACHE: ������ ��ȣ �̸� ����
 * - NOCACHE: �̸� ���� X
 * 
 * */

-- �ǽ� DEPT_SEQUENCE ���̺� (������ ����)
CREATE TABLE DEPT_SEQUENCE
AS SELECT *
	FROM DEPT 
	WHERE 1 <> 1;

SELECT * FROM DEPT_SEQUENCE;

-- DEPTNO�� ���۰� 10, 10�� ������ �� �ֵ��� ������ ����
CREATE SEQUENCE SEQ_DEPTNO
INCREMENT BY 10
START WITH 10
MAXVALUE 90
MINVALUE 0
NOCYCLE
CACHE 20;

SELECT * FROM USER_SEQUENCES;

/* ������ ���
 * 
 * ������ �̸�.CURRVAL => ���������� ������ ��ȣ ��ȯ
 * �� ���� �������� ����� ���� ���� ������ CURRVAL�� ����
 * => ����ϸ� ������ ��
 * => �������� �������ڸ��� �ٷ� CURRVAL ����� ���� ����
 * 
 * ������ �̸�.NEXTVAL => ���� ������ ��ȣ ��ȯ
 * 
 * */


INSERT INTO DEPT_SEQUENCE (DEPTNO)
VALUES (SEQ_DEPTNO.NEXTVAL);
-- �ִ��� �Ѱ� �� ��쿡�� ���� �߻�!

SELECT * FROM DEPT_SEQUENCE;

SELECT SEQ_DEPTNO.CURRVAL
FROM DUAL; -- ���� Ȯ�ο� ���̺� (DUMMY TABLE)



/* ������ ���� (START WITH�� ���� �Ұ�)
 * ALTER SEQUENCE ������ �̸� 
 * [INCREMENT BY n] - ��ȣ�� ������ (�⺻�� 1) (����)
 * [MAXVALUE n | NOMAXVALUE] (����) 
 * - MAXVALUE: �������� �ִ�
 * - NOMAXVALUE: �������� 10^27, �������� -1 
 * [MINVALUE n | NOMINVALUE] (����)
 * - MINVALUE: �������� �ּڰ�
 * - NOMINVALUE: �������� 1, �������� 10^-26 == 1/10^26
 * [CYCLE | NOCYCLE] (����)
 * - CYCLE: �ִ� �������� ��� �ٽ� ���۰����� ���ư�
 * - NOCYCLE: �ִ� �������� ��� ��ȣ ���� �ߴ� (���� �߻�)
 * [CACHE n | NOCACHE] (����) (�⺻�� 20)
 * - CACHE: ������ ��ȣ �̸� ����
 * - NOCACHE: �̸� ���� X
 **/

-- �������� CYCLE �߰�, ������ 2, �ִ� 99
ALTER SEQUENCE SEQ_DEPTNO
INCREMENT BY 2
MAXVALUE 99
CYCLE;


SELECT * FROM USER_SEQUENCES;

INSERT INTO DEPT_SEQUENCE (DEPTNO)
VALUES (SEQ_DEPTNO.NEXTVAL);

SELECT * FROM DEPT_SEQUENCE;

/* ������ ����
 * DROP SEQUENCE
 * 
 * DEPTNO 
 * => ������ ���� ���� (�������� �����ص� DEPTNO �����ʹ� ������� ����)
 * */

DROP SEQUENCE SEQ_DEPTNO;

SELECT * FROM USER_SEQUENCES;
SELECT * FROM DEPT_SEQUENCE;


/* ���Ǿ� (synonym)
 * : ���̺�, ��, �������� ��ü �̸� ��� ����� �� �ִ� �ٸ� �̸� �ο�
 * ex) ���̺��� �̸��� �� ��� ���Ǿ ����
 * 
 * ���Ǿ� ������
 * CREATE [PUBLIC] SYNONYM ���Ǿ� �̸�
 * FOR [�����.][��ü�̸�];
 * 
 * PUBLIC - DB ���� ��� ����ڰ� ����� �� �ֵ��� ����
 * (������ ���, ���Ǿ ������ ����ڸ� ����� ����) (����)
 * ���Ǿ� �̸� - ������ ���Ǿ� �̸� (�ʼ�)
 * �����. - ������ ���Ǿ��� ���� ����� ����
 * (������ ���, ���� ������ ����� ����) (����)
 * ��ü �̸� - ���Ǿ ������ ��ü �̸� (���̺�, ��, ������) (�ʼ�)
 * 
 * ���Ǿ� VS ���̺� ��Ī (FROM ���̺� �̸� ��Ī)
 * : ���Ǿ�� DB�� ����Ǵ� ��ü (��ȸ�� X)
 * : ���̺� ��Ī�� ��ȸ��
 * 
 * */

-- SCOTT ������ ���Ǿ ������ �� �ִ� ���� �ο� (SQLPLUS)
-- sqlplus
-- system/oracle
-- 1) ���Ǿ� ���� ���� �ο�: 
-- >> grant create synonym to scott;
-- 2) ���Ǿ� PUBLIC ���� �ο�: 
-- >> grant create public synonym to scott;

-- ���Ǿ� ���� (EMP -> E)
CREATE SYNONYM E
FOR EMP;

SELECT * FROM E;

-- ���Ǿ� ���� (DEPT -> D)
CREATE SYNONYM D
FOR DEPT;

SELECT * FROM D;

-- ���Ǿ� �̿�! 
-- �� ���� (JOIN VS JOIN X)�� Ǯ�����!
-- Q1. �μ��� RESEARCH���� ���ϴ� ��� ���� ��� 
SELECT * FROM EMP;
SELECT * FROM DEPT;

-- ���� �̿� O
SELECT E.*
FROM E JOIN D ON (E.DEPTNO = D.DEPTNO)
WHERE D.DNAME = 'RESEARCH';

-- ���� �̿� X
SELECT *
FROM E
WHERE DEPTNO = (SELECT DEPTNO
				FROM D
				WHERE DNAME = 'RESEARCH');

-- Q2. �μ��� SALES���� ���ϴ� ��� ��� ���� (SAL * 12 + COMM) ���
-- * NULL�� ó��!
SELECT * FROM E;

-- ���� �̿� O
SELECT AVG(E.SAL*12+E.COMM) 
FROM E JOIN D ON (E.DEPTNO = D.DEPTNO)
WHERE D.DNAME = 'SALES';
-- COMM�� NULL�� �Ǹ� E.SAL*12+E.COMM�� NULL
-- AVG(): NULL�� ���� �����ϰ� ����� ���
-- => COMM�� NULL�� ����� ������ ����


SELECT E.SAL*12+E.COMM
FROM E;

SELECT ROUND(AVG(E.SAL*12+NVL(E.COMM, 0)), 2)
FROM E JOIN D ON (E.DEPTNO = D.DEPTNO)
WHERE D.DNAME = 'SALES';


-- ���� �̿� X
SELECT ROUND(AVG(SAL*12+NVL(COMM, 0)), 2)
FROM E
WHERE DEPTNO = (SELECT DEPTNO
				FROM D
				WHERE DNAME = 'SALES');

-- ���Ǿ� ����
DROP SYNONYM E;
DROP SYNONYM D;

-- ���Ǿ� ��ȸ
SELECT * FROM ALL_SYNONYMS WHERE OWNER='SCOTT';
SELECT * FROM ALL_SYNONYMS WHERE TABLE_NAME='DEPT';
