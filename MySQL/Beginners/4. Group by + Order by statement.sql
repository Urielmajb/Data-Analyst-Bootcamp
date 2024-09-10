-- Group By

select gender, avg(age), max(age), min(age), count(age)
from employee_demographics
group by gender;

select occupation, salary
from employee_salary
group by occupation, salary;

-- Order by
-- Te ordena los datos ya sea de manera ascendente o descendiente
select * from employee_demographics
order by first_name DESC;

select * from employee_demographics
order by gender, age DESC ;