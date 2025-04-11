use bdejemplo2;

-- Realizar un trigger que se dispare
-- cuando se inserte un pedido y modifique
-- el stock del producto vendido, 
-- verificar si hay suficiente stock sino 
-- se cancela el pedido

Select * from pedidos
go

create or alter trigger tg_pedidos_insertar
on pedidos
after insert 
as
begin

declare @existencia int
declare @fab char(3)
declare @prod char(5)
declare @cantidad int

select @fab = fab, @prod = producto, 
@cantidad = cantidad 
from inserted;

select @existencia = stock from Productos
where Id_fab = @fab and Id_producto = @prod;

if @existencia > (select cantidad from inserted)
begin 
 update Productos
 set stock = stock - @cantidad
 where Id_fab = @fab and
       Id_producto = @prod;
end
else
begin 
    raiserror('No hay suficiente stock para el pedido', 16,1)
	rollback;
end
end;

select * from pedidos
select max(Num_Pedido) from Pedidos
select * from Productos

declare @importe money
select @importe = (p.Cantidad * pr.Precio)
from Pedidos as p
inner join Productos as pr
on p.Fab = pr.Id_fab 
and p.Producto = pr.Id_producto

insert into pedidos (Num_Pedido, Fecha_Pedido, cliente, 
Rep, Fab, Producto, Cantidad, importe)
values(113071, getdate(), 2103, 106, 'ACI', '41001', 77, @importe)