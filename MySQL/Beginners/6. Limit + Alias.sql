-- Limit & aliasing
select * from employee_demographics
order by age desc
limit 2, 1; 

-- Alias
select gender, avg(age) as avg_age
from employee_demographics 
group by gender
having avg(age) > 40;