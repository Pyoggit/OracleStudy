-- susan 부서아이디 보기
SELECT DEPARTMENT_ID FROM EMPLOYEES WHERE first_name = 'Susan';
-- 부서테이블에서 40번 부서명 조회
SELECT DEPARTMENT_NAME FROM DEPARTMENTS WHERE DEPARTMENT_ID = 40;

-- susan이 소속되어있는 부서명을 검색
SELECT * FROM EMPLOYEES WHERE first_name = 'Susan';
SELECT * FROM DEPARTMENTS WHERE DEPARTMENT_ID = 40;
select * from employees E inner join departments D on E.department_id = D.department_id 
WHERE UPPER(first_name) = UPPER('Susan');
-- 단일행은 비교, 크기, 연산이 가능하다.
-- 다중행은 비교, 크기, 연산이 불가능하다.(IN=ON, ANY=AND, ALL=OR, EXISTS=존재하면 true,안하면 false)
SELECT DEPARTMENT_ID FROM EMPLOYEES WHERE FIRST_NAME = 'Susan';
-- 서브 쿼리
SELECT * FROM DEPARTMENTS WHERE DEPARTMENT_ID = 
(SELECT DEPARTMENT_ID FROM EMPLOYEES WHERE FIRST_NAME = 'Susan');

SELECT EMPLOYEES FROM departments WHERE JOB_ID = 'CED';

SELECT * FROM DEPARTMENTS;
SELECT * FROM EMPLOYEES;

SELECT department_id FROM departments WHERE department_name = 'Accounting';

SELECT first_name,job_id,department_Id
FROM employees
WHERE job_id
IN(SELECT job_id FROM employees WHERE department_id = 110);

SELECT department_id FROM departments WHERE UPPER(department_name) = UPPER('accounting');





SELECT first_name, salary, department_id
FROM employees 
WHERE salary>(SELECT MIN(salary) FROM employees WHERE job_id = 'ST_MAN')
ORDER BY employees.department_id ASC;

SELECT * FROM employees
WHERE(job_id,salary)=(SELECT job_id,salary FROM employees WHERE first_name = 'Valli')
AND first_name <> 'Valli';

SELECT department_id,first_name,salary
FROM  employees 
WHERE salary>(SELECT AVG(salary) FROM employees 
WHERE department_id = (SELECT department_id FROM employees WHERE first_name = 'Valli'));


SELECT * FROM employees WHERE last_name = 'Tucker';

SELECT first_name, last_name AS Name, job_id, salary
FROM employees
WHERE salary>(SELECT salary FROM employees WHERE last_name = 'Tucker');

SELECT first_name, last_name AS Name, job_id, salary, hire_date 
FROM employees
WHERE(job_id, salary) IN (SELECT job_id,MIN(salary) FROM employees GROUP BY job_id); 
    
SELECT first_name, last_name AS Name, job_id, salary, department_id
FROM employees E
WHERE salary > (SELECT AVG(salary) FROM employees WHERE department_id = E.department_id);

SELECT first_name, last_name AS Name, job_id, salary, department_id,
(SELECT   ROUND(AVG(salary)) FROM employees WHERE department_id = E.department_id)
FROM employees E;