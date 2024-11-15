--PL/SQL
DECLARE
    VDEPARTMENTS DEPARTMENTS%ROWTYPE;
    I NUMBER := 1;
    J NUMBER := 1;

BEGIN
    FOR I IN 1..9 LOOP 
    DBMS_OUTPUT.PUT_LINE('==========='|| I || '단=============='); 
        FOR J IN 1..9 LOOP
            DBMS_OUTPUT.PUT_LINE(I || '*' || J || '=' || I * J);
        END LOOP;
    END LOOP;

END;
/

