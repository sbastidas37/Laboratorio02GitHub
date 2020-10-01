-- Santiago Bastidas
-- ADSI 3
-- 12 Mayo 2020

-- Ejemplo 6.22: Obtener los nombres de los empleados que trabajan en el departamento Investigacion (research)

USE SAMPLE_SBR
GO

SELECT emp_fname, emp_lname
	FROM employee
	WHERE dept_no = 
		(SELECT dept_no
			FROM department
			WHERE dept_name = 'research');

-- Ejemplo 6.23: Obtener los datos de todos los empleados cuyo departamento se encuentra en la ciudad de Dallas.

SELECT *
	FROM employee
	WHERE dept_no IN
		(SELECT dept_no 
			FROM department
			WHERE location = 'Dallas');

-- Ejemplo 6.24: Obtener los apellidos de todos los empleados que trabajan en el proyecto Apollo

SELECT emp_fname, emp_lname -- Tercera consulta que se realiza
	FROM employee
	WHERE emp_no IN
		(SELECT emp_no -- Segunda consulta que se realiza
			FROM works_on
			WHERE project_no IN
				(SELECT project_no -- Primera consulta que se realiza
					FROM project
					WHERE project_name = 'Apollo'));

-- Ejemplo 6.25: Obtener los numeros del empleado, numero de proyecto, nommbre del puesto de trabajo que no han dedicado la mayor parte del tiempo al trabajo en el que estan

SELECT DISTINCT emp_no, project_no, job 
	FROM works_on
	WHERE enter_date > ANY
		(SELECT enter_date 
			FROM works_on);

-- Ejemplo 6.26: Obtener todos los puestos de trabajo
 
SELECT job 
	FROM works_on
	GROUP BY job;

-- Ejemplo 6.27: Agrupar los puestos de trabajo y los numeros de proyecto.

SELECT project_no, job
	FROM works_on
	GROUP BY project_no, job; 

-- Funciones Agregadas
-- Ejemplo 6.28: Instruccion Ilegal.

SELECT emp_lname, MIN(emp_no)
	FROM employee;

-- Ejemplo 6.29: 

SELECT MIN(emp_no) AS min_employee_no
	FROM employee;

-- Ejemplo 6.30:

SELECT emp_no, emp_lname
	FROM employee
	WHERE emp_no =
	(SELECT MIN(emp_no) 
		FROM employee);

-- Ejemplo 6.31: Obtenga el numero de empleado del gerente que se ingreso al ultimo en la tabla trabaja_en

SELECT emp_no
	FROM works_on
	WHERE enter_date =
	(SELECT MAX(enter_date)
		FROM works_on
		WHERE job = 'Manager');

-- Ejemplo 6.32: Calcular la suma de todos los presupuestos de todos los proyectos

SELECT SUM(budget) suma_de_presupuestos
	FROM project;

-- Ejemplo 6.33: El mismo resultado anterior.

SELECT SUM(budget) suma_de_presupuestos
	FROM project
	GROUP BY();

-- Ejemplo 6.34: Calcular el promedio de todos los presupuestos con una cantidad mayor a $100.000

SELECT AVG(budget) presupuesto_prom
	FROM project
	WHERE budget > 100000;

-- Ejemplo 6.35: Cuenta todos los puestos diferentes en cada proyecto.

SELECT project_no, COUNT(job) job_count
	FROM works_on
	GROUP BY project_no;

-- Ejemplo 6.36: Obtener el numero de cada puesto en todos los proyectos.

SELECT job, COUNT(*) job_count
	FROM works_on
	GROUP BY job;

-- Ejemplo 6.37: Obtener los numeros de projectos que emplean a menos de 4 personas.

SELECT project_no
	FROM works_on
	GROUP BY project_no
	HAVING COUNT(*) < 4;

-- Ejemplo 6.38: Agrupar las filas de la tabla Trabaja_en por puesto y eliminar los puestos que no comiencen con la M

SELECT job
	FROM works_on
	GROUP BY job
	HAVING job LIKE 'M%';

-- Ejemplo 6.39: Obtener los numeros de empleado y su nombre donde el numero sea menor a 20000

SELECT emp_lname, emp_fname,  dept_no
	FROM employee
	WHERE emp_no < 20000
	ORDER BY emp_lname, emp_fname;

-- Ejemplo 6.40: Para cada numero de proyecto, obtenga el numero de proyecto y el numero de todos los empleados, en orden descendente

SELECT project_no, COUNT(*) emp_Cantidad
	FROM works_on
	GROUP BY project_no
	ORDER BY 2 DESC;

-- Ejemplo 6.41:

CREATE TABLE Product
(
	product_no INTEGER IDENTITY (10000, 5) NOT NULL, -- Campo candidato a identidad
	product_name CHAR(30) NOT NULL,
	price MONEY);

USE [SAMPLE_SBR]
GO

-- Insert de la tabla Product
INSERT INTO [dbo].[Product]
           ([product_name]
           ,[price])
     VALUES
           ('Jabon'
           ,10000)
GO

INSERT INTO [dbo].[Product]
           ([product_name]
           ,[price])
     VALUES
           ('Lentejas'
           ,20000)
GO

INSERT INTO [dbo].[Product]
           ([product_name]
           ,[price])
     VALUES
           ('Arbejas'
           ,30000)
GO

SELECT IDENTITYCOL
	FROM Product
	WHERE product_name = 'Lentejas';

SELECT IDENT_SEED('DBO.Product'); -- Devuelve el valor de la semilla del campo product_no de la tabla Product

SELECT IDENT_INCR('DBO.Product'); -- Devuelve el valor del incremento del campo product_no de la tabla Product



