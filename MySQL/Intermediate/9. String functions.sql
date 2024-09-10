-- String Functions

-- cuenta la cantidad de caracteres
select length('skyfall');
select first_name, length(first_name) from employee_demographics;

-- upper y lower
select first_name, upper(first_name) as mays from employee_demographics;
select first_name, lower(first_name) as min from employee_demographics;

-- trim (quita los espacios)
select trim('  uri   ');

-- Busca solo los primeros 4 caracteres de laizquierda
select first_name, left(first_name,4)
from employee_demographics;

select first_name, right(first_name,4)
from employee_demographics;

-- substring (nos ayuda a extraer una parte en especifica de un texto o cadena)
select first_name, birth_date,
substring(birth_date,6,2) as birth_month
from employee_demographics;

-- Replace (Reemplaza un dato con cualquier resultado q querramos)
select first_name, replace(first_name,'a', 'z')
from employee_demographics;

-- Concatenacion

select first_name, last_name, concat(first_name, '  ', last_name) as full_name from employee_demographics;