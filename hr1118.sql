-- 프로시저를 통해서 사원번호를 입력하면 사원이름, 사원급여, 사원직급 매개변수를 통해서 전달   
CREATE OR REPLACE PROCEDURE EMP_PROCEDURE_OUTMODE(
    VEMPNO IN EMPLOYEES.EMPLOYEE_ID%TYPE,
    VNAME OUT EMPLOYEES.FIRST_NAME%TYPE,
    VSALARY OUT EMPLOYEES.SALARY%TYPE,
    VJOBID OUT EMPLOYEES.JOB_ID%TYPE
)
IS
    -- 지역변수
BEGIN
    SELECT FIRST_NAME,SALARY, JOB_ID INTO VNAME, VSALARY, VJOBID 
    FROM EMPLOYEES WHERE EMPLOYEE_ID = VEMPNO;

END;
/

DECLARE 
    VEMP_ROWTYPE EMPLOYEES%ROWTYPE;
BEGIN
    EMP_PROCEDURE_OUTMODE( 100, 
    VEMP_ROWTYPE.FIRST_NAME,
    VEMP_ROWTYPE.SALARY,
    VEMP_ROWTYPE.JOB_ID
);
    DBMS_OUTPUT.PUT_LINE('이름: ' || VEMP_ROWTYPE.FIRST_NAME);
    DBMS_OUTPUT.PUT_LINE('급여: ' || VEMP_ROWTYPE.SALARY);
    DBMS_OUTPUT.PUT_LINE('직책: ' || VEMP_ROWTYPE.JOB_ID);

END;
/

-- 프로시저를 워크시트에서 불러서 사용
VARIABLE VNAME VARCHAR2(100)
VARIABLE VSALARY NUMBER
VARIABLE VJOBID VARCHAR2(100)
EXECUTE EMP_PROCEDURE_OUTMODE(100,:VNAME,:VSALARY,:VJOBID);

-- PROCEDERE IN OUT MODE 동시사용
CREATE OR REPLACE PROCEDURE PROCEDURE_INOUTMODE(VSALARY IN OUT VARCHAR2)
IS
BEGIN
    -- VSALARY := TO_CHAR(VSALARY , '$999,999,999.99');
    VSALARY := '$'||SUBSTR(VSALARY, -9, 3)||','||SUBSTR(VSALARY, -6, 3)||','||SUBSTR(VSALARY, -3, 3); 
END;
/

DECLARE
    VSALARY VARCHAR2(20) := '123456789';
BEGIN
    PROCEDURE_INOUTMODE(VSALARY);
    DBMS_OUTPUT.PUT_LINE('VSALARY = '||VSALARY); 
END;
/



-- 성적처리프로그램 테이블 생성
CREATE TABLE SCORE (
    STUNUM NUMBER(4),
    NAME VARCHAR2(20) NOT NULL,
    KOR NUMBER(4) NOT NULL,
    ENG NUMBER(4) NOT NULL,
    MAT NUMBER(4) NOT NULL,
    TOT NUMBER(4),
    AVE NUMBER(5,1),
    RANK NUMBER(4)
);
-- 제약조건 등록 확인
ALTER TABLE SCORE ADD CONSTRAINT SCORE_STUNUM_PK PRIMARY KEY(STUNUM);
select * from user_cons_columns where table_name = 'SCORE';

-- 성적을 입력을 하면 총점과 평균이 자동 계산되어 입력되는 프로시저를 작성
CREATE OR REPLACE NONEDITIONABLE PROCEDURE SCORE_PROC_INPUT (
    VSTUNUM IN SCORE.STUNUM%TYPE,
    VNAME IN SCORE.NAME%TYPE,
    VKOR IN SCORE.KOR%TYPE,
    VENG IN SCORE.ENG%TYPE,
    VMAT IN SCORE.MAT%TYPE
)
IS 
    VTOT NUMBER;
    VAVE NUMBER;
