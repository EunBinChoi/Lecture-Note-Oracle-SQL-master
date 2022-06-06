/* �������� (constraint)
 * : ���̺� ������ �����Ϳ� ���� ��Ģ
 * : ������ ���Ǿ� (DDL)�� ���� ���
 * 
 * 1) NOT NULL: ������ ���� NULL ������� ����
 * (������ �ߺ��� ��� => user1: scott, user2: scott)
 * 2) UNIQUE: ������ ���� ������ �� (�ߺ� X)
 * (�����Ϳ� NULL�� �ߺ� ����)
 * 3) PRIMARY KEY (�⺻Ű): ������ �� + NULL�� ������� ����
 * (�ϳ��� ���̺� �ϳ��� ������ �� ����)
 * 4) FOREIGN KEY (�ܷ�Ű): �ٸ� ���̺��� �� �����ϴ� ���� �Է� ����
 * 5) CHECK: ���ǽĿ� �����ϴ� �����͸� �Է� ���� 
 * 6) DEFAULT: ���� �� ������ �⺻���� ������ �� ���� (���������� �ƴ�)
 * 
 * * ���̺��� ������ �� ���������� ���� ���� (����)
 * * ���߿� ���̺� ����ÿ��� ������ ���� ����
 * */

-- ���̺� ���� 
-- EX) GAME_ID_PASS
-- GAME_ID VARCHAR(20) NOT NULL
-- GAME_PASS VARCHAR(20) NOT NULL
-- LASTDATE DATE

-- 1) NOT NULL
DROP TABLE GAME_ID_PASS;
CREATE TABLE GAME_ID_PASS(
	GAME_ID VARCHAR(20) NOT NULL,
	GAME_PASS VARCHAR(20) NOT NULL,
	LASTDATE DATE
);

SELECT * FROM GAME_ID_PASS;

-- ID, PASS, LASTDATE�� INSERT INTO
INSERT INTO GAME_ID_PASS
VALUES ('eunbin', '1234', SYSDATE);

-- GAME_ID, GAME_PASS�� �����͸� ���� ���� (����)
INSERT INTO GAME_ID_PASS(LASTDATE)
VALUES (SYSDATE);

-- GAME_PASS�� NULL�� ���� ���� ���� (����)
INSERT INTO GAME_ID_PASS
VALUES ('eunbin', NULL, SYSDATE);

SELECT * FROM GAME_ID_PASS;

-- GAME_PASS�� NULL���� ���� (����)
UPDATE GAME_ID_PASS
SET GAME_PASS = NULL
WHERE GAME_ID = 'eunbin';

-- ���� ���� ��ȸ
SELECT * 
FROM USER_CONSTRAINTS 
WHERE TABLE_NAME = 'GAME_ID_PASS';
/* OWNER: ���� ���� ���� ����
 * CONSTRAINT_NAME: ���� ���� �̸� (������ ����Ŭ �ڵ� ����)
 * CONSTRAINT_TYPE: ���� ���� ����
 * C: CHECK, NOT NULL
 * U: UNIQUE
 * P: PRIMARY KEY
 * R: FOREIGN KEY
 * V: VIEW���� WITH CHECK OPTION
 * O: VIEW���� WITH READ ONLY
 * */


-- ���� ���� �̸� ����
-- >> ���� ���� ������ ���� �̸��� �������ִ� ���� ����
CREATE TABLE GAME_ID_PASS_CONS_NAME(
	GAME_ID VARCHAR(20) CONSTRAINT ID_NN NOT NULL,
	GAME_PASS VARCHAR(20) CONSTRAINT PASS_NN NOT NULL,
	LASTDATE DATE
);

SELECT * FROM USER_CONSTRAINTS;

-- �̹� ������ ���̺� ���� ���� �߰�
/* ����)
 * ALTER TABLE ���̺��
 * MODIFY (���̸� ��������)
 */

-- ���� ���� �߰�
ALTER TABLE GAME_ID_PASS_CONS_NAME
MODIFY (LASTDATE CONSTRAINT LD_NN NOT NULL);

-- ���� ���� ����
ALTER TABLE GAME_ID_PASS_CONS_NAME
DROP CONSTRAINT SYS_C007023;

SELECT * FROM USER_CONSTRAINTS;

