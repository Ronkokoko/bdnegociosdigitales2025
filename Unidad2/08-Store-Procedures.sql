--- crear un store procedure para seleccionar todos los clientes


create or alter procedure spu_mostrar_clientes
as
	 begin 
select * from Customers
end;
go

exec spu_mostrar_clientes
go

-- crear un sp que muestre los clientes por pais
-- parametros de entrada

create or alter proc spu_customersporpais
-- parametros 
@pais  nvarchar(15), -- parametro de entrada
@pais2 nvarchar(16)
	as
	begin
	select * from Customers
	where Country in (@pais, @pais2);
	end;


exec spu_customersporpais 'Spain', 'Germany'

-- o

declare @p1 nvarchar(15) = 'spain';
declare @p2 nvarchar(15) = 'germany';

exec spu_customersporpais @p1, @p2;
go


select * from Customers
select * from VistaOrdenesdeCompra
select * from [Order Details]


create or alter procedure sp_datos_de_compra
@NumerodeOrden int,
@OrdenFecha datetime ,
@Total money
as
 select * from VistaOrdenesdeCompra
 where year ([Fecha de Orden]) in (1996,1998)
 

 exec sp_datos_de_compra @NumerodeOrden  = 10250,
 @OrdenFecha = 1998, @Total = 26.00

 -- Generar un reporte que permita visualizar los datos de compra de un
 -- determinado cliente, en un rango de fechas, mostrando,
 -- el monto total de compras por producto mediante un sp

 go
 select * from VistaOrdenesdeCompra

 select * from Customers;
 create or alter proc spu_informe_ventas_clientes
 -- parametros
 @nombre nvarchar(40) = 'Berglunds snabbköp',
 @fechaInicial DateTime,
 @fechaFinal DateTime,
 AS
 begin
 select [Nombre Producto],
 [Nombre Cliente],
 sum(importe) AS [Monto Total]
 from VistaOrdenesdeCompra
 where [Nombre Cliente] = @nombre
 and [Fecha de Orden] between @fechaInicial and @fechaFinal
 group by [Nombre Producto], [Nombre Cliente]
 end;
 Go

 -- Ejecucion de un store procedure con parametros de entrada
 exec spu_informe_ventas_clientes
								'Berglunds snabbköp',
								'1996-07-04', '1997-01-01';

-- Ejecucion de un store procedure con parametros en diferente posicion
exec spu_informe_ventas_clientes @fechaInicial = '1996-07-04', 
								 @fechaFinal'1997-01-01';

-- Ejecucion de un store procedure con parametros de entrada con un 
-- campo que tiene un valor por default
exec spu_informe_ventas_clientes @fechaInicial = '1996-07-04', 
								 @fechaFinal'1997-01-01';
go


-- Store procedure con parametros de salida
create or alter proc spu_obtener_numero_clientes
@customerid nchar(5), -- Parametro de entrada	
@totalCustomers int output -- Parametro de salida
AS
begin 
	select @totalCustomers = count(*) from Customers
	where CustomerID = @customerid;
end;
GO

go

declare @numero int;
exec spu_obtener_numero_clientes @customerid= 'ANATR',
								@totalCustomers = @numero output;
print @numero;
GO

select * from Customers


-- Crear un store Procedure que permita saber si un alumno aprobo o reprobo
go
create or alter proc spu_comparar_calificacion
@calif decimal(10,2) --Parametro de entrada
AS
begin
	if @calif>=0 and @calif<=10
	begin
	if @calif>=8
	print 'La calificacion es aprobatoria'
	else
	print 'La calificacion es reprobatoria'
	end;
	else
		print 'Calificacion no valida'
End;
go

exec spu_comparar_calificacion @calif = 9;

-- Crear un sp que permita verificar si un cliente existe antes de 
-- devolver su informacion
go
create or alter procedure spu_obtener_cliente_siexiste
@numeroCliente nchar(5)
as
begin
	if exists (select 1 from Customers where CustomerID = @numeroCliente)
	select * from Customers 
	where CustomerID = @numeroCliente;
	else
		print 'El cliente no existe'
end;
go

exec spu_obtener_cliente_siexiste @numeroCliente = 'Arout'\


-- Crear un store procedure que permita insertar un cliente,
-- pero se debe verificar primero que no exista

go
create or alter procedure spu_obtener_cliente_siexiste
@numeroCliente nchar(5)
as
begin
	if exists (select 1 from Customers where CustomerID = @numeroCliente)
	select * from Customers 
	where CustomerID = @numeroCliente;
	else
		print 'El cliente no existe'
end;
go

go

create or alter procedure spu_agregar_cliente
	@id nchar(5),
	@nombre nvarchar(40),
	@city nvarchar(15) = 'San Miguel'
as
begin
	if exists (select 1 from Customers where CustomerID = @id)
	begin
		print ('El cliente ya existe')
		return 1
	end

	insert into Customers(customerid, companyname)
	values(@id, @nombre)
	print('Cliente insertado exitosamente');
	return 0;
end;
go

	-- Insertar un cliente con un excecute
exec spu_agregar_cliente 'AFIK', 'Patito de Hule'
select * from Customers;

go
create or alter procedure spu_agregar_cliente_try_catch
	@id nchar(5),
	@nombre nvarchar(40),
	@city nvarchar(15) = 'San Miguel'
AS
begin
	begin try
	insert into Customers(CustomerID, CompanyName)
	print('Cliente insertado exitosamente');
	end try
	begin catch
		print('El cliente ya existe');
	end catch
end;
go

exec spu_agregar_cliente_try_catch 'ALFKD', 'Muñeca Vieja'



-- Manejo de ciclos en Store Procedures


-- Imprimir el numero de veces que indique el usuario
go
create or alter procedure spu_ciclo_imprimir
	@numero int
AS
begin

	if  @numero<=0
	begin
		print('El numero no puede ser 0 o negativo');
		return
	end
----------
	declare @i int
	SET @i = 1
	while(@i<=@numero)
	begin
	print concat('Numero ', @i);
	SET @i = @i+1
	end
end;
go

exec spu_ciclo_imprimir @numero = 100000000




Go