/* ������ ���Ǿ� (DDL, Data Definition Language)
 * : ���� ��ü (object)�� ����, ����, ���� ���� ���
 * �� ��ü ? ���̺�
 * 
 * : ��ü ����: CREATE
 * : ��ü ����: ALTER
 * : ��ü ����: DROP
 * 
 * ** ���� ������ �ٷ� �ݿ� (�ٷ� �ڵ� COMMIT, ROLLBACK �Ұ�)
 * 
 * 
 */


-- ��ü ���� (CREATE)
/* CREATE TABLE ��������(SYSTEM/SCOTT).���̺�� (
 * 	���̸� �ڷ���,
 *  ���̸� �ڷ���,
 *  ���̸� �ڷ���
 * );
 * 
 * 
 * - ���̺�� ����
 * 1) ���̺�� �ߺ� X
 * 2) 30byte ���� (���� 30����, �ѱ� 15����)
 * 3) ���̺� �̸� ���̿� Ư�����ڰ� �� �� ���� (_, #, $)
 *  -> ù ���ڴ� ����! (EMP11(O), 11EMP(X))
 * 4) Ű���� ��� �Ұ� (SELECT, DROP, FROM ..)
 * 
 * 
 * - �� �̸� ����� ��Ģ
 * 1) ù���� ���� ����
 * 2) 30byte ����
 * 3) �ϳ��� ���̺� �ȿ��� �� �̸� �ߺ� X (EMPNO, EMPNO (X))
 * 4) �� �̸� ���̿� Ư�����ڰ� �� �� ���� (_, #, $)
 * 5) Ű���� ��� �Ұ�
 * */


-- [CREATE]
-- ���̺� �����ϴ� ��ɾ�

SELECT * FROM TAB;
-- Q1. CREATE TABLE ATTENDANCE
-- �� 1: �⼮��¥
-- �� 2: �⼮�� ��� �̸�
-- �� 3: �⼮ �ο�
-- �� 4: ��ü �µ�



DROP TABLE ATTENDANCE;


CREATE TABLE ATTENDANCE(
	ATTENDDATE DATE,
	PARTICIPANT VARCHAR2(10),
	ID NUMBER(10),
	TEMP NUMBER(10, 2)
);

-- ������ 3�� ���� ATTENDANCE ���̺� �߰�! (DML)
INSERT INTO ATTENDANCE
VALUES (TO_DATE('2021-07-30', 'YYYY-MM-DD'), -- SYSDATE
		'ȫ�浿', 1, '35.5');
INSERT INTO ATTENDANCE
VALUES (TO_DATE('2021-07-30', 'YYYY-MM-DD'), -- SYSDATE
		'�ڹڹ�', 2, '35.2');
INSERT INTO ATTENDANCE
VALUES (TO_DATE('2021-07-30', 'YYYY-MM-DD'), -- SYSDATE
		'ȫȫȫ', 3, '34.5');
COMMIT
	
SELECT * FROM ATTENDANCE;	
	
-- ���� ATTENDANCE ���̺� ���� (��� ������)
DROP TABLE ATTENDANCE_TEMP;
CREATE TABLE ATTENDANCE_TEMP
AS SELECT * FROM ATTENDANCE;

SELECT * FROM ATTENDANCE_TEMP;

-- ���� ���̺� ������ ���� (�� �̸��� ������ ��)
DROP TABLE ATTENDANCE_TEMP2;
CREATE TABLE ATTENDANCE_TEMP2
AS SELECT * FROM ATTENDANCE WHERE 1 <> 1;
-- ���ǹ��� false�� �Ǵ� ������ �߰��ϸ� ������ ������ ���� ����

SELECT * FROM ATTENDANCE_TEMP2;

-- �Ϻ� �����͸� ���� (ID = 1�� ����� ����)�ؼ� ���ο� ���̺� ����
DROP TABLE ATTENDANCE_TEMP3;
CREATE TABLE ATTENDANCE_TEMP3
AS SELECT * FROM ATTENDANCE WHERE ID = 1;

SELECT * FROM ATTENDANCE_TEMP3;

-- [ALTER]
-- ���̺� �����ϴ� ��ɾ�

CREATE TABLE ATTENDANCE_ALTER
AS SELECT * FROM ATTENDANCE;

SELECT * FROM ATTENDANCE_ALTER;

-- ���̺� �� �� �̸� ����

-- 1) �� �̸� �߰� ADD
-- : �������⿩�� (ISSUBMITTED, VARCHAR2(1))
ALTER TABLE ATTENDANCE_ALTER
ADD ISSUBMITTED VARCHAR2(1);

SELECT * FROM ATTENDANCE_ALTER;

-- 2) �� �̸� ���� RENAME
ALTER TABLE ATTENDANCE_ALTER
RENAME COLUMN ISSUBMITTED TO ISSUBMIT;

-- 3) �� ������ �ڷ��� ���� MODIFY ('O', 'X' -> 1, 0)
ALTER TABLE ATTENDANCE_ALTER
MODIFY ISSUBMIT NUMBER(1);

-- 4) �� ���� DROP (DROP TABLE / "DROP COLUMN")
ALTER TABLE ATTENDANCE_ALTER
DROP COLUMN ISSUBMIT;

SELECT * FROM ATTENDANCE_ALTER;


-- ���̺� ����
-- 1) ���̺� �̸� ���� RENAME (RENAME COLUMN - ���̺� �� �̸� ����)
RENAME ATTENDANCE_ALTER TO ATTENDANCE_RENAME;

SELECT * FROM ATTENDANCE_ALTER; -- ��� �Ұ�
SELECT * FROM ATTENDANCE_RENAME;

-- 2) ���̺� ���� ��� ������ ���� TRUNCATE
TRUNCATE TABLE ATTENDANCE_RENAME;

SELECT * FROM ATTENDANCE_RENAME;

/* TRUNCATE VS DELETE
 * - TRUNCATE (DDL) - �ڵ� COMMIT (ROLLBACK �Ұ�) 
 * 							    (�ǵ��� �� .. ����)
 * - DELETE (*) (DML) - �츮�� COMMIT�� ����� DB ����!
 * */

-- 3) ���̺� ���� DROP (DROP TABLE ~~)
DROP TABLE SSS; 
-- TABLE DOES NOT EXIST! (����)
-- ���� �ش��ϴ� ���̺� �̸��� ���� ���

DROP TABLE ATTENDANCE_RENAME;
SELECT * FROM ATTENDANCE_RENAME;
-- TABLE DOES NOT EXIST! (����)
-- ���� �ش��ϴ� ���̺��� DROP �Ǿ��� ���

