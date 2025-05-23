# Inner Joins

![Diagrama Resultante](../Unidad2//Imgs/img_inner_join.png)

-- Lenguaje SQL-LMD (Insert, Update, Delete, Select - CRUD)
-- Consultas Simples

use Northwind;

-- Mostrar todos los clientes de la empresa con todas las columas (todos sus datos)
-- Clientes, Proveedores, Categorias, Productos, Ordenes, Detalle de Ordemes, Empleados

select _ from Customers;
select _ from Employees;
select _ from Orders;
select _ from Suppliers;
select _ from Products;
select _ from Shippers;
select _ from Categories;
select _ from [Order Details];

--Proyeccion
select ProductID, ProductName, UnitPrice, UnitsInStock from products;

--Seleccionar el numero de emplead, su primer nombre, su cargo, ciudad y pais a la que pertenece
select \* from Employees;
select EmployeeID, FirstName, Title, City, Country from Employees;

-- En base a la consulta anterior, visualizar es EmployeeID como numero de empleado, FistName como primer nombre,
-- Title como cargo, City como ciudad, Country como pais

select EmployeeID as 'Numero Empleado',
FirstName as 'PrimerNombre', Title as 'Cargo', City as 'Ciudad', Country as 'Pais' from Employees;

--Campos Calculados
--Seleccionar el importe de cada uno de los productos vendidos en una orden
select _, (UnitPrice _ Quantity) as 'Importe' from [Order Details];

--Seleccionar las fechas de orden, a�o, mes y dia,
--el cliente que las ordeno y el empleado que las realizo

select \* from Orders;
select OrderDate, year(OrderDate) as 'A�o en el que se ordeno', MONTH(OrderDate)as 'Mes en el que se ordeno', day(OrderDate) as 'Dia en el que se
ordeno', CustomerID, EmployeeID from Orders;

-- Filas duplicadas
-- Mostrar los paises donde se tienen los clientes,
-- mostrando pais solamente

select distinct Country as 'Paises donde se encuentran clientes' from Customers order by country;

-- Clausula Where (Campo o Columna y lleva;
-- Operadores relacionales(>, <, <=, >=, != o <>))

select \* from Customers;

-- Seleccionar el cliente BOLID
select
CustomerID as 'Id del Cliente',
CompanyName as 'Compa�ia del que Proviene',
City as 'Ciudad del que Proviene',
Country as 'Pais del que Proviene'
from Customers
where CustomerID = 'BOLID';

--Seleccionar los clientes mostrando su identificador, nombre de la emprese, contacto, ciudad y pais de alemania
select
CustomerID as 'Id del Cliente',
CompanyName as 'Compa�ia del que Proviene',
ContactName as 'Nombre del contacto',
Country as 'Pais del que Proviene',
City as 'Ciudad del que Proviene'
from Customers
where Country = 'Germany';

--Seleccionar todos los clientes que no sean de alemania

select
CustomerID as 'Id del Cliente',
CompanyName as 'Compa�ia del que Proviene',
ContactName as 'Nombre del contacto',
Country as 'Pais del que Proviene',
City as 'Ciudad del que Proviene'
from Customers
where Country != 'Germany';

-- Seleccionar todos los productos, mostrando el nombre del producto
-- Categoria a la que pertenece, existencia, precio. pero solamente donde su precio sea mayor que 100

select\* from Products;

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
select \* from Orders;

-- Mostrar el nombre completo del empleado, su numero de empleado,
-- Fecha de nacimiento, Ciudad en la que nacio, Fecha de contratacion y
-- esta debe ser de aquellos que fueron contratados despues de 1993
-- Los resultados de sus encabezados deben ser mostrados en espa�ol

select \* from Employees;

select
FirstName as 'Nombre del empleado',
LastName as 'Apellido del empleado',
City as 'Ciudad',
year(BirthDate) as 'Fecha de nacimiento',
year(HireDate) as 'Fecha de contratacion'
from Employees
where YEAR(HireDate) >'1993';

select
(FirstName+ ' ' + LastName) as 'Nombre del empleado',
City as 'Ciudad',
year(BirthDate) as 'Fecha de nacimiento',
year(HireDate) as 'Fecha de contratacion'
from Employees
where YEAR(HireDate) >'1993';

select
Concat(FirstName, ' ', LastName) as [Nombre del empleado],
City as 'Ciudad',
year(BirthDate) as 'Fecha de nacimiento',
year(HireDate) as 'Fecha de contratacion'
from Employees
where YEAR(HireDate) >'1993';

-- Mostrar los empleados con los empleados que no son dirigidos por el jefe 2
-- CCV a un dataframe, diccionarios
select
Concat(FirstName, ' ', LastName) as [Nombre del empleado],
City as 'Ciudad',
year(BirthDate) as 'Fecha de nacimiento',
year(HireDate) as 'Fecha de contratacion'
from Employees
where ReportsTo != 2;

-- Seleccionar los empleados que no tengan jefe

select \* from Employees
where ReportsTo is null;

-- Operadores Logicos (or, and y not)
-- Seleccionar los productos que tengan un precio de entre 10 y 50
--
select ProductName as 'Nombre', UnitPrice as 'Precio', UnitsInStock as 'Existencias'
from Products
where UnitPrice >= 10 and UnitPrice <=50;

-- Mostrar todos los pedidos realizados por clientes que NO
-- Son de alemania Mathloglive Seaborn

select OrderId, ShipName 'Cliente', ShipCountry 'Pais del cliente'
from Orders
where NOT ShipCountry = 'Germany';

-- Seleccionar clientes de mexico o estados unidos

select ContactName as 'Cliente', Country as 'Pais del cliente'
from Customers
where Country = 'Mexico' or Country = 'USA';

-- Seleccionar Empleados que nacieron entre 1955 y 1958
-- Que vivan en londres

select
Concat(FirstName, ' ', LastName) as [Nombre del empleado],
Country as 'Pais'
from Employees
where City = 'London' and (year(BirthDate) >= 1955 and year(BirthDate) <= 1958);

-- Seleccionar los pedidos con un viaje de peso(Freight) mayor a $100
-- y enviadosa Francia o Espa�a

select \*
from Orders
where Freight > 100 and (ShipCountry = 'Spain' or ShipCountry = 'France');

-- Seleccionar las primeras 5 ordenes de compra

select top 10 \*
from Orders;

-- Seleccionar los productos con precio entre $10 y $50,
-- Que no esten descontinuados y tengan mas de 20 unidades en stock

select ProductName as 'Producto',
UnitPrice as 'Precio',
Discontinued as 'Descontinuacion (0 = No)',
UnitsInStock as 'Existencias'
from Products
where Discontinued !=1 and (UnitPrice>=10 and UnitPrice<=50) and UnitsInStock >=20;

-- Seleccionar los pedidos con un viaje de peso(Freight) menor a $50
-- y enviadosa Francia o Alemania

select OrderID as 'Id de orden',
ShipCountry 'Pais',
Freight 'Peso'
from Orders
where Freight < 50 and (ShipCountry = 'Germany' or ShipCountry = 'France');

-- Seleccionar empleados que no viven en MEXICO o USA que
-- tengan fax registrado
select Companyname 'Nombre de la compa�ia',
country as 'Pais',
city as 'Ciudad',
fax as 'Fax'
from Customers
where not (Country = 'Mexico' or Country = 'USA') and fax is not null;

-- Seleccionar pedidos con un filete mayor a 100,
-- Enviados a brasil o argentina
-- Pero no enviados por el transportista

select OrderID as 'Id de la orden',
Freight as 'Peso',
ShipCountry as 'Pais'
from Orders
where Freight > 100 and (ShipCountry = 'Brazil' or ShipCountry = 'Argentina') and ShippedDate is null;

select \* from orders
where Freight > 100 and (ShipCountry = 'Brazil' or ShipCountry = 'Argentina');

-- Seleccionar empleados que no viven en londres o Seattle
-- y que fueron contratados despues de 1992

select concat(FirstName, ' ', LastName) as [Nombre Completo],
HireDate as 'Fecha de contratacion',
City as 'Ciudad',
Country as 'Pais'
from Employees
where City <> 'London' and City <> 'Seattle'
And year(HireDate) >=1992;

-- Clausula IN (or)

--Seleccionar los productos con categoria 1, 3 o 5

select ProductName as 'Nombre del producto',
CategoryID as 'Categoria',
UnitPrice as 'Precio'
from Products
where CategoryID in (1,3,5);

-- Seleccionar todas las ordenes de la region RJ, Tachira y que
-- no tengan region asignada

select OrderID as 'Id de la orden',
OrderDate as 'Fecha de la orden',
ShipRegion as 'Region de envio'
from Orders
where ShipRegion in('RJ','T�chira') or ShipRegion is null;

-- Seleccionar las ordenes que tengan cantidades de 12, 9 y 40
-- y descuento de 0.15 y 0.5

select OrderID 'Id de orden',
Quantity 'Cantidad de productos',
Discount 'Descuento aplicado'
from [Order Details]
where Quantity in (9,12,40) and Discount in(0.15,0.05);

--CLAUSULA BETWEEN (BUSCAR RANGOS, SIEMPRE VA EN EL WHERE )
-- BETWEEN valorInicial and valorFinal---
--mostrar los productos con precio entre 10 y 50
select \* from Products
where UnitPrice >=10 and UnitPrice<=50;

select \* from Products
where UnitPrice between 10 and 50;

-- Seleccionar todos los pedidos realizados
-- Entre el primero de enero y el 30 de junio de 1997

select OrderDate as 'Fecha de la orden' from orders
where OrderDate >= '1997-01-01' and OrderDate<= '1997-06-30';

select OrderDate as 'Fecha de la orden' from orders
where OrderDate between '1997-01-01' and '1997-06-30';

-- Seleccionar todos los empleados contratados entre
-- 1992 y 1995 que trabajan en londres

select \* from Employees
where HireDate >= '1992' and HireDate <= '1995' and City = 'London';

select HireDate
from Employees
where City = 'London' and (year(HireDate) between '1992' and '1995');

-- Pedidos com flete (Freight) entre 50 y 200 enviados a alemania
-- y a francia

select OrderID as 'Numero de Orden',
OrderDate as 'Fecha de Orden',
RequiredDate as 'Fecha de Entrega',
Freight as 'Peso',
ShipCountry as 'Pais de Entrega'
from Orders
where ShipCountry in('France','Germany') and (Freight between 50 and 200);

-- Seleccionar todos los productos que tengan un precio
-- entre 5 y 20 dolares o que sean de la categoria 1,2 o 3

select ProductName as 'Nombre del Producto',
CategoryID as 'Categoria',
UnitPrice as 'Precio',
UnitsInStock as 'Existencias'
from Products
where UnitPrice >=5 and UnitPrice <= 20 or (CategoryID = 1 or CategoryID = 2 or CategoryID = 3);

select ProductName as 'Nombre del Producto',
CategoryID as 'Categoria',
UnitPrice as 'Precio',
UnitsInStock as 'Existencias'
from Products
where (UnitPrice between 5 and 20) or (CategoryID in(1,2,3));

-- Empleados con numero de trabajador entre 3 y 7
-- Que no trabajan en Londres ni Seattle

select EmployeeID as 'Numero de trabajador',
concat(FirstName, ' ', LastName) as [Nombre del Trabajador],
City as 'Ciudad'
from Employees
where (EmployeeID between 3 and 7) and (City != 'London' and City != 'Seattle');

select EmployeeID as 'Numero de trabajador',
concat(FirstName, ' ', LastName) as [Nombre del Trabajador],
City as 'Ciudad'
from Employees
where (EmployeeID between 3 and 7) and not City in ('London','Seattle');

-- Clausula Like
-- Patrones:
-- 1) % (Porcentaje) -> Representa cero o mas caracteres en el patron
-- de busqueda
-- 2) \_ (Guion bajo) -> Representa exactamente un caracter en el patron
-- de busqueda
-- 3) [] (Corchetes) -> Se utiliza para definir un conjunto
-- de caracteres, buscando cualquiera de ellos en la
-- posicion fisica
-- 4) [^] (Potencia, Acento circunplejo) -> Se utiliza para buscar
-- caracteres que no estan dentro del conjunto especifico

-- Buscar los productos que empiezan con (Cha)

Select ProductName as 'Nombre del producto',
CategoryID as 'Categoria',
UnitPrice as 'Precio',
UnitsInStock as 'Existencias'
from Products
where ProductName like 'Cha%' and UnitPrice = 18;

-- Buscar todos los productos que terminen con (E)

Select ProductName as 'Nombre del producto',
CategoryID as 'Categoria',
UnitPrice as 'Precio',
UnitsInStock as 'Existencias'
from Products
where ProductName like '%e';

-- Seleccionar todos los clientes cuyo nombre de empresa
-- Contiene la palabra "co" en cualquier parte

select CompanyName as 'Nombre de la compa�ia' from Customers
where CompanyName like '%co%';

-- Seleccionar los empleados cuyo nombre comience con "A"
-- y tenga exactamente 5 caracteres

select EmployeeID as 'Numero de trabajador',
concat(FirstName, ' ', LastName) as [Nombre del Trabajador],
City as 'Ciudad'
from Employees
where FirstName like 'A**\_**';

-- Seleccionar los productos que comiencen con 'A' o 'B'

select \*
from Products
where ProductName like '[AB]%';

select \* from Products
where ProductName like '[A-M]%';

-- Seleccionar todos los productos que no comiencen con A o B

