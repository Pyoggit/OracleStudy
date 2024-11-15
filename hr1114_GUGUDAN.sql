DECLARE 
    VNUM NUMBER := 1;
    VCOUNT NUMBER := 1;
BEGIN
    FOR VNUM IN 1..9 LOOP 
    DBMS_OUTPUT.PUT_LINE('==========='|| VNUM || '단=============='); 
        FOR VCOUNT IN 1..9 LOOP
            DBMS_OUTPUT.PUT_LINE(VNUM || '*' || VCOUNT || '=' || VNUM * VCOUNT);
        END LOOP;
    END LOOP;
    
END;