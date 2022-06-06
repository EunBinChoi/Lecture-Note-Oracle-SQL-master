/*
���� ���� ���α׷�

-- ���ݱ��� �ۼ��� PL/SQL ����� �̸����� �ۼ� (�͸� ��� (anonymous block))
-- : ����Ŭ DB�� ����Ǵ� �� �ƴ�

-- ���� ���� ���α׷� (stored subprogram)
-- : PL/SQL�� �̸��� �ٿ� ����Ŭ�� �����ϴ� ���α׷�
-- : EX) ���ν��� (procedure), �Լ� (function), ��Ű�� (package), Ʈ���� (trigger)

-- ���� ?
-- 1) �ʿ��� ������ ������ �� ����
-- 2) �̸��� �־ �ٸ� ������� �����ϱ� ����
-- 3) �ٸ� ���α׷����� ȣ���ϱ� ����

*/

/* 
1) ���ν���

CREATE [OR REPLACE] PROCEDURE ���ν��� �̸�
IS | AS -- ����� (DECLARE ��� ���, ����ΰ� ��� ������ �ۼ�)
BEGIN
EXCEPTION -- ���� ����
END [���ν��� �̸�]; -- ���ν��� �̸��� ���� ����

ON REPLACE: ���� �̸��� ���ν����� �ִ� ��� ���� ���ν����� ��ü

*/

-- ���ν��� ����
CREATE OR REPLACE PROCEDURE PRO_TEST
IS
    DEPT_ROW DEPT%ROWTYPE;
BEGIN
    SELECT * INTO DEPT_ROW
    FROM DEPT
    WHERE DEPTNO = 10;
    
    DBMS_OUTPUT.PUT_LINE('DEPTNO : ' || DEPT_ROW.DEPTNO);
    DBMS_OUTPUT.PUT_LINE('DNAME : ' || DEPT_ROW.DNAME);
    DBMS_OUTPUT.PUT_LINE('LOC : ' || DEPT_ROW.LOC);
END;
/
-- DEPTNO�� 10�� �μ������� ROWTYPE�� ���� (DEPT_ROW)�� �����ϴ� ���ν���

-- ���ν��� ���� (EXECUTE ���ν��� �̸�;)
EXECUTE PRO_TEST;

-- �͸� ��� ������ ���ν��� ����
BEGIN
    PRO_TEST;
END;
/

-- ���ν��� ��� Ȯ��
SELECT * FROM USER_SOURCE;

-- ���ν��� ���� Ȯ��
SELECT * FROM USER_SOURCE
WHERE NAME = 'PRO_TEST';

-- ���ν��� ���� (DROP PROCEDURE)
DROP PROCEDURE PRO_TEST;

-- �Ķ���͸� ����ϴ�  ���ν���
-- : ���ν����� �����ϱ� ���� �Է� �����Ͱ� �ʿ��� ��� �Ķ���� ����

/*
����)

CREATE [OR REPLACE] PROCEDURE ���ν��� �̸�
[(�Ķ���� �̸�1[modes (���� ����)] �ڷ��� [ := | DEFAULT �⺻�� (���� ����)],
  �Ķ���� �̸�2[modes (���� ����)] �ڷ��� [ := | DEFAULT �⺻�� (���� ����)],
 .......
 )]

IS | AS -- ����� (DECLARE ��� ���, ����ΰ� ��� ������ �ۼ�)
BEGIN
EXCEPTION -- ���� ����
END [���ν��� �̸�]; -- ���ν��� �̸��� ���� ����

ON REPLACE: ���� �̸��� ���ν����� �ִ� ��� ���� ���ν����� ��ü
[modes]: 
IN: ���ν��� ȣ�� �� �ʿ��� �� (�⺻��)
OUT: ���ν��� ��ȯ �� �ʿ��� ��
IN OUT: ȣ�� �� �� �Է��� �ް� ��� ��ȯ�� ��
*/


