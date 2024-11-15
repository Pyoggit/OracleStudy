-- DDL(CREATE, RENAME, ALTER, DROP)
-- 테이블 삭제하기
DROP TABLE EXAMPLE01;
-- 테이블 생성(생성시 제약조건 추가)
CREATE TABLE EXAMPLE01(
    id VARCHAR2(20),--pk
    name VARCHAR2(20)NOT NULL,
    gender CHAR(1) NOT NULL,--check
    phone VARCHAR(15) NOT NULL,--uk
    salary NUMBER(10) DEFAULT 1000,--default
    CONSTRAINT EXAMPLE01_id_PK PRIMARY KEY(id),--생성시 제약조건걸기
    CONSTRAINT EXAMPLE01_phone_UK UNIQUE(phone),
    CONSTRAINT EXAMPLE01_gender_CK CHECK(gender IN('M','W'))
);

--테이블 생성(이미 생성된 객체에 제약조건 추가)
CREATE TABLE EXAMPLE02(
    no NUMBER(10),--PK
    id VARCHAR2(20)NOT NULL,--FK
    name VARCHAR2(20)NOT NULL,
    gender CHAR(1) NOT NULL,--CHECK
    phone VARCHAR(15) NOT NULL,--UK
    salary NUMBER(10) DEFAULT 1000--default
);
-- 이미 생성된 객체에 제약조건 추가
-- PK 생성
ALTER TABLE EXAMPLE02 ADD CONSTRAINT EXAMPLE02_no_PK PRIMARY KEY(no);
-- UK 생성
ALTER TABLE EXAMPLE02 ADD CONSTRAINT EXAMPLE02_phone_UK UNIQUE(phone);
-- CHECK 제약조건 생성
ALTER TABLE EXAMPLE02 ADD CONSTRAINT EXAMPLE02_gender_CK CHECK(gender IN('M','W'));
-- FK 생성
ALTER TABLE EXAMPLE02 ADD CONSTRAINT EXAMPLE02_id_FK FOREIGN KEY(id) 
    REFERENCES EXAMPLE01(id) ON DELETE CASCADE;

-- 제약조건 삭제하기
ALTER TABLE EXAMPLE02 DROP CONSTRAINT EXAMPLE02_phone_UK;  
    
-- DML(INSERT, SELECT, UPDATE, DELETE)
-- 테이블 검색하기
SELECT * FROM EXAMPLE01;
SELECT * FROM EXAMPLE02;

-- DATA DICTIONARY(USER_TABLES, USER_CONSTRAINTS, USER_CONS_COLUMNS, USER_VIEWS, USER_INDEXES)
-- 모든 테이블 보기
SELECT * FROM user_tables;

-- 모든 제약조건 보기(테이블명이 'EXAMPLE01'인 테이블의 모든 제약조건)
SELECT * FROM user_constraints;
SELECT * FROM user_constraints WHERE table_name = 'EXAMPLE01';

-- 모든 테이블의 컬럼명과 제약조건 보기(테이블명이 "EXAMPLE01'인 테이블의 컬럼명 보기)
SELECT * FROM user_cons_columns;
SELECT * FROM user_cons_columns WHERE table_name = 'EXAMPLE01';

-- 모든 뷰 보기
SELECT * FROM user_views;

-- 모든 인덱스 보기
SELECT * FROM user_indexes;

-- 모든 시퀀스 보기
SELECT * FROM user_sequences;

-- 모든 프로시저 소스 보기
SELECT * FROM user_source;