-- ���� ���� �̸� ���� (������ ������ �������� �̸��� ������ ����!)
ALTER TABLE GAME_ID_PASS
RENAME CONSTRAINT SYS_C007019 TO ID_NN2;

-- SYS_C007020, C007018�� �̸� ����
ALTER TABLE GAME_ID_PASS
RENAME CONSTRAINT SYS_C007020 TO PASS_NN2;

-- Ȯ��!
ALTER VIEW VW_EMP
RENAME CONSTRAINT SYS_C007018 TO VW_EMP_CHECK;

ALTER TABLE GAME_ID_PASS
DROP CONSTRAINT ID_NN2;

ALTER TABLE GAME_ID_PASS
DROP CONSTRAINT PASS_NN2;

SELECT * FROM USER_CONSTRAINTS;

-- 2) UNIQUE
-- : �������� �ߺ��� ��� X
-- : NULL���� �ߺ��� ���Ե��� ���� (NULL ���� �� ����)

-- STUDENT ���̺�
-- ID: UNIQUE => ID_UQ
-- NAME: NOT NULL => NAME_NN
-- PHONE
SELECT * FROM TAB;

DROP TABLE STUDENT;
CREATE TABLE STUDENT(
	ID VARCHAR(20) CONSTRAINT ID_UQ UNIQUE,
	NAME VARCHAR(20) CONSTRAINT NAME_NN NOT NULL,
	PHONE VARCHAR(20)
);


SELECT * 
FROM USER_CONSTRAINTS
WHERE TABLE_NAME = 'STUDENT';

-- ������ ���� 2�� (ID�� ����)
INSERT INTO STUDENT
VALUES ('2021001', 'ȫ�浿', '010-1234-5678');
INSERT INTO STUDENT -- ID UNIQUE �������� ����
VALUES ('2021001', 'ȫ���', '010-1234-1234');

-- ������ ���� 2�� (ID�� NULL) -- UNIQUE �������� ���� X
INSERT INTO STUDENT
VALUES (NULL, 'ȫ�浿', '010-1234-5678');
INSERT INTO STUDENT 
VALUES (NULL, 'ȫ���', '010-1234-1234');

SELECT * FROM STUDENT;

SELECT * FROM USER_CONSTRAINTS;

-- ���� ���� ����
ALTER TABLE STUDENT
DROP CONSTRAINT ID_UQ;


-- ���� ���� �߰� (ID_UQ)
-- ���� ���� �߰� �Ұ�! (�̹� ID�� UNIQUE ���� ����)
ALTER TABLE STUDENT
MODIFY (ID CONSTRAINT ID_UQ UNIQUE);

DELETE FROM STUDENT
WHERE ID = '2021001' AND NAME = 'ȫ���';

SELECT * FROM STUDENT;
SELECT * FROM USER_CONSTRAINTS;

-- ���� ���� �̸� ���� (ID_UQ -> ID_UNIQUE)
ALTER TABLE STUDENT
RENAME CONSTRAINT ID_UQ TO ID_UNIQUE;


-- 3) PRIMARY KEY (�⺻Ű)
-- : UNIQUE + NOT NULL
-- : �⺻Ű�� �ٸ� �����͸� ��ǥ�� �� �ִ� ���� ����
-- : ���̺��� ���� �� ���� ����
-- : �ش� ������ �ڵ����� �ε��� ������� (���� �⺻Ű�� SELECT���� ���� ���) 

-- Q1. PERSON�̶�� TABLE�� ����
-- ID NUMBER(2)
-- NAME VARCHAR(20)
-- GENDER VARCHAR(5)
-- REGISTRATION VARCHAR(15)

-- A. PRIMARY KEY(�⺻Ű)�� �� �� �ִ� �� (+ ���� ���� �̸� ����)
-- B. NAME NOT NULL (+ ���� ���� �̸� ����)

CREATE TABLE PERSON( -- �� ����/�� ���� ���� ���� ����
	ID NUMBER(2) CONSTRAINT PID_PK PRIMARY KEY,
	NAME VARCHAR(20) CONSTRAINT PNAME_NN NOT NULL,
	GENDER VARCHAR(5),
	REGISTRATION VARCHAR(15)
);

