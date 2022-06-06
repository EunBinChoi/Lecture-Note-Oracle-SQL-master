/*
������ �ڷ���
1) ��Į���� (SCALAR TYPE)
-- : ����Ŭ���� �����ϴ� �⺻��
-- : ���ο� �� ���� ���� �ϳ�
-- EX) VARCHAR, NUMBER, DATE, BOOLEAN (PL/SQL)

2) ������ (REFERENCE TYPE, %ROWTYPE, %TYPE)
-- : �� ���� (���̺��̸�%ROWTYPE): ���̺� �� �ڷ��� ��� ���� (SELECT * INTO ������) (����/�ڷ���/���� ��� ��ġ)
-- : �� ���� (���̺��̸�.���̸�%TYPE): ���� �� �ڷ��� ���� (���� �ڷ����� ������ 1��)

3) ������ (COMPOSITE TYPE)
-- : ���� ������ ���� �����͸� ������ �� �ִ� �ڷ���
-- A. ���ڵ� (RECORD): ���̺��� �� (�������� �ڷ����� ���� �� �ϼ��� ����)
-- B. �÷��� (COLLECTION): ���̺��� �� (�������� �ڷ����� �ϳ�)

A. ���ڵ�
����)
TYPE ���ڵ��̸� IS RECORD(
    �����̸� �ڷ��� NOT NULL := (�Ǵ� DEFAULT) �� 
);

-- �����̸�: ���ڵ� �ȿ� �� ���� ���� (���� �� �� �� ���� (, ����))
-- �ڷ���: ������ �ڷ��� ���� (%TYPE, %ROWTYPE ����)
-- NOT NULL, DEFAULT ���� ����
*/

DECLARE
    -- ���ڵ嵵 �ϳ��� �ڷ��� (Ŭ����)
    TYPE REC_TEST IS RECORD(
        DEPTNO DEPT.DEPTNO%TYPE, 
        DNAME DEPT.DNAME%TYPE,
        LOC DEPT.LOC%TYPE
    );
    DEPT_REC REC_TEST; -- ���ڵ� Ÿ���� ���� DEPT_REC ���� ����
    DEPT_REC2 REC_TEST; -- ���ڵ� Ÿ���� ���� DEPT_REC2 ���� ����
BEGIN
    -- �� ���ڵ忡 ���Ե� ������ ���ڵ��̸�.�����̸����� ��� ����
    DEPT_REC.DEPTNO := 50;
    DEPT_REC.DNAME := 'DB';
    DEPT_REC.LOC := 'USA';
    
    -- ������ ���ϴ� �ɷ� ����!
    DEPT_REC2.DEPTNO := 60;
    DEPT_REC2.DNAME := 'WEB DEVELOPER';
    DEPT_REC2.LOC := 'SEOUL';
    
    -- ���
    /*
    DBMS_OUTPUT.PUT(): print()
    DBMS_OUTPUT.PUT_LINE(): println()
    */
    DBMS_OUTPUT.PUT_LINE('DEPT_REC.DEPTNO : ' || DEPT_REC.DEPTNO);
    DBMS_OUTPUT.PUT_LINE('DEPT_REC.DNAME : ' || DEPT_REC.DNAME);
    DBMS_OUTPUT.PUT_LINE('DEPT_REC.LOC : ' || DEPT_REC.LOC);
    
    DBMS_OUTPUT.PUT_LINE('DEPT_REC2.DEPTNO : ' || DEPT_REC2.DEPTNO);
    DBMS_OUTPUT.PUT_LINE('DEPT_REC2.DNAME : ' || DEPT_REC2.DNAME);
    DBMS_OUTPUT.PUT_LINE('DEPT_REC2.LOC : ' || DEPT_REC2.LOC);
    
END;
/

SELECT * FROM DEPT;

-- ���ڵ带 �̿��ؼ� TABLE�� INSERT, UPDATE�� ����
-- 1) DEPT_RECORD ���̺� ���� (DEPT ���̺��� ������ �����͸� ��� ������ ��)
DROP TABLE DEPT_RECORD;
CREATE TABLE DEPT_RECORD
AS SELECT * FROM DEPT;

