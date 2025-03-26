-- Funciones de cadena

-- Las funciones de cadena permite manipular tipos de datos 
-- como varchar, nvarchar, char, nchar

-- Función Len -> devuelve la longitud de una cadena 

-- Declaración de una variable
DECLARE @numero int;
SET @numero = 10;
print @numero


DECLARE @Texto varchar(50) = 'Hola, Mundo!';

-- Obtener el tamaño de la cadena almacenada en la variable Texto
Select len(@Texto) as [Longitud]

--LEFT -> Extrae un determinado numero de caracteres desde el inicio de la cadena

select LEFT(@Texto, 4) as Inicio

-- Right -> Extrae un determinado numero de carecteres del final de la cadena
select RIGHT(@Texto, 6) as Final


--substring -> Extrae una parte de la cadena, donde el segundo parametro, 
-- es la posición inicial y tercer parametro el recorrido
select SUBSTRING(@Texto2, 7,4)
-- replace -> Reemplaza una subcadena por otra
-- REPLACE ( string_expression , string_pattern , string_replacement )  
SELECT REPLACE(@Texto2, 'Mundo', 'Amigo')


DECLARE @Texto2 varchar(50) = 'Hola, Mundo!';
-- CharIndex
select CHARINDEX('Hola', @Texto2)

-- UPPER -> Convierte una cadena en mayusculas
select Upper(@Texto2) as Mayusculas
DECLARE @Texto2 varchar(50) = 'Hola, Mundo!';

select Concat(
              LEFT(@Texto2,6),
			  UPPER(SUBSTRING(@Texto2, 7, 5)),
			  RIGHT(@texto2,1)
			  ) as Textonuevo

Update Customers
set CompanyName = Upper(CompanyName)
where country in ('Mexico', 'Germany')

-- Trim -> Quita espacios en blanco de una cadena
SELECT TRIM( '     test    ') AS Result;

DECLARE @Texto2 varchar(50) = '   Hola,Mundo!     ';
SELECT LTRIM(@Texto2) AS Result;

SELECT LTRIM('     Five spaces are at the beginning of this string.');
SELECT TRIM('  Five spaces are at the beginning of this string.       ');

select companyname, len(CompanyName) as 'Numero de Caracteres',
LEFT(CompanyName, 4) as Inicio, 
RIGHT(CompanyName, 6) as Final, 
SUBSTRING(CompanyName,7,4) as 'SubCadena'
from Customers
GO