select \*
from Products
where ProductName like '[^AB]%';

-- Seleccionar todos los productos donde el nombre
-- que comience con a pero no contenga la e

select \*
from Products
where ProductName like 'A[^E]%';

-- Clausula Order By

select ProductID as 'Codigo del Producto',
ProductName as 'Nombre del Producto',
UnitPrice as 'Precio',
UnitsInStock as 'Existencias'
from Products
order by 'Precio' desc;

-- Seleccionar los clientes ordenados por el pais y dentro
-- Por ciudad

select \* from Customers;

select CustomerID as 'Id del Cliente',
ContactName as 'Nombre de contacto',
Country as 'Pais',
City as 'Ciudad',
Region as 'Region'
from Customers
where Country in( 'Brazil', 'Germany') and Region is not null
order by Country asc, City desc;

## -- Seleccionar todos las categorias y productos

-- Version con todo
select \* from
Categories
inner join
Products
on Categories.CategoryID = Products.CategoryID
;

-- Version con filtro
select
Categories.CategoryID,
CategoryName,
ProductName,
UnitsInStock,
UnitPrice
from
Categories
inner join
Products
on Categories.CategoryID = Products.CategoryID
;

-- Version con alias en las tablas
select
c.CategoryID as 'Id de Categorias',
CategoryName as 'Nombre de la categoria',
ProductName as 'Nombre del producto',
UnitsInStock as 'Existencias',
UnitPrice as 'Precio'
from
Categories as c
inner join
Products as p
on c.CategoryID = p.CategoryID;

