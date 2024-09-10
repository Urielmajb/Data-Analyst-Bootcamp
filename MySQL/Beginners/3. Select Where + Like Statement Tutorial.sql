-- WHERE CLAUSE

select * from employee_salary
where first_name= 'Leslie';

select * from employee_salary
where salary <= 50000;

select * from employee_demographics
where gender != 'Female';   #aqui busca los que no tienen genero femenino#

select * from employee_demographics
where birth_date > '1985-01-01' or not gender = 'Male';

select * from employee_demographics
where (first_name = 'Leslie' and age = 44) or age > 55;

-- Like Statement
-- % and _ (El porcentaje significa que busque cualquier cosa, pero el barra hacia abajo un dato en especifico.
select * from employee_demographics
where first_name like '%a%';

#Este nos ayuda a buscar un dato que tenga dos caracteres depues de la a
select * from employee_demographics
where first_name like 'a__';

#Tambien se pueden unificar.
select * from employee_demographics
where birth_date like '198__%';