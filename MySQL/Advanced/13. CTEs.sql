-- CTE (Common table expressions) son expresiones o "tablas temporales" donde se pueden definir 
-- dentro de una consulta

-- query calculates and returns the average, maximum, minimum, 
-- and count of salaries for each gender group in the employee_demographics and employee_salary tables.

with CTE_Example (Gender, AVG_SAL, MAX_SAL, MIN_SAL, COUNT_SAL) AS (
select gender, avg(salary) avg_sal, MAX(salary) max_sal, MIN(salary) min_sal, count(salary) count_sal
from employee_demographics dem
join employee_salary sal 
on dem.employee_id = sal.employee_id
group by gender
)
select * from CTE_Example;

-- crear mas ctes y unirlas
with CTE_Example AS 
(
select first_name, employee_id, gender, birth_date
from employee_demographics 
where birth_date > '1985-01-01'
),
CTE_Example2 as 
(
select employee_id, salary 
from employee_salary
where salary > 50000
)
select * from CTE_Example
JOIN CTE_Example2 on CTE_Example.employee_id = CTE_Example2.employee_id;