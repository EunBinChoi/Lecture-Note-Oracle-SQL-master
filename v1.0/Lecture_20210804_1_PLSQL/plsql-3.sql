/*
Ŀ�� (Cursor)
: SELECT�� �Ǵ� DML (Data Manipulation Lang., ������ ���۾�)�� ���� SQL���� �������� ��
 �ش� SQL���� ó���� �� �ִ� �޸� ���� (Private SQL Area)
 
 : Ŀ���� �޸� ������ �ּҸ� ����Ű�� ������
 : SELECT, DML�� ���� �����ؾ� �ϴ� ���� ���� ���� �� Ŀ�� �̿�
 
 1) ����� Ŀ�� (explicit cursor)
 2) �Ͻ��� Ŀ�� (implicit cursor)
 
 SELECT ___ INTO ROWTYPE�� ����
 : ��ȸ���� �� �����Ͱ� �ϳ��� �ุ ����
 : Ŀ���� ���� ���� �� ��ȸ (������ ��� ���� �ϳ����� ���� �� ���� ��) -> Ŀ���� ���� �� ����
*/

/* 1) ����� Ŀ��
   : ��������� ����ڰ� ���� Ŀ���� �����ϰ� ����ϴ� Ŀ��
   
   A. Ŀ�� ���� (declaration)
   : SQL�� �Բ� ���� 
   
   B. Ŀ�� ���� (open)
   : Ŀ�� ������ �� �ۼ��� SQL�� ����
   : ACTIVE SET: SQL���� ���� �޴� ��
   
   C. Ŀ���� ���� �о�� ������ ��� (fetch)
   : SQL�� ��� ������ ���� �����ϰ� �ʿ��� �۾��� ����
   : �� �� ���� �۾��� �ϱ� ���� �ݺ����� ���� ���
   
   D. Ŀ�� �ݱ� (close)
   : ��� �࿡�� ��� �� Ŀ�� ����

����)
DECLARE
    CURSOR Ŀ�� �̸� IS SQL�� - Ŀ�� ����
BEGIN
    OPEN Ŀ�� �̸�; - Ŀ�� ���� 
    FETCH Ŀ�� �̸� INTO ������; - Ŀ���� ���� �о�� ������ ��� 
    CLOSE Ŀ�� �̸�; - Ŀ�� �ݱ�
END;
/


*/

-- �ϳ��� �ุ ��ȸ�� ���� Ŀ�� ��� (�� �Ⱦ� ..!) => Ŀ���� ��ȸ�Ǵ� ���� ���� ���϶� ����!
DECLARE
    DEPT_ROW DEPT%ROWTYPE;
    
    -- Ŀ�� ����� ���� 
    CURSOR TEST_CURSOR IS
    SELECT *
    FROM DEPT
    WHERE DEPTNO = 40;
BEGIN
    -- Ŀ�� ���� (Active Set Ȯ��)
    OPEN TEST_CURSOR;

    -- Ŀ���� ���� �����͸� DEPT_ROW ������ ���� 
    FETCH TEST_CURSOR INTO DEPT_ROW;
    
    DBMS_OUTPUT.PUT_LINE('DEPTNO : ' || DEPT_ROW.DEPTNO);
    DBMS_OUTPUT.PUT_LINE('DNAME  : ' || DEPT_ROW.DNAME);
    DBMS_OUTPUT.PUT_LINE('LOC : ' || DEPT_ROW.LOC);
    
    CLOSE TEST_CURSOR;
END;
/

-- ���� �� ��ȸ�Ǵ� ��� (+ LOOP��)
DECLARE
    DEPT_ROW DEPT%ROWTYPE;
    
    -- Ŀ�� ����
    CURSOR C1 IS
    SELECT *
    FROM DEPT;
    