-- IN ��� �Ķ����
CREATE OR REPLACE PROCEDURE PRO_TEST_PRAM_IN
(
    -- NUMBER(max length): � ���� �� �� �� (�ִ� ���̸� ���� X)
   PARAM1 IN NUMBER,
   PARAM2 NUMBER DEFAULT 3,
   PARAM3 NUMBER,
   PARAM4 NUMBER DEFAULT 4
   -- * �⺻�� (����Ʈ��) �ڿ������� ������� (����������) �Ҵ� (���� ����)
   -- * ����Ŭ 11 ���� �̻���� ����Ʈ ���� ���������� ���� �ʾƵ� �� (���ڷ� �����͸� ������ �� �Ű����� �̸��� ���� �������� ��)
)
IS
BEGIN
    DBMS_OUTPUT.PUT_LINE('PARAM1 : ' || TO_CHAR(PARAM1));
    DBMS_OUTPUT.PUT_LINE('PARAM2 : ' || TO_CHAR(PARAM2));
    DBMS_OUTPUT.PUT_LINE('PARAM3 : ' || TO_CHAR(PARAM3));
    DBMS_OUTPUT.PUT_LINE('PARAM4 : ' || TO_CHAR(PARAM4));
END;
/
SET SERVEROUTPUT ON;
EXECUTE PRO_TEST_PRAM_IN(10, 20, 30, 40);
EXECUTE PRO_TEST_PRAM_IN(10, 20); -- PARAM1: 10, PARAM2: 20, PARAM3 �����Ͱ� ���� ����, PARAM4 : 4
EXECUTE PRO_TEST_PRAM_IN(10, 20, 30); -- PARAM1: 10, PARAM2: 20, PARAM3: 30, PARAM4 : 4
EXECUTE PRO_TEST_PRAM_IN(PARAM1 => 10, PARAM3 => 20); -- ����Ŭ 11 �̻���� ����!

-- PARAM3, PARAM4 �⺻�� ����

-- OUT��� �Ķ����
-- : ���ν��� ���� �� ȣ���� ���α׷����� �� ��ȯ

CREATE OR REPLACE PROCEDURE PRO_TEST_PRAM_OUT(
    IN_EMP IN EMP.EMPNO%TYPE, -- IN�� ���� ����! (���ν��� ȣ���� �� ���޵Ǵ� ��)
    OUT_EMP OUT EMP.ENAME%TYPE, -- ��ȯ��
    OUT_SAL OUT EMP.SAL%TYPE -- ��ȯ��
)
IS
BEGIN
    SELECT ENAME, SAL INTO OUT_EMP, OUT_SAL -- 'SMITH', 800
    FROM EMP
    WHERE EMPNO = IN_EMP; -- 7369
END PRO_TEST_PRAM_OUT; -- ��ȯ ���� ���� ���
/

-- PROCEDURE(�����ȣ, ����̸�, �޿�)
select * from emp;
DECLARE
    PRO_OUTPUT_ENAME EMP.ENAME%TYPE;
    PRO_OUTPUT_SAL EMP.SAL%TYPE;
    
BEGIN
    PRO_TEST_PRAM_OUT(7369, PRO_OUTPUT_ENAME, PRO_OUTPUT_SAL);
    DBMS_OUTPUT.PUT_LINE('ENAME : ' || PRO_OUTPUT_ENAME);
    DBMS_OUTPUT.PUT_LINE('SAL : ' || TO_CHAR(PRO_OUTPUT_SAL));
END;
/

SET SERVEROUTPUT ON;

SELECT * FROM EMP;

-- PRO_TEST_PRAM_OUT ���ν��� �̿��ؼ� 7566 ����� �̸��� �޿��� ���!
DECLARE
    PRO_OUTPUT_ENAME EMP.ENAME%TYPE;
    PRO_OUTPUT_SAL EMP.SAL%TYPE;
    
BEGIN
    PRO_TEST_PRAM_OUT(7566, PRO_OUTPUT_ENAME, PRO_OUTPUT_SAL);
    DBMS_OUTPUT.PUT_LINE('ENAME : ' || PRO_OUTPUT_ENAME);
    DBMS_OUTPUT.PUT_LINE('SAL : ' || TO_CHAR(PRO_OUTPUT_SAL));
END;
/

-- IN OUT ��� �Ķ����
-- : IN, OUT ���ÿ� ����

-- ���ν��� �ϳ� ����, �Ķ���� INOUT_NUM NUMBER 
CREATE OR REPLACE PROCEDURE PRO_TEST_IN_OUT(
    INOUT_NUM IN OUT NUMBER
)
IS
BEGIN
    INOUT_NUM := INOUT_NUM * 100;
