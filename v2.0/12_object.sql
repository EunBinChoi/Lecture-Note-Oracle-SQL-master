-- ��ü (Object) ����
-- 1) ���̺� (table): ������ ���� ����
-- 2) �� (view) : ���̺� �Ϻ�/��ü�� ������ ���̺�� �� �� �ֵ��� �ϴ� ��ü
--                 : ������ ��ü�� ������ �ִ� �� �ƴϰ� SQL�� ����
SELECT * FROM EMP WHERE ENAME LIKE '%S%';
SELECT * FROM EMP;

-- �� ���� ����
-- cmd
-- sqlplus
-- system/oracle
-- grant create view to scott;
DROP VIEW VW_EMP_ENAME_WITH_S;
CREATE OR REPLACE VIEW VW_EMP_ENAME_WITH_S
AS (SELECT * FROM EMP WHERE ENAME LIKE '%S%');

SELECT * FROM USER_VIEWS;
SELECT * FROM VW_EMP_ENAME_WITH_S;

-- �̹� ������ �̸����� ���̺��� �ִ� ��쿡 REPLACE �ϰڴ�!
CREATE OR REPLACE VIEW VW_EMP_ENAME_WITH_S
AS (SELECT * FROM EMP WHERE ENAME LIKE '%S%');

SELECT * FROM VW_EMP_ENAME_WITH_S;
INSERT INTO VW_EMP_ENAME_WITH_S VALUES (8000, 'SALLY', 'CLERK', 7839, SYSDATE, 3000, NULL, 20); -- �� Ȯ��
INSERT INTO VW_EMP_ENAME_WITH_S VALUES (9000, 'AALLY', 'CLERK', 7839, SYSDATE, 3000, NULL, 20); -- �� Ȯ�� X
SELECT * FROM VW_EMP_ENAME_WITH_S; -- ENAME�� S�� �������� �ʴ� AALLY�� VIEW�� Ȯ�� �Ұ�
COMMIT;

SELECT * FROM EMP;

CREATE OR REPLACE VIEW VW_EMP_ENAME_WITH_A
AS (SELECT * FROM EMP WHERE ENAME LIKE '%A%')
WITH CHECK OPTION;

INSERT INTO VW_EMP_ENAME_WITH_A VALUES (6000, 'GOOTT', 'CLERK', 7839, SYSDATE, 3000, NULL, 20);
SELECT * FROM EMP;

SELECT * FROM USER_VIEWS;

-- EMP ���̺��� VIEW�� ������ �� ������ ��ü�� �̸��� �� ������ �¾ƾ� �Ѵ�!
CREATE OR REPLACE VIEW VW_EMP ("NUMBER", "NAME", "DATE")
AS (SELECT EMPNO, ENAME FROM EMP);
SELECT * FROM VW_EMP;

-- FORCE VS NOFORCE
-- FORCE: �� �����ϰ��� �ϴ� ����ڰ� �ٸ� ������� ���̺��� �����ؼ� �並 �����ϰ��� �� �� 
-- ���Ѿ�� �� ���� ����
-- NOFORCE: �� �����ϰ��� �ϴ� ����ڰ� �ٸ� ������� ���̺��� �����ؼ� �並 �����ϰ��� �� �� 
-- �������� ���� �� ���� ����

CREATE OR REPLACE FORCE VIEW VW_EMP_FORCE
AS (SELECT * FROM SYSTEM.SYSFILES);

CREATE OR REPLACE NOFORCE VIEW VW_EMP_NOFORCE
AS (SELECT * FROM SYSTEM.SYSFILES);