BEGIN
    -- Ŀ�� ����
    -- SQL������ ������� ���� Ȯ���� �� ���� (ACTIVE SET)
    OPEN C1;
    
    LOOP
        -- Ŀ���� ���� ���� �����͸� ���
        FETCH C1 INTO DEPT_ROW;
        
        -- Ŀ���� �Ӽ� �߿� NOTFOUND�� �̿��ϸ� �� �̻� ���� �����Ͱ� ���ٴ� ���� �� �� ����
        -- FETCH������ �� ���� ������ false, �� �������� �ʾ����� true ��ȯ
        EXIT WHEN C1%NOTFOUND;
        
        DBMS_OUTPUT.PUT_LINE('DEPTNO : ' || DEPT_ROW.DEPTNO);
        DBMS_OUTPUT.PUT_LINE('DNAME  : ' || DEPT_ROW.DNAME);
        DBMS_OUTPUT.PUT_LINE('LOC : ' || DEPT_ROW.LOC);
    
    END LOOP;
     
     -- Ŀ�� �ݱ�
    CLOSE C1;
    
END;
/

-- Ŀ�� �Ӽ�
-- Ŀ�� �̸�%NOTFOUND: FETCH���� ���� ����� ���� ������ false, ������ true ��ȯ  (���� ���ǹ��� ���)
-- Ŀ�� �̸�%FOUND: FETCH���� ���� ����� ���� ������ true, ������ false ��ȯ
-- Ŀ�� �̸�%ROWCOUNT: ����� �� �� ��ȯ
-- Ŀ�� �̸�%ISOPEN: Ŀ�� ���� ������ true, ������ false ��ȯ

-- Ŀ�� + FOR LOOP��
/*
����)
FOR ���� �ε��� �̸� IN Ŀ�� �̸� LOOP
    �ݺ� ������ �۾�
END LOOP;

-- OPEN, FETCH, CLOSE �ۼ��� �ʿ� ����
-- FOR LOOP�� �ڵ����� ����
*/

DECLARE
    CURSOR C1 IS
    SELECT *
    FROM EMP;
BEGIN
    -- Ŀ�� FOR LOOP ���� (OPEN, FETCH, CLOSE)
    FOR C1_IDX IN C1 LOOP -- �� ���� C1_IDX �����ϹǷ� ROWTYPE�� ������ �ʿ� ����
        DBMS_OUTPUT.PUT_LINE('EMPNO : ' || C1_IDX.EMPNO);
        DBMS_OUTPUT.PUT_LINE('ENAME  : ' || C1_IDX.ENAME);
        DBMS_OUTPUT.PUT_LINE('JOB : ' || C1_IDX.JOB);
    END LOOP;
END;
/

SELECT * FROM TAB;

-- GOOTT_STUDENT ���̺��� �� ������ ���� CURSOR �ۼ� (FOR LOOP)
DECLARE
    CURSOR C1 IS
    SELECT * FROM GOOTT_STUDENT;
BEGIN
    FOR C1_IDX IN C1 LOOP
        DBMS_OUTPUT.PUT_LINE('STUID : ' || C1_IDX.STUID);
        DBMS_OUTPUT.PUT_LINE('STUNAME : ' || C1_IDX.STUNAME);
        DBMS_OUTPUT.PUT_LINE('SEATNUM : ' || C1_IDX.SEATNUM);
    END LOOP;
END;
/

SELECT * FROM EMP;

-- ��� �μ� ��ȣ 10, 20, 30 => ������ ������ �ٸ��� ���� Ŀ���� ������ ��
-- Ŀ���� �Ķ���� ���

/*
����)
CURSOR Ŀ�� �̸� (�Ķ���� (�Ű�����) �̸� �ڷ���, ...  ) IS
SELECT ....

*/

DECLARE
    CURSOR C1 (P_DEPTNO DEPT.DEPTNO%TYPE) IS
    SELECT * FROM DEPT WHERE DEPTNO = P_DEPTNO;
    -- P_DEPTNO ���� Ŀ���� ���Ӱ� ����
    
    DEPT_ROW DEPT%ROWTYPE;
    -- Ŀ���� ������ �� ������ �����ϴ� ���� ����
