-- INSERT INTO 테이블명(컬럼명,,) VALUES (컬럼값, ,,)
-- DELETE FROM 테이블명 WHERE
-- UPDATE 테이블명 SET WHERE

CREATE TABLE INSERT_TEST(
    NO1 NUMBER,
    NO2 NUMBER,
    NO3 NUMBER
);

DESC INSERT_TEST;
INSERT INTO INSERT_TEST VALUES(1,2,3);
SELECT * FROM INSERT_TEST;
RENAME INSERT_TEST TO IT;
DESC IT;

INSERT INTO IT VALUES(1,2,3);
INSERT INTO IT VALUES(1,2,NULL);
INSERT INTO IT(NO1,NO2) VALUES(11,22);

DELETE FROM IT WHERE NO3 IS NULL;
ALTER TABLE IT MODIFY NO3 NUMBER NOT NULL;
SELECT * FROM IT;

CREATE TABLE DEPT
AS 
SELECT DEPARTMENT_ID, DEPARTMENT_NAME, LOCATION_ID FROM DEPARTMENTS;
SELECT * FROM DEPT;
DELETE FROM DEPT;
TRUNCATE TABLE DEPT;
ROLLBACK;

INSERT INTO DEPT SELECT DEPARTMENT_ID, DEPARTMENT_NAME, LOCATION_ID FROM DEPARTMENTS;

-- 학과 테이블
CREATE TABLE DEPARTMENT(
    DEPT_CODE NUMBER PRIMARY KEY, 
    DEPT_NAME VARCHAR2(50) NOT NULL 
);

-- 학생 테이블
CREATE TABLE STUDENT(
    STUDENT_ID NUMBER PRIMARY KEY, 
    NAME VARCHAR2(10) NOT NULL, 
    KO NUMBER DEFAULT 0 NOT NULL, 
    EN NUMBER DEFAULT 0 NOT NULL, 
    MATH NUMBER DEFAULT 0 NOT NULL, 
    TOTAL NUMBER DEFAULT 0, 
    AVERAGE NUMBER DEFAULT 0, 
    DEPT_CODE NUMBER, 
    CONSTRAINT FK_DEPT_CODE FOREIGN KEY (DEPT_CODE) REFERENCES DEPARTMENT(DEPT_CODE)--FK
);

-- 샘플데이터 입력
INSERT INTO DEPARTMENT (DEPT_CODE, DEPT_NAME) VALUES (1101, '컴퓨터공학과');
INSERT INTO DEPARTMENT (DEPT_CODE, DEPT_NAME) VALUES (1106, '정보통신학과');

DESC STUDENT;
SELECT * FROM STUDENT;
SELECT * FROM DEPARTMENT;

SELECT STUDENT_ID, NAME, KO, EN, MATH, TOTAL, AVERAGE, DEPT_CODE
FROM STUDENT;

CREATE TABLE EMP03
AS
SELECT * FROM EMPLOYEES;

--모든 사원의 부서번호를 30번으로 수정하자
SELECT * FROM EMP03;
UPDATE EMP03 SET DEPARTMENT_ID = 30;
ROLLBACK;

--모든 사원의 급여를 10% 인상한다.
UPDATE EMP03 SET SALARY = SALARY * 1.1;

--부서번호가 10번인 사원의 부서번호를 30번으로 수정
UPDATE EMP03 
SET DEPARTMENT_ID = 30 
WHERE DEPARTMENT_ID = 10; 

--급여가 3000이상인 사원만 급여를 10%인상
UPDATE EMP03
SET SALARY = SALARY * 1.1
WHERE SALARY >= 3000;

-- 2007년에 입사한 사원의 입사일을 오늘로 수정
UPDATE EMP03
SET HIRE_DATE = SYSDATE
WHERE SUBSTR(HIER_DATE,1,2)= '07';
ROLLBACK;

--이름이 susan인 부서번호는 20번으로, 직급은 FI_MGR로 수정
UPDATE EMP03
SET DEPARTMENT_ID = 20,JOB_ID = 'FI_MGR'
WHERE UPPER(FIRST_NAME) = UPPER('Susan');
SELECT * FROM EMP03 WHERE FIRST_NAME = 'Susan';

