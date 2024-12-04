CREATE SEQUENCE visit_seq  -- 시퀀스이름
   START WITH 1             -- 시작을 1로 설정
   INCREMENT BY 1          -- 증가 값을 1씩 증가
   NOMAXVALUE             -- 최대 값이 무한대
   NOCACHE
   NOCYCLE;

CREATE table VISIT (
    NO        NUMBER(5,0),
    WRITER     VARCHAR2(20) NOT NULL,
    MEMO     VARCHAR2(4000) NOT NULL,
    REGDATE   DATE NOT NULL
);

ALTER TABLE VISIT ADD CONSTRAINT VISIT_NO_PK PRIMARY KEY(NO);

SELECT * FROM VISIT;

DROP TABLE MEMBER;
CREATE TABLE MEMBER (
    NO NUMBER(5,0),                           -- 회원번호
    ID VARCHAR2(12) NOT NULL,                 -- 아이디 (4~12자의 영문 대소문자와 숫자) UK
    PWD VARCHAR2(12) NOT NULL,                -- 비밀번호 (4~12자의 영문 대소문자와 숫자)
    EMAIL VARCHAR2(100) NOT NULL,             -- 이메일 주소
    NAME VARCHAR2(50) NOT NULL                -- 이름
);

ALTER TABLE MEMBER ADD CONSTRAINT MEMBER_NO_PK PRIMARY KEY(NO);
ALTER TABLE MEMBER ADD CONSTRAINT MEMBER_ID_UK UNIQUE(ID);



CREATE SEQUENCE MEMBER_SEQ  -- 시퀀스이름
   START WITH 1             -- 시작을 1로 설정
   INCREMENT BY 1          -- 증가 값을 1씩 증가
   NOMAXVALUE             -- 최대 값이 무한대
   NOCACHE
   NOCYCLE;
   
CREATE TABLE MEMBER (
    ID VARCHAR2(12) PRIMARY KEY,              -- 아이디 (4~12자의 영문 대소문자와 숫자)
    PWD VARCHAR2(12) NOT NULL,                -- 비밀번호 (4~12자의 영문 대소문자와 숫자)
    EMAIL VARCHAR2(100) NOT NULL,             -- 이메일 주소
    NAME VARCHAR2(50) NOT NULL,               -- 이름
    RESIDENT_NO CHAR(14),                     -- 주민등록번호 (123456-1234567)
    BIRTH_DATE DATE,                          -- 생년월일
    INTERESTS VARCHAR2(200),                  -- 관심분야 (콤마로 구분하여 저장)
    INTRO CLOB,                               -- 자기소개 (긴 텍스트)
    AGE_AGREE CHAR(1) CHECK (AGE_AGREE IN ('Y', 'N')), -- 만 14세 이상 여부
    TERMS_AGREE CHAR(1) CHECK (TERMS_AGREE IN ('Y', 'N')), -- 이용약관 동의 여부
    INFO_AGREE CHAR(1) CHECK (INFO_AGREE IN ('Y', 'N'))    -- 개인정보 동의 여부
);

CREATE TABLE INTEREST (
    MEMBER_ID VARCHAR2(12),       -- 회원 ID (외래키)
    INTEREST VARCHAR2(50),        -- 관심분야
    CONSTRAINT FK_INTEREST_MEMBER FOREIGN KEY (MEMBER_ID)
    REFERENCES MEMBER (ID)
);

SELECT * FROM MEMBER;

SELECT * FROM INTEREST;

CREATE TABLE SIGNUP (
    ID VARCHAR(12),
    PASSWORD VARCHAR(12) NOT NULL,
    EMAIL VARCHAR(50) NOT NULL,
    NAME VARCHAR(50) NOT NULL
);

ALTER TABLE SIGNUP ADD CONSTRAINT SIGNUP_ID_PK PRIMARY KEY(ID);

--------------------------------------------------------------------------
-- 로그인테이블
CREATE TABLE LOGIN(
    ID VARCHAR2(12),
    PASS VARCHAR2(12) NOT NULL
);
ALTER TABLE LOGIN ADD CONSTRAINT LOGIN_ID_PK PRIMARY KEY(ID);

--------------------------------------------------------------------------
-- 회원가입테이블
CREATE TABLE REGISTER(
    ID VARCHAR2(12) ,                         -- 아이디 (4~12자의 영문 대소문자와 숫자)
    PWD VARCHAR2(12) NOT NULL,                -- 비밀번호 (4~12자의 영문 대소문자와 숫자)
    EMAIL VARCHAR2(100) NOT NULL,             -- 이메일 주소
    NAME VARCHAR2(50) NOT NULL,               -- 이름
    BIRTH NUMBER(10)                          -- 생년월일 (20001010)
);

ALTER TABLE REGISTER ADD CONSTRAINT REGISTER_ID_PK PRIMARY KEY(ID);