BEGIN
    OPEN C1(10);
        LOOP
            FETCH C1 INTO DEPT_ROW;
            EXIT WHEN C1%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE('10�� �μ��� �����Դϴ� ...');
            DBMS_OUTPUT.PUT_LINE('DEPTNO : ' || DEPT_ROW.DEPTNO);
            DBMS_OUTPUT.PUT_LINE('DNAME  : ' || DEPT_ROW.DNAME);
            DBMS_OUTPUT.PUT_LINE('LOC : ' || DEPT_ROW.LOC);
            DBMS_OUTPUT.PUT_LINE('');
        END LOOP;
    CLOSE C1;
    
    OPEN C1(20);
        LOOP
            FETCH C1 INTO DEPT_ROW;
            EXIT WHEN C1%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE('20�� �μ��� �����Դϴ� ...');
            DBMS_OUTPUT.PUT_LINE('DEPTNO : ' || DEPT_ROW.DEPTNO);
            DBMS_OUTPUT.PUT_LINE('DNAME  : ' || DEPT_ROW.DNAME);
            DBMS_OUTPUT.PUT_LINE('LOC : ' || DEPT_ROW.LOC);
            DBMS_OUTPUT.PUT_LINE('');
        END LOOP;
    CLOSE C1;
        
    OPEN C1(30);
        LOOP
            FETCH C1 INTO DEPT_ROW;
            EXIT WHEN C1%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE('30�� �μ��� �����Դϴ� ...');
            DBMS_OUTPUT.PUT_LINE('DEPTNO : ' || DEPT_ROW.DEPTNO);
            DBMS_OUTPUT.PUT_LINE('DNAME  : ' || DEPT_ROW.DNAME);
            DBMS_OUTPUT.PUT_LINE('LOC : ' || DEPT_ROW.LOC);
        END LOOP;
    CLOSE C1;
    
END;
/


DECLARE
    CURSOR C1 (P_DEPTNO DEPT.DEPTNO%TYPE) IS
    SELECT * FROM DEPT WHERE DEPTNO = P_DEPTNO;
    -- P_DEPTNO ���� Ŀ���� ���Ӱ� ����
    
    -- 10, 20, 30�� �μ� 
    -- ����ڿ��� �Է¹��� �μ� ��ȣ�� ������ ���� ����
    DEPTNO_INPUT DEPT.DEPTNO%TYPE;
BEGIN
    -- ����ڿ��� �μ� ��ȣ�� �Է¹޾Ƽ�(&) INPUT (ġȯ ����)�� �ְ� DEPTNO_INPUT�� ����
    DEPTNO_INPUT := &INPUT;
    
    -- Ŀ�� FOR LOOP
    FOR C1_IDX IN C1(DEPTNO_INPUT) LOOP
        
        DBMS_OUTPUT.PUT_LINE(DEPTNO_INPUT || '�� �μ��� �����Դϴ� ..');
        DBMS_OUTPUT.PUT_LINE('DEPTNO : ' || C1_IDX.DEPTNO);
        DBMS_OUTPUT.PUT_LINE('DNAME  : ' || C1_IDX.DNAME);
        DBMS_OUTPUT.PUT_LINE('LOC : ' || C1_IDX.LOC);
    
    END LOOP;
    
END;
/

-- 2) �Ͻ��� Ŀ��
-- : SQL�� �ۼ��� �� �ڵ����� ����Ŭ���� ������ Ŀ��
-- : SELECT, DML ��ɾ� �ڵ����� ���� (OPEN, FETCH, CLOSE�� �������� �ʾƵ� ��)

-- Ŀ�� �Ӽ�
-- Ŀ�� �̸�%NOTFOUND: �Ͻ��� Ŀ���� ����� ���� ������ false, ������ true ��ȯ 
-- Ŀ�� �̸�%FOUND: �Ͻ��� Ŀ���� ����� ���� ������ true, ������ false ��ȯ
-- Ŀ�� �̸�%ROWCOUNT: ����� �� �� ��ȯ
-- Ŀ�� �̸�%ISOPEN: �ڵ����� CLOSE�Ǳ� ������ �׻� false ��ȯ

DECLARE
BEGIN
    UPDATE DEPT SET DNAME = 'DB'
    WHERE DEPTNO = 50;
    -- ������Ʈ �� ���� DEPT ���̺� ����!
    -- ����� ���� �� 0, �� ���� X
    
    DBMS_OUTPUT.PUT_LINE('���� �� : ' || SQL%ROWCOUNT);
    -- �Ͻ��� Ŀ���� Ŀ�� �̸��� �����ϱ� �Ӽ� �տ� SQL �ۼ��ϸ� ��!
    
    IF (SQL%FOUND) THEN
        DBMS_OUTPUT.PUT_LINE('�� ���� �Ϸ�!');
    ELSE
        DBMS_OUTPUT.PUT_LINE('�� ���� X!');
    END IF;
    
    IF (SQL%ISOPEN) THEN -- �Ͻ��� Ŀ���� �˾Ƽ� ���� (�׻� false)
        DBMS_OUTPUT.PUT_LINE('Ŀ�� ���� ����!');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Ŀ�� ���� ����!');
    END IF;
