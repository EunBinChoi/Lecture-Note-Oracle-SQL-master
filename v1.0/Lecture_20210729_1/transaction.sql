/* [Ʈ�����]
 * : transaction 
 * : �� �̻� ������ �� ���� �ּ� ���� ����
 * : �� �� �̻��� ������ ���۾� (DML)�� ����
 * 
 * Ʈ������� �� ����� ?
 * ex) ���� ���� ���� DB
 * 1) A���� (���� �ܾ� 200)
 * UPDATE 200 -> 0
 * 
 * 2) B���� (���� �ܾ� 0)
 * UPDATE 0 -> 200
 * 
 * -> 1), 2)�� ���� ����! (Ʈ���������� ����� ��)
 * -> 'ALL OR NOTHING'
 * -> Ʈ����� ���� ��ɾ� : TCL 
 * (Transaction Control Language)
 * -> Ʈ����� ����
 * 1) ���� ����
 * 2) ��� 
 * 
 * Ʈ�������� Ư¡ (ACID)
 * 1) ���ڼ� (Atomicity) - ȸ��
 * : Ʈ�������� �̷�� DML �ڵ带 �ϳ��� ���ڷ� ���ڴ�!
 * : "ALL OR NOTHING"
 * 
 * 2) �ϰ��� (Consistency) - ���ü� ���� (LOCKING), ������ ��������
 * : Ʈ������ ����Ǳ� �� ������ ���� DB  
 *  => Ʈ������ ���� �� ������ ���� DB
 * 
 * 3) ���� (Isolation) - ���ü� ���� (LOCKING)
 * : Ʈ������ ���� ���߿� �ٸ� Ʈ������ ������ �޾� ����� �߸��Ǹ� �ȵȴ�!
 * 
 * 4) ���Ӽ� (Durability) - ȸ��
 * : Ʈ�������� ���������� ����Ǹ� �ش� Ʈ�������� 
 *   ������ DB ������ ���������� ����
 */

-- DEPT ���̺� �����ؼ� DEPT_TCL ���̺� ����

DROP TABLE DEPT_TCL2;

CREATE TABLE DEPT_TCL2
AS SELECT * FROM DEPT;

SELECT * FROM DEPT_TCL2;



-- 50�� �μ� �߰�
INSERT INTO DEPT_TCL2 VALUES(50, 'DEVELOPER', 'SEOUL');
SELECT * FROM DEPT_TCL2;


-- 40�� �μ� DNAME�� FACTORY�� ����
UPDATE DEPT_TCL2 SET DNAME = 'FACTORY' WHERE DEPTNO = 40;
SELECT * FROM DEPT_TCL2;

SAVEPOINT point1
-- �μ� DNAME RESEARCH�� �μ� ����
DELETE FROM DEPT_TCL2 WHERE DNAME = 'RESEARCH';
SELECT * FROM DEPT_TCL2;

-- 1) Ʈ������ ��� ROLLBACK
ROLLBACK TO SAVEPOINT point1
-- �����ݷ� ���� �ۼ�
SELECT * FROM DEPT_TCL2;
SELECT * FROM DEPT;

/* �ϳ��� Ʈ������ ����:
 * TCL�� ������ �� ���� Ʈ������ ����
 * */


-- 2) Ʈ�������� ������ �ݿ��ϴ� COMMIT
-- : COMMIT �Ͻø� ROLLBACK �Ұ�!


SELECT * FROM DEPT_TCL2;
COMMIT -- TCL (���м�)

INSERT INTO DEPT_TCL2 VALUES(60, 'NETWORK', 'BUSAN');
ROLLBACK -- TCL (���м�)

UPDATE DEPT_TCL2 SET LOC = 'SEOUL' WHERE DEPTNO = 30;
--DELETE FROM DEPT_TCL2 WHERE DEPTNO = 60;
SELECT * FROM DEPT_TCL2;
COMMIT -- TCL (���м�)

ROLLBACK
SELECT * FROM DEPT_TCL2;
/* ���� COMMIT�� �Ǹ� ���̻� ROLLBACK�� ���� ���� */

-- Q1. ���� ���� ���� 
-- TABLE ACCOUNT_A
-- ������ �̸� (NAME, VARCHAR(10))
-- ���¹�ȣ (ACCOUNT, VARCHAR(20))
-- �ܾ� (BALANCE, VARCHAR(20))

-- TABLE ACCOUNT_B
-- ������ �̸� (NAME, VARCHAR(10))
-- ���¹�ȣ (ACCOUNT, VARCHAR(20))
-- �ܾ� (BALANCE, VARCHAR(20))

