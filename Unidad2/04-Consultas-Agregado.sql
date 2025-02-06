
use Northwind;

-- Consultas de agregado
-- Nota: Solo devuelven un solo registro

-- sum, avg, count, count(*), max y min

-- Cuantos clientes tengo

Select Region from Customers;

select count(Region) as 'Numero de Clientes' 
from Customers;

select count(*) as 'Numero de Clientes' 
from Customers
where Region is null;

Select count(distinct Region) 
from Customers
where Region is not null;

select count(distinct ShipRegion) from Orders;

-- Selecciona el precio mas bajo de los 
-- productos

select * from Products;

select min(UnitPrice) from Products;

select min(UnitPrice), max(UnitPrice), avg(UnitsInStock) from Products;

-- Seleccionar cuantos pedidos existen

select count(*)from Orders;

-- Calcula el total de dinero vendido

select * from [Order Details];
select sum(UnitPrice * Quantity) from [Order Details];
-- Funciones de agregado o resumen porque resumen datos
select sum(UnitPrice * Quantity - (UnitPrice * Quantity * Discount)) from [Order Details];

-- Calcula el total de unidades en stock de todos los productos

select sum(UnitsInStock) as 'Total de Stock' from Products;

-- Seleccionar el total de dinero 
-- Que se gano en el ultimo trimestre de 1996

select * from Orders
where day(OrderDate) between '1996-10-00' and '1996-12-31';

-- Clausula Group By

-- Seleccionar el numero de productos por categoria

select CategoryID, count(*) 
from Products
group by CategoryID;

-- Un inner Join
select Categories.CategoryName,
count(*) as 'Numero de Productos'
from 
Categories
inner join Products as p
on Categories.CategoryID = p.CategoryID
group by Categories.CategoryName;

-- Calcular el precio promedio de los productos por categoria
select CategoryID, 
avg(UnitPrice) as 'Precio Promedio de los Productos por categoria'
from Products
group by CategoryID;

-- Seleccionar el numero de pedidos realizados por cada empleado

select EmployeeID,
count(*) 
from Orders
group by EmployeeID;

-- Ultimo trimestre del 96
select EmployeeID,count(*) 
from Orders
where OrderDate between '1996-10-01' and '1996-12-31'
group by EmployeeID;

-- Seleccionar la suma total de unidades 
-- vendidas por cada producto

select top 5 ProductID, 
sum(Quantity) as 'Cantidad de Producto Vendido'
from [Order Details]
group by ProductID order by 2 desc;

-- Numero de producto vendido por cada orden
select OrderID,ProductID, 
sum(Quantity) as 'Cantidad de Producto Vendido'
from [Order Details]
group by OrderID,ProductID
order by 2 desc;

-- Seleccionar los numero de productos por categoria
-- pero solo aquellos que tengan mas de 10 productos

select CategoryID, sum(UnitPrice) 
from Products
where CategoryID in (1,3,4)
group by CategoryID
having sum(UnitPrice)>10;

-- Paso a paso
-- Paso 1 asi se ven solo las categorias existentes sin tomar en cuenta las lineas repetidas

select distinct CategoryID from Products;

-- Paso 2 aqui el filtro de where se dedica a dar las lineas donde la condicion se cumple

select CategoryID 
from Products
where CategoryID in (2,4,8);

-- Paso 3 ordenado por categoria

select CategoryID, UnitsInStock
from Products
where CategoryID in (2,4,8)
order by CategoryID asc;

-- Paso 4 agrupacion

select CategoryID, sum(UnitsInStock)
from Products
where CategoryID in (2,4,8)
group by CategoryID
order by CategoryID asc;

-- Paso 5 no entiendo

select CategoryID, sum(UnitsInStock)
from Products
where CategoryID in (2,4,8)
group by CategoryID
having count(*)>=12
order by CategoryID asc;

-- Listar las ordenes agrupadas por empleado, 
-- pero que solo muestren aquellos que hayan
-- gestionado mas de 10 pedidos

select EmployeeID, count(OrderID)
from Orders
group by EmployeeID
having count(*)>10
order by EmployeeID;