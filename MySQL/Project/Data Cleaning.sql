-- Data cleaning 

SELECT * FROM layoffs;

-- Task to do
-- 1. Remove Duplicates if there's any.
-- 2. Standardize the Data.
-- 3. Null values or blank values
-- 4. Remove any columns that are unnecesary.

-- Creamos otra tabla de stage para evitar estragos en la tabla donde tenemos los datos originales.
CREATE TABLE layoff_staging 
LIKE layoffs;

-- Insertamos los mismo datos a la tabla que se creó.
insert layoff_staging
select * from layoffs;

-- Remover los duplicados
select * from layoff_staging;

-- Creamos un cte para ayudarnos a identificar y selecciona las filas que tienen valores duplicados 
-- en todas las columnas especificadas en la cláusula PARTITION BY.

WITH duplicate_cte as (
select *, row_number() 
over(partition by company, location, industry, total_laid_off, percentage_laid_off, `date`,
stage, country, funds_raised_millions) as row_num
from layoff_staging
)
select * from duplicate_cte
where row_num > 1;

-- Delete duplicate rows.

-- Creamos otra tabla agregandole la columna "row_num" para identificar bien 
-- los datos duplicados.
CREATE TABLE `layoff_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Insertamos de nuevo los datos ya incluyendo el row_num
insert into layoff_staging2
 select *, row_number() 
over(partition by company, location, industry, total_laid_off, percentage_laid_off, `date`,
stage, country, funds_raised_millions) as row_num
from layoff_staging;

-- Borramos los datos que se duplicana
DELETE from layoff_staging2
where row_num > 1;

-- Seleccionamos, y no apareceran los datos duplicados.
select *  from layoff_staging2;

-- Standarizing data (Encontrar problemas en la data y arreglarlos=

-- Quitamos los espacios
select company, TRIM(company)
from layoff_staging2;

-- Actualizamos los datos para quitar los espacios.
update layoffs_staging2
set company = trim(company);

-- Revisamos las columnas

-- Se identifico que en la columna Industry hay valores que se repiten pero son del mismo grupo tal como "Crypto" esta tiene multiples variaciones
-- Hacemos un select para indentificar y luego update al valor que queremos que se llamen.

select *
from layoff_staging2
where industry like 'Crypto%';

update layoff_staging2
set industry = 'Crypto'
where industry like 'Crypto%';

-- Identificamos que en la columna country hay un dato que se repite "United State", pero uno de ellos lleva un . al final, por lo tanto se 
-- tendra que actualizar.
select distinct(country), trim(trailing '.' from country)
from layoff_staging2
order by 1;

update layoff_staging2
set country = trim(trailing '.' from country)
where country like 'United States%';

SET SQL_SAFE_UPDATES = 0;

SELECT * FROM layoff_staging2;

-- Así mismo identificamos que date esta en formato TEXT, por lo tanto haremos un parsing a su dato original-
SELECT `date`,
str_to_date(`date`, '%m/%d/%Y')
from layoff_staging2;

update layoff_staging2
set `date` = str_to_date(`date`, '%m/%d/%Y');

alter table layoff_staging2 
modify column `date` date;

-- Null values or blank values

select * from layoff_staging2;

-- Verificamos que en las tablas total_laid_off y percentage_laid_off tienen muchos valores null.
select * from layoff_staging2
where total_laid_off and percentage_laid_off is null;

-- Así mismo en la tabla industry
select *
from layoff_staging2
where industry IS NULL
OR industry = '';

select t1.industry, t2.industry 
from layoff_staging2 t1
JOIN layoff_staging2 t2
	on t1.company = t2.company
WHERE (t1.industry IS NULL OR t1.industry = '')
AND t2.industry IS NOT NULL;

update layoff_staging2 t1
JOIN layoff_staging2 t2
	on t1.company = t2.company
set t1.industry = t2.industry
WHERE (t1.industry IS NULL OR t1.industry = '')
AND t2.industry IS NOT NULL;

update layoff_staging2 
set industry = NULL
where industry = '';

select * from layoff_staging2
where total_laid_off is null 
and percentage_laid_off is null;

-- Remove any columns that are unnecesary.

-- Se borró datos que son nulos ya que no serviran en el proceso de la bdo, así mismo de la tabla de row_com
delete from layoff_staging2
where total_laid_off is null 
and percentage_laid_off is null;

select * from layoff_staging2;

alter table layoff_staging2
drop column row_num;