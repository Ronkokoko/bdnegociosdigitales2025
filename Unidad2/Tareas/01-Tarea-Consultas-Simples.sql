
use Northwind;

-- Tareas Consultas Simples

-- 1.  Productos con categoría 1, 3 o 5

select ProductName as 'Nombre del Producto',
CategoryID as 'Categoria',
UnitPrice as 'Precio',
UnitsInStock as 'Existencias'
from Products
where CategoryID in(1,3,5);

-- 2.	Clientes de México, Brasil o Argentina

select 
CustomerID as 'Id del Cliente', 
CompanyName as 'Compañia del que Proviene', 
City as 'Ciudad del que Proviene', 
Country as 'Pais del que Proviene'
from Customers
where Country in('Brazil','Mexico','Argentina');

-- 3.	Pedidos enviados por los transportistas 1, 2 o 3 y con flete mayor a 50

select * from Orders;

select OrderID as 'Numero de Orden',
OrderDate as 'Fecha de Orden',
RequiredDate as 'Fecha de Entrega',
Freight as 'Peso',
ShipCountry as 'Pais de Entrega'
from Orders
where ShipVia in(1,2,3) and Freight > 50;

-- 4.	Empleados que trabajan en Londres, Seattle o Buenos Aires

select * from Employees
where City = 'Buenos Aires';
-- No hay ningun empleado viviendo en Buenos Aires
select EmployeeID as 'Numero de trabajador',
concat(FirstName, '   ',  LastName) as [Nombre del Trabajador],
City as 'Ciudad'
from Employees
where City in ('London','Seattle','Buenos Aires');

-- 5.	Pedidos de clientes en Francia o Alemania, pero con un flete menor a 100

select * from Orders;

select OrderID as 'Numero de Orden',
OrderDate as 'Fecha de Orden',
RequiredDate as 'Fecha de Entrega',
Freight as 'Peso',
ShipCountry as 'Pais de Entrega'
from Orders
where Freight < 100 and ShipCountry in('Germany','France');

-- 6.	Productos con categoría 2, 4 o 6 y que NO estén descontinuados

select * from Products;

Select ProductName as 'Nombre del producto',
CategoryID as 'Categoria',
UnitPrice as 'Precio',
UnitsInStock as 'Existencias',
Discontinued as 'Descontinuacion (0 = No)'
from Products
where CategoryID in(2,4,6) and not Discontinued = 1;

-- 7.	Clientes que NO son de Alemania, Reino Unido ni Canadá

select * from Customers;

select 
CustomerID as 'Id del Cliente', 
CompanyName as 'Compañia del que Proviene', 
City as 'Ciudad del que Proviene', 
Country as 'Pais del que Proviene'
from Customers
where  not Country in('Germany','Mexico','UK');

-- 8.	Pedidos enviados por transportistas 2 o 3, pero que NO sean a USA ni Canadá

select * from Orders;

select OrderID as 'Numero de Orden',
OrderDate as 'Fecha de Orden',
RequiredDate as 'Fecha de Entrega',
Freight as 'Peso',
ShipCountry as 'Pais de Entrega'
from Orders
where ShipVia in(2,3) and not ShipCountry in('USA','Canada');

-- 9.	Empleados que trabajan en 'London' o 'Seattle' y fueron contratados después de 1995

select * from Employees;
-- No hay empleados contratados despuesd del 1995
select concat(FirstName, '   ',  LastName) as [Nombre Completo],
HireDate as 'Fecha de contratacion', 
City as 'Ciudad', 
Country as 'Pais'
from Employees
where City in('London','Seattle')
And year(HireDate) >1995;

-- 10.	Productos de categorías 1, 3 o 5 con stock mayor a 50 y que NO están descontinuados

select * from Products;

Select ProductName as 'Nombre del producto',
CategoryID as 'Categoria',
UnitPrice as 'Precio',
UnitsInStock as 'Existencias',
Discontinued as 'Descontinuacion (0 = No)'
from Products
where CategoryID in(1,3,5) and UnitsInStock > 50 and not Discontinued = 1;