SELECT * FROM DEPT_RECORD;


-- 2) ���ڵ� �̿��ؼ� �����͸� INSERT
DECLARE
    -- ���ڵ嵵 �ϳ��� �ڷ��� (Ŭ����)
    TYPE REC_TEST IS RECORD(
        DEPTNO DEPT.DEPTNO%TYPE, 
        DNAME DEPT.DNAME%TYPE,
        LOC DEPT.LOC%TYPE
    );
    DEPT_REC REC_TEST; -- ���ڵ� Ÿ���� ���� DEPT_REC ���� ����
    DEPT_REC2 REC_TEST; -- ���ڵ� Ÿ���� ���� DEPT_REC2 ���� ����
BEGIN
    -- �� ���ڵ忡 ���Ե� ������ ���ڵ��̸�.�����̸����� ��� ����
    DEPT_REC.DEPTNO := 50;
    DEPT_REC.DNAME := 'DB';
    DEPT_REC.LOC := 'USA';
    
    -- ������ ���ϴ� �ɷ� ����!
    DEPT_REC2.DEPTNO := 60;
    DEPT_REC2.DNAME := 'WEB DEVELOPER';
    DEPT_REC2.LOC := 'SEOUL';
    
    -- VALUES ���� �����͸� ���� �� �ϳ��ϳ� ������ ���
    -- VALUES�� ���ڵ带 ���� �� ��ü�� ���� (���ڵ� �̸��� ���)
    INSERT INTO DEPT_RECORD
    VALUES DEPT_REC;
    
    INSERT INTO DEPT_RECORD
    VALUES DEPT_REC2;
END;
/

SELECT * FROM DEPT_RECORD;


-- 3) ���ڵ� �̿��ؼ� �����͸� UPDATE
DECLARE
    -- ���ڵ嵵 �ϳ��� �ڷ��� (Ŭ����)
    TYPE REC_TEST IS RECORD(
        DEPTNO DEPT.DEPTNO%TYPE, 
        DNAME DEPT.DNAME%TYPE,
        LOC DEPT.LOC%TYPE
    );
    DEPT_REC REC_TEST; -- ���ڵ� Ÿ���� ���� DEPT_REC ���� ����
    DEPT_REC2 REC_TEST; -- ���ڵ� Ÿ���� ���� DEPT_REC2 ���� ����
    DEPT_REC_REVISED REC_TEST; -- ���ڵ� Ÿ���� ���� DEPT_REC_REVISED ���� ���� (������ �����͸� ����)
BEGIN
--    -- �� ���ڵ忡 ���Ե� ������ ���ڵ��̸�.�����̸����� ��� ����
--    DEPT_REC.DEPTNO := 50;
--    DEPT_REC.DNAME := 'DB';
--    DEPT_REC.LOC := 'USA';
--    
--    -- ������ ���ϴ� �ɷ� ����!
--    DEPT_REC2.DEPTNO := 60;
--    DEPT_REC2.DNAME := 'WEB DEVELOPER';
--    DEPT_REC2.LOC := 'SEOUL';

    DEPT_REC_REVISED.DEPTNO := 50;
    DEPT_REC_REVISED.DNAME := 'DATABASE';
    DEPT_REC_REVISED.LOC := 'BUSAN';
    
    
    -- VALUES�� ���ڵ带 ���� �� ��ü ���� (UPDATE ~~  SET + ROW Ű����)
    UPDATE DEPT_RECORD
    SET ROW = DEPT_REC_REVISED
    WHERE DEPTNO = 50;
    
END;
/

SELECT * FROM DEPT_RECORD;


-- Q1. ���̺� ���� (GOOTT_STUDENT)
-- �Ӽ�: ID, NUMBER(4)
--      NAME, VARCHAR(10)
--      SEATNUM, NUMBER(2)

-- ���̺��� �� �̸��� ������ ���� ��Ȯ�ϰ� �����ϴ� ���� ���� 
--(���� ����ϴ� ID, NAME .... ������� �ʴ� �� ����)

