-- Stored Procedures
-- Son como "funciones" que puedes ejecutar cuando lo necesites, y que pueden contener 
-- consultas SQL, lógica condicional (IF, WHILE, etc.) y más

CREATE PROCEDURE large_salaries()
select * from employee_salary
where salary >= 50000;

DELIMITER $$ 
CREATE PROCEDURE large_salaries2()
BEGIN
	select * from employee_salary
	where salary >= 50000;
	select * from employee_salary
	where salary >= 10000;
END $$
DELIMITER ;

-- asi llamamos los stored procedures
CALL large_salaries2(); 


-- Pasamos parametros
DELIMITER $$ 
CREATE PROCEDURE large_salaries4(emp_id int)
BEGIN
	select salary from employee_salary
    where employee_id = emp_id
    ;
END $$
DELIMITER ;

call large_salaries4(1)

