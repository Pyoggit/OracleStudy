--DDL
CREATE TABLE EXAMPLE01(
    ex_id NUMBER(10),--pk 아이디
    name VARCHAR2(20),
    gender CHAR(1) NOT NULL,
    CONSTRAINT EXAMPLE01_ex_id_PK PRIMARY KEY(ex_id)--생성시 제약조건걸기
);
--이미 생성된 객체에 제약조건 추가
ALTER TABLE EXAMPLE01 ADD CONSTRAINT EXAMPLE01_gender_CK CHECK(gender IN('M','W'));
--이미 생성된 객체의 제약조건 수정
