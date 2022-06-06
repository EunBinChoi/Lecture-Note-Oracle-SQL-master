-- 사용자 관리, 롤 관리, 권한 관리

-- USER: SYSTEM/ORACLE (DBA) 연결해서 사용자 생성

-- 사용자 생성
CREATE USER eunbin
IDENTIFIED BY eunbin
DEFAULT TABLESPACE USERS QUOTA UNLIMITED ON USERS;

-- 선택 사항
-- DEFAULT TABLESPACE 테이블 스페이스 이름 (EX) USERS)
-- QUOTA 테이블 스페이스 크기 ON 테이블 스페이스 이름 (EX) QUOTA UNLIMITED ON USERS)
-- ACCOUNT LOCK/UNLOCK (기본값)

-- 사용자 삭제
-- DROP USER eunbin CASCADE;
-- CASCADE: eunbin 계정이 만든 객체 (table, view ...) 같이 삭제

-- 사용자 권한
-- 권한 부여: GRANT 권한 이름 TO 사용자 이름
GRANT RESOURCE, CREATE SESSION, CREATE TABLE TO eunbin;
-- 권한 취소: REVOKE 권한 이름 FROM 사용자 이름
REVOKE RESOURCE, CREATE SESSION, CREATE TABLE FROM eunbin;

-- 사용자 권한 확인
SELECT * FROM DBA_SYS_PRIVS WHERE GRANTEE = 'EUNBIN';