-- Seleccionar los productos de la categoria
-- Beverages y Condiments donde la existencia este entre 18 y 30

select
c.CategoryID as 'Id de Categorias',
CategoryName as 'Nombre de la categoria',
ProductName as 'Nombre del producto',
UnitsInStock as 'Existencias',
UnitPrice as 'Precio'
from
Categories as c
inner join
Products as p
on c.CategoryID = p.CategoryID
where c.CategoryID in(1, 2) and UnitsInStock between 18 and 30;

-- Seleccionar los productos y sus importes realozados de marzo a junio
-- de 1996, mostrando la fecha de la orden, el id del producto y el importe

select \* from Orders

select GETDATE();
select
o.OrderID as 'Id de la orden',
OrderDate as 'Fecha de la orden',
ProductID as 'Id del producto',
(od.UnitPrice \* od.Quantity) as 'Importe'
from
Orders as o
inner join
[Order Details] as od
on o.OrderID = od.OrderID
where OrderDate between '1996-07-01' and '1996-10-31';

-- Mostrar el importe total de ventas de la consulta anterior

select
concat('$', ' ',sum(od.UnitPrice \* od.Quantity)) as 'Importe'
from
Orders as o
inner join
[Order Details] as od
on o.OrderID = od.OrderID
where OrderDate between '1996-07-01' and '1996-10-31';

-- Consultas basicas de inner join

-- 1. Obtener los nombres de los clientes y los paises a los que
-- se enviaron sus pedidos

select _ from Customers;
select _ from Orders;

select
e.CustomerID as 'ID del Cliente',
CompanyName as 'Nombre del Cliente',
ContactName as 'Nombre de Contacto del Cliente',
ShipCountry as 'Pais al que enviaron sus envios',
ShipCity as 'Ciudad al que se enviaron sus envios',
ShipAddress as 'Direccion de los Envios'
from
Customers as e
inner join
Orders as o
on e.CustomerID = o.CustomerID;

-- 2. Obtener los productos y sus respectivos proveedores

select _ from Products;
select _ from Suppliers;

select
s.SupplierID as 'Id del Proveedor',
ProductID as 'Id del producto',
s.CompanyName as 'Nombre del proveedor',
ProductName as 'Nombre del producto',
UnitPrice as 'Precio del producto',
UnitsInStock as 'Existencias',
Discontinued as 'Descontinuado'
from
Products as p
inner join
Suppliers as s
on p.SupplierID = s.SupplierID;

-- 3. Obtener los pedidos y los empleados que los gestionaron

select _ from Orders;
select _ from Employees;

select
CustomerID as 'ID del Cliente',
e.EmployeeID as 'Id del empleado',
Concat(FirstName, ' ', LastName) as [Nombre del empleado que lo gestiono],
year(OrderDate) as 'A�o en el que se ordeno',
ShipCountry as 'Pais al que se envio'
from
Orders as o
inner join
Employees as e
on o.EmployeeID = e.EmployeeID;

-- 4. Listar los productos junto con sus precios y la categoria a la que pertenecen

select _ from Categories;
select _ from Products;

select
c.CategoryID as 'Id de la categoria',
ProductID as 'Id del producto',
c.CategoryName 'Nombre de la categoria',
ProductName as 'Nombre del producto',
UnitPrice as 'Precio del producto',
UnitsInStock as 'Existencias',
Discontinued as 'Descontinuado'
from
Categories as c
left join
Products as p
on p.CategoryID = c.CategoryID
where c.CategoryName = 'Fast Food';

-- 5. Obtener el nombre del cliente, el numero de orden y la fecha de orden

select _ from Orders;
select _ from Employees;

select
CustomerID as 'ID del Cliente',
e.EmployeeID as 'Id del empleado',
Concat(FirstName, ' ', LastName) as [Nombre del empleado],
OrderDate as 'A�o en el que se ordeno',
ShipCountry as 'Pais al que se envio'
from
Orders as o
inner join
Employees as e
on o.EmployeeID = e.EmployeeID;

-- 6. Listar las ordenes mostrando el numero de orden,
-- el nombre del producto y la cantidad que se vendio

select _ from [Order Details];
select _ from Products;

select top 5
od.OrderID as 'Id de la orden',
p.ProductID as 'Id del producto',
od.UnitPrice as 'Cantidad vendida en la orden',
ProductName as 'Nombre del producto',
p.UnitPrice as 'Precio del producto',
UnitsInStock as 'Existencias',
Discontinued as 'Descontinuado'
from
Products as p
inner join
[Order Details] as od
on p.ProductID = od.ProductID
order by od.Quantity desc;

-- con group by
select
od.OrderID as 'Id de la orden',
count(\*) as 'Cantidad de productos vendidos'
from
Products as p
inner join
[Order Details] as od
on p.ProductID = od.ProductID
group by od.OrderID
order by od.OrderID desc;

select \* from
[Order Details] as od
where od.OrderID = 11077

-- 7. Obtener los empleados y sus respectivos jefes

select \* from Employees;

select
e1.EmployeeID as 'Id del empleado',
Concat(e1.FirstName, ' ', e1.LastName) as [Nombre del Jefe],
e2.ReportsTo as 'Id del Jefe',
Concat(e2.FirstName, ' ', e2.LastName) as [Nombre del empleado]
from
Employees as e1
inner join
Employees as e2
on e1.EmployeeID = e2.ReportsTo;

-- 8. Listar los pedidos y el nombre de la empresa de transporte utilizada

select _ from Orders;
select _ from Shippers;

select
o.OrderID as 'Id de la orden',
s.ShipperID as 'Id del transportista',
s.CompanyName as 'Nombre del transportista'
from
Orders as o
inner join
Shippers as s
on o.ShipVia = s.ShipperID;

--Consultas inner join Intermedias

--9. Obtener la cantidad total de productos vendidos por categoria

select sum(Quantity) from [Order Details]

select c.CategoryName as 'Nombre Categoria', sum (Quantity) as 'Productos Vendidos'
from Categories as c
inner join Products as p
on c.CategoryID = p.CategoryID
inner join [Order Details] as od
on od.ProductID = p.ProductID
group by c.CategoryName
order by c.CategoryName

--10 Obtener el total de ventas por empleado

select \* from [Order Details];

select  
Concat(e.FirstName, ' ', e.LastName) as [Nombre del empleado],
count(o.OrderID) as 'Cantidad de ordenes',
sum((od.UnitPrice _ od.Quantity) - (od.UnitPrice _ od.Quantity)\* od.Discount) as 'Cantidad total vendida'
from
Orders as o
inner join
Employees as e
on o.EmployeeID = e.EmployeeID
inner join [Order Details] as od
on o.OrderID = od.OrderID
group by e.FirstName,e.LastName;

-- 11. Listar los clientes y la cantidad de pedidos que han realizado

select _ from Orders;
select _ from Customers;

select c.ContactName,
count(o.OrderID) as 'Cantidad de ordenes'
from
Orders as o
inner join
Customers as c
on o.CustomerID = c.CustomerID
group by c.ContactName
order by count(\*) desc;

-- 12. Obtener los empleados que han gestionado pedidos enviados a alemania

select
Concat(e.FirstName, ' ', e.LastName) as [Nombre del empleado],
o.OrderID as 'Id de la orden',
o.ShipCountry as 'Pais de envido'
from
Employees as e
inner join
Orders as o
on o.EmployeeID = e.EmployeeID
where o.ShipCountry = 'Germany'
group by e.EmployeeID;

select
Concat(e.FirstName, ' ', e.LastName) as [Nombre del empleado]
from
Employees as e
inner join
Orders as o
on e.EmployeeID = o.EmployeeID
where o.ShipCountry = 'Germany';

-- Version del profe
select distinct
Concat(e.FirstName, ' ', e.LastName) as [Nombre del empleado],
count(o.OrderID) as 'Cantidad de ordenes'
from
Employees as e
inner join
Orders as o
on e.EmployeeID = o.EmployeeID
where o.ShipCountry = 'Germany'
group by e.FirstName, e.LastName;

select
Concat(e.FirstName, ' ', e.LastName) as [Nombre del empleado],
count(o.OrderID) as 'Cantidad de ordenes',
sum((od.UnitPrice _ od.Quantity) - (od.UnitPrice _ od.Quantity)\* od.Discount) as 'Cantidad total vendida'
from
Orders as o
inner join
Employees as e
on o.EmployeeID = e.EmployeeID
inner join [Order Details] as od
on o.OrderID = od.OrderID
where o.ShipCountry = 'Germany'
group by e.FirstName,e.LastName;

-- 13. Listar los productos junto con el nombre del proveedor y el pais de origen

select _ from Products;
select _ from Suppliers;

select
s.SupplierID as 'Id del proveedor',
p.ProductID as 'Id del producto',
p.ProductName as 'Nombre del producto',
s.CompanyName as 'Nombre de la compa�ia',
s.ContactName as 'Contacto de la compa�ia',
s.Country as 'Pais de origen del proveedor'
from
Products as p
inner join
Suppliers as s
on p.SupplierID = s.SupplierID

-- 14. Obtener los pedidos agrupados por pais de envio

select
ShipCountry as 'Pais de la orden',
count(OrderID) as 'Cantidad de ordenes'
from Orders
group by ShipCountry;

-- 15. Obtener los empleados y la cantidad de territorios
-- En los que trabajan

select _ from EmployeeTerritories;
select _ from Employees;

-- Version del profe
select concat(e.FirstName, ' ', e.LastName) as 'Nombre',
count(et.TerritoryID) as 'Cantidad Territorio',
t.TerritoryDescription as 'Nombre Territorio'
from Employees as e
inner join
EmployeeTerritories as et
on e.EmployeeID = et.EmployeeID
inner join Territories as t
on et.TerritoryID = t.TerritoryID
group by e.FirstName, e.LastName, t.TerritoryDescription
order by 'Nombre', t.TerritoryDescription desc;

-- Mio
select
Concat(e.FirstName, ' ', e.LastName) as [Nombre del empleado],
COUNT(TerritoryID)
from
Employees as e
inner join
EmployeeTerritories as et
on e.EmployeeID = et.EmployeeID
group by e.FirstName,e.LastName;

-- 16. Listar las categorias y la cantidad de productos que contienen

select _ from Categories;
select _ from Products;

-- Profe
select c.CategoryName as 'Categoria',
count(p.ProductID) as 'Cantidad de Productos'
from Categories as c
inner join
Products as p
on c.CategoryID = p.CategoryID
group by c.CategoryName
order by 2 desc;

select c.CategoryName as 'Nombre de la categoria',
COUNT(p.ProductID)
from
Products as p
inner join
Categories as c
on p.CategoryID = c.CategoryID
group by c.CategoryName;

-- 17. Obtener la cantidad total de productos vendidos
-- Por proveedor

select _ from Products;
select _ from [Order Details];
select \* from Suppliers;

select
s.CompanyName as 'Proveedor',
count(OrderID),
sum((od.UnitPrice _ od.Quantity) - (od.UnitPrice _ od.Quantity)\* od.Discount) as 'Cantidad total vendida'
from
Products as p
inner join
Suppliers as s
on p.SupplierID = s.SupplierID
inner join
[Order Details] as od
on od.ProductID = p.ProductID
group by s.CompanyName;

-- 18. Obtener la cantidad de pedidos
-- enviados por cada empresa de transporte

select _ from Orders;
select _ from Shippers;

select
s.CompanyName as 'Nombre del Transportista',
count(OrderID) as 'Cantidad de envios'
from
Orders as o
inner join
Shippers as s
on o.ShipVia = s.ShipperID
group by CompanyName;

select s.CompanyName as 'Transportista',
count(\*) as 'cantidad de pedidos'
from
Orders as o
inner join
Shippers as s
on o.ShipVia = s.ShipperID
group by s.CompanyName;

Select count(\*) from Orders;
select count(OrderID) from Orders;
Select count(ShipRegion) from Orders;

-- 19. Obtener a los clientes que han realizado pedidos
-- con mas de un producto

select
c.CompanyName as 'Nombre de la compa�ia',
count(distinct ProductID) as 'numero de productos'
from
Customers as c
inner join
Orders as o
on c.CustomerID = o.CustomerID
inner join
[Order Details] as od
on o.OrderID = od.OrderID
group by c.CompanyName
order by 2 desc;

select
c.CompanyName as 'Nombre de la compa�ia',
count(distinct ProductID) as 'numero de productos'
from
Customers as c
inner join
Orders as o
on c.CustomerID = o.CustomerID
inner join
[Order Details] as od
on o.OrderID = od.OrderID
group by c.CompanyName
order by 2 desc;

select distinct ProductID as 'Numero de Productos'
from
Customers as c
inner join
Orders as o
on c.CustomerID = o.CustomerID
inner join
[Order Details] as od
on od.OrderID = o.OrderID
group by ProductID
order by 1 desc;

-- 20. Listar los empleados con la cantidad total de pedidos que han gestionado,
-- y a que clientes les han vendido, agrupandolos por nombre completo
-- y dentro de este nombre por cliente, ordenandolos por la cantidad mayor de pedidos

select \* from
Customers;

select concat(FirstName, '', LastName) as 'Nombre',
c.CompanyName as 'Cliente',
count(OrderID) as 'Numero de Ordenes'
from
Orders as o
inner join
Employees as e
on o.EmployeeID = e.EmployeeID
inner join
Customers as c
on o.CustomerID = c.CustomerID
group by e.FirstName, e.LastName, c.CompanyName
order by 'Nombre' asc, 'Cliente';

select  
concat(e.FirstName, ' ', e.LastName) as 'Nombre',
c.CompanyName as 'Cliente',
count(OrderID) as 'Numero de ordenes'
from
Orders as o
inner join
Employees as e
on o.EmployeeID = e.EmployeeID
inner join Customers as c
on o.CustomerID = c.CustomerID
group by e.FirstName, e.LastName, c.CompanyName
order by 'Nombre' desc;

-- 21. Listar las categorias con el total de ingresos
-- generados por sus productos

select
c.CategoryName as 'Categoria',
p.ProductName as 'Producto',
sum((od.UnitPrice _ od.Quantity) - (od.UnitPrice _ od.Quantity)\* od.Discount) as 'Cantidad total vendida por producto'
from
Categories as c
inner join
Products as p
on c.CategoryID = p.CategoryID
inner join
[Order Details] as od
on p.ProductID = od.ProductID
group by c.CategoryName, p.ProductName
order by c.CategoryName;

-- 22. Listar los clientes con el total ($) gastado en pedidos

select \* from [Order Details]

select
c.CompanyName as 'Cliente',
sum((od.UnitPrice _ od.Quantity) - (od.UnitPrice _ od.Quantity)\* od.Discount) as 'Cantidad total de $ gastado'
from
Orders as o
inner join
[Order Details] as od
on o.OrderID = od.OrderID
inner join
Customers as c
on o.CustomerID = c.CustomerID
group by c.CompanyName

-- 23. Listar los pedidos realizados entre el 1 de enero de 1997 y
-- el 30 de junio de 1997 y mostrar el total en dinero

select \* from Orders

select distinct o.OrderID as 'Id de la Orden',
sum((od.UnitPrice _ od.Quantity) - (od.UnitPrice _ od.Quantity)\* od.Discount) as 'Cantidad total vendida por producto'
from
Orders as o
inner join
[Order Details] as od
on o.OrderID = od.OrderID
where o.OrderDate between '1997-01-01' and '1997-06-30'
group by o.OrderID

-- 24. Listar los productos con las categorias Beverages, Seafood, Confections

select \* from Categories

select
c.CategoryName as 'Categoria',
p.ProductName as 'Producto',
sum((od.UnitPrice _ od.Quantity) - (od.UnitPrice _ od.Quantity)\* od.Discount) as 'Cantidad total vendida por producto'
from
Categories as c
inner join
Products as p
on c.CategoryID = p.CategoryID
inner join
[Order Details] as od
on p.ProductID = od.ProductID
where c.CategoryID in(1,3,8)
group by c.CategoryName, p.ProductName
order by c.CategoryName;

-- 25. Listar los clientes ubicados en alemania
-- y que hayan realizado pedidos antes del 1 de enero de 1997

select \* from Customers

select \* from
Customers as c
inner join
Orders as o
on o.CustomerID = c.CustomerID
where c.Region = 'Germany';

select distinct o.OrderID as 'Id de la Orden',
c.CompanyName as 'Cliente',
o.OrderDate as 'Fecha de la orden',
sum((od.UnitPrice _ od.Quantity) - (od.UnitPrice _ od.Quantity)\* od.Discount) as 'Cantidad total vendida por producto'
from
Customers as c
inner join
Orders as o
on o.CustomerID = c.CustomerID
inner join
[Order Details] as od
on o.OrderID = od.OrderID
where o.OrderDate <= '1997-01-01' and c.Country = 'Germany'
group by o.OrderID, c.CompanyName, o.OrderDate;

-- 26. Listar los clientes que han realizado pedidos con un total entre $500 y $2000

select distinct o.OrderID as 'Id de la Orden',
c.CompanyName as 'Cliente',
o.OrderDate as 'Fecha de la orden',
sum(od.UnitPrice _ od.Quantity) as 'Cantidad total'
from
Customers as c
inner join
Orders as o
on o.CustomerID = c.CustomerID
inner join
[Order Details] as od
on o.OrderID = od.OrderID
group by o.OrderID, c.CompanyName, o.OrderDate
having sum(od.UnitPrice _ od.Quantity) between 500 and 200;

select distinct o.OrderID as 'Id de la Orden',
sum((od.UnitPrice _ od.Quantity) - (od.UnitPrice _ od.Quantity)\* od.Discount) as 'Cantidad total'
from
Orders as o
inner join
[Order Details] as od
on o.OrderID = od.OrderID
where 'Cantidad total' between '500' and '2000'
group by o.OrderID;

-- Left Join, Right Join, Full Join y Corss Join
