-- 사용자 계정 만들기(시스템 관리자 모드에서 진행)
ALTER SESSION SET "_ORACLE_SCRIPT"=true;
DROP USER TEAMPROJECT CASCADE; -- 기존 사용자 삭제
CREATE USER TEAMPROJECT IDENTIFIED BY 123456 -- 사용자 이름: Model, 비밀번호 : 1234
    DEFAULT TABLESPACE USERS -- 데이터 저장소
    TEMPORARY TABLESPACE TEMP; -- 임시 저장 장소
GRANT connect, resource, dba TO TEAMPROJECT; -- 권한 부여