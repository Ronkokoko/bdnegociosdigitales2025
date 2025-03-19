
use Northwind;

select * from Categories

select * 
from
Categories as c
inner join 
Products as p
on c.CategoryID = p.CategoryID
where c.CategoryName = 'Fastfood'

select c.CategoryName, 
c.CategoryID,
p.CategoryID,
p.ProductName
from Categories as c
left join 
Products as p
on c.CategoryID = p.CategoryID;

select c.CategoryName, 
c.CategoryID,
p.CategoryID,
p.ProductName
from 
Products as p
left join 
Categories as c
on c.CategoryID = p.CategoryID;

insert into Products (ProductName, SupplierID, CategoryID, QuantityPerUnit, UnitPrice,
UnitsInStock, UnitsOnOrder, ReorderLevel, Discontinued)
values('Hamburgesa Sabrosa', 1, 9, 'xyz', 68.7, 45, 12, 2, 0)

insert into Products (ProductName, SupplierID, CategoryID, QuantityPerUnit, UnitPrice,
UnitsInStock, UnitsOnOrder, ReorderLevel, Discontinued)
values('Guaracha Sabrosona', 1, null, 'xyz', 68.7, 45, 12, 2, 0)


-- 1. Listar los empleados y los pedidos que han gestionado 
-- (Incluyendo los empleados que no han hecho pedidos)

-- 2. Todos los productos que no tengan categorias


select * 
from
Products as p
left join 
Categories as c
on c.CategoryID = p.CategoryID
where c.CategoryID is null