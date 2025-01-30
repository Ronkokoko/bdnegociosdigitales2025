

-- Lenguaje SQL-LMD (Insert, Update, Delete, Select - CRUD)
-- Consultas Simples

use Northwind;

-- Mostrar todos los clientes de la empresa con todas las columas (todos sus datos)
-- Clientes, Proveedores, Categorias, Productos, Ordenes, Detalle de Ordemes, Empleados

select * from Customers;
select * from Employees;
select * from Orders;
select * from Suppliers;
select * from Products;
select * from Shippers;
select * from Categories;
select * from [Order Details];

--Proyeccion
select ProductID, ProductName, UnitPrice, UnitsInStock from products;

--Seleccionar el numero de emplead, su primer nombre, su cargo, ciudad y pais a la que pertenece
select * from Employees;
select EmployeeID, FirstName, Title, City, Country from Employees;


-- En base a la consulta anterior, visualizar es EmployeeID como numero de empleado, FistName como primer nombre,
-- Title como cargo, City como ciudad, Country como pais

select EmployeeID as 'Numero Empleado',
FirstName as 'PrimerNombre', Title as 'Cargo', City as 'Ciudad', Country as 'Pais' from Employees;

--Campos Calculados
--Seleccionar el importe de cada uno de los productos vendidos en una orden
select *, (UnitPrice * Quantity) as 'Importe' from [Order Details];

--Seleccionar las fechas de orden, año, mes y dia, 
--el cliente que las ordeno y el empleado que las realizo

select * from Orders;
select OrderDate, year(OrderDate) as 'Año en el que se ordeno', MONTH(OrderDate)as 'Mes en el que se ordeno', day(OrderDate) as 'Dia en el que se 
ordeno', CustomerID, EmployeeID from Orders;


-- Filas duplicadas
-- Mostrar los paises donde se tienen los clientes, 
-- mostrando pais solamente

select distinct Country as 'Paises donde se encuentran clientes' from Customers order by country;

-- Clausula Where (Campo o Columna y lleva; 
-- Operadores relacionales(>, <, <=, >=, != o <>))

select * from Customers;

-- Seleccionar el cliente BOLID
select 
CustomerID as 'Id del Cliente', 
CompanyName as 'Compañia del que Proviene', 
City as 'Ciudad del que Proviene', 
Country as 'Pais del que Proviene'
from Customers
where CustomerID = 'BOLID';

--Seleccionar los clientes mostrando su identificador, nombre de la emprese, contacto, ciudad y pais de alemania
select 
CustomerID as 'Id del Cliente', 
CompanyName as 'Compañia del que Proviene', 
ContactName as 'Nombre del contacto', 
Country as 'Pais del que Proviene', 
City as 'Ciudad del que Proviene'
from Customers
where Country = 'Germany';

--Seleccionar todos los clientes que no sean de alemania

select 
CustomerID as 'Id del Cliente', 
CompanyName as 'Compañia del que Proviene', 
ContactName as 'Nombre del contacto', 
Country as 'Pais del que Proviene', 
City as 'Ciudad del que Proviene'
from Customers
where Country != 'Germany';

-- Seleccionar todos los productos, mostrando el nombre del producto
-- Categoria a la que pertenece, existencia, precio. pero solamente donde su precio sea mayor que 100

select* from Products;

select
ProductName as 'Nombre del producto',
CategoryID as 'Categoria a la que pertenece',
UnitsInStock as 'Existencias',
UnitPrice as 'Precio del producto'
from Products
where UnitPrice > 100;

--Seleccionar las ordenes de compra, mostrando la fecha de orden, la fecha de entrega, 
--la fecha de envio, el cliente a quien se vendio de 1996
select 
OrderDate as 'Fecha de la orden',
RequiredDate as 'Fecha de entrega',
ShippedDate as 'Fecha de envio',
CustomerID as 'Client'
from Orders
where YEAR(OrderDate) ='1996';


-- Test de comparacion
-- Mostrar todas las ordenes de compra donde la cantidad de productos comprados
-- sea mayor a 40

select Quantity as 'Cantidad de productos por orden' from [Order Details] where Quantity>40;
select * from Orders;

-- Mostrar el nombre completo del empleado, su numero de empleado,
-- Fecha de nacimiento, Ciudad en la que nacio, Fecha de contratacion y 
-- esta debe ser de aquellos que fueron contratados despues de 1993
-- Los resultados de sus encabezados deben ser mostrados en español

select * from Employees;

select 
FirstName as 'Nombre del empleado',
LastName as 'Apellido del empleado',
City as 'Ciudad',
year(BirthDate) as 'Fecha de nacimiento',
year(HireDate) as 'Fecha de contratacion'
from Employees 
where YEAR(HireDate) >'1993';

select 
(FirstName+ '  ' + LastName) as 'Nombre del empleado',
City as 'Ciudad',
year(BirthDate) as 'Fecha de nacimiento',
year(HireDate) as 'Fecha de contratacion'
from Employees 
where YEAR(HireDate) >'1993';

select 
Concat(FirstName, '  ', LastName) as [Nombre del empleado],
City as 'Ciudad',
year(BirthDate) as 'Fecha de nacimiento',
year(HireDate) as 'Fecha de contratacion'
from Employees 
where YEAR(HireDate) >'1993';

-- Mostrar los empleados con los empleados que no son dirigidos por el jefe 2
-- CCV a un dataframe, diccionarios
select 
Concat(FirstName, '  ', LastName) as [Nombre del empleado],
City as 'Ciudad',
year(BirthDate) as 'Fecha de nacimiento',
year(HireDate) as 'Fecha de contratacion'
from Employees 
where ReportsTo != 2;

-- Seleccionar los empleados que no tengan jefe

select * from Employees
where ReportsTo is null;
