-- Ʈ����� (Transaction)
-- : �� �̻� ���� �� ���� �ּ� ���� ����
-- : ������ ���� ����Ǿ�� �ϴ� ������! + (COMMIT, ROLLBACK, (TCL))

-- : EX) ���� ���� SALLY --- 1000���� --> ���� ���� GILDONG
-- (1) SALLY: 5000 - 1000 = 4000
-- (2) GILDONG: 3000 + 1000 = 4000

-- UPDATE SALLY 5000 -> 4000
-- UPDATE GILDONG 3000 -> 4000
-- COMMIT OR ROLLBACK

-- (1)���� (2)���� �׻� "����" ����ǰų� ������� �ʾƾ� ��!
-- => �ϳ��� Ʈ��������� ����� �� (ALL OR NOTHING)

DROP TABLE NH_BANK;
DROP TABLE SH_BANK;

CREATE TABLE NH_BANK(
    ACCNUMBER VARCHAR2(20) CONSTRAINT NH_BANK_PK PRIMARY KEY,
    ACCOWNER VARCHAR2(10) NOT NULL,
    BALANCE NUMBER(10) DEFAULT 0
);

CREATE TABLE SH_BANK(
    ACCNUMBER  VARCHAR2(20) CONSTRAINT SH_BANK_PK PRIMARY KEY,
    ACCOWNER VARCHAR2(10) NOT NULL,
    BALANCE NUMBER(10) DEFAULT 0
);

-- ���� ����
INSERT INTO NH_BANK VALUES ('1111-1111', 'SALLY', 5000);
COMMIT;

INSERT INTO SH_BANK VALUES ('2222-2222', 'GILDONG', 3000);
COMMIT;

SAVEPOINT ACCOUNT_INSERT;

-- ���� ��ü (SALLY -- 1000 ���� ---> GILDONG)
UPDATE NH_BANK
SET BALANCE = BALANCE - 1000
WHERE ACCNUMBER = '1111-1111';
SELECT * FROM NH_BANK;

SAVEPOINT NH_BANK_WITHDRAW;

UPDATE SH_BANK
SET BALANCE = BALANCE + 1000
WHERE ACCNUMBER = '2222-2222';
SELECT * FROM SH_BANK;
-- ROLLBACK TO SAVEPOINT NH_BANK_WITHDRAW;
COMMIT;

SELECT * FROM NH_BANK;
SELECT * FROM SH_BANK;


-- Ʈ����� Ư¡ (ACID)
-- 1) ���ڼ� (Atomicity)
-- : Ʈ������� �̷�� DML �ڵ�� �ϳ��� ���ڷ� ���ڴ�!
-- 2) �ϰ��� (Consistency)
-- : Ʈ����� ���� �� DB�� ������ ����� ��!
-- : ���ü� ����
-- 3) ���� (Isolation)
-- : Ʈ����� ���� ���߿� �ٸ� Ʈ����ǿ� ���� ������ ������ �ȵ�!
-- : ���ü� ����
-- 4) ���Ӽ� (Durability)
-- : Ʈ������� ���������� ����Ǹ� �ش� ������ DB�� ������ ����!



