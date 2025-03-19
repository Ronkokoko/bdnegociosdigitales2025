

-- Ejemplo de Left Join aplicado

use Northwind

Select * from Products_New;

drop table Products_New;

-- Crear una tabla a partir de una consulta


select p.ProductID, p.ProductName,
[cu].CompanyName,
c.CategoryName, od.UnitPrice,
p.Discontinued, GETDATE() as 'Inserted_Date'
into Products_New
from Products as p
inner join 
Categories as c
on p.CategoryID = c.CategoryID
inner join
[Order Details] as od
on od.ProductID = p.ProductID
inner join 
Orders as o
on o.OrderID = od.OrderID
inner join 
Customers as [cu]
on [cu].CustomerID = O.CustomerID;


-- Crea la tabla solo con la estructura

select * from Products_New;

select top 0 p.ProductID, p.ProductName,
[cu].CompanyName,
c.CategoryName, od.UnitPrice,
p.Discontinued, GETDATE() as 'Inserted_Date'
into Products_New
from Products as p
inner join 
Categories as c
on p.CategoryID = c.CategoryID
inner join
[Order Details] as od
on od.ProductID = p.ProductID
inner join 
Orders as o
on o.OrderID = od.OrderID
inner join 
Customers as [cu]
on [cu].CustomerID = O.CustomerID;

Drop table Products_New;


-- Con Alias


select * from Products_New;

select top 0 0 as [ProductBK]
p.ProductID as 'ProductID', 
p.ProductName as 'ProductName',
[cu].CompanyName as 'CompanyName',
c.CategoryName as 'Category', 
od.UnitPrice as 'UnitPrice',
p.Discontinued as 'Discountinued', 
GETDATE() as 'Inserted_Date'
into Products_New
from Products as p
inner join 
Categories as c
on p.CategoryID = c.CategoryID
inner join
[Order Details] as od
on od.ProductID = p.ProductID
inner join 
Orders as o
on o.OrderID = od.OrderID
inner join 
Customers as [cu]
on [cu].CustomerID = O.CustomerID;





-- Carga Full

insert into Products_New
select p.ProductID, p.ProductName,
[cu].CompanyName,
c.CategoryName, od.UnitPrice,
p.Discontinued, GETDATE() as 'Inserted_Date'
from Products as p
inner join 
Categories as c
on p.CategoryID = c.CategoryID
inner join
[Order Details] as od
on od.ProductID = p.ProductID
inner join 
Orders as o
on o.OrderID = od.OrderID
inner join 
Customers as [cu]
on [cu].CustomerID = O.CustomerID;