/*
CREATE (OR REPLACE) (FORCE/NOFORCE) VIEW �� �̸� (�ʼ�) (�� �̸�, ..)
AS (SELECT ����) (�ʼ�)

(WITH CHECK OPTION (CONSTRAINT ���� ����)) 
(WITH READ ONLY (CONSTRAINT ���� ����))

���� ���׵�
- OR REPLACE: ���� �̸��� �䰡 ������ ��� �� ��ü
- FORCE: SELECT ������ ������ ���̺��� ��� ���� ����
- NOFORCE: SELECT ������ ������ ���̺��� ��� ���� ���� X (�⺻��)
- �� �̸�: SELECT�� ��õ� �̸� ��� ����� �̸� ���� 
- WITH CHECK OPTION: DML �۾� �����ϵ��� �� ����
- WITH READ ONLY: �� ������ �����ϵ��� �� ����
*/


-- 3) ������ ���� (data dictionary)
-- : DB ��ϱ� ���� �߿��� ������ ���� ����
-- : USER_: SCOTT�� ��ü ����
-- : ALL_: ��� ������� ��ü ����
SELECT * FROM DICT;

SELECT TABLE_NAME FROM USER_TABLES;
SELECT OWNER, TABLE_NAME FROM ALL_TABLES;

-- 4) �ε��� (index)
-- : INDEX SCAN VS TABLE FULL SCAN
-- : B TREE�� �̿��ؼ� ����

-- (*) PRIMARY KEY�� �ε����� ������ �ϴ���?
-- : PRIMARY KEY�� NOT NULL, �ߺ� ������� �ʱ� ����

-- ����
-- �ε����� ������ ���� ���� �����͸� �˻��ϴ� �� ���� ���
-- (1) WHERE��, ORDER BY�� + (�ε����� ������ �� �̸�)
-- (2) MIN(), MAX()

-- ����
-- �׻� ���ĵ� ���¸� �����ؾ��ϱ� ������ INSERT, DELETE, UPDATE���� ������ �� ����
-- �ε����� ���� ���� ������ ������ �� ���� (���� 10% ����)

-- �ε��� ���� ���
-- (1) WHERE���� ���� ���� ��
-- (2) ORDER BY���� ���� ���� ��
-- (3) ���� ���� ��� ��
-- (4) �ߺ� �����Ͱ� �ּ��� ��

SELECT * FROM USER_INDEXES;

-- �ε��� ����
CREATE INDEX EMP_SIMPLE_ENAME_IDX ON EMP_SIMPLE(ENAME);
SELECT * FROM USER_INDEXES;

-- �ε��� ����
DROP INDEX EMP_SIMPLE_ENAME_IDX;
SELECT * FROM USER_INDEXES;


-- 5) ������ (sequence)
-- : ���ӵǴ� ���� ���� ��ü
-- EX) �Խ��� �� ��� ��ȣ: 1, 2, 3, 4....

-- ������ ����
DROP SEQUENCE DEPT_SIMPLE_SEQUENCE;
CREATE SEQUENCE DEPT_SIMPLE_SEQUENCE
INCREMENT BY 10 
-- �������� (���/����) (����Ʈ 1)
START WITH 10 
-- ���ۼ��� 
-- �������ڰ� ����� ��쿡�� ����Ʈ�� MINVALUE
-- �������ڰ� ������ ��쿡�� ����Ʈ�� MAXVALUE
MAXVALUE 90 
-- �ִ� (NOMAXVALUE / MAXVALUE)
-- �������ڰ� ����� ��쿡�� ����Ʈ�� 1027
-- �������ڰ� ������ ��쿡�� ����Ʈ�� -1
-- (*) ���ۼ��ڶ� ���ų� ���ۼ��ں��� Ŀ�� ��
-- (*) MINVALUE���ٴ� Ŀ�� ��
MINVALUE 0
-- �ּڰ� (NOMINVALUE / MINVALUE)
-- �������ڰ� ����� ��쿡�� ����Ʈ�� 1
-- �������ڰ� ������ ��쿡�� ����Ʈ�� -1028
-- (*) ���ۼ��ڶ� ���ų� ���ۼ��ں��� �۾ƾ� ��
-- (*) MAXVALUE���ٴ� �۾ƾ� ��
CYCLE
-- CYCLE: �ִ񰪿� �����ϰ� �Ǹ� �ٽ� MINVALUE���� ����
-- NOCYCLE: �ִ񰪿� �����ϰ� �Ǹ� ���� ����
CACHE 9;
-- CACHE n: �������� �̸� �Ҵ�� ���� �ο� (n: ĳ���� ������)
-- NO CACHE: �������� �̸� �Ҵ�� ���� �ο� X
-- CEIL(MAXVALUE - MINVALUE) / INCREMENT BY �̸� ���� ���� �� ����
-- (90 - 0) / 10 == 9 ����
-- cycle: 0 10 20 30 40 50 ... 90 (10ȸ)

