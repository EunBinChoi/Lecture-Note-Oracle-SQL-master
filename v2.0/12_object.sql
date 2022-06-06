-- 객체 (Object) 종류
-- 1) 테이블 (table): 데이터 저장 공간
-- 2) 뷰 (view) : 테이블 일부/전체를 가상의 테이블로 볼 수 있도록 하는 객체
--                 : 데이터 자체를 가지고 있는 게 아니고 SQL문 저장
SELECT * FROM EMP WHERE ENAME LIKE '%S%';
SELECT * FROM EMP;

-- 뷰 생성 권한
-- cmd
-- sqlplus
-- system/oracle
-- grant create view to scott;
DROP VIEW VW_EMP_ENAME_WITH_S;
CREATE OR REPLACE VIEW VW_EMP_ENAME_WITH_S
AS (SELECT * FROM EMP WHERE ENAME LIKE '%S%');

SELECT * FROM USER_VIEWS;
SELECT * FROM VW_EMP_ENAME_WITH_S;

-- 이미 동일한 이름으로 테이블이 있는 경우에 REPLACE 하겠다!
CREATE OR REPLACE VIEW VW_EMP_ENAME_WITH_S
AS (SELECT * FROM EMP WHERE ENAME LIKE '%S%');

SELECT * FROM VW_EMP_ENAME_WITH_S;
INSERT INTO VW_EMP_ENAME_WITH_S VALUES (8000, 'SALLY', 'CLERK', 7839, SYSDATE, 3000, NULL, 20); -- 뷰 확인
INSERT INTO VW_EMP_ENAME_WITH_S VALUES (9000, 'AALLY', 'CLERK', 7839, SYSDATE, 3000, NULL, 20); -- 뷰 확인 X
SELECT * FROM VW_EMP_ENAME_WITH_S; -- ENAME에 S를 포함하지 않는 AALLY는 VIEW로 확인 불가
COMMIT;

SELECT * FROM EMP;

CREATE OR REPLACE VIEW VW_EMP_ENAME_WITH_A
AS (SELECT * FROM EMP WHERE ENAME LIKE '%A%')
WITH CHECK OPTION;

INSERT INTO VW_EMP_ENAME_WITH_A VALUES (6000, 'GOOTT', 'CLERK', 7839, SYSDATE, 3000, NULL, 20);
SELECT * FROM EMP;

SELECT * FROM USER_VIEWS;

-- EMP 테이블에서 VIEW로 저장할 열 개수랑 대체할 이름의 열 개수랑 맞아야 한다!
CREATE OR REPLACE VIEW VW_EMP ("NUMBER", "NAME", "DATE")
AS (SELECT EMPNO, ENAME FROM EMP);
SELECT * FROM VW_EMP;

-- FORCE VS NOFORCE
-- FORCE: 뷰 생성하고자 하는 사용자가 다른 사용자의 테이블을 참조해서 뷰를 생성하고자 할 때 
-- 권한없어도 뷰 생성 가능
-- NOFORCE: 뷰 생성하고자 하는 사용자가 다른 사용자의 테이블을 참조해서 뷰를 생성하고자 할 때 
-- 권한있을 때만 뷰 생성 가능

CREATE OR REPLACE FORCE VIEW VW_EMP_FORCE
AS (SELECT * FROM SYSTEM.SYSFILES);

CREATE OR REPLACE NOFORCE VIEW VW_EMP_NOFORCE
AS (SELECT * FROM SYSTEM.SYSFILES);


/*
CREATE (OR REPLACE) (FORCE/NOFORCE) VIEW 뷰 이름 (필수) (열 이름, ..)
AS (SELECT 문장) (필수)

(WITH CHECK OPTION (CONSTRAINT 제약 조건)) 
(WITH READ ONLY (CONSTRAINT 제약 조건))

선택 사항들
- OR REPLACE: 같은 이름의 뷰가 존재할 경우 뷰 대체
- FORCE: SELECT 문장의 실행할 테이블이 없어도 강제 생성
- NOFORCE: SELECT 문장의 실행할 테이블이 없어도 강제 생성 X (기본값)
- 열 이름: SELECT문 명시된 이름 대신 사용할 이름 지정 
- WITH CHECK OPTION: DML 작업 가능하도록 뷰 생성
- WITH READ ONLY: 뷰 열람만 가능하도록 뷰 생성
*/


-- 3) 데이터 사전 (data dictionary)
-- : DB 운영하기 위한 중요한 데이터 보관 공간
-- : USER_: SCOTT의 객체 정보
-- : ALL_: 모든 사용자의 객체 정보
SELECT * FROM DICT;

SELECT TABLE_NAME FROM USER_TABLES;
SELECT OWNER, TABLE_NAME FROM ALL_TABLES;

-- 4) 인덱스 (index)
-- : INDEX SCAN VS TABLE FULL SCAN
-- : B TREE를 이용해서 저장

-- (*) PRIMARY KEY를 인덱스로 지정을 하느냐?
-- : PRIMARY KEY가 NOT NULL, 중복 허용하지 않기 때문

-- 장점
-- 인덱스로 지정된 열을 통해 데이터를 검색하는 데 성능 향상
-- (1) WHERE절, ORDER BY절 + (인덱스로 설정된 열 이름)
-- (2) MIN(), MAX()

-- 단점
-- 항상 정렬된 상태를 유지해야하기 때문에 INSERT, DELETE, UPDATE문이 느려질 수 있음
-- 인덱스를 위한 저장 공간이 부족할 수 있음 (보통 10% 설정)

-- 인덱스 설정 방법
-- (1) WHERE절에 많이 오는 열
-- (2) ORDER BY절에 많이 오는 열
-- (3) 조인 조건 대상 열
-- (4) 중복 데이터가 최소인 열

