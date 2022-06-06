-- 트랜잭션 (Transaction)
-- : 더 이상 분할 수 없는 최소 수행 단위
-- : 무조건 같이 실행되어야 하는 쿼리문! + (COMMIT, ROLLBACK, (TCL))

-- : EX) 농협 계좌 SALLY --- 1000만원 --> 신한 계좌 GILDONG
-- (1) SALLY: 5000 - 1000 = 4000
-- (2) GILDONG: 3000 + 1000 = 4000

-- UPDATE SALLY 5000 -> 4000
-- UPDATE GILDONG 3000 -> 4000
-- COMMIT OR ROLLBACK

-- (1)번과 (2)번은 항상 "같이" 수행되거나 수행되지 않아야 함!
-- => 하나의 트랜잭션으로 묶어야 함 (ALL OR NOTHING)

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

-- 계좌 생성
INSERT INTO NH_BANK VALUES ('1111-1111', 'SALLY', 5000);
COMMIT;

INSERT INTO SH_BANK VALUES ('2222-2222', 'GILDONG', 3000);
COMMIT;

SAVEPOINT ACCOUNT_INSERT;

-- 계좌 이체 (SALLY -- 1000 만원 ---> GILDONG)
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


-- 트랜잭션 특징 (ACID)
-- 1) 원자성 (Atomicity)
-- : 트랜잭션을 이루는 DML 코드는 하나의 원자로 보겠다!
-- 2) 일관성 (Consistency)
-- : 트랜잭션 실행 후 DB에 오류가 없어야 함!
-- : 동시성 제어
-- 3) 고립성 (Isolation)
-- : 트랜잭션 실행 도중에 다른 트랜잭션에 의해 영향을 받으면 안됨!
-- : 동시성 제어
-- 4) 지속성 (Durability)
-- : 트랜잭션이 성공적으로 수행되면 해당 내용은 DB에 영구히 저장!