SELECT * FROM USER_SEQUENCES;
SELECT CACHE_SIZE FROM USER_SEQUENCES;


-- ������ ���
-- CURRVAL: ���������� ������ ��ȣ ��ȯ
-- (*) �������� ���� ��ȣ�� �ѹ��� ������ ���� ������ CURRVAL�� ����Ϸ��� �ϸ� ����!
-- NEXTVAL: ���� ������ ��ȣ ��ȯ

SELECT * FROM DEPT_SIMPLE;
INSERT INTO DEPT_SIMPLE
VALUES (DEPT_SIMPLE_SEQUENCE.NEXTVAL, 'ACCOUNTING', 'SEOUL');
SELECT * FROM DEPT_SIMPLE;
COMMIT;

SELECT DEPT_SIMPLE_SEQUENCE.CURRVAL FROM DUAL;

-- ������ ���� (INCREMENT, MAXVALUE, MINVALUE, CYCLE,... (START WITH ���� �Ұ�))
ALTER SEQUENCE DEPT_SIMPLE_SEQUENCE
INCREMENT BY 1
CYCLE;

SELECT * FROM USER_SEQUENCES;
SELECT DEPT_SIMPLE_SEQUENCE.NEXTVAL FROM DUAL;

-- ������ ����
DROP SEQUENCE DEPT_SIMPLE_SEQUENCE;
SELECT * FROM USER_SEQUENCES;


-- 6) ���Ǿ� (synonym)
-- : �ٸ� ������ �ִ� ���̺�, �並 ������ �� �����̸�.���̺�/���̸����� �����ؾ� ��!
-- : �����̸�.���̺�/���̸��� ����� �� �ִ� ���Ǿ ���� ���

-- cmd
-- sqlplus
-- system/oracle
-- grant create synonym to scott;
-- grant create public synonym to scott;

/*
CREATE (PUBLIC) SYNONYM ���Ǿ� �̸�
FOR �����.��ü �̸�

PUBLIC (����) - ��� ����ڰ� �ش� ���Ǿ ����� �� ����
(�����ϸ� ���Ǿ ������ ����ڸ� ��� ����)
�����. (����) - ������ ���Ǿ��� ���� ����� ����
(�����ϸ� ���� ������ ����� ����)
��ü �̸� (�ʼ�) - ���Ǿ ������ ��ü �̸� (���̺�, ��, ������)

�� ���Ǿ� VS ���̺� ��Ī (FROM ���̺�� ��Ī)
: ���Ǿ�� DB�� ����Ǵ� ��ü -> ��ȸ�� X
: ���̺� ��Ī -> ��ȸ��

*/

CREATE SYNONYM EMP_S
FOR SCOTT.EMP_SIMPLE;

SELECT * FROM USER_SYNONYMS;
SELECT * FROM EMP_S;

CREATE SYNONYM FILES
FOR SYSTEM.SYSFILES;

SELECT * FROM USER_SYNONYMS;
SELECT * FROM FILES;

-- ���Ǿ� ����
DROP SYNONYM EMP_S;
DROP SYNONYM FILES;

-- ���Ǿ� ��ȸ
SELECT * FROM USER_SYNONYMS; -- ����ڸ� �� �� �ִ� ���Ǿ� ��ȸ
SELECT * FROM ALL_SYNONYMS WHERE OWNER = 'SCOTT'; -- PUBLIC�ϰ� ������ ���Ǿ� ��ȸ