-- LAST_NAME이 Russell인 사원의 급여를 17000로, 커미션 비율이 0.45로 인상된다
UPDATE EMP03
SET SALARY = 17000, COMMISSION_PCT = 0.45
WHERE UPPER(LAST_NAME)= UPPER('Russell');

--30번 부서를 삭제
DELETE FROM EMP03 WHERE DEPARTMENT_ID = 30;

--테이블생성
CREATE TABLE MYCUSTOMER(
    code VARCHAR2(7),
    name VARCHAR2(10) NOT NULL,
    gender CHAR(1) NOT NULL,
    birth VARCHAR2(8)NOT NULL,
    phone VARCHAR2(16)
);

ALTER TABLE MYCUSTOMER ADD CONSTRAINT MYCUSTOMER_code_PK PRIMARY KEY(code);
ALTER TABLE MYCUSTOMER ADD CONSTRAINT MYCUSTOMER_gender_CK CHECK(gender IN('M','W'));
ALTER TABLE MYCUSTOMER ADD CONSTRAINT MYCUSTOMER_PHONE_UK UNIQUE (phone);
DESC MYCUSTOMER;

-- 모든 제약 조건 보기
SELECT * FROM USER_CONSTRAINTS;
-- 테이블 제약 조건 보기
SELECT * FROM USER_TABLES;
-- 컬럼 제약 조건 보기
SELECT * FROM USER_CONS_COLUMNS;
--테이블 이름이 'MYCUSTOMER'인 제약 조건
SELECT * FROM USER_CONSTRAINTS WHERE TABLE_NAME = 'MYCUSTOMER';



--샘플데이터 입력
INSERT INTO MYCUSTOMER VALUES ('2017108','박승대','M','19711430','010-2580-9919');
INSERT INTO MYCUSTOMER VALUES ('2019302','전미래','W','19740812','010-8864-0232');
SELECT * FROM MYCUSTOMER;

--ALTER TABLE CUSTOMER DROP


--MARGE MYCUSTOMER => CUSTOMER 병합을 진행 (없으면 INSERT, 있으면 UPDATE)
MERGE INTO CUSTOMER C
    USING MYCUSTOMER M
    ON (C.code = M.code)
    WHEN MATCHED THEN
        UPDATE SET C.name = M.name, C.gender = M.gender, C.birth = M.birth, C.no = M.phone
    WHEN NOT MATCHED THEN
        INSERT (C.code,C.name,C.gender,C.birth,C.no) VALUES(M.code,M.name,M.gender,M.birth,M.phone);

SELECT * FROM CUSTOMER;
SELECT * FROM MYCUSTOMER;
UPDATE MYCUSTOMER SET NAME = '박승우' WHERE code = '2017108';


CREATE TABLE DEPT01(
    NO VARCHAR2(8),
    NAME VARCHAR2(10) NOT NULL,
    REGION VARCHAR2(10)
);

ALTER TABLE DEPT01 ADD CONSTRAINT DEPT01_NO_PK PRIMARY KEY(NO);

CREATE TABLE MEMBER(
    NO NUMBER(8),
    NAME VARCHAR2(10) NOT NULL,
    JOB_ID VARCHAR2(10),
    DEPT_NO VARCHAR2(8)
    );
ALTER TABLE MEMBER ADD CONSTRAINT MEMBER_NO_PK PRIMARY KEY(NO);
ALTER TABLE MEMBER ADD CONSTRAINT MEMBER_DEPT_NO_FK FOREIGN KEY(DEPT_NO) REFERENCES DEPT01(NO);

INSERT INTO DEPT01 VALUES(10,'ACCOUNTING','NEW YORK');
INSERT INTO DEPT01 VALUES(20,'RESEARCH','DALLAS');
INSERT INTO DEPT01 VALUES(30,'SALES','CHICAGO');
INSERT INTO DEPT01 VALUES(40,'OPERATIONS','BOSTON');
SELECT * FROM DEPT01;

INSERT INTO MEMBER VALUES(7499,'ALLEN','SALESMAN',30);
INSERT INTO MEMBER VALUES(7566,'JONES','MANAGER',40);
SELECT * FROM MEMBER;

