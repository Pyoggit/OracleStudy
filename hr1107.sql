--inner join/ left,right Outer join

-- 부서별에 따라 급여를 인상하도록 하자.(조인: inner join, outer join, self join, cross join) 
-- (직원번호, 직원명, 직급, 급여)
--  부서ID에 따라서  'Marketing'인 직원은 5%, 'Purchasing'인 사원은 10%,
-- 'Human Resources'인 사원은 15%, ' IT'인 직원은 20%인 인상한다.
select * from departments;
select employee_id, first_name, salary, department_id from employees;
select * from employees inner join departments on employees.department_id = departments.department_id;

select employee_id, first_name, job_id, salary, E.department_id, D.department_name,
        case
        when upper(D.department_name) = upper('Marketing') then salary*1.05
        when upper(D.department_name) = upper('Purchasing') then salary*1.10
        when upper(D.department_name) = upper('Human Resources') then salary*1.15
        when upper(D.department_name) = upper('IT') then salary*1.20
        end NEWSALARY
from employees E inner join departments D on E.department_id = D.department_id
where upper(D.department_name) in (upper('Marketing'),upper('Purchasing'),upper('Human Resources'),upper('IT'))
order by NEWSALARY DESC;