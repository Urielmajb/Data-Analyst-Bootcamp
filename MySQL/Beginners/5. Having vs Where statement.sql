-- Having vs Where

select gender, avg(age)
from employee_demographics
group by gender
having avg(age) > 40;

select occupation, avg(salary)
from employee_salary
group by occupation
having avg(salary) > 75000;

-- Se usa having para filas en totalidad y estas van despues del group by,mientras que where es para algo en especifico que se cumpla.