END;
/

SELECT * FROM DEPT;
SELECT * FROM GOOTT_STUDENT;
-- INSERT (1, '�浿', 5);

DECLARE
BEGIN
    INSERT INTO GOOTT_STUDENT
    VALUES (1, '�浿', 5);
    
    DBMS_OUTPUT.PUT_LINE('���� �� : ' || SQL%ROWCOUNT);
    -- �Ͻ��� Ŀ���� Ŀ�� �̸��� �����ϱ� �Ӽ� �տ� SQL �ۼ��ϸ� ��!
    
    IF (SQL%FOUND) THEN
        DBMS_OUTPUT.PUT_LINE('�� ���� �Ϸ�!');
    ELSE
        DBMS_OUTPUT.PUT_LINE('�� ���� X!');
    END IF;
    
    IF (SQL%ISOPEN) THEN -- �Ͻ��� Ŀ���� �˾Ƽ� ���� (�׻� false)
        DBMS_OUTPUT.PUT_LINE('Ŀ�� ���� ����!');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Ŀ�� ���� ����!');
    END IF;
END;
/


-- ���� (exception) ó��
-- : ���α׷��� ������������ ������� �ʰ� �ϱ� ����
/*
����
1) ������ ���� (compile error): ������ �߸� �ۼ� (���� ����, syntax error)
2) ���� ���� (��Ÿ�� ����, runtime error) => "����" => ���� ó�� (exception handling)
ORA-...... : ����Ŭ���� ������ ���� (���� ����)

VALUE_ERROR (ORA-06502): ���, ���� ���� ����
ZERO_DIVIDE (ORA-01476): ���ڸ� 0���� �������� �� ���
TOO_MANY_ROWS (ORA-01422): SELECT INTO ��� ���� ���� ���� ���
INVALID_CURSOR (ORA-01001): OPEN ���� ���� Ŀ���� CLOSE �� ���
LOGIN_DENIED (ORA-01017): ����� �̸�/�н����� �߸� ���� ���
NOT_LOGGED_ON (ORA-01012): ���� DB�� ���ӵǾ� ���� ���� ���
SELF_IS_NULL (ORA-30625): ��ü�̸�.�޼ҵ�/�����̸��� ��ü�� NULL�� ���
STORAGE_ERROR (ORA-06500): �޸� ����
DUP_VAL_ON_INDEX (ORA-00001); �ε��� �ߺ�

����)
EXCEPTION
 WHEN ���� �̸�1 THEN
    ���� ����;
 WHEN ���� �̸�2 THEN
    ���� ����;
 ....
 WHEN OTHERS THEN
    ���� ����;

*/

-- ������ Ÿ�� ����ġ
DECLARE
    NUM_TEST NUMBER(5);    
BEGIN
    SELECT ENAME INTO NUM_TEST
    FROM EMP
    WHERE EMPNO = 7566;
END;
/

SELECT * FROM EMP;

-- ���� ó��
DECLARE
    NUM_TEST NUMBER(5);    
BEGIN
    SELECT ENAME INTO NUM_TEST -- ���� �߻�! (������ -> ������, ������Ÿ�� ����ġ)
    FROM EMP
    WHERE EMPNO = 7566;
    
    DBMS_OUTPUT.PUT_LINE('������� ����ɱ�� ? '); -- �� ���忡�� ���� �߻��ϸ� �� ������ ������� ����
EXCEPTION
--    WHEN VALUE_ERROR THEN
        -- ��� �޽����� �ۼ�
        
    WHEN OTHERS THEN -- ��� ���� ó�� ����!
        DBMS_OUTPUT.PUT_LINE('[���� �߻�] �� ����!');
        DBMS_OUTPUT.PUT_LINE('SQLCODE : ' || TO_CHAR(SQLCODE)); -- ���� ��ȣ ��ȯ
        DBMS_OUTPUT.PUT_LINE('SQLERRM : ' || SQLERRM); -- ���� �޽��� ��ȯ
        
END;
/

