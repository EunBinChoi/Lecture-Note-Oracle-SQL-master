-- SCOTT ���� Ȱ��ȭ
ALTER USER scott ACCOUNT UNLOCK;

-- SCOTT���� ������ �� �ִ� ���� �ο�
GRANT CONNECT, RESOURCE, UNLIMITED TABLESPACE TO scott
IDENTIFIED BY tiger;

-- SCOTT���� DBA ���� �ο�
-- DBA: DATABASE ADMIN
GRANT DBA TO scott;


SELECT *
  FROM EMP;

