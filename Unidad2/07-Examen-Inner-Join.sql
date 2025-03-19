

use BDEJEMPLO2;

select * from Clientes;
select * from Pedidos;
select * from Productos;
select * from Oficinas;
select * from Representantes;

-- 1. Clientes con limite de credito mayor a 5000 y sus representantes

select * from Representantes;
select * from Clientes;


select 
r.Num_Empl as 'ID del Representante',
r.Nombre as 'Nombre del Representante',
r.Puesto as 'Puesto del Representante',
c.Num_Cli as 'ID del Cliente',
c.Empresa as 'Nombre del Cliente',
c.Limite_Credito as 'Limite de credito'
from 
Clientes as c
inner join
Representantes as r
on c.Rep_Cli = r.Num_Empl
where Limite_Credito > 5000;


-- 2. Pedidos con cantidad mayor a 100 o importe mayor a 5000, con detalles del cliente

select * from Clientes;
select * from Pedidos;

select 
c.Num_Cli as 'ID del Cliente',
c.Empresa as 'Nombre del Cliente',
c.Limite_Credito as 'Limite de credito del cliente',
p.Num_Pedido as 'Numero del pedido',
year(p.Fecha_Pedido) as 'Fecha',
p.Cantidad as 'Cantidad de cosas pedidas',
p.Importe as 'Importe'
from
Pedidos as p
inner join 
Clientes as c
on p.Cliente = c.Num_Cli
where p.Cantidad > 100 or p.Importe >5000


-- 3. Oficinias en la region 'Este' o 'Este', con detalles de su jefe (ciudad y nombre del jefe)

select * from Oficinas;
select * from Representantes;

select 
o.Oficina as 'Numero de la oficina',
o.Ciudad as 'Ciudad en la que se encuentra la oficina',
o.Region as 'Region de la Oficina',
r.Jefe as 'ID del jefe',
r.Nombre as 'Nombre del jefe'
from
Oficinas as o
inner join 
Representantes as r
on o.Oficina = r.Oficina_Rep
where Region between 'Este' and 'Oeste'



-- 4. Clientes en las ciudades 'Navarra', 'Castellon', 'Daimel', con detalles
-- de representante (Empresa y Nombre)

select * from Clientes
select * from Oficinas
select * from Representantes

select 
o.Oficina as 'Numero de la oficina',
o.Ciudad as 'Ciudad',
r.Num_Empl as 'ID del representante',
r.Nombre as 'Nombre del representante',
c.Num_Cli as 'ID del Cliente',
c.Empresa as 'Nombre del Cliente'
from
Oficinas as o
inner join 
Representantes as r
on o.Oficina = r.Oficina_Rep
inner join
Clientes as c
on r.Num_Empl = c.Rep_Cli
where Ciudad in('Navarra', 'Castellón', 'Daimel')

-- 5. Clientes ordenados por limite de credito con mayor limite de credito, 
-- con detalles de representantes y clientes

select * from Representantes;
select * from Clientes;

-- Consulta completa
select 
r.Num_Empl as 'ID del Representante',
r.Nombre as 'Nombre del Representante',
r.Puesto as 'Puesto del Representante',
c.Num_Cli as 'ID del Cliente',
c.Empresa as 'Nombre del Cliente',
c.Limite_Credito as 'Limite de credito'
from 
Clientes as c
inner join
Representantes as r
on c.Rep_Cli = r.Num_Empl
order by c.Limite_Credito desc;

-- Consulta con top
select top 5
r.Num_Empl as 'ID del Representante',
r.Nombre as 'Nombre del Representante',
r.Puesto as 'Puesto del Representante',
c.Num_Cli as 'ID del Cliente',
c.Empresa as 'Nombre del Cliente',
c.Limite_Credito as 'Limite de credito'
from 
Clientes as c
inner join
Representantes as r
on c.Rep_Cli = r.Num_Empl
order by c.Limite_Credito desc;

-- 6. Clientes con mas de 3 pedidos con detalles de respresentantr,
-- (Nombre del cliente, nombre del representantre)

select * from Productos;
select * from Pedidos;
select * from Representantes;
select * from Clientes;

select 
r.Nombre as 'Nombre del Representante',
c.Num_Cli as 'ID del Cliente',
c.Empresa as 'Nombre del Cliente',
count(p.Num_Pedido) as 'Cantidad de Pedidos'
from
Pedidos as p
inner join 
Representantes as r
on p.Rep = r.Num_Empl
inner join
Clientes as c
on r.Num_Empl = c.Rep_Cli
group by c.Num_Cli, c.Empresa, r.Nombre
having count(p.Num_Pedido) > 3;

-- 7. Representantes con ventas totales mayores a 10000, con detalles de oficina

select * from Representantes;
select * from Oficinas;

select 
o.Oficina as 'Numero de la oficina',
o.Ciudad as 'Ciudad en la que se encuentra la oficina',
r.Jefe as 'ID del Representante',
r.Nombre as 'Nombre del Representante',
r.Ventas as 'Ventas totales'
from
Representantes as r
inner join
Oficinas as o
on o.Oficina = r.Oficina_Rep
where r.Ventas > 10000


-- 8. Oficinas con mas de 3 representantes por region()

select * from Oficinas
select * from Representantes

select 
o.Region as 'Region',
count(r.Num_Empl) as 'Numero de representantes por region'
from 
Oficinas as o
inner join 
Representantes as r
on r.Oficina_Rep = o.Oficina
group by o.Region
having count(r.Num_Empl) > 3;

-- 9. Productos con stock menor a 50, con detalles de fabricante 
-- (Fabricante, descripcion del producto)

select * from Productos;
select * from Pedidos;

select 
pr.Id_fab as 'Fabricante',
pr.Id_producto as 'ID del producto',
pr.Descripcion as 'Descripcion del producto',
pr.Stock as 'Existencias'
from
Productos as pr
where pr.Stock <50 

-- 10. Clientes con mas de 3 pedidos, con detalles de representante y oficina
-- (Cliente, nombre del representante y ciudad)

select * from Pedidos
select * from Oficinas
select * from Representantes

select 
r.Nombre as 'Nombre del Representante',
c.Num_Cli as 'ID del Cliente',
c.Empresa as 'Nombre del Cliente',
o.Oficina 'Numero de la oficina',
count(p.Num_Pedido) as 'Cantidad de Pedidos'
from
Pedidos as p
inner join
Representantes as r
on p.Rep = r.Num_Empl
inner join
Clientes as c
on r.Num_Empl = c.Rep_Cli
inner join 
Oficinas as o
on o.Oficina = r.Oficina_Rep
group by c.Num_Cli, c.Empresa, r.Nombre, o.Oficina
having count(p.Num_Pedido) > 3;