--hr resource 에 있는 테이블 정보(클래스종류)
select * from tab;
--employees 테이블 구조(클래스구조)
desc employees;
--employees 속에 들어있는 레코드(객체구조)  
select * from employees;
--departments 테이블 객체(레코드=인스턴스)를 확인
select * from departments;
--departments 테이블 구조
desc departments;
--department_id,department_name
select department_id,department_name from departments;
--필드명에 별칭사용하기
select department_id as "부서번호", department_name as "부서명" from departments;
select department_id as DEPT_NO, department_name as DEPT_NAME from departments;
-- + ||
select '5' + 5 from dual;
select '5' || 5 from dual;
--문자열 기능을 이용해서 필드명 보여주기
select first_name, job_id from employees;
select first_name || '의 직급은' || job_id || '입니다' from employees;
select first_name || '의 직급은' || job_id || '입니다' as data from employees;
--중복되지 않게 보여주기 DISTINCT
select distinct job_id from employees;
--연봉을 3000이상 받는 사람 정보
select * from employees where salary >= 3000;
--2008년 이후에 입사한 직원 정보
select * from employees where hire_date >= '2008/01/01';
select * from employees where TO_CHAR(hire_date,'YYYY/MM/DD') >= '2008/01/01';
select * from employees where hire_date >= TO_DATE('2008/01/01','YYYY/MM/DD HH24:MI:SS');
--AND , BETWEEN a AND b 
SELECT * FROM EMPLOYEES WHERE SALARY >= 2000 AND SALARY <= 3000;
SELECT * FROM EMPLOYEES WHERE SALARY BETWEEN 2000 AND 3000;
--OR, IN ( , )직원번호가 67 이거나 101 이거나 184인 사원 정보
SELECT * FROM EMPLOYEES WHERE EMPLOYEE_ID = 67 OR EMPLOYEE_ID = 101 OR EMPLOYEE_ID = 184;
SELECT * FROM EMPLOYEES WHERE EMPLOYEE_ID IN(67,101,184);
-- NULL 연산,비교,할당 불가능 
SELECT 100 + NULL FROM DUAL;
DESC EMPLOYEES;
SELECT * FROM EMPLOYEES WHERE COMMISSION_PCT IS NOT NULL;
SELECT * FROM EMPLOYEES;
-- ORDER BY ASC, DESC 사원번호를 기준으로 오름차순,내림차순 정렬
SELECT EMPLOYEE_ID, FIRST_NAME FROM EMPLOYEES ORDER BY EMPLOYEE_ID ASC;
SELECT EMPLOYEE_ID, FIRST_NAME FROM EMPLOYEES ORDER BY EMPLOYEE_ID DESC;
-- GROUP BY
SELECT DEPARTMENT_ID, SUM(SALARY) FROM EMPLOYEES
GROUP BY DEPARTMENT_ID HAVING DEPARTMENT_ID = 30;

SELECT * FROM EMPLOYEES;
SELECT DEPARTMENT_ID, SALARY FROM EMPLOYEES;