DROP TABLE GOOTT_STUDENT;
CREATE TABLE GOOTT_STUDENT(
    STUID NUMBER(4),
    STUNAME VARCHAR(10),
    SEATNUM NUMBER(2)
);

-- ���̺��� �����͸� �����ϱ� ���� ���ڵ带 �����ϰ� ���ڵ带 ���� �����͸� ����
-- (1, 'EUNBIN', 0)
-- (2, 'GILDONG', 5)

DECLARE
    TYPE STUDENT IS RECORD(
        STUID GOOTT_STUDENT.STUID%TYPE,
        STUNAME GOOTT_STUDENT.STUNAME%TYPE,
        SEATNUM GOOTT_STUDENT.SEATNUM%TYPE
    );  
    STUDENT_REC1 STUDENT;
    STUDENT_REC2 STUDENT;
BEGIN
    STUDENT_REC1.STUID := 1;
    STUDENT_REC1.STUNAME := 'EUNBIN';
    STUDENT_REC1.SEATNUM := 0;

    STUDENT_REC2.STUID := 2;
    STUDENT_REC2.STUNAME := 'GILDONG';
    STUDENT_REC2.SEATNUM := 1;
    
    INSERT INTO GOOTT_STUDENT
    VALUES STUDENT_REC1;

    INSERT INTO GOOTT_STUDENT
    VALUES STUDENT_REC2;
    
END;
/
SELECT * FROM GOOTT_STUDENT;

-- ������ ���ڵ带 ���� �����͸� ����
DECLARE
    TYPE STUDENT IS RECORD(
        STUID GOOTT_STUDENT.STUID%TYPE,
        STUNAME GOOTT_STUDENT.STUNAME%TYPE,
        SEATNUM GOOTT_STUDENT.SEATNUM%TYPE
    );
    
    STUDENT_REC_REVISED STUDENT;
BEGIN
    STUDENT_REC_REVISED.STUID := 2;
    STUDENT_REC_REVISED.STUNAME := 'GILDONG';
    STUDENT_REC_REVISED.SEATNUM := 5;

    UPDATE GOOTT_STUDENT
    SET ROW = STUDENT_REC_REVISED
    WHERE STUID = 2;
END;
/



-- ���ڵ� �ȿ� ���ڵ� (��ø ���ڵ�, nested record)
-- class Student{
--      int id;
--      String name;
--      Department department; 
--}


DECLARE
    TYPE REC_DEPT IS RECORD(
        DEPTNO DEPT.DEPTNO%TYPE,
        DNAME DEPT.DNAME%TYPE,
        LOC DEPT.LOC%TYPE
    );                
    TYPE REC_EMP IS RECORD(
        EMPNO EMP.EMPNO%TYPE,
        ENAME EMP.ENAME%TYPE,
        DEPART REC_DEPT -- ���ڵ� �ȿ� ���ڵ尡 �� ����
    );
    EMP_INFO REC_EMP;
BEGIN
    -- EMP ���̺��� ��� ��ȣ 7654�� ����� ���� (EMPNO, ENAME, DEPART (DEPTNO, DNAME, LOC))
    SELECT E.EMPNO, E.ENAME, E.DEPTNO, D.DNAME, D.LOC
    INTO EMP_INFO.EMPNO, EMP_INFO.ENAME, EMP_INFO.DEPART.DEPTNO, EMP_INFO.DEPART.DNAME, EMP_INFO.DEPART.LOC
    -- �� �̸� ����, ����, �ڷ��� ��ġ
    
    FROM EMP E JOIN DEPT D ON (E.DEPTNO = D.DEPTNO)
    WHERE E.EMPNO = 7654;
    
    DBMS_OUTPUT.PUT_LINE('EMPNO : ' || EMP_INFO.EMPNO);
    DBMS_OUTPUT.PUT_LINE('ENAME : ' || EMP_INFO.ENAME);
    DBMS_OUTPUT.PUT_LINE('DEPTNO : ' || EMP_INFO.DEPART.DEPTNO);
END;
/

SELECT * FROM EMP;

-- B. �÷���
-- : ������ �ڷ����� ������ �����͸� ������ �� ����
-- : ���̺��� ���� ���� ����

-- ���� �迭 (+ �ݺ���)
-- : associative array (or index by table)
-- : Ű (key)(�ε���) + �� (value)
-- : Ű (�ε���) �ߺ� X

/*
����)
TYPE ���� �迭 �̸� IS TABLE OF �ڷ��� [NOT NULL (���� ����)] -- �ڷ���: ��Į����, ������ (%TYPE, %ROWTYPE)
INDEX BY �ε��� �ڷ���; -- ���� (BINARY_INTEGER, PLS_INTEGER) (PL/SQL ������ �ڷ���) (**), ������ (VARCHAR, VARCHAR2)
*/


DECLARE
    -- �÷��� (�ڷ���)
    TYPE ARRAY_TEST IS TABLE OF VARCHAR(20)
    INDEX BY PLS_INTEGER;
    -- �ε��� (����)�� ���� ARRAY_TEST �迭 ���Ҹ� ����
    -- �ε��� (����): -1, 0, 1, 2, .....100
    ARRAY_TEST1 ARRAY_TEST;
BEGIN
    ARRAY_TEST1(0) := '0�� ������';
    ARRAY_TEST1(2) := '2�� ������';
    ARRAY_TEST1(3) := '3�� ������';
    
    DBMS_OUTPUT.PUT_LINE(ARRAY_TEST1(0));
    DBMS_OUTPUT.PUT_LINE(ARRAY_TEST1(2));
    DBMS_OUTPUT.PUT_LINE(ARRAY_TEST1(3));
END;
/

-- ���� �迭�� �ݺ����� ������ ������ �� �ִ� �� ����!
DECLARE
    -- ���� �迭 + ���ڵ� (record)
    -- ���� �迭 �ȿ� ������ �ڷ����� ���ڵ尡 �� ���� ���� (���̺��� ������ ������ �� �ִ� �ڷ���)
--    TYPE REC_DEPT IS RECORD (
--        DEPTNO DEPT.DEPTNO%TYPE,
--        DNAME DEPT.DNAME%TYPE,
--        LOC DEPT.LOC%TYPE
--    );

    
--    TYPE ASSARRAY IS TABLE OF REC_DEPT
--    INDEX BY PLS_INTEGER;
--    
    -- ���� �迭 �ȿ� ������ �ڷ����� ROWTYPE (�� ������)�� �� ���� ���� 
    -- (������ ���̺��� �ְ�, �ش� ���̺��� ������ ������ ���� ������)
    TYPE ASSARRAY IS TABLE OF DEPT%ROWTYPE
    INDEX BY PLS_INTEGER;
    DEPT_ARRAY ASSARRAY;
    idx PLS_INTEGER := 0;
    
BEGIN
    -- i (counter): %ROWTYPE
    FOR i IN (SELECT DEPTNO, DNAME, LOC FROM DEPT) LOOP
        idx := idx + 1;
        DEPT_ARRAY(idx).DEPTNO := i.DEPTNO;
        DEPT_ARRAY(idx).DNAME := i.DNAME;
        DEPT_ARRAY(idx).LOC := i.LOC;
        
        DBMS_OUTPUT.PUT_LINE(DEPT_ARRAY(idx).DEPTNO || ' ' || DEPT_ARRAY(idx).DNAME || ' ' || DEPT_ARRAY(idx).LOC);
        
    END LOOP;

END;
/

-- EMP ���̺��� EMPNO, ENAME, JOB�� ������ �ڷ����� �����ϴ� RECORD �����, 
-- �ش� RECORD�� �ϳ��� ��ҷ� ���� ���� �迭�� ������!

-- �׸��� EMP ���̺��� EMPNO, ENAME, JOB�� �����ؼ� �����迭�� ���� �� ����غ���!

DECLARE
    TYPE REC_EMP IS RECORD (
        EMPNO EMP.EMPNO%TYPE,
        ENAME EMP.ENAME%TYPE,
        JOB EMP.JOB%TYPE
    );
    TYPE ASSARRAY IS TABLE OF REC_EMP -- (EMP%ROWTYPE �����ұ�� ? ����� (���� ������ �� ����))
    INDEX BY PLS_INTEGER;
    
    EMP_ARRAY ASSARRAY;
    idx PLS_INTEGER := 0;
    