/* CREATE TABLE ���̺� �̸� {
 * 	�� �̸� �ڷ���,
 *  �� �̸� �ڷ���,
 * 
 *  �� �̸� �ڷ���
 * };
 * 
 * ACCOUNT_A (200), ACCOUNT_B (0) ���� �����͸� �Է�
 * A -> B ���� 200���� ��ü (COMMIT)
 * */

DROP TABLE ACCOUNT_A;
DROP TABLE ACCOUNT_B;

CREATE TABLE ACCOUNT_A (
	NAME	VARCHAR(10),
	ACCOUNT VARCHAR(20),
	BALANCE NUMBER(30)
);

CREATE TABLE ACCOUNT_B (
	NAME	VARCHAR(10),
	ACCOUNT VARCHAR(20),
	BALANCE NUMBER(30)
);


-- 0. INSERT INTO �ܾ��� �Է�
--   A: 200����, B: 0�� ����

INSERT INTO ACCOUNT_A
VALUES ('A', '1234-5678', 2000000);
COMMIT -- �����ݷ� ���� �ۼ�

INSERT INTO ACCOUNT_B
VALUES ('B', '1234-5678', 0);
COMMIT -- �����ݷ� ���� �ۼ�

SELECT * FROM ACCOUNT_A;
SELECT * FROM ACCOUNT_B;

ROLLBACK 
-- �����ݷ� ���� �ۼ�
-- COMMIT �ڿ� �ۼ��� DML (UPDATE, DELETE, INSERT)�� ���
-- ROLLBACK�� �ڵ尡 ����


-- 1. A�� ��ü�Ϸ��� �ϴ� �ݾ��� �߸� �Է����� �� (100����)
SAVEPOINT WITHDRAW;
UPDATE ACCOUNT_A
SET BALANCE = 1000000;
UPDATE ACCOUNT_B
SET BALANCE = 1000000;
ROLLBACK TO SAVEPOINT WITHDRAW

SELECT * FROM ACCOUNT_A;
SELECT * FROM ACCOUNT_B;

-- 2. A -> B ���������� ��ü�Ǿ��� �� (200����)
UPDATE ACCOUNT_A
SET BALANCE = 0;
UPDATE ACCOUNT_B
SET BALANCE = 2000000;
COMMIT


SELECT * FROM ACCOUNT_A;
SELECT * FROM ACCOUNT_B;

ROLLBACK

SELECT * FROM ACCOUNT_A, ACCOUNT_B;

/* [���� (session)]
 * : DB ������ �ǰ� ������ ������ ������ ��ü �Ⱓ
 * ex) �� �α��� ~ �α׾ƿ������� �Ⱓ
 * 
 * : ������ �������� Ʈ�������� ����
 * 
 * 
 */

CREATE TABLE SESSION_TEST
AS SELECT * FROM DEPT;

SELECT * FROM SESSION_TEST;

INSERT INTO SESSION_TEST
VALUES (50, 'DEVELOPER', 'SEOUL');

SELECT * FROM SESSION_TEST;
COMMIT

UPDATE SESSION_TEST 
SET LOC = 'BUSAN' 
WHERE DEPTNO = 50;

COMMIT

UPDATE SESSION_TEST 
SET LOC = 'JEJU' 
WHERE DEPTNO = 50;



/* �����ͺ��̽��� ���� �� ���� ���� (���� ������)
 * - COMMIT, ROLLBACK (Ʈ������ �Ϸ�)�� ���� ������ 
 * �ٸ� ���ǿ��� �������� ���� ������ �� �� ���� 
 * (�б� �ϰ���, read consistency) => ����
 * - �ٸ� ���ǿ����� ����� ������ ���� �����͸� ������
 * 
 * - Ư�� ���ǿ��� ���� (DML) ���� �����ʹ� ���� �� (LOCK)
 * : Ʈ�������� �Ϸ�Ǳ� ������ �ٸ� ���ǿ��� ������ �� ���� ����
 * : �����͸� �ٸ� ������ ������ �� ������ �����ϴ� ��
 * 
 * - LOCK ����
 * 1) ROW LEVEL LOCK (�� ���� ��)
 * : WHERE�� ���� Ư�� �ุ (����) ������ �ָ� 
 *   Ư�� �� �����͸� LOCK
 * 2) TABLE LEVEL LOCK (���̺� ���� ��)
 * : WHERE���� ���� ���۾��� ��� ��ü ���̺� ���� LOCK
 * 
 * - HANG (��): A ���ǿ��� ���� �Ϸ���� ��ٸ��� ���� (����)
 * - ����: A, B
 * - A: UPDATE ~~~~ 
 * - B: UPDATE ~~~~ (B�� HANG)
 * - A: COMMIT
 * - B: UPDATE ���� (DATA�� LOCK Ǯ��)
 * 
 * */