CREATE TABLE PERSON( -- ���̺� ����/�ƿ� ���� ���� ���� ����
	ID NUMBER(2),
	NAME VARCHAR(20),
	GENDER VARCHAR(5),
	REGISTRATION VARCHAR(15),
	CONSTRAINT PID_PK PRIMARY KEY (ID),
--	CONSTRAINT PNAME_NN NOT NULL (NAME)
	-- ���̺� ���� ���� ���� ���Ǵ� NOT NULL ������ �� ����
	-- PRIMARY KEY, UNIQUE, FOREIGN KEY ....
);

SELECT * FROM USER_CONSTRAINTS;

-- PRIMARY KEY (�⺻Ű)�� �����͸� �ĺ��ϴ� ������ �� 
-- (SELECT ���� ���� ��� => INDEX�� ����)
-- �ε��� �̸��� ���� ���� �̸��� ��������
SELECT * FROM USER_INDEXES;


-- PERSON ���̺� �� 5���� ����
-- 1) PERSON ���̺� ID�� SEQUENCE�� ���� ���� (SEQ_PERSON)
-- START WITH: 1
-- MINVALUE: 1
-- MAXVALUE: 5
-- INCREMENT BY: 1
-- CYCLE
-- NOCACHE

CREATE SEQUENCE SEQ_PERSON
INCREMENT BY 1
START WITH 1
MINVALUE 1
MAXVALUE 5
CYCLE
NOCACHE;

SELECT * FROM USER_SEQUENCES;

-- 2) SEQ_PERSON�� ���� ������ ����
INSERT INTO PERSON (ID, NAME)
VALUES (SEQ_PERSON.NEXTVAL, 'ȫ�浿');
-- �� 6���� �����ϸ� UNIQUE ���ǿ� �������� ����

SELECT * FROM PERSON;

INSERT INTO PERSON (ID, NAME)
VALUES (NULL, 'ȫ�浿');
-- NOT NULL ���ǿ� �������� ����

-- ALTER, MODIFY, RENAME, DROP�� �ۼ��� �� ����!

-- 4) FOREIGN KEY (�ܷ�Ű, �ܺ�Ű)
-- : �� ���̺��� ���� �����ϴ� ���� ����
-- ex) EMP, DEPT 
-- (EMP ���̺��� DEPTNO�� �ܷ�Ű, DEPT ���̺��� DEPTNO�� �⺻Ű)

SELECT * FROM USER_CONSTRAINTS;
SELECT * FROM EMP;
SELECT * FROM DEPT;

INSERT INTO EMP(EMPNO, ENAME, JOB, DEPTNO)
VALUES (5000, '��Ŭ��', 'DEVELOPER', 50);
-- �ܷ�Ű�� �����ϴ� DEPT.DEPTNO�� 50�� ���� ������ ����

INSERT INTO EMP(EMPNO, ENAME, JOB, DEPTNO)
VALUES (5000, '��Ŭ��', 'DEVELOPER', NULL);
-- �ܷ�Ű ����: �����ϴ� ���̺��� �⺻Ű�̰ų� 
-- NULL�� �� ('������ �����Ͱ� ����!') ���� ����!
-- �ܷ�Ű�� NULL�� ��� JOIN�� �ϸ� ��� ���̺�?
-- : �ܷ�Ű�� NULL�� �� ����

SELECT *
FROM EMP JOIN DEPT ON (EMP.DEPTNO = DEPT.DEPTNO);

SELECT * FROM EMP;


-- FOREGIN KEY ����
/* CREATE TABLE ���̺��(
 * 	.... (�ٸ� �� ����),
 * 	�� �ڷ��� CONSTRAINT [�������� �̸� (����)] REFERENCES ���� ���̺� (��)
 * );
 * 
 * CREATE TABLE ���̺��(
 * 	.... (�ٸ� �� ����),
 * 	�� �ڷ���,
 *  CONSTRAINT [�������� �̸� (����)] FOREIGN KEY (�� �̸�)
 *  REFERENCES ���� ���̺� (��)
 * );
 * 
 * */


-- DEPT_FK ���̺� ����
CREATE TABLE DEPT_FK(
	DEPTNO NUMBER(2) CONSTRAINT DEPT_FK_PK PRIMARY KEY,
	DNAME VARCHAR(20),
	LOC VARCHAR(20)
);

