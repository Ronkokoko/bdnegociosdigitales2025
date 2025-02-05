-- Consultas de agregadi
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