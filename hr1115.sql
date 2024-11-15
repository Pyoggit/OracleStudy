--PL/SQL
--EMPLOYEES 테이블에서 요구한 부서별로 사용자 정보(이름,급여)를 CURSOR에 저장하고 부서별 요청시 해당되는 부서정보 출력
DECLARE
    VEMP_ROWTYPE EMPLOYEES%ROWTYPE;
    VSALARY VARCHAR2(20);
    VNO NUMBER(3);
    -- 부서별로 정보를 저장할 수 있는 커서 생성
    CURSOR C1(VDEPTNO EMPLOYEES.DEPARTMENT_ID%TYPE)
    IS
    SELECT * FROM EMPLOYEES WHERE DEPARTMENT_ID = VDEPTNO;

BEGIN
    -- 부서별 정보를 생성을 시킨다. 랜덤값으로
    VNO := ROUND(DBMS_RANDOM.VALUE(10, 110),-1);
    -- 부서번호 40번에 종료
    IF (VNO = 40) THEN 
        DBMS_OUTPUT.PUT_LINE(VNO || '해당되지 않는 부서 번호입니다.');
        RETURN;
    END IF;
    -- 부서번호 정보를 가져와서 월급에 대해서 평가를 진행한다.
    FOR VEMP_ROWTYPE IN C1(VNO) LOOP
        IF VEMP_ROWTYPE.SALARY BETWEEN 1 AND 1000 THEN
            VSALARY := '낮음';     
        ELSIF  VEMP_ROWTYPE.SALARY BETWEEN 1001 AND 2000 THEN
            VSALARY := '중간';
        ELSIF  VEMP_ROWTYPE.SALARY BETWEEN 2001 AND 3000 THEN
            VSALARY := '높음';
        ELSE
            VSALARY := '매우높음';
        END IF;
        DBMS_OUTPUT.PUT_LINE(VNO || ' / ' ||VEMP_ROWTYPE.FIRST_NAME|| ' / ' ||VEMP_ROWTYPE.SALARY || ' / ' || VSALARY);
    
    END LOOP;
END;
/