-- EMP_FK ���̺� ���� (DEPT_FK�� DEPTNO�� ����)
-- �⺻Ű: EMPNO
-- �ܷ�Ű: DEPTNO
CREATE TABLE EMP_FK(
	EMPNO NUMBER(4) CONSTRAINT EMP_FK_PK PRIMARY KEY,
	ENAME VARCHAR(20),
	JOB VARCHAR(20),
	MGR NUMBER(4),
	HIREDATE DATE,
	SAL NUMBER(7, 2),
	COMM NUMBER(7, 2),
	DEPTNO NUMBER(2) CONSTRAINT EMP_FK_FK REFERENCES DEPT_FK (DEPTNO)
);

CREATE TABLE EMP_FK(
	EMPNO NUMBER(4),
	ENAME VARCHAR(20),
	JOB VARCHAR(20),
	MGR NUMBER(4),
	HIREDATE DATE,
	SAL NUMBER(7, 2),
	COMM NUMBER(7, 2),
	DEPTNO NUMBER(2),
	CONSTRAINT EMP_FK_PK PRIMARY KEY (EMPNO),
	CONSTRAINT EMP_FK_FK FOREIGN KEY (DEPTNO) 
	REFERENCES DEPT_FK (DEPTNO)
);

INSERT INTO EMP_FK (EMPNO, ENAME, DEPTNO)
VALUES (1000, 'ȫ�浿', 10);
-- �ܷ�Ű�� ������ DEPTNO �������� ���� ä�� ������ ������ �Ұ���

INSERT INTO DEPT_FK (DEPTNO, DNAME, LOC)
VALUES (10, 'ACCOUTING', 'SEOUL');
-- ���� DEPTNO�� ������ ������ (1000, 'ȫ�浿', 10) ������ ���� ����

SELECT * FROM EMP_FK;
SELECT * FROM DEPT_FK;

DELETE FROM DEPT_FK
WHERE DEPTNO = 10;
-- ���� �߻�!
-- DEPTNO 10���� �����ϰ� �ִ� ���ڵ尡 ���� ('ȫ�浿')

/* 1. EMP ���̺��� 'ȫ�浿' �����ϰ� DEPT ���̺� 10���� ����
 * 2. EMP ���̺��� 'ȫ�浿'�� DEPTNO�� NULL ����
 * 3. EMP ���̺��� FOREIGN KEY �������� ����
 * 
 * * FOREIGN KEY�� ������ ������� ���� ���� �����ϴ� �� ����!
 * */

/* ON DELETE CASCADE: DEPT ���̺� 10���� ������ ��쿡
 * �̸� �����ϴ� �����͸� �Բ� ����
 * 
 * ON DELETE SET NULL: DEPT ���̺� 10���� ������ ��쿡
 * �̸� �����ϴ� �����͸� NULL�� ����
 * */

DROP TABLE EMP_FK;
CREATE TABLE EMP_FK(
	EMPNO NUMBER(4) CONSTRAINT EMP_FK_PK PRIMARY KEY,
	ENAME VARCHAR(20),
	JOB VARCHAR(20),
	MGR NUMBER(4),
	HIREDATE DATE,
	SAL NUMBER(7, 2),
	COMM NUMBER(7, 2),
	DEPTNO NUMBER(2) 
	CONSTRAINT EMP_FK_FK 
	REFERENCES DEPT_FK (DEPTNO) ON DELETE CASCADE
);

DROP TABLE EMP_FK;
CREATE TABLE EMP_FK(
	EMPNO NUMBER(4),
	ENAME VARCHAR(20),
	JOB VARCHAR(20),
	MGR NUMBER(4),
	HIREDATE DATE,
	SAL NUMBER(7, 2),
	COMM NUMBER(7, 2),
	DEPTNO NUMBER(2),
	CONSTRAINT EMP_FK_PK PRIMARY KEY (EMPNO),
	CONSTRAINT EMP_FK_FK FOREIGN KEY (DEPTNO) 
	REFERENCES DEPT_FK (DEPTNO) ON DELETE SET NULL
);

