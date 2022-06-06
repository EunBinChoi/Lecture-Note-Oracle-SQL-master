-- ����� ����, �� ����, ���� ����

-- USER: SYSTEM/ORACLE (DBA) �����ؼ� ����� ����

-- ����� ����
CREATE USER eunbin
IDENTIFIED BY eunbin
DEFAULT TABLESPACE USERS QUOTA UNLIMITED ON USERS;

-- ���� ����
-- DEFAULT TABLESPACE ���̺� �����̽� �̸� (EX) USERS)
-- QUOTA ���̺� �����̽� ũ�� ON ���̺� �����̽� �̸� (EX) QUOTA UNLIMITED ON USERS)
-- ACCOUNT LOCK/UNLOCK (�⺻��)

-- ����� ����
-- DROP USER eunbin CASCADE;
-- CASCADE: eunbin ������ ���� ��ü (table, view ...) ���� ����

-- ����� ����
-- ���� �ο�: GRANT ���� �̸� TO ����� �̸�
GRANT RESOURCE, CREATE SESSION, CREATE TABLE TO eunbin;
-- ���� ���: REVOKE ���� �̸� FROM ����� �̸�
REVOKE RESOURCE, CREATE SESSION, CREATE TABLE FROM eunbin;

-- ����� ���� Ȯ��
SELECT * FROM DBA_SYS_PRIVS WHERE GRANTEE = 'EUNBIN';