BEGIN
    VTOT := VKOR + VENG + VMAT;
    VAVE := (VTOT)/3;
    INSERT INTO SCORE(STUNUM,NAME,KOR,ENG,MAT,TOT,AVE)
    VALUES (VSTUNUM,VNAME,VKOR,VENG,VMAT,VTOT,VAVE);
END;
/

EXECUTE SCORE_PROC_INPUT (1,'홍길동',99,80,85);
SELECT * FROM SCORE;

-- -- 성적을 입력을 하면 총점과 평균이 자동 계산되어 입력되는 트리거를 작성
CREATE OR REPLACE TRIGGER SCORE_TRIGGER
AFTER INSERT ON SCORE
FOR EACH ROW
DECLARE 
    VTOT NUMBER(3);
    VAVE NUMBER(5,2);
BEGIN
    VTOT := :NEW.KOR + :NEW.ENG + :NEW.MAT;
    VAVE := VTOT / 3;
END;
/

INSERT INTO SCORE (STUNUM,NAME,KOR,ENG,MAT) VALUES (2,'김희진',95,84,79);
SELECT * FROM SCORE;
INSERT INTO SCORE (STUNUM,NAME,KOR,ENG,MAT) VALUES (3,'이현수',83,89,99);

-- 김민석 트리거 처리프로그램
CREATE OR REPLACE TRIGGER SCORE_INSERT_TRG
AFTER INSERT ON SCORE
BEGIN
    UPDATE SCORE SET TOT=(KOR+ENG+MAT);
    UPDATE SCORE SET AVE=(KOR+ENG+MAT)/3;
END;
/
INSERT INTO SCORE(STUNUM,NAME,KOR,ENG,MAT) VALUES (2,'김희진',95,84,79);
SELECT * FROM SCORE;

-- 김동욱  트리거 처리프로그램
CREATE OR REPLACE TRIGGER SCORE_INSERT_TRG
    BEFORE INSERT ON SCORE
    FOR EACH ROW
BEGIN
    :NEW.TOT := :NEW.KOR + :NEW.ENG + :NEW.MAT;
    :NEW.AVE := ROUND((:NEW.KOR + :NEW.ENG + :NEW.MAT) / 3, 1);
END;
/
INSERT INTO SCORE(STUNUM,NAME,KOR,ENG,MAT) VALUES (3,'이희진',90,80,70);
SELECT * FROM SCORE;

-- 등수를 처리하는 저장 프로시저를 생성하라.
CREATE OR REPLACE PROCEDURE SCORE_RANK_PROC
IS 
BEGIN
    UPDATE SCORE S 
    SET RANK =
    (SELECT S_RANK FROM(SELECT STUNUM, RANK()OVER(ORDER BY AVE DESC) AS S_RANK FROM SCORE) WHERE S.STUNUM=STUNUM);
END;
/
EXECUTE SCORE_RANK_PROC;
SELECT * FROM SCORE;
SELECT * FROM SCORE ORDER BY RANK ASC, KOR DESC, ENG DESC, MAT DESC;
-- 윈도우 함수를 이용해서 생성해보자

SELECT NAME, TOT, RANK() OVER(ORDER BY TOT DESC) RANK FROM SCORE ORDER BY TOT DESC; 

CREATE OR REPLACE PROCEDURE SCORE_RANK_PROC
IS 
    VSCORE_RT SCORE%ROWTYPE; 
    CURSOR C1 IS
    SELECT STUNUM, NAME, TOT,RANK() OVER(ORDER BY TOT DESC) RANK FROM SCORE ORDER BY TOT DESC; 
BEGIN
    FOR  VSCORE_RT IN C1 LOOP
        UPDATE SCORE SET RANK = VSCORE_RT.RANK WHERE STUNUM =  VSCORE_RT.STUNUM; 
    END LOOP;
    COMMIT; 
END;
/

INSERT INTO SCORE(STUNUM,NAME,KOR,ENG,MAT) VALUES (4,'구희진',100,81,71);
EXECUTE SCORE_RANK_PROC;
SELECT * FROM SCORE;
SELECT * FROM SCORE ORDER BY RANK ASC, KOR DESC, ENG DESC, MAT DESC;