-- Temporary tables
-- Son tablas que son solo visibles en las sesiones que fueron creadas, es decir son temporales.

-- esta es una manera vieja de hacerlo.
CREATE TEMPORARY TABLE temp_table
(
	first_name varchar(50),
    last_name varchar(50),
    favorite_movie varchar(100)
);

select * from temp_table;
insert into temp_table 
values ('urielma', 'jiron', 'pearl (2022)');

-- Podemos tambien crear tablas temporales apartir de otras que SI EXISTEN

create temporary table salary_over_50k
select * from employee_salary
where salary >=50000;

select * from salary_over_50k