BEGIN
    FOR i IN (SELECT EMPNO, ENAME, JOB FROM EMP) LOOP
        idx := idx + 1;
        EMP_ARRAY(idx).EMPNO := i.EMPNO;
        EMP_ARRAY(idx).ENAME := i.ENAME;
        EMP_ARRAY(idx).JOB := i.JOB;
        
        DBMS_OUTPUT.PUT_LINE(EMP_ARRAY(idx).EMPNO || ' ' || EMP_ARRAY(idx).ENAME || ' ' || EMP_ARRAY(idx).JOB);
        
    END LOOP;

END;
/


SELECT * FROM EMP;


-- �÷��� �޼ҵ�
/*
1) EXISTS(n): n �ε����� ������ �����ϸ� true, �������� ������ false
2) COUNT: ����� ��� ���� ��ȯ
3) FIRST: ù��° �ε��� ��ȣ ��ȯ
4) LAST: ������ �ε��� ��ȣ ��ȯ
5) PRIOR(n): n �ε��� �ٷ� �� �ε��� �� ��ȯ (������ NULL ��ȯ)
6) NEXT(n): n �ε��� �ٷ� ���� �ε��� �� ��ȯ (������ NULL ��ȯ)
7) DELETE: ����� ��Ҹ� ����
DELETE: ��� ��� ����
DELETE(n): n �ε����� ��Ҹ� ����
DELETE(n, m): n �ε��� ~ m �ε��� ��Ҹ� ����

* �÷��� �̸�.�޼ҵ� �̸� ȣ�� (�޼ҵ� �̸��� () ����)
*/

DECLARE
    TYPE ARRAY_METHOD IS TABLE OF VARCHAR(20)
    INDEX BY PLS_INTEGER;
    
    TEST_ARRAY ARRAY_METHOD;
BEGIN
    TEST_ARRAY(1) := '1�� ������';
    TEST_ARRAY(2) := '2�� ������';
    TEST_ARRAY(3) := '3�� ������';
    TEST_ARRAY(-50) := '-50�� ������';
    TEST_ARRAY(100) := '100�� ������';
    
    IF TEST_ARRAY.EXISTS(1) THEN
        DBMS_OUTPUT.PUT_LINE('1�� �ε��� ��� ����!');
    ELSE
        DBMS_OUTPUT.PUT_LINE('1�� �ε��� ��� ���� X');
    END IF;
    
    IF TEST_ARRAY.EXISTS(-50) THEN
        DBMS_OUTPUT.PUT_LINE('-50�� �ε��� ��� ����!');
    ELSE
        DBMS_OUTPUT.PUT_LINE('-50�� �ε��� ��� ���� X');
    END IF;
    
    IF TEST_ARRAY.EXISTS(100) THEN
        DBMS_OUTPUT.PUT_LINE('100�� �ε��� ��� ����!');
    ELSE
        DBMS_OUTPUT.PUT_LINE('100�� �ε��� ��� ���� X');
    END IF;

    TEST_ARRAY.DELETE(1); -- 1�� ��� ����
    IF TEST_ARRAY.EXISTS(1) THEN
        DBMS_OUTPUT.PUT_LINE('1�� �ε��� ��� ����!');
    ELSE
        DBMS_OUTPUT.PUT_LINE('1�� �ε��� ��� ���� X');
    END IF;
    
    TEST_ARRAY.DELETE(2, 3); -- 2 ~ 3�� ��� ����
    
    DBMS_OUTPUT.PUT_LINE(TEST_ARRAY.COUNT);
    DBMS_OUTPUT.PUT_LINE(TEST_ARRAY.FIRST);
    DBMS_OUTPUT.PUT_LINE(TEST_ARRAY.LAST);
    DBMS_OUTPUT.PUT_LINE(TEST_ARRAY.PRIOR(50));
    DBMS_OUTPUT.PUT_LINE(TEST_ARRAY.NEXT(-100));
END;
/
