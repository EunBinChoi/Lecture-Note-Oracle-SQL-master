/* 1) ����� ����
 * - ����� (user)
 * : DB�� �����ؼ� �����͸� �����ϴ� ����
 * 
 * - ����� ����
 * : ���� �����̳� ������ ����ؼ� ����ڸ� ����
 * 
 * 2) ��Ű�� (schema)
 * : ������ ���� ����, ��������, ���踦 ������ ����
 * 
 * - ����ڴ� ������ ���/������ ���� DB ����
 * - ��Ű���� DB�� ������ ����ڿ� ����� ��ü
 * 
 * EX) 
 * �����
 * : SCOTT
 * 
 * ��Ű��
 * : SCOTT ���� ��, ���̺�, ��������, �ε���, ������, ���Ǿ� ��
 * : SCOTT�� ������ ��ü 
 */


-- ����� ����
/* ����)
 * CREATE USER ����� �̸� (�ʼ�)
 * IDENTIFIED BY �н����� (�ʼ�)
 * DEFAULT TABLESPACE ���̺� �����̽� �̸� (����)
 * TEMPORARY TABLESPACE ���̺� �����̽� (�׷�) �̸� (����)
 * QUOTA ���̺� �����̽� ũ�� ON ���̺� �����̽� �̸� (����)
 * PASSWORD EXPIRE (����Ǵ�) (����)
 * ACCOUNT [LOCK/UNLOCK] (����, �⺻�� UNLOCK);
 * */

/* ���̺� �����̽�
 * : ����Ŭ ������ �����͸� �����ϴ� ����
 * : �� ��ü���� ���̺� �����̽��� ������ �� ����
 * 
 * oracle - ...oradata/[SID]/
 * oracle xe - ...oracl/xe/oradata/XE/
 * 
 * ���࿡ �������� ������ �ý��� ���̺����̽� -> �ý����� ����ȭ
 * �� ����ڰ� ������ �����Ϳ� ��ü�� 
 * ������ ���� ������ ������ ������ִ� ���� ����
 * 
 * */

CREATE USER EUNBINCHOI
IDENTIFIED BY 1234;

SELECT * FROM ALL_USERS;

/* CREATE USER�� DBA ������ ������ �ִ� ������ ����
 * SQLPLUS
 * SYSTEM/oracle
 * create user ~~~~
 * identified by ~~~;
 * 
 * */

/* ������� ������ SESSION ���� �� �ִ� ���� �����!
 * SQLPLUS
 * SYSTEM/oracle
 * GRANT CREATE SESSION TO _____ (���� �̸�);
 * */

-- ����� ���� ���� (�н�����) (DBA ������ ���� ���)
-- ���� ����� ����: EUNBINCHOI/1234 (���� �Ұ�)
-- DBA ������ ������ �ִ� ���� ����

ALTER USER EUNBINCHOI
IDENTIFIED BY eunbinchoi;

-- DBA ������ �ٸ� ������ �ο�
-- GRANT DBA TO ____ (���� �̸�);

-- ����� ����
DROP USER EUNBINCHOI;

-- ����ڷ� �����ؼ� ������ ��ü (���̺�, ��, ������, �ε��� ...)
-- �� ���� ���� �ϰ� ���� ���
DROP USER EUNBINCHOI CASCADE;

-- 2) ���� ����
-- : ����ڿ� ���� ������ ����ϰų� ������ �� �ִ� ���� ��ġ -> ����
-- : ���� ����ڿ� ���� ������ �� �ִ� ������ ������ ������ ����
-- : A. �ý��� ���� (system privilege)
-- : B. ��ü ���� (object privilege)

-- A. �ý��� ���� (system privilege)
-- : ����� ����, ���� ����/����, �����ͺ��̽� ����
-- : �ý��� ���� �з�
-- : USER: CREATE/ALTER/DROP USER
-- : SESSION: CREATE/ALTER SESSION
-- : TABLE: CREATE TABLE -- �ڽ��� ���̺� �����ϴ� ����
--			CREATE/ALTER/DROP/INSERT/UPDATE/DELETE/SELECT 
--			ANY TABLE 
			-- ���� ���� ���̺� ����/����/����/�����ͻ���/����/����/��ȸ ����
-- : INDEX
-- : VIEW
-- : SEQUENCE
-- : SYNONYM

/* �ý��� ����
 * GRANT [�ý��� ����] TO [����� �̸�]
 * [WITH ADMIN OPTION];
 * -- SYSTEM: GRANT CREATE SESSION TO EUNBINCHOI WITH ADMIN OPTION
 * -- EUNBINCHOI: GRANT CREATE SESSION TO OTHERUSER
 * -- SYSTEM >> EUNBINCHOI >> OTHERUSER
 * -- �߰��� EUNBINCHOI ������ ������� OTHERUSER�� ������ ������� 
 **/
 

CREATE USER EUNBINCHOI
IDENTIFIED BY 1234;

GRANT RESOURCE, CREATE SESSION, CREATE TABLE TO EUNBINCHOI;
-- RESOURCE: ������ �ϳ��� �����ִ� ����
-- GRANT RESOURCE�� ������ "���̺� �����̽� USER ������ �����ϴ�!"

-- �ý��� ���� ���
REVOKE RESOURCE, CREATE SESSION, CREATE TABLE FROM EUNBINCHOI;

SELECT * FROM DBA_ROLE_PRIVS WHERE GRANTEE ='EUNBINCHOI';
-- ����ڿ��� �ο��� �� ����

SELECT * FROM DBA_TAB_PRIVS WHERE GRANTEE ='EUNBINCHOI';
-- Ÿ ����ڿ��� �ο��� ��ü ����

SELECT * FROM DBA_SYS_PRIVS WHERE GRANTEE ='EUNBINCHOI';
-- ����ڿ��� �ο��� �ý����� ����

/* ��ü ���� (object privilege)
 * : Ư�� ����ڰ� ������ ��ü (���̺�/��/������...)�� ���õ� ����
 * ex) scott �������� ���� ���̺��� 
 * eunbinchoi���� insert, select�� �����ϵ��� ����
 * 
 * TABLE: ALTER/DELETE/INDEX (���̺� �ε��� ���� ����)/INSERT/SELECT/UPDATE/REFERENCES
 * VIEW: DELETE/INSERT/SELECT/UPDATE/REFERENCES (���� ������ ���� ����)
 * SEQUENCE: ALTER/SELECT (CURRVAL, NEXTVAL ��� ����)
 * 
 * 
 * ��ü ���� �ο�
 * GRANT [��ü ����/ALL PRIVILEGES] (�ʼ�)
 * ON [��ü �̸�] (�ʼ�)
 * TO [����� �̸�] (�ʼ�)
 * [WITH GRANT OPTION];
 * -- SYSTEM: GRANT ____ ON _____ TO EUNBINCHOI WITH GRANT OPTION
 * -- EUNBINCHOI: GRANT CREATE SESSION TO OTHERUSER
 * -- SYSTEM >> EUNBINCHOI >> OTHERUSER
 * -- �߰��� EUNBINCHOI ������ ������� OTHERUSER�� ������ ������� 
 * 
 */

CREATE TABLE PRIV_TEST(
	COL1 VARCHAR(20),
	COL2 VARCHAR(20)
);
 
DROP USER EUNBINCHOI;
CREATE USER EUNBINCHOI
IDENTIFIED BY 1234;

-- �ý��� ���� (CREATE SESSION, CREATE TABLE) (���� ����, ���̺� ����, ���� ����)
-- �� ���� (RESOURCE)
GRANT RESOURCE, CREATE SESSION, CREATE TABLE TO EUNBINCHOI;
SELECT * FROM DBA_SYS_PRIVS WHERE GRANTEE ='EUNBINCHOI';
-- Ÿ ����ڿ��� �ο��� �ý��� ����

