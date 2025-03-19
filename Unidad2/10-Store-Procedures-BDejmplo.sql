use BDEJEMPLO2

-- Realizar un pedido con un Store Procedure
-- Validar que el pedido no exista
-- Validar que el cliente, que el empleado y producto exista
-- La cantidad a vender, debe ser validada, que haya suficiente stock del producto
-- Insertar el pedido y calcular el importe (multiplicando el precio del producto
-- por la cantidad vendida)
-- Actualizar el stock del producto(restando el stock menos la cantidad vendida)
select * from Pedidos;
go
create or alter procedure spu_pedido_submit
@numpedido int,
@cliente int,
@rep int,
@fab char(3),
@producto char(5),
@cantidad int
AS
begin
	if exists (select 1 from Pedidos where Num_Pedido = @numpedido)
	begin
		print('El pedido ya existe');
		return
	end	

	if not exists (select 1 from Clientes where Num_Cli = @cliente) or
	   not exists (select 1 from Representantes where Num_Empl = @rep) or
	   not exists (select 1 from Productos where Id_fab = @fab and Id_producto = @producto)
	begin
		print('Los datos no son validos')
		return
	end

	if @cantidad <= 0
	begin
		print('La cantidad no puede ser 0 o negativo')
		return;
	end

	declare @stockValido int
	select @stockValido = Stock from Productos where Id_fab = @fab and Id_producto = @producto
	if @cantidad > @stockValido
	begin
		print('No hay suficiente Stock')
		return;
	end
	declare @precio money
	declare @importe money

	select @precio = Precio from Productos where Id_fab = @fab and Id_producto = @producto
	SET @importe = @cantidad * @precio
	insert into Pedidos
	values(@numpedido, GETDATE(), @cliente, @rep, @fab, @producto, @cantidad, @importe)
end
--(Num_Pedido, Cliente, Rep, Fab, Producto, Cantidad)
go

--Existente
execute spu_pedido_submit @numpedido = 112961, @cliente = 2117, @rep =106, 
@fab ='REI', @producto ='2A44L', @cantidad =20
-- Cliente
execute spu_pedido_submit @numpedido = 112960, @cliente = 2190, @rep =106, 
@fab ='REI', @producto ='2A44L', @cantidad =20
-- Representante
execute spu_pedido_submit @numpedido = 112961, @cliente = 2117, @rep =106, 
@fab ='REI', @producto ='2A44L', @cantidad =20
-- Fabricante
execute spu_pedido_submit @numpedido = 112961, @cliente = 2117, @rep =106, 
@fab ='REI', @producto ='2A44L', @cantidad =20
-- Producto
execute spu_pedido_submit @numpedido = 112961, @cliente = 2117, @rep =106, 
@fab ='REI', @producto ='2A44L', @cantidad =20
-- Cantidad
execute spu_pedido_submit @numpedido = 112961, @cliente = 2117, @rep =106, 
@fab ='REI', @producto ='2A44L', @cantidad =20

select * from Pedidos