-- Q1. EMP_FK, DEPT_FK�� ����
-- 1) ON DELETE SET NULL
INSERT INTO DEPT_FK (DEPTNO, DNAME, LOC)
VALUES (10, 'ACCOUNTING', 'SEOUL');
INSERT INTO EMP_FK (EMPNO, ENAME, DEPTNO)
VALUES (1000, 'ȫ�浿', 10);

SELECT * FROM EMP_FK;
SELECT * FROM DEPT_FK;

DELETE FROM DEPT_FK
WHERE DEPTNO = 10;

-- NULL���� ���� (ON DELETE SET NULL ��� �̿�)
SELECT * FROM EMP_FK;
SELECT * FROM DEPT_FK;

-- 2) ON DELETE CASCADE
INSERT INTO DEPT_FK (DEPTNO, DNAME, LOC)
VALUES (10, 'ACCOUNTING', 'SEOUL');
INSERT INTO EMP_FK (EMPNO, ENAME, DEPTNO)
VALUES (2000, 'ȫ�浿', 10);

SELECT * FROM EMP_FK;
SELECT * FROM DEPT_FK;


DELETE FROM DEPT_FK
WHERE DEPTNO = 10;

-- �����Ͱ� �� ����� (ON DELETE CASCADE ��� �̿�)
SELECT * FROM EMP_FK;
SELECT * FROM DEPT_FK;


-- 5) CHECK
-- : �����Ϳ� ������ ���� (�� ����, ���� ����)
-- EX) ����: 1 ~ 99, ��: 0 ~ 23, ��: 0 ~ 59, ��: 0 ~ 59

DROP TABLE GAME_ID_PASS;
CREATE TABLE GAME_ID_PASS(
	LOGIN_ID VARCHAR(20) CONSTRAINT LOGIN_ID_PK PRIMARY KEY,
	LOGIN_PWD VARCHAR(20),
	PHONE VARCHAR(20) CONSTRAINT PHONE_CK CHECK (LENGTH(PHONE) > 11)
	-- 010-123-3456
);

DROP TABLE GAME_ID_PASS;
CREATE TABLE GAME_ID_PASS(
	LOGIN_ID VARCHAR(20),
	LOGIN_PWD VARCHAR(20),
	PHONE VARCHAR(20),
	CONSTRAINT LOGIN_ID_PK PRIMARY KEY (LOGIN_ID),
	CONSTRAINT PHONE_CK CHECK (LENGTH(PHONE) > 11)
);

SELECT * FROM GAME_ID_PASS;
SELECT * 
FROM USER_CONSTRAINTS 
WHERE TABLE_NAME = 'GAME_ID_PASS';


INSERT INTO GAME_ID_PASS (LOGIN_ID)
VALUES ('ID_3');

-- ������ 2�� ����
INSERT INTO GAME_ID_PASS 
VALUES ('ID_1', '1234', '010-11-1111');
-- PHONE�� �������ǿ� ����

INSERT INTO GAME_ID_PASS 
VALUES ('ID_2', '1234', '010-111-1111');

SELECT * FROM GAME_ID_PASS;

INSERT INTO GAME_ID_PASS (PHONE)
VALUES ('010-111-1111');
-- ID�� �⺻Ű ���� (UNIQUE + NOT NULL)
-- �⺻Ű�� ������ ID�� NULL�̸� �������� ����

-- 6) DEFAULT (�⺻��)
-- : �⺻�� ����
-- : Ư�� ���� �ƹ� ���� ������ ���� ��쿡 �⺻������ ����
-- : �������� �ƴ� (USER_CONSTRAINTS�� �߰����� ����)

-- ���̺� �̸�
-- : ������ �����̾� ��� (YT_PR_MEMBER)
-- �� ����
-- 1) ID: VARCHAR(20) (PRIMARY KEY) 
-- (1aaaa(x), aaa1(o) CHECK)
-- (111aaaa(x), aaa111(o) CHECK)
-- ���� ����

