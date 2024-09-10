-- Trigger y Eventos

-- los trigger son bloques de codigos que se ejecutan automaticamente cuando evento esta a punto de 
-- tomar una especifica tabla.

-- Tambien son de uso para mantener una consistencia de datos y hacer cambios de datos basados en tareas automaticas

DELIMITER $$
CREATE TRIGGER Employee_insert
	AFTER INSERT ON employee_salary -- Aqui es cuando insertarmos despues. 
    FOR EACH ROW -- Se activara cuando cada columna sea insertada
BEGIN
INSERT INTO employee_demographics (employee_id, first_name, last_name)
VALUES (NEW.employee_id, NEW.first_name, NEW.last_name); 
END $$
DELIMITER ;

insert into employee_salary (employee_id, first_name, last_name, occupation,salary, dept_id)
values (13, 'urielma', 'jiron', 'wev dev', 200000, null);

select * from employee_salary;
select * from employee_demographics;


-- EVENTS (Es por horario)

select * from employee_demographics;

DELIMITER $$
create event delete_retiree
ON SCHEDULE EVERY 30 SECOND -- TAMBIEN SE PUEDE HACER CADA MES O AÑO
DO
BEGIN 
	DELETE FROM employee_demographics
    where age >= 60;
END $$
DELIMITER ;

SHOW VARIABLES LIKE 'event%'