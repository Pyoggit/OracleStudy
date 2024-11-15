--PL/SQL
DECLARE
    VDEPARTMENTS DEPARTMENTS%ROWTYPE;
    CURSOR C1 IS SELECT * FROM DEPARTMENTS;

BEGIN
    -- FOR문 활용
    FOR VDEPARTMENTS IN C1 LOOP
        DBMS_OUTPUT.PUT_LINE(VDEPARTMENTS.DEPARTMENT_ID || ' / ' || VDEPARTMENTS.DEPARTMENT_NAME);
    END LOOP;
    
    /*
    OPEN C1;
    LOOP
        FETCH C1 INTO VDEPARTMENTS;
        EXIT WHEN C1%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(VDEPARTMENTS.DEPARTMENT_ID || ' / ' || VDEPARTMENTS.DEPARTMENT_NAME);
        
    END LOOP;
    CLOSE C1;*/
END;
/

