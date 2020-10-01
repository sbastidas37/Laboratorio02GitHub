USE SAMPLE_SBR
GO

CREATE TABLE employee  (emp_no INTEGER NOT NULL, 
                        emp_fname CHAR(20) NOT NULL,
                        emp_lname CHAR(20) NOT NULL,
                        dept_no CHAR(4) NULL)
CREATE TABLE department(dept_no CHAR(4) NOT NULL,
                        dept_name CHAR(25) NOT NULL,
                        location CHAR(30) NULL)
CREATE TABLE project   (project_no CHAR(4) NOT NULL,
                        project_name CHAR(15) NOT NULL,
                        budget FLOAT NULL)
CREATE TABLE works_on	(emp_no INTEGER NOT NULL,
                        project_no CHAR(4) NOT NULL,
                        job CHAR (15) NULL,
                        enter_date DATE NULL)

insert into employee values(25348, 'Matthew', 'Smith','d3')
insert into employee values(10102, 'Ann', 'Jones','d3')
insert into employee values(18316, 'John', 'Barrimore', 'd1')
insert into employee values(29346, 'James', 'James', 'd2')
insert into employee values(9031, 'Elsa', 'Bertoni', 'd2')
insert into employee values(2581, 'Elke', 'Hansel', 'd2')
insert into employee values(28559, 'Sybill', 'Moser', 'd1')

insert into department values ('d1', 'research','Dallas')
insert into department values ('d2', 'accounting', 'Seattle')
insert into department values ('d3', 'marketing', 'Dallas')

insert into project values ('p1', 'Apollo', 120000.00)
insert into project values ('p2', 'Gemini', 95000.00)
insert into project values ('p3', 'Mercury', 186500.00)

insert into works_on values (10102,'p1', 'analyst', '2006.10.1')
insert into works_on values (10102, 'p3', 'manager', '2008.1.1')
insert into works_on values (25348, 'p2', 'clerk', '2007.2.15')
insert into works_on values (18316, 'p2', NULL, '2007.6.1')
insert into works_on values (29346, 'p2', NULL, '2006.12.15')
insert into works_on values (2581, 'p3', 'analyst', '2007.10.15')
insert into works_on values (9031, 'p1', 'manager', '2007.4.15')
insert into works_on values (28559, 'p1', NULL, '2007.8.1')
insert into works_on values (28559, 'p2', 'clerk', '2008.2.1')
insert into works_on values (9031, 'p3', 'clerk', '2006.11.15')  
insert into works_on values (29346, 'p1','clerk', '2007.1.4')


-- Ejemplo 6.1 -- Se obtiene detalles de todos los departamentos
USE SAMPLE_SBR
SELECT [dept_no]
	  ,[dept_name]
	  ,[location]
  FROM [department]
GO

-- o tambien se puede utilizar asi

SELECT * FROM [department]

-- Ejemplo 6.2 --Usar WHERE

SELECT dept_name, dept_no --Salida
	FROM department		  -- Objeto
	WHERE location = 'Dallas'; -- Predicado

-- Ejemplo 6.3 -- Obtener los nombre y apellidos de los empleados cuyo numero sea igual o mayor a 15000

SELECT emp_no, emp_lname, emp_fname
	FROM employee
	WHERE emp_no >= 15000;

-- Ejemplo 6.4 -- Obtener los nombres de los proyectos con un presupuesto mayor o igual a $60.000

SELECT project_name, budget
	FROM project
	WHERE budget*0.51 > 60000; 

-- Ejemplo 6.5 -- Obtener el nombre del proyecto que tenga como codigo p1 o p2 

SELECT project_name
	FROM project
	WHERE project_no = 'p1'
	OR project_no = 'p2';
	    
-- 6.5.2 
SELECT DISTINCT emp_no, project_no
	FROM works_on
	WHERE project_no = 'p1' OR project_no = 'p2';

-- Ejemplo 6.6 (Como no usar el Distinct)

SELECT  emp_fname, DISTINCT emp_no
	FROM employee
	WHERE emp_lname = 'Moser';

-- Ejemplo 6.7

SELECT emp_no, emp_fname, emp_lname
	FROM employee
	WHERE (emp_no = 25348 AND emp_lname = 'Smith') -- VERDADERO
	OR (emp_fname = 'Matthew' AND dept_no = 'd1 '); -- FALSO -- Me muestra al empleado porque la comparacion OR da como resultado VERDADERO

-- Ejemplo 6.8 

SELECT emp_no, emp_lname
	FROM employee
	WHERE NOT dept_no = 'd2'; -- Me muestra los Empleados que no estan en el departamento d2

-- Ejemplo 6.9

SELECT emp_no,  emp_fname, emp_lname
	FROM employee
	WHERE emp_no IN (29346, 25348, 28559); -- Se muestran los empleados que tengan esos numeros 

-- Ejemplo 6.10 -- Muestra las columnas del empleado cuyo numero de empleado no es ni 10102 ni 9031

SELECT emp_no, emp_fname, emp_lname, dept_no
	FROM employee
	WHERE emp_no NOT IN (10102, 9031);

-- Ejemplo 6.11: 

SELECT project_name, budget
	FROM project
	WHERE budget BETWEEN 95000 AND 120000;

-- Ejemplo 6.12: Intervalo abierto

SELECT project_name, budget
	FROM project
	WHERE budget > 95000 AND budget < 120000;

--Ejemplo 6.13 -- Me muestra todos los Presupuestos que no estan entre $100.000 y $150.000

SELECT project_name, budget
	FROM project
	WHERE budget NOT BETWEEN 100000 AND 150000; 


-- Ejemplo 6.14  -- Muestra todos los empleados que estan en el proyecto 2 y ademas su trabajo esta en valor NULL

SELECT emp_no, project_no
	FROM works_on
	WHERE project_no = 'p2' 
	AND job IS NULL;

-- Ejemplo 6.15 -- Muestra todos los registros de puesto que son diferentes a NULL

SELECT emp_no, project_no
	FROM works_on
	WHERE job IS NOT NULL;

-- Ejemplo 6.16 

SELECT emp_no, ISNULL(job, 'No conocido') AS task -- Me remplaza el valor NULL por el valor que yo deseo
	FROM works_on
	WHERE project_no = 'p1';

-- Ejemplo 6.17 

SELECT emp_fname, emp_lname, emp_no
	FROM employee
	WHERE emp_fname LIKE '%__s%';

-- Ejemplo 6.18

SELECT *
	FROM department
	WHERE location LIKE '[C-F]%';
	 
-- Ejemplo 6.19 -- Obtener los empleados cuyo Apellido empieza con las letras entre J y O y su nombre no comience con la letra E y Z 

SELECT emp_no, emp_fname, emp_lname
	FROM employee
	WHERE emp_lname LIKE '[^J-O]%'
	AND emp_fname LIKE '[^EZ]%';

-- Ejemplo 6.20 -- Obtener todos los nombres de empleados que no terminen en N

SELECT emp_no, emp_fname, emp_lname
	FROM employee
	WHERE emp_fname NOT LIKE '%n';

-- Ejemplo 6.21 

SELECT project_no, project_name
	FROM project
	WHERE project_name LIKE '%[!_]%';

SELECT project_no, project_name
	FROM project
	WHERE project_name LIKE '%!_%' ESCAPE '!';    
-- Caracteres comodin (_, %, ^)