DELETE FROM MEMBER WHERE DEPT_NO = 40;
DELETE FROM DEPT01 WHERE NO = 40;

--기본키 제약조건을 비활성화하면 한번에 삭제 가능
ALTER TABLE MEMBER DROP CONSTRAINT MEMBER_DEPT_NO_FK;
--CASCADE
ALTER TABLE MEMBER ADD CONSTRAINT MEMBER_DEPT_NO_FK FOREIGN KEY (DEPT_NO) REFERENCES DEPT01(NO)ON DELETE CASCADE; 

DELETE FROM DEPT01 WHERE NO = 40;





--EMP01 테이블 생성
CREATE TABLE EMP01(
    EMPNO NUMBER(4),--PK
    ENAME VARCHAR(10) NOT NULL,
    JOB VARCHAR2(9),
    MGR NUMBER(4),  
    HIREDATE DATE NOT NULL,
    SAL NUMBER(7,2) NOT NULL,
    COMM NUMBER(7,2) DEFAULT 0.0,
    DEPTNO NUMBER(2) NOT NULL
);

ALTER TABLE EMP01 ADD CONSTRAINT EMP01_EMPNO_PK PRIMARY KEY(EMPNO);

--EMP01 테이블에 데이터 추가
INSERT INTO EMP01 VALUES(7369,'SMITH','CLEAK',7369,'80/12/17',800,NULL,20);
INSERT INTO EMP01 VALUES(7499,'ALLEN','SALESMAN',7369,'87/12/20',1600,300,30);
INSERT INTO EMP01 VALUES(7839,'KING','PRESIDENT',NULL,'81/02/08',5000,NULL,10);
--EMP01 데이터 보기
SELECT * FROM EMP01;


--MEMBERS 테이블 생성
CREATE TABLE MEMBERS (
    ID VARCHAR2(20) NOT NULL,--pk
    NAME VARCHAR2(20) NOT NULL,
    REGNO VARCHAR2(13) NOT NULL,
    HP VARCHAR2(13),
    ADDRESS VARCHAR2(100)
);
--제약조건
ALTER TABLE MEMBERS ADD CONSTRAINT MEMBERS_ID_PK PRIMARY KEY(ID);
--임의데이터 삽입
INSERT INTO MEMBERS VALUES('PERSON','JANG','99999-11111','010-10-10','ADDRESS');
--데이터 보기
SELECT * FROM MEMBERS;


--BOOKS 테이블 생성
CREATE TABLE BOOKS (
    CODE NUMBER(4) NOT NULL,--pk
    TITLE VARCHAR2(50) NOT NULL,
    COUNT NUMBER(6) NOT NULL,
    PRICE NUMBER(10) NOT NULL,
    PUBLISH VARCHAR2(50) NOT NULL
);
--제약조건
ALTER TABLE BOOKS ADD CONSTRAINT BOOKS_CODE_PK PRIMARY KEY(CODE);
--임의데이터 삽입
INSERT INTO BOOKS VALUES(123,'TITLE',3,9000,'Publisher');
--데이터 보기
SELECT * FROM BOOKS;

--고객테이블 생성
CREATE TABLE CUSTOMER01(
    CODE NUMBER(5),--pk 고객번호
    NAME VARCHAR2(20) NOT NULL,
    AGE NUMBER(3),
    ADDR VARCHAR2(50),
    TEL VARCHAR2(20)
);

ALTER TABLE CUSTOMER01 ADD CONSTRAINT CUSTOMER01_CODE_PK PRIMARY KEY(CODE);


--비디오테이블 생성
CREATE TABLE VIDEO(
    CODE NUMBER(5),--비디오번호
    TITLE VARCHAR2(50) NOT NULL,
    GENRE VARCHAR2(30),
    PAY NUMBER(7) NOT NULL,
    LEND NUMBER(1),
    COMPANY VARCHAR(50),
    V_DATE DATE,
    AGE NUMBER(1)
);

DELETE 
ALTER TABLE VIDEO ADD CONSTRAINT VIDEO_CODE_PK PRIMARY KEY(CODE);


--대여반납테이블 생성
CREATE TABLE LEND(
    LEND_CODE NUMBER(5),
    CODE NUMBER(5) REFERENCES CUSTOMER01(CODE),
    
    
);