END PRO_TEST_IN_OUT; -- ��ȯ���� ���� ��쿡�� END �ڿ� ���ν��� �̸� �ۼ�!
/

DECLARE
    NUM NUMBER := 5;
BEGIN
    PRO_TEST_IN_OUT(NUM);
    DBMS_OUTPUT.PUT_LINE('NUM : ' || TO_CHAR(NUM));
END;
/

-- ���ν��� ���� ������ ��
CREATE OR REPLACE PROCEDURE PRO_ERROR
IS -- �����
    ERROR_NO NUMBER;
BEGIN
    ERROR_NO = 100; -- ���� ������ �߸� �ۼ� (:= -> =)
    DBMS_OUTPUT.PUT_LINE('ERROR_NO : '|| TO_CHAR(ERROR_NUM));
END;
/

-- �����Ϸ� �α� Ȯ�ι�
SHOW ERRORS;
SHOW ERR;

SHOW ERRORS PROCEDURE PRO_ERROR;
-- SHOW ERRORS/ERR ���α׷� ���� ���α׷� �̸�;

SELECT *
FROM USER_ERRORS -- ������ ���� (SQL DEVELOPER ��ȸ �Ұ�)
WHEN NAME = 'PRO_ERROR';

/*
2) �Լ� (FUNCTION)
���ν��� VS �Լ� (SUBSTR, MAX, MIN, .... ���� �Լ� / ����� ����)

���ν���: PL/SQL ȣ�� ����, �Ķ���� ��� (IN, OUT, IN OUT), 
��ȯ�� (OUT ��� �Ķ����)�� ���� ���� �� ����

�Լ�: SQL, PL/SQL ȣ�� ����, �Ķ���� ��� (IN, ����), 
��ȯ���� ���� �ϳ� (RETURN���� �ۼ�)

*/

/* ����� ���� �Լ� ����

����)
CREATE [OR REPLACE] FUNCTION �Լ� �̸�
[(�Ķ���� �̸�1[modes (���� ����)] �ڷ��� [ := | DEFAULT �⺻�� (���� ����)],
  �Ķ���� �̸�2[modes (���� ����)] �ڷ��� [ := | DEFAULT �⺻�� (���� ����)],
 .......
 )]
RETURN �ڷ���; -- ��ȯ���� �ڷ���

IS | AS -- ����� (DECLARE ��� ���, ����ΰ� ��� ������ �ۼ�)
BEGIN
    RETURN (��ȯ��);
EXCEPTION -- ���� ����
END [���ν��� �̸�]; -- ���ν��� �̸��� ���� ����

*/

-- �Լ� ���� (�� ����/�Ǽ�...�� ����)
CREATE OR REPLACE FUNCTION ADD_FUNC(
    ANUMBER NUMBER, -- IN ���
    BNUMBER NUMBER -- IN ���
)
RETURN NUMBER -- ��ȯ��
IS -- �����
BEGIN -- �����
    RETURN ANUMBER + BNUMBER;
END ADD_FUNC;
/


DECLARE
    RESNUMBER NUMBER;
BEGIN
    RESNUMBER := ADD_FUNC(10, 20);
    DBMS_OUTPUT.PUT_LINE('�� ���� �� : ' || TO_CHAR(RESNUMBER));
END;
/

-- �Լ� ����
-- SAL * 12 + COMM
-- �Ҽ��� �ι�° �ڸ������� ǥ�� (����° �ڸ����� �ݿø�)

CREATE OR REPLACE FUNCTION ANNSAL(
    EMP_SAL EMP.SAL%TYPE,
    EMP_COMM EMP.COMM%TYPE
)
RETURN NUMBER
IS
BEGIN
    RETURN (ROUND(EMP_SAL * 12 + NVL(EMP_COMM, 0), 2)); -- RETURN �ڿ� �Ұ�ȣ! �ʿ�
END ANNSAL;
/

-- ���ν��� (PLSQL������ ����� �� ����)�� �ٸ��� �Լ��� PLSQL, SQL������ ����� ����!
-- SQL (SELECT FROM~)
SELECT EMPNO, ENAME, ANNSAL(SAL, COMM)
FROM EMP;

-- PL/SQL (SELECT INTO FROM~, ��ȯ�� �ϳ�)
DECLARE
    T_EMPNO EMP.EMPNO%TYPE;
    T_ENAME EMP.ENAME%TYPE;
    T_ANNSAL NUMBER;
