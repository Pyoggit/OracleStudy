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