-- 2) PW: VARCHAR(20) (CHECK�� 7�ڸ��� �Ѱܾ� ��)
-- 3) NAME: VARCHAR(10)
-- 4) BIRTHDAY: DATE
-- 5) REGDATE: DATE (������ ����, SYSDATE)
-- 6) ISPAID: NUMBER(1) (1 - TRUE, 0 - FALSE) (DEFAULT 0)
DROP TABLE YT_PR_MEMBER;
CREATE TABLE YT_PR_MEMBER(
	ID VARCHAR(20),
	PW VARCHAR(20),
	NAME VARCHAR(10),
	BIRTHDAY DATE,
	REGDATE DATE DEFAULT SYSDATE,
	ISPAID NUMBER(1) DEFAULT 0,
	CONSTRAINT YT_ID_PK PRIMARY KEY(ID),
	CONSTRAINT YT_PW_CK CHECK (LENGTH(PW) > 7),
	CONSTRAINT YT_ID_CK CHECK 
	(UPPER(ID) BETWEEN 'A' AND 'Z')
);
-- ���� + ���� ����
-- 111a -> '1'
-- a111 -> 'a'

SELECT *
FROM USER_CONSTRAINTS
WHERE TABLE_NAME = 'YT_PR_MEMBER';

-- NULL => ���������� Ȯ������ ���� (PW�� �Է��� �ȵǾ����� (NULL))
INSERT INTO YT_PR_MEMBER(ID, NAME)
VALUES ('gildong', 'ȫ�浿');

SELECT * FROM YT_PR_MEMBER;

-- ���� X (���̵� ù���ڰ� ���ڶ�)
INSERT INTO YT_PR_MEMBER(ID, NAME)
VALUES ('1gildong', 'ȫ�浿');

-- ���� X (�н����尡 7���ڰ� ���� ����)
INSERT INTO YT_PR_MEMBER(ID, NAME, PW)
VALUES ('gilsun', 'ȫ���', '1234');

-- ID�� �⺻Ű�� NULL���� ���� ���� ����
INSERT INTO YT_PR_MEMBER(NAME)
VALUES ('ȫȫ');

INSERT INTO YT_PR_MEMBER
VALUES ('eunbin', '12345678', '�ڹ�', 
TO_DATE('1990/11/30', 'YYYY/MM/DD'), SYSDATE, NULL);
-- ����Ʈ ���� �ִ� ISPAID ���� 
-- NULL�� ��������� �ְ� �Ǹ� NULL ����

INSERT INTO YT_PR_MEMBER (ID, PW, NAME)
VALUES ('echoi', '12345678', '����');
-- ����Ʈ ���� �ִ� ISPAID ���� 
-- �ƹ� ���� ���� ������ ����Ʈ ������ ����

SELECT * FROM YT_PR_MEMBER;
SELECT * 
FROM USER_CONSTRAINTS
WHERE TABLE_NAME = 'YT_PR_MEMBER';

/* �������� Ȱ��ȭ/��Ȱ��ȭ
 * : Ȱ��ȭ - �������� Ȯ�� (ENABLE)
 * : ��Ȱ��ȭ - �������� Ȯ�� X (DISABLE)
 * ��Ȱ��ȭ ���� ?
 * 1) �׽�Ʈ �����ÿ� ���������� ��� ����
 * */

-- ��Ȱ��ȭ
ALTER TABLE YT_PR_MEMBER
DISABLE CONSTRAINT YT_ID_CK;

SELECT * 
FROM USER_CONSTRAINTS
WHERE CONSTRAINT_NAME = 'YT_ID_CK';

-- Ȱ��ȭ
ALTER TABLE YT_PR_MEMBER
ENABLE CONSTRAINT YT_ID_CK;


/* ��������  | �������� Ÿ��
 * NOT NULL (C)
 * UNIQUE  (U) - NULL�� ���
 * PRIMARY KEY (P) 
 * FOREIGN KEY (R) - NULL�� ���
 * - ON DELETE CASCADE: 
 * '���� �����ϰ� �ִ� �����Ͱ� �����Ǹ� ���� ����'
 * - ON DELETE SET NULL: 
 * '���� �����ϰ� �ִ� �����Ͱ� �����Ǹ� ���� NULL ����'
 * CHECK (C) - NULL�� CHECK (���ǽ�)�� �����ϰ� NULL�� ����
 * 
 * -- DISABLE, ENABLE
 * 
 * DEFAULT - NULL ��������� �����ϸ� NULL�� ���
 *         - NULL ��������� �������� ������ �⺻���� ���Ե� 
 * */