BEGIN
    -- ��ȯ���� �ϳ��� �ƴ϶� ������ �� ����
    SELECT EMPNO, ENAME, ANNSAL(SAL, COMM) 
    INTO T_EMPNO, T_ENAME, T_ANNSAL
    FROM EMP;    
END;
/


-- �Լ� ����
DROP FUNCTION ANNSAL;


/*
3) ��Ű�� (package)
: ��� ������ ����� ���ν���, �Լ� ���� �ϳ��� ��� �����ϴ� ��ü
: ��Ű�� = ���ν���1, ���ν���2, �Լ�1, �Լ�2 .... (����� ����� �ϴ� ���α׷��� ��� ����)

����?
1) ���� ���� (��Ű���� �ϳ��� ���ν� ǥ��)
2) �� ���� ���α׷��� ���� ���� (�ܺ� ���� / ���� ����)
*/

-- ��Ű��
-- 1) �� (�����)
/*
����)
CREATE [OR REPLACE] PACKAGE ��Ű�� �̸�
IS | AS
    ���� ���α׷� ����
END [��Ű�� �̸�];
*/

CREATE OR REPLACE PACKAGE PKG_TEST
IS
    FUNCTION ANNSAL(EMP_SAL EMP.SAL%TYPE, EMP_COMM EMP.COMM%TYPE) RETURN NUMBER;
    /*IN (��Ű�� �� �ۼ��� IN �κи� �Ķ���� �ۼ�), OUT (��Ű�� ���� �ۼ��� �Ķ���� �ۼ�)*/
    PROCEDURE PRO_EMP(EMP_EMPNO EMP.EMPNO%TYPE); 
    -- EMPNO (IN ��� �Ķ����)�� ���� ��� �̸�, �޿� (OUT ��� �Ķ����)�� ��ȯ
    PROCEDURE PRO_DEPT(DEPT_DEPTNO DEPT.DEPTNO%TYPE); 
    -- DEPTNO (IN ��� �Ķ����)�� ���� �μ� �̸�, �μ� ��ġ (OUT ��� �Ķ����)�� ��ȯ
END;
/

-- ��Ű�� ��ȸ (USER_SOURCE ������ ���� ��ȸ OR DESC ��ɾ�)
SELECT * 
FROM USER_SOURCE
WHERE TYPE = 'PACKAGE';

DESC PKG_TEST;
-- DESCRIBE ��ɾ� (��ü�� ���� Ȯ��)
DESC EMP;
DESC DEPT;

-- 2) ���� (body)
/*
����)
CREATE [OR REPLACE] PACKAGE BODY ��Ű�� �̸�
IS | AS
   ��Ű�� ������ ������ �������α׷��� ����
END [��Ű�� �̸�];
*/



CREATE OR REPLACE PACKAGE BODY PKG_TEST
IS
    FUNCTION ANNSAL(EMP_SAL EMP.SAL%TYPE, EMP_COMM EMP.COMM%TYPE) RETURN NUMBER
        IS
        BEGIN
            RETURN (ROUND(EMP_SAL * 12 + NVL(EMP_COMM, 0), 2));
    END ANNSAL;
    
    /*IN (��Ű�� �� �ۼ��� IN �κи� �Ķ���� �ۼ�),
    OUT (��Ű�� ���� �ۼ��� �Ķ���� �ۼ�)*/
    PROCEDURE PRO_EMP(EMP_EMPNO EMP.EMPNO%TYPE) -- EMPNO (IN ��� �Ķ����)�� ���� ��� �̸�, �޿� (OUT ��� �Ķ����)�� ��ȯ
        IS
            EMP_ENAME EMP.ENAME%TYPE; 
            -- OUT ��带 �ۼ����� �ʾƵ� ��Ű�� �������� 
            -- ���ǵǴ� �Ķ���ʹ� OUT ����̱� ������ ���� ����
            EMP_SAL EMP.SAL%TYPE;
        BEGIN
            SELECT ENAME, SAL INTO EMP_ENAME, EMP_SAL
            FROM EMP
            WHERE EMPNO = EMP_EMPNO;
            
            DBMS_OUTPUT.PUT_LINE('ENAME : ' || EMP_ENAME);
            DBMS_OUTPUT.PUT_LINE('SAL : ' || TO_CHAR(EMP_SAL));
    END PRO_EMP;
    
    PROCEDURE PRO_DEPT(DEPT_DEPTNO DEPT.DEPTNO%TYPE) -- DEPTNO (IN ��� �Ķ����)�� ���� �μ� �̸�, �μ� ��ġ (OUT ��� �Ķ����)�� ��ȯ
        IS
            DEPT_DNAME DEPT.DNAME%TYPE;
            DEPT_LOC DEPT.LOC%TYPE;
        BEGIN
            SELECT DNAME, LOC INTO DEPT_DNAME, DEPT_LOC
            FROM DEPT
            WHERE DEPTNO = DEPT_DEPTNO;
            
            DBMS_OUTPUT.PUT_LINE('DNAME : ' || DEPT_DNAME);
            DBMS_OUTPUT.PUT_LINE('LOC: ' || DEPT_LOC);
    END PRO_DEPT; -- ���ν��� ���� ��
END; -- ��Ű�� �ٵ� ��
/

SHOW ERRORS;

-- ��Ű�� ��� (��Ű�� �̸�.�Լ�/���ν��� �̸� (IN��� �Ķ����))
DECLARE
    IN_SAL EMP.SAL%TYPE;
    IN_COMM EMP.COMM%TYPE;
BEGIN
    SELECT SAL, COMM INTO IN_SAL, IN_COMM
    FROM EMP
    WHERE EMPNO = 7839;

    DBMS_OUTPUT.PUT_LINE('ANNSAL :  ' || TO_CHAR(PKG_TEST.ANNSAL(IN_SAL, IN_COMM))); -- ��� ��ȣ �ش��ϴ� ����� ���� ��� (SAL * 12 + COMM)
    PKG_TEST.PRO_EMP(7839); -- EMPNO�� IN���� �Ѱ��ָ� ENAME, SAL ��ȯ
    PKG_TEST.PRO_DEPT(10); -- DEPTNO�� IN���� �Ѱ��ָ� DNAME, LOC ��ȯ
    
END;
/

SELECT * FROM EMP;

-- ��Ű�� ����
-- DROP PACKAGE ��Ű�� �̸�; -- �� + ���� �Ѳ����� ����
-- DROP PACKAGE BODY ��Ű�� �̸� -- ������ ����

DROP PACKAGE PKG_TEST;

-- 4) Ʈ���� (trigger)
-- : �����̳� �̺�Ʈ�� �߻��� ��쿡 �ڵ����� ����Ǵ� ���
-- EX) ���� ������Ʈ�� �ð� ���߸� �� �� �ְ� ����ٰų� DML �۾��� �Ϸ��� �ϴµ� ���Ƴ��� ���� ����

-- : ������ ���� �۾��� �����ϰ� ������ �� ������ �ʹ� ���� �ۼ��� �ϸ� DB ������ ����

-- Ʈ���ŷ� ������ �� �ִ� ���� 
-- (BEFORE (��� ���� ����), AFTER (��� �����ϰ� �ش� ��ɿ� ���� �α�))
/*
1) DML: INSERT, UPDATE, DELETE
2) DDL: CREATE, DROP, ALTER
3) DB ����: SERVERERROR, LOGON, LOGOFF, STARTUP, SHUTDOWN
*/

/*
1) DML Ʈ����

����)
CREATE [OR REPLACE] TRIGGER Ʈ���� �̸�
BEFORE | AFTER -- BEFORE: DML ��ɾ� ���� ��, AFTER: DML ��ɾ� ���� �� ������ Ʈ���� ����
INSERT | UPDATE | DELETE ON ���̺� �̸�
FOR EACH ROW WHEN ���ǽ�
*/

-- Ʈ���� ���� �� ��� (BEFORE)
CREATE TABLE EMP_TRG
AS SELECT * FROM EMP;

CREATE OR REPLACE TRIGGER TRG_EMP_NODML_WEEKEND
BEFORE -- ��ɾ� ��� ���� ����
INSERT OR UPDATE OR DELETE ON EMP_TRG   
BEGIN
    IF TO_CHAR(SYSDATE, 'DY') IN ('��', '��') THEN
        IF INSERTING THEN