-- ��ü ���� (SELECT, INSERT, UPDATE)
GRANT SELECT ON PRIV_TEST TO EUNBINCHOI WITH GRANT OPTION;
GRANT INSERT ON PRIV_TEST TO EUNBINCHOI WITH GRANT OPTION;
GRANT UPDATE ON PRIV_TEST TO EUNBINCHOI WITH GRANT OPTION;
SELECT * FROM DBA_TAB_PRIVS WHERE GRANTEE ='EUNBINCHOI';
-- Ÿ ����ڿ��� �ο��� ��ü ����

-- ��ü ������ �ϰ������� �� ���� ����
GRANT SELECT, INSERT, UPDATE ON PRIV_TEST TO EUNBINCHOI;

-- EUNBINCHOI �������� (SQLPLUS EUNBINCHOI/1234)
-- Q1. �����͸� 2������ INSERT
INSERT INTO SCOTT.PRIV_TEST
VALUES ('HI', 'HELLO');

INSERT INTO SCOTT.PRIV_TEST
VALUES ('JAVA', 'SQL');

SELECT * FROM SCOTT.PRIV_TEST;

-- Q2. �����͸� UPDATE
UPDATE SCOTT.PRIV_TEST
SET COL1 = 'ORACLE DB'
WHERE COL1 = 'JAVA';


-- ��ü ���� ���
REVOKE SELECT, INSERT, UPDATE ON PRIV_TEST FROM EUNBINCHOI;

-- SQLPLUS
-- SELECT * FROM SCOTT.RPIV_TEST
-- "TABLE OR VIEW DOES NOT EXIST"

/* 3) �� (role, ����) ����
 * : ���ο� ������� ���� ���� ������ �ο������ �� (����)
 * : �� (role): ���� ���� ������ ������� �׷�
 * : �� ���ҿ� ���� �ѹ��� �ο��ϰ� ������ �� ���� >> �����ϱ� ����
 * 
 * 
 * : ����Ŭ DB������
 * A. ����Ŭ�� ������ ��
 * - CONNECT (�⺻): CREATE SESSION (/TABLE/SEQUENCE .... ����Ŭ 10�������� �����)
 * - RESOURCE (�⺻): ����� ���̺� + �ٸ� ��ü (�ε���, ������ ...)���� ������ �� �ִ� �ý��� ����
 * CREATE TABLE/SEQUENCE .....
 * 
 * * ��, ���Ǿ� �����ϰ� ������ ���� ������ �ּž� ��
 * CREATE VIEW/SYNONYM
 * 
 * - DBA
 * : DB�� �����ϴ� �ý��� ������ ��κ� ������ ����
 * 
 * 
 * B. ����ڰ� ������ ��
 * : ����ڰ� �ʿ信 ���� �ʿ��� ������ ������� ���� ����
 * 1) CREATE ROLE������ �� ����
 * 2) GRANT ��ɾ ���� �ѿ� ������ ���Խ�Ŵ
 * 3) GRANT ��ɾ�� �ش� ���� Ư�� ����ڿ��� �ο�
 * 4) REVOKE ��ɾ�� �� ���
 * */

-- ����� �� ����
CREATE ROLE EUNBINROLE;

-- ������ ������ �ο�
GRANT CONNECT, RESOURCE, CREATE VIEW, CREATE SYNONYM TO EUNBINROLE;

-- ���� EUNBINCHOI ����ڿ��� �ο�
GRANT EUNBINROLE TO EUNBINCHOI WITH ADMIN OPTION;

SELECT * FROM DBA_ROLE_PRIVS WHERE GRANTEE ='EUNBINCHOI'; -- ��
SELECT * FROM DBA_SYS_PRIVS WHERE GRANTEE ='EUNBINCHOI';  -- �ý��� ����
SELECT * FROM DBA_TAB_PRIVS WHERE GRANTEE ='EUNBINCHOI'; -- ��ü ����

-- �ο��� �� ���
REVOKE EUNBINROLE FROM EUNBINCHOI;

-- �� ����
DROP ROLE EUNBINROLE;

-- ���� ��� �ο�
GRANT ALL PRIVILEGES TO EUNBINCHOI;


