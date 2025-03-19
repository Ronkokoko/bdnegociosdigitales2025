use Northwind;

-- Views

-- Sintaxis
/* create view nombreVista
as
select columnas
from tabla
where condicion
*/

-- Crear un view
go
create view VistaCategoriasTodas
AS
select CategoryID, CategoryName, [Description], Picture from Categories;
GO

-- Alterar un view
go
create view VistaCategoriasTodas
AS
select CategoryID, CategoryName, [Description], Picture from Categories;
GO

-- Tirar la view
drop view VistaCategoriasTodas

-- Seleccionar desde un view
select * from VistaCategoriasTodas
where CategoryName = 'Beverages';

-- Crear una vista que permita visualizar solamente 
-- los clientes de mexico y brazil
select * from Customers
where Country = 'Mexico' or Country = 'Brazil'

select * from Customers
where Country in('Mexico','Brazil')

select * from VistaCategoriasTodas;

select * from
VistaClientesLatinos
where city = 'Sao Paulo'
order by 2 desc;

select * from
Orders as o
inner join
VistaClientesLatinos as vcl
on vcl.CustomerID = o.CustomerID

Orders as o
Right join VistaClientesLatinos as vcl
on vcl.CustomerID = o.CustomerID

-- Crear una vista que contenga los datos de todas las ordenes 
-- los productos, cateforias de productos, empleados y clientes,
-- en la orden, calcular el importe

CREATE OR ALTER   view  [dbo].[VistaOrdenesdeCompra]	
as
select o.OrderID as [Numero de Orden],
o.OrderDate as [Fecha de Orden],
o.RequiredDate [Fecha de Requisicion],
concat (e.FirstName , ' ', e.LastName) as [Nombre Empleado],
cu.CompanyName as [Nombre Cliente],
p.ProductName as [Nombre Producto],
c.CategoryName as [Nombre Categoria],
od.UnitPrice as [Precio de Venta],
od.Quantity [Cantidad Vendida],
(od.Quantity * od.UnitPrice) 
as [importe]
from 
Categories as c 
join Products as p
on c.CategoryID = p.CategoryID
join
[Order Details] as od
on od.ProductID = p.ProductID
join Orders as o
on o.OrderID = od.OrderID
join Customers as cu
on cu.CustomerID = o.CustomerID
join Employees as e
on e.EmployeeID = o.EmployeeID
GO