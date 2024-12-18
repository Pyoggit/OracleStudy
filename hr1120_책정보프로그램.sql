-- 자바에서 CallableStatement test
CREATE TABLE EMP1
AS
SELECT EMPLOYEE_ID, FIRST_NAME, DEPARTMENT_ID, SALARY FROM EMPLOYEES;

SELECT * FROM EMP1;

-- 부서별로 해당되는 부서만 인상률이 적용되는 프로시저
CREATE OR REPLACE PROCEDURE BOOKS_PROCEDURE(
    VID IN BOOKS.ID%TYPE, VPRICE IN BOOKS.PRICE%TYPE, VMESSAGE OUT VARCHAR2)
IS
    VBOOKS_RT BOOKS%ROWTYPE;
BEGIN
    UPDATE BOOKS 
    SET PRICE= PRICE + VPRICE
    WHERE ID = VID;
    COMMIT;
    SELECT * INTO VBOOKS_RT FROM BOOKS WHERE ID = VID;
    VMESSAGE := VBOOKS_RT.ID||'번호의 인상금액 ' || VPRICE ||'이고 총 금액은 '|| VBOOKS_RT.PRICE || '입니다';
    DBMS_OUTPUT.PUT_LINE(VMESSAGE);
END;
/

SELECT * FROM BOOKS;

VARIABLE MESSAGE VARCHAR2(100);
EXECUTE BOOKS_PROCEDURE(1, 10000, :MESSAGE);

SELECT * FROM EMP1 ORDER BY DEPARTMENT_ID;


CREATE OR REPLACE FUNCTION BOOKS_FUNCTION(VID IN BOOKS.ID%TYPE)RETURN VARCHAR2
IS
    VBOOKS_RT BOOKS%ROWTYPE;
    VMESSAGE VARCHAR2(100);
BEGIN
    
    SELECT * INTO VBOOKS_RT FROM BOOKS WHERE ID = VID;
    VMESSAGE := VBOOKS_RT.ID||'번의 총 금액은 '|| VBOOKS_RT.PRICE || '입니다';
    RETURN VMESSAGE;
END;
/

SELECT BOOKS_FUNCTION(2) AS "RESULT" FROM DUAL;