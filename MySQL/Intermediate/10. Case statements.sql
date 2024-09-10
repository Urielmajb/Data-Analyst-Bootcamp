-- Case statement

select * from employee_demographics;
select concat(first_name, ' ', last_name) as full_name, age,
CASE 
	when age <= 30 then 'Young'
    when age between 31 and 50 then 'Old'
    when age >= 61 then 'Bye bye'
END AS Age_bracked
from employee_demographics;

-- Una institucion mando un memo de los bonus y pagos a incrementar al final de año
-- y determinar dependiendo del salario si ganaran ese bonus o no.
	
-- Pay increase and bonus
-- < 50000 = 5%
-- > 50000 = 7%
-- Finance = 10% bonus

Select first_name, last_name, salary,
case 
	when salary < 50000 then salary * 1.05
    when salary > 50000 then salary * 1.07
end as new_salary,
case
	when dept_id = 6 then salary * .10
end as bonus
from employee_salary;