--            DBMS_OUTPUT.PUT_LINE('�ָ� ������� �߰� �Ұ�!');
               RAISE_APPLICATION_ERROR(-20000, '�ָ� ������� �߰� �Ұ�!'); 
               -- ������� ���� ���� (-20000 ~ -20999)
        ELSIF UPDATING THEN
--            DBMS_OUTPUT.PUT_LINE('�ָ� ������� ���� �Ұ�!');
            RAISE_APPLICATION_ERROR(-20001, '�ָ� ������� ���� �Ұ�!');
        ELSIF DELETING THEN
--            DBMS_OUTPUT.PUT_LINE('�ָ� ������� ���� �Ұ�!');
              RAISE_APPLICATION_ERROR(-20002,  '�ָ� ������� ���� �Ұ�!');
        ELSE
--            DBMS_OUTPUT.PUT_LINE('�ָ� ������� ���� �Ұ�!');
               RAISE_APPLICATION_ERROR(-20003, '�ָ� ������� ���� �Ұ�!');
        END IF;
    END IF;
END;
/

UPDATE EMP_TRG
SET SAL = 3000
WHERE EMPNO = 7566;

SELECT * FROM EMP_TRG;

-- Ʈ���� ���� �� ��� (AFTER)
-- : DML ��ɵ� �Ŀ� �۵�
-- : DML ��ɾ� �α׿� ����

CREATE TABLE EMP_TRG_LOG(
    TABLENAME VARCHAR2(10),  -- DML�� ����� ���̺� �̸�
    DMLTYPE VARCHAR2(10), -- DML ��ɾ� ����
    EMPNO NUMBER,
    USERNAME VARCHAR2(20), -- DML�� ������ ����� �̸�
    CHANGEDATE DATE -- DML ����� ��¥
);

-- EMP_TRG ���̺� DML ��ɾ� ������ �� (AFTER)
-- EMP_TRG_LOG ���̺� 
-- ������ ������� �α׷� ����ϴ� Ʈ���� ����

CREATE OR REPLACE TRIGGER TRG_EMP_LOG
AFTER
INSERT OR UPDATE OR DELETE ON EMP_TRG
FOR EACH ROW -- DML ����� �Ǵ� �� �ະ�� Ʈ���Ű� �۵�
BEGIN
    IF INSERTING THEN
        INSERT INTO EMP_TRG_LOG
        VALUES ('EMP_TRG', 'INSERT', 
        :NEW.EMPNO, 
        -- ���� �߰��� ���� EMPNO�� �α׷� ����
        SYS_CONTEXT('USERENV', 'SESSION_USER'),
        -- ���� DB�� ���� ���� ����ڸ� ��ȯ
        SYSDATE);
    ELSIF UPDATING THEN
        INSERT INTO EMP_TRG_LOG
        VALUES ('EMP_TRG', 'UPDATE', 
        :OLD.EMPNO, 
        -- ���� �� EMPNO�� �α׷� ����
        SYS_CONTEXT('USERENV', 'SESSION_USER'),
        -- ���� DB�� ���� ���� ����ڸ� ��ȯ
        SYSDATE);
    ELSIF DELETING THEN
        INSERT INTO EMP_TRG_LOG
        VALUES ('EMP_TRG', 'DELETE', 
        :OLD.EMPNO, 
        -- ���� �� EMPNO�� �α׷� ����
        SYS_CONTEXT('USERENV', 'SESSION_USER'),
        -- ���� DB�� ���� ���� ����ڸ� ��ȯ
        SYSDATE);
    END IF;
END;
/

INSERT INTO EMP_TRG
VALUES (9999, 'EUNBIN', 'DEVELOPER', 7900, 
TO_DATE('2019-03-03', 'YYYY-MM-DD'), 1200, NULL, 20);
COMMIT;

-- �α� ���̺� Ȯ��
SELECT * FROM EMP_TRG_LOG;

SELECT * FROM EMP_TRG;

UPDATE EMP_TRG
SET SAL = 1300
WHERE MGR = 7698;
-- �� 5���� �࿡ ���ؼ� Ʈ���Ű� ����� (FOR EACH ROW �ɼ�)

COMMIT;

SELECT * FROM EMP_TRG_LOG;

-- Ʈ���� ���� ��ȸ (USER_TRIGGERS ������ ���� ��ȸ)
SELECT *
FROM USER_TRIGGERS;

-- Ʈ���� ����
DROP TRIGGER TRG_EMP_LOG;