SELECT * FROM USER_INDEXES;

-- 인덱스 생성
CREATE INDEX EMP_SIMPLE_ENAME_IDX ON EMP_SIMPLE(ENAME);
SELECT * FROM USER_INDEXES;

-- 인덱스 삭제
DROP INDEX EMP_SIMPLE_ENAME_IDX;
SELECT * FROM USER_INDEXES;


-- 5) 시퀀스 (sequence)
-- : 연속되는 숫자 생성 객체
-- EX) 게시판 글 목록 번호: 1, 2, 3, 4....

-- 시퀀스 생성
DROP SEQUENCE DEPT_SIMPLE_SEQUENCE;
CREATE SEQUENCE DEPT_SIMPLE_SEQUENCE
INCREMENT BY 10 
-- 증감숫자 (양수/음수) (디폴트 1)
START WITH 10 
-- 시작숫자 
-- 증감숫자가 양수일 경우에는 디폴트값 MINVALUE
-- 증감숫자가 음수인 경우에는 디폴트값 MAXVALUE
MAXVALUE 90 
-- 최댓값 (NOMAXVALUE / MAXVALUE)
-- 증감숫자가 양수일 경우에는 디폴트값 1027
-- 증감숫자가 음수일 경우에는 디폴트값 -1
-- (*) 시작숫자랑 같거나 시작숫자보다 커야 함
-- (*) MINVALUE보다는 커야 함
MINVALUE 0
-- 최솟값 (NOMINVALUE / MINVALUE)
-- 증감숫자가 양수일 경우에는 디폴트값 1
-- 증감숫자가 음수일 경우에는 디폴트값 -1028
-- (*) 시작숫자랑 같거나 시작숫자보다 작아야 함
-- (*) MAXVALUE보다는 작아야 함
CYCLE
-- CYCLE: 최댓값에 도달하게 되면 다시 MINVALUE부터 시작
-- NOCYCLE: 최댓값에 도달하게 되면 생성 멈춤
CACHE 9;
-- CACHE n: 시퀀스에 미리 할당된 값을 부여 (n: 캐쉬의 사이즈)
-- NO CACHE: 시퀀스에 미리 할당된 값을 부여 X
-- CEIL(MAXVALUE - MINVALUE) / INCREMENT BY 미만 값만 넣을 수 있음
-- (90 - 0) / 10 == 9 이하
-- cycle: 0 10 20 30 40 50 ... 90 (10회)

SELECT * FROM USER_SEQUENCES;
SELECT CACHE_SIZE FROM USER_SEQUENCES;


-- 시퀀스 사용
-- CURRVAL: 마지막으로 생성한 번호 반환
-- (*) 시퀀스를 통해 번호를 한번도 생성한 적이 없으면 CURRVAL를 사용하려고 하면 오류!
-- NEXTVAL: 다음 생성할 번호 반환

SELECT * FROM DEPT_SIMPLE;
INSERT INTO DEPT_SIMPLE
VALUES (DEPT_SIMPLE_SEQUENCE.NEXTVAL, 'ACCOUNTING', 'SEOUL');
SELECT * FROM DEPT_SIMPLE;
COMMIT;

SELECT DEPT_SIMPLE_SEQUENCE.CURRVAL FROM DUAL;

-- 시퀀스 수정 (INCREMENT, MAXVALUE, MINVALUE, CYCLE,... (START WITH 수정 불가))
ALTER SEQUENCE DEPT_SIMPLE_SEQUENCE
INCREMENT BY 1
CYCLE;

SELECT * FROM USER_SEQUENCES;
SELECT DEPT_SIMPLE_SEQUENCE.NEXTVAL FROM DUAL;

-- 시퀀스 삭제
DROP SEQUENCE DEPT_SIMPLE_SEQUENCE;
SELECT * FROM USER_SEQUENCES;


-- 6) 동의어 (synonym)
-- : 다른 계정에 있는 테이블, 뷰를 접근할 때 계정이름.테이블/뷰이름으로 접근해야 함!
-- : 계정이름.테이블/뷰이름를 대신할 수 있는 동의어를 만들어서 사용

-- cmd
-- sqlplus
-- system/oracle
-- grant create synonym to scott;
-- grant create public synonym to scott;

/*
CREATE (PUBLIC) SYNONYM 동의어 이름
FOR 사용자.객체 이름

PUBLIC (선택) - 모든 사용자가 해당 동의어를 사용할 수 있음
(생략하면 동의어를 생성한 사용자만 사용 가능)
사용자. (선택) - 생성할 동의어의 소유 사용자 지정
(생략하면 현재 접속한 사용자 지정)
객체 이름 (필수) - 동의어를 생성할 객체 이름 (테이블, 뷰, 시퀀스)

※ 동의어 VS 테이블 별칭 (FROM 테이블명 별칭)
: 동의어는 DB에 저장되는 객체 -> 일회성 X
: 테이블 별칭 -> 일회성

*/

CREATE SYNONYM EMP_S
FOR SCOTT.EMP_SIMPLE;

SELECT * FROM USER_SYNONYMS;
SELECT * FROM EMP_S;

CREATE SYNONYM FILES
FOR SYSTEM.SYSFILES;

SELECT * FROM USER_SYNONYMS;
SELECT * FROM FILES;

-- 동의어 삭제
DROP SYNONYM EMP_S;
DROP SYNONYM FILES;

-- 동의어 조회
SELECT * FROM USER_SYNONYMS; -- 사용자만 볼 수 있는 동의어 조회
SELECT * FROM ALL_SYNONYMS WHERE OWNER = 'SCOTT'; -- PUBLIC하게 설정한 동의어 조회

