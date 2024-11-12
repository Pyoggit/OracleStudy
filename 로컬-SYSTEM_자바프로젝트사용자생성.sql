-- 사용자 정의 테이블스페이스
CREATE TABLESPACE firstdata
DATAFILE 'C:\oraclexe\oradata\XE\first01.dbf' size 10M;
-- 용량 부족시 테이블스페이스 확장
ALTER TABLESPACE firstdata 
ADD DATAFILE 'C:\oraclexe\oradata\XE/first02.dbf' size 1M;
-- 용량 부족시 테이블스페이스 용량 확대
ALTER DATABASE
DATAFILE 'C:\oraclexe\oradata\XE/first02.dbf' resize 10M;
-- 용량 부족시 테이블스페이스 자동 용량 확대(최소 1M 최대 20M)
ALTER DATABASE
DATAFILE 'C:\oraclexe\oradata\XE\first01.dbf'
AUTOEXTEND ON
NEXT 1M
MAXSIZE 20M;


-- 자바 프로젝트 사용자 계정 및 테이블스페이스(javadata), 파일명(app_data.dbf) 생성
CREATE TABLESPACE javadata
DATAFILE'C:\oraclexe\oradata\XE\app_data.dbf' size 20M
AUTOEXTEND ON
NEXT 3M
MAXSIZE 500M;

-- 자바 프로젝트 사용자 계정 생성
ALTER SESSION SET "_ORACLE_SCRIPT"=true;
DROP USER javauser CASCADE; -- 기존 사용자 삭제
CREATE USER javauser IDENTIFIED BY 123456 -- 사용자 이름: Model, 비밀번호 : 1234
    DEFAULT TABLESPACE javadata -- 데이터 저장소
    TEMPORARY TABLESPACE TEMP; -- 임시 저장 장소
GRANT connect, resource, dba TO javauser; -- 권한 부여