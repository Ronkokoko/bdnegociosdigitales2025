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
go create view VistaCategoriasTodas AS
select CategoryID,
    CategoryName,
    [Description],
    Picture
from Categories;
GO -- Alterar un view
go create view VistaCategoriasTodas AS
select CategoryID,
    CategoryName,
    [Description],
    Picture
from Categories;
GO -- Tirar la view
    drop view VistaCategoriasTodas -- Seleccionar desde un view
select *
from VistaCategoriasTodas
where CategoryName = 'Beverages';
-- Crear una vista que permita visualizar solamente 
-- los clientes de mexico y brazil
select *
from Customers
where Country = 'Mexico'
    or Country = 'Brazil'
select *
from Customers
where Country in('Mexico', 'Brazil')
select *
from VistaCategoriasTodas;
select *
from VistaClientesLatinos
where city = 'Sao Paulo'
order by 2 desc;
select *
from Orders as o
    inner join VistaClientesLatinos as vcl on vcl.CustomerID = o.CustomerID Orders as o
    Right join VistaClientesLatinos as vcl on vcl.CustomerID = o.CustomerID -- Crear una vista que contenga los datos de todas las ordenes 
    -- los productos, cateforias de productos, empleados y clientes,
    -- en la orden, calcular el importe
    CREATE
    OR ALTER view [dbo].[VistaOrdenesdeCompra] as
select o.OrderID as [Numero de Orden],
    o.OrderDate as [Fecha de Orden],
    o.RequiredDate [Fecha de Requisicion],
    concat (e.FirstName, ' ', e.LastName) as [Nombre Empleado],
    cu.CompanyName as [Nombre Cliente],
    p.ProductName as [Nombre Producto],
    c.CategoryName as [Nombre Categoria],
    od.UnitPrice as [Precio de Venta],
    od.Quantity [Cantidad Vendida],
    (od.Quantity * od.UnitPrice) as [importe]
from Categories as c
    join Products as p on c.CategoryID = p.CategoryID
    join [Order Details] as od on od.ProductID = p.ProductID
    join Orders as o on o.OrderID = od.OrderID
    join Customers as cu on cu.CustomerID = o.CustomerID
    join Employees as e on e.EmployeeID = o.EmployeeID
GO ---------------------
    -- Views 
    --sintaxis 
    /*create view nombreVista 
     AS
     select columnas
     from tabla 
     where condicion
     */
    use northwind;
go create
    or alter view VistaCategoriasTodas AS
select CategoryID,
    CategoryName,
    [Description],
    picture
from Categories
where CategoryName = 'Beverages'
Go drop view VistaCategoriasTodas
go
select *
from VistaCategoriasTodas
where CategoryName = 'Beverages' -- Crear una vista que permita visualizar solamente clientes de mexico y brazil
go create
    or alter view vistaClientesLatinos as
select *
from Customers
where country in('MExico', 'Brazil')
select CompanyName as [Cliente],
    City as [Ciudad],
    country as [Pais]
from vistaClientesLatinos
where city = 'Sao Paulo'
order by 2 desc
select *
from Orders as o
    inner join vistaClientesLatinos as vcl on vcl.CustomerID = o.CustomerID -- Crear una vista que contenga los datos de todas las ordenes
    -- los productos, catgorias de productos,empleados y clientes,  
    -- en la orden 
    -- calcular el importe 
    create
    or alter view [dbo].[vistaordenescompra] as
select o.OrderID as [numero Orden],
    o.OrderDate as [Fecha de Orden],
    o.RequiredDate as [Fecha de Requisición],
    concat(e.FirstName, ' ', e.LastName) as [Nombre Empleado],
    cu.CompanyName as [Nombre del Cliente],
    p.ProductName as [Nombre Producto],
    c.CategoryName as [Nombre de la Categoria],
    od.UnitPrice as [Precio de Venta],
    od.Quantity as [Cantidad Vendida],
    (od.Quantity * od.UnitPrice) as [importe]
from Categories as c
    inner join Products as p on c.CategoryID = p.CategoryID
    inner join [Order Details] as od on od.ProductID = p.ProductID
    inner join orders as o on od.OrderID = o.OrderID
    inner join Customers as cu on cu.CustomerID = o.CustomerID
    inner join Employees as e on e.EmployeeID = o.EmployeeID
select count(distinct [numero Orden]) as [Numero de Ordenes]
from vistaordenescompra
select sum([Cantidad Vendida] * [Precio de Venta]) as [importe Total]
from vistaordenescompra
Go
select sum(importe) as [importe Total]
from vistaordenescompra
where year([Fecha de Orden]) between '1995' and '1996'
Go create
    or alter view vista_ordenes_1995_1996 as
select [Nombre del Cliente] as 'Nombre Cliente',
    sum(importe) as [importe Total]
from vistaordenescompra
where year([Fecha de Orden]) between '1995' and '1996'
group by [Nombre del Cliente]
having count(*) > 2 create schema rh create table rh.tablarh (
        id int primary key,
        nombre nvarchar(50)
    ) -- vista horizontal
    create
    or alter view rh.viewcategoriasproductos as
select c.CategoryID,
    CategoryName,
    p.ProductID,
    p.ProductName
from Categories as c
    inner join Products as p on c.CategoryID = p.CategoryID;
GO
select *
from rh.viewcategoriasproductos