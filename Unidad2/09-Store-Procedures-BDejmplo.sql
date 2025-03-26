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
	
	begin try
		insert into Pedidos
		values(@numpedido, GETDATE(), @cliente, @rep, @fab, @producto, @cantidad, @importe)

		update Productos
		set Stock = Stock - @cantidad
		where Id_fab = @fab and Id_producto = @producto;

	end try

	begin catch
		print 'Error al actualizar datos'
		return;
	end catch 
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

execute spu_pedido_submit @numpedido = 113070, @cliente = 2117, @rep =107, 
@fab ='ACI', @producto ='4100X', @cantidad =20;

select * from Productos
where Id_fab = 'ACI' and Id_producto = '4100X'


-- Crea un Store Procedure que permita registrar un nuevo cliente en la base de datos Clientes.
-- Debes realizar las siguientes validaciones antes de insertar el registro:
-- El cliente no debe existir previamente en la base de datos.
-- El representante asignado debe existir en la tabla Representantes.
-- El límite de crédito debe ser mayor a 0, de lo contrario, mostrar un mensaje de error.
-- Manejo de errores: Usa un TRY-CATCH para capturar errores durante la inserción.

-- Parámetros que debe recibir el procedimiento:
-- @numcli (int) → Número de cliente.
-- @empresa (varchar(20)) → Nombre de la empresa.
-- @repcli (int) → Número de empleado del representante.
-- @limitecredito (money) → Límite de crédito del cliente.

go
select * from Clientes
select * from Representantes
select * from 
Clientes as c
inner join
Representantes as r
on c.Rep_Cli = r.Num_Empl

create or alter procedure spu_registrar_cliente_nuevo
@numcli int,
@empresa varchar(20),
@repcli int,
@limcredito money
AS
begin
	if exists (select 1 from Clientes as c where c.Num_Cli = @numcli)
	begin
		print('El cliente ya existe');
		return
	end	

	if exists (select 1 from Clientes as c where c.Empresa = @empresa)
	begin
		print('La empresa ya existe');
		return
	end

	if not exists (select 1 from Representantes as r where r.Num_Empl = @repcli)
	begin
		print('El representante no existe');
		return
	end

	if @limcredito <= 0 
	begin
	print('La cantidad no puede ser 0 o negativo')
	return;
	end
	
	begin try
		insert into Clientes
		values(@numcli, @empresa, @repcli, @limcredito)
		print('Los datos se han insertado correctamente')
		return;
	end try
	begin catch
		print ('Error al actualizar datos')
		return;
	end catch
end
go

-- Pruebas del store procedure
select * from Clientes;
-- Numero de cliente existente:
execute spu_registrar_cliente_nuevo @numcli = 2114, @empresa = 'Amarillo Co.', 
											@repcli = 109, @limcredito = 65000;
-- Empresa existente:
execute spu_registrar_cliente_nuevo @numcli = 2126, @empresa = 'Mejorada Sistemas', 
											@repcli = 109, @limcredito = 65000;
-- Numero de representante inexistente:
execute spu_registrar_cliente_nuevo @numcli = 2126, @empresa = 'Amarillo Co.', 
											@repcli = 111, @limcredito = 65000;
-- Credito inaccesible:
execute spu_registrar_cliente_nuevo @numcli = 2127, @empresa = 'Azulejo Corp', 
											@repcli = 102, @limcredito = 0;
/* Aqui me equivoque porque mi prueba de credito si inserto un 0 en el limite de credito
UPDATE Clientes
SET Limite_Credito = 89000  -- Nuevo valor que deseas asignar
WHERE Num_Cli = 2126;  -- Cliente específico con el error
*/
-- Insercion de datos:
execute spu_registrar_cliente_nuevo @numcli = 2127, @empresa = 'Azulejo Corp', 
											@repcli = 102, @limcredito = 78000;


/*
Ejercicio 3: Actualización de cuota de ventas de un representante
Crea un Store Procedure que actualice la cuota de ventas de un representante en la tabla Representantes.
El procedimiento debe:

Verificar que el representante existe.
Validar que la nueva cuota de ventas sea mayor que 0.
No permitir disminuir la cuota de ventas si las ventas actuales ya superan la nueva cuota.
Registrar la actualización en una tabla de auditoría llamada Historial_Cuotas con:
Num_Empl (representante afectado),
Fecha_Cambio,
Cuota_Antigua,
Cuota_Nueva.
Manejo de errores con TRY-CATCH.
Parámetros:

@numempl (int) → Número del representante.
@nuevaCuota (money) → Nueva cuota de ventas.
*/
go
select * from Representantes
create or alter procedure spu_nuevas_cuotas
@numempleado int,
@nombre varchar(16),
@edad int,
@oficina int,
@puesto varchar(13),
@fecha date,
@jefe int,
@cuota money,
@ventas money
AS
begin 
	begin transaction;
	
	if not exists (select 1 from Representantes as r where r.Num_Empl = @numempleado)
	begin
		raiserror('El id del representante no es valido', 16, 1);
		rollback transaction;
		return;
	end

	if not exists (select 1 from Representantes as r where r.Nombre = @nombre)
	begin
		raiserror('El nombre del representante no existe o es incorrecto', 16, 1);
		rollback transaction;
		return;
	end

	if not exists (select 1 from Representantes as r where r.Edad = @edad)
	begin
		raiserror('El representante no cuenta con esa edad', 16, 1);
		rollback transaction;
		return;
	end

	if not exists (select 1 from Representantes as r where r.Oficina_Rep = @oficina)
	begin
		raiserror('El representante no se encuentra trabajando en esa oficina', 16, 1);
		rollback transaction;
		return;
	end

	if not exists (select 1 from Representantes as r where r.Edad = @edad)
	begin
		raiserror('El representante no cuenta con esa edad', 16, 1);
		rollback transaction;
		return;
	end

	if not exists (select 1 from Representantes as r where r.Puesto = @puesto)
	begin
		raiserror('El representante no cuenta con ese puesto', 16, 1);
		rollback transaction;
		return;
	end

	if not exists (select 1 from Representantes as r where r.Fecha_Contrato = @fecha)
	begin
		raiserror('Esa no es la fecha en la que el representante fue contratado', 16, 1);
		rollback transaction;
		return;
	end

	if not exists (select 1 from Representantes as r where r.Jefe = @jefe)
	begin
		raiserror('El id del jefe del representante no es correcto', 16, 1);
		rollback transaction;
		return;
		if exists (select 1 from Representantes where Num_Empl = @numempleado and Jefe IS NULL)
		begin
			raiserror('El representante no cuenta con un jefe', 16, 1);
			rollback transaction;
			return;
		end
	end

	if not exists (select 1 from Representantes as r where r.Cuota = @cuota)
	begin
		raiserror('La cuota es incorrecta', 16, 1);
		rollback transaction;
		return;
	end
	
	if not exists (select 1 from Representantes as r where r.Ventas = @ventas)
	begin
		raiserror('Las ventas son incorrectas', 16, 1);
		rollback transaction;
		return;
	end
end;
go

-- Pruebas del store procedure
select * from  Representantes
-- Id incorrecto
execute spu_nuevas_cuotas @numempleado = 101, @nombre = 'Daniel Ruidrobo', @edad = 45, 
						  @oficina = 12, @puesto = 'Representante', @fecha = '1986-10-20', 
						  @jefe = 100, @cuota = 300000, @ventas = 305673;

execute spu_nuevas_cuotas @numempleado = 102, @nombre = 'Susana Santos', @edad = 48, 
						  @oficina = 21, @puesto = 'Representante', @fecha = '1986-12-10', 
						  @jefe = 102, @cuota = 300000, @ventas = 305673;


---------------------------------------

go
CREATE OR ALTER PROCEDURE spu_nuevas_cuotas
@numempleado INT,
@nuevacuota MONEY
AS
BEGIN
    BEGIN TRANSACTION;

    -- Verificar si el representante existe
    IF NOT EXISTS (SELECT 1 FROM Representantes WHERE Num_Empl = @numempleado)
    BEGIN
        RAISERROR('El representante no existe', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END

    -- Obtener la cuota actual y las ventas
    DECLARE @cuotaActual MONEY, @ventasActuales MONEY, @jefe INT;
    
    SELECT @cuotaActual = Cuota, 
           @ventasActuales = Ventas, 
           @jefe = Jefe
    FROM Representantes 
    WHERE Num_Empl = @numempleado;

    -- Verificar si la nueva cuota es válida
    IF @nuevacuota <= 0
    BEGIN
        RAISERROR('La nueva cuota debe ser mayor a 0', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END

    -- No permitir disminuir la cuota si las ventas actuales ya la superaron
    IF @nuevacuota < @ventasActuales
    BEGIN
        RAISERROR('No se puede asignar una cuota menor a las ventas actuales', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END

    -- Si el representante no tiene jefe (Jefe IS NULL)
    IF @jefe IS NULL
    BEGIN
        PRINT('El representante no tiene un jefe asignado.');
    END

	-- **Verificar si la tabla Historial_Cuotas existe y crearla si no existe**
    IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Historial_Cuotas')
    BEGIN
        CREATE TABLE Historial_Cuotas (
            ID INT IDENTITY(1,1) PRIMARY KEY,
            Num_Empl INT NOT NULL,
            Fecha_Cambio DATETIME DEFAULT GETDATE(),
            Cuota_Antigua MONEY NOT NULL,
            Cuota_Nueva MONEY NOT NULL,
            FOREIGN KEY (Num_Empl) REFERENCES Representantes(Num_Empl)
        );
    END

	begin try
    -- Actualizar la cuota del representante
    UPDATE Representantes
    SET Cuota = @nuevacuota
    WHERE Num_Empl = @numempleado;

    -- Registrar la actualización en la tabla de historial
    INSERT INTO Historial_Cuotas (Num_Empl, Fecha_Cambio, Cuota_Antigua, Cuota_Nueva)
    VALUES (@numempleado, GETDATE(), @cuotaActual, @nuevacuota);

		
		PRINT('Cuota actualizada exitosamente');
	END TRY

	BEGIN CATCH
		ROLLBACK TRANSACTION;
		RAISERROR('Error al actualizar la cuota', 16, 1);
	END CATCH
end;
go

select * from Representantes
select * from Historial_Cuotas
-- Intentar actualizar un representante que NO existe
EXEC spu_nuevas_cuotas @numempleado = 999, @nuevacuota = 70000;

-- Intentar asignar una cuota menor a 0
EXEC spu_nuevas_cuotas @numempleado = 102, @nuevacuota = -1000;

-- Intentar asignar una cuota menor a las ventas actuales
EXEC spu_nuevas_cuotas @numempleado = 101, @nuevacuota = 20000; -- Si las ventas son mayores a las ventas, fallará

-- Caso exitoso: Actualizar la cuota de un representante existente
EXEC spu_nuevas_cuotas @numempleado = 102, @nuevacuota = 491000;

/* Aqui me equivoque porque mi prueba de cuotas inserto un valor al que no le pude hacer rollback
UPDATE Representantes
SET Cuota = 350000  -- Nuevo valor que deseas asignar
WHERE Num_Empl = 102;  -- Cliente específico con el error
*/

rollback transaction

/*
Ejercicio 2: Cancelación de pedidos con restricciones
Crea un Store Procedure para cancelar un pedido en la tabla Pedidos.
Condiciones a validar antes de la cancelación:

El pedido debe existir en la tabla Pedidos.
El pedido no debe haber sido procesado (es decir, que el stock aún no haya sido actualizado).
El pedido debe pertenecer a un cliente válido en la tabla Clientes.
Si la cancelación es exitosa, debe reponer el stock del producto en la tabla Productos.
Manejo de errores con TRY-CATCH.
Parámetros:

@numpedido (int) → Número de pedido a cancelar.
*/


go
CREATE OR ALTER PROCEDURE spu_cancelar_pedido
@numpedido INT
AS
BEGIN
    BEGIN TRANSACTION;

    -- Verificar si el pedido existe
    IF NOT EXISTS (SELECT 1 FROM Pedidos WHERE Num_Pedido = @numpedido)
    BEGIN
        RAISERROR('El pedido no existe', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END

    -- Obtener información del pedido
    DECLARE @cliente INT, @rep INT, @fab CHAR(3), @producto CHAR(5), @cantidad INT, @importe MONEY;

    SELECT @cliente = Cliente, 
           @rep = Rep, 
           @fab = Fab, 
           @producto = Producto, 
           @cantidad = Cantidad, 
           @importe = Importe
    FROM Pedidos
    WHERE Num_Pedido = @numpedido;

    -- Verificar si el cliente es válido
    IF NOT EXISTS (SELECT 1 FROM Clientes WHERE Num_Cli = @cliente)
    BEGIN
        RAISERROR('El cliente asociado al pedido no es válido', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END

    -- Verificar si el stock ya ha sido modificado (para evitar reversiones indebidas)
    DECLARE @stockActual INT;

    SELECT @stockActual = Stock 
    FROM Productos 
    WHERE Id_fab = @fab AND Id_producto = @producto;

    IF @stockActual + @cantidad < 0
    BEGIN
        RAISERROR('No se puede cancelar el pedido porque el stock ya fue modificado manualmente.', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END

	begin try
    -- Eliminar el pedido
    DELETE FROM Pedidos WHERE Num_Pedido = @numpedido;

    -- Revertir el stock del producto
    UPDATE Productos
    SET Stock = Stock + @cantidad
    WHERE Id_fab = @fab AND Id_producto = @producto;

    
    PRINT('Pedido cancelado y stock restaurado exitosamente');
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION;
		RAISERROR('Error al cancelar el pedido', 16, 1);
	END CATCH
end
go

select * from Pedidos
select * from Productos

-- PRUEBAS 

SELECT * FROM Pedidos WHERE Num_Pedido = 112961;
SELECT * FROM Productos WHERE Id_fab = 'REI' AND Id_producto = '2A44L';

-- Ejecutamos el procedimiento para cancelar el pedido
EXEC spu_cancelar_pedido @numpedido = 112961;

-- Verificamos que el pedido haya sido eliminado o marcado como cancelado
SELECT * FROM Pedidos WHERE Num_Pedido = 112961;
SELECT * FROM Productos WHERE Id_fab = 'REI' AND Id_producto = '244L';

rollback transaction;

-- Pruebas con un pedido inexistente
EXEC spu_cancelar_pedido @numpedido = 999999;



/*
Ejercicio 4: Consulta de pedidos en un período determinado (VIEW)
Crea una Vista (VIEW) que muestre todos los pedidos realizados en un rango de fechas específico.
Debe incluir:

Número de pedido.
Nombre del cliente y representante.
Nombre del producto, cantidad e importe total.
Debe incluir pedidos solo si el importe es mayor a 1000.
*/

/*
Generar un informe de desempeño de representantes
Crea un Store Procedure que genere un informe detallado sobre el desempeño de los representantes de ventas.
El procedimiento debe calcular varios indicadores clave y devolver los resultados en una consulta.
Requerimientos del procedimiento
 Verificar que el representante exista.
 Calcular el total de pedidos gestionados por el representante.
 Calcular la cantidad total de productos vendidos por el representante.
 Calcular el monto total de ventas generadas por el representante.
 Calcular el porcentaje de cumplimiento de cuota:

Si el representante ya ha superado su cuota, debe indicar cuánto ha sobrepasado.
Si no ha cumplido la cuota, debe mostrar el porcentaje restante.
 Determinar si el representante ha cumplido su cuota (SI o NO).
 Si el representante no ha realizado ventas, mostrar "Sin Ventas" en el informe.
 Manejo de errores con TRY-CATCH.
*/
select * from Representantes
go
CREATE OR ALTER PROCEDURE spu_reporte_desempeño
@numempleado INT
AS
BEGIN
    BEGIN TRANSACTION;

    -- Verificar si el representante existe
    IF NOT EXISTS (SELECT 1 FROM Representantes WHERE Num_Empl = @numempleado)
    BEGIN
        RAISERROR('El representante no existe', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END

    -- Declarar variables para cálculos
    DECLARE @totalPedidos INT, 
            @totalProductosVendidos INT, 
            @totalVentas MONEY, 
            @cuota MONEY, 
            @porcentajeCumplimiento FLOAT, 
            @estadoCumplimiento VARCHAR(10);

    -- Obtener la cuota del representante
    SELECT @cuota = Cuota 
    FROM Representantes 
    WHERE Num_Empl = @numempleado;
	
    -- Calcular el total de pedidos gestionados
    SELECT @totalPedidos = COUNT(*)
    FROM Pedidos
    WHERE Rep = @numempleado;

    -- Calcular la cantidad total de productos vendidos
    SELECT @totalProductosVendidos = SUM(Cantidad)
    FROM Pedidos
    WHERE Rep = @numempleado;

    -- Calcular el monto total de ventas generadas
    SELECT @totalVentas = SUM(Importe)
    FROM Pedidos
    WHERE Rep = @numempleado;

    -- Si el representante no ha realizado ventas, establecer valores predeterminados
    IF @totalPedidos IS NULL
        SET @totalPedidos = 0;
    IF @totalProductosVendidos IS NULL
        SET @totalProductosVendidos = 0;
    IF @totalVentas IS NULL
        SET @totalVentas = 0;

    -- Calcular el porcentaje de cumplimiento de cuota
    IF @cuota > 0
        SET @porcentajeCumplimiento = (@totalVentas / @cuota) * 100;
    ELSE
        SET @porcentajeCumplimiento = 0; -- Evitar división por cero

    -- Determinar si ha cumplido su cuota
    IF @totalVentas >= @cuota
        SET @estadoCumplimiento = 'SI';
    ELSE
        SET @estadoCumplimiento = 'NO';

	begin try
    -- Devolver los resultados
    SELECT 
        @numempleado AS Num_Empleado,
        @totalPedidos AS Total_Pedidos,
        @totalProductosVendidos AS Total_Productos_Vendidos,
        @totalVentas AS Total_Ventas,
        @cuota AS Cuota_Asignada,
        @porcentajeCumplimiento AS Porcentaje_Cumplimiento,
        @estadoCumplimiento AS Cumplio_Cuota,
        CASE 
            WHEN @totalVentas = 0 THEN 'Sin Ventas'
            ELSE 'Ventas Realizadas'
        END AS Estado_Ventas;
		commit transaction
	END TRY

	BEGIN CATCH
		ROLLBACK TRANSACTION;
		RAISERROR('Error al generar el reporte de desempeño', 16, 1);
	END CATCH
end
go
select * from Representantes
SELECT * FROM Representantes WHERE Cuota IS NULL OR Ventas IS NULL;

--	Prueba: Representante con ventas
EXEC spu_reporte_desempeño @numempleado = 104;
rollback transaction

select * from Pedidos
select sum(Importe) from Pedidos
where Rep = 104
-- 58633,00



------------------------------ Views
/*
Vista de Pedidos Detallados
Objetivo: Crear una vista que muestre información detallada de cada pedido, incluyendo:

Número de pedido
Fecha del pedido
Nombre del cliente
Nombre del representante
Nombre del producto
Cantidad pedida
Importe total
*/
CREATE OR ALTER VIEW vw_Pedidos_Detallados AS
SELECT 
    p.Num_Pedido,
    p.Fecha_Pedido,
    c.Empresa AS Cliente,
    r.Nombre AS Representante,
    pr.Descripcion AS Producto,
    p.Cantidad,
    p.Importe
FROM Pedidos as p
inner JOIN Clientes as c 
ON p.Cliente = c.Num_Cli
inner JOIN Representantes as r 
ON p.Rep = r.Num_Empl
inner JOIN Productos as pr 
ON p.Fab = pr.Id_fab AND p.Producto = pr.Id_producto;

SELECT * FROM vw_Pedidos_Detallados;

/*
Vista de Representantes y Cumplimiento de Cuotas
Objetivo: Crear una vista que muestre información de los representantes junto con:

Su cuota asignada
Ventas realizadas
Porcentaje de cumplimiento de cuota
Estado (Cumple o No Cumple)
*/

CREATE OR ALTER VIEW vw_Cumplimiento_Cuotas AS
SELECT 
    r.Num_Empl AS ID_Representante,
    r.Nombre,
    r.Cuota AS Cuota_Asignada,
    r.Ventas AS Ventas_Realizadas,
    CASE 
        WHEN r.Cuota = 0 THEN 'Sin cuota asignada'
        WHEN r.Ventas >= r.Cuota THEN 'Cumple'
        ELSE 'No Cumple'
    END AS Estado_Cuota,
    CASE 
        WHEN r.Cuota = 0 THEN 0
        ELSE (r.Ventas * 100.0 / NULLIF(r.Cuota, 0)) 
    END AS Porcentaje_Cumplimiento
FROM Representantes as r;

SELECT * FROM vw_Cumplimiento_Cuotas;

/*
Vista de Stock Crítico de Productos
Objetivo: Crear una vista que muestre productos con stock bajo, junto con:

Cantidad en stock
Un indicador de "Estado de Abastecimiento" (Bajo, Óptimo, Crítico)
Cantidad faltante para alcanzar un mínimo de seguridad de 50 unidades
*/

CREATE OR ALTER VIEW vw_Stock_Critico AS
SELECT 
    pr.Id_producto,
    pr.Descripcion AS Producto,
    pr.Stock,
    CASE 
        WHEN pr.Stock = 0 THEN 'Agotado'
        WHEN pr.Stock < 20 THEN 'Crítico'
        WHEN pr.Stock < 50 THEN 'Bajo'
        ELSE 'Óptimo'
    END AS Estado_Abastecimiento,
    CASE 
        WHEN pr.Stock < 50 THEN 50 - pr.Stock
        ELSE 0
    END AS Cantidad_Faltante
FROM Productos pr;

SELECT * FROM vw_Stock_Critico;

/*
Vista de Ventas Anuales por Representante
Objetivo: Mostrar las ventas totales por representante agrupadas por año, 
comparando el crecimiento respecto al año anterior.
*/

CREATE OR ALTER VIEW vw_Ventas_Anuales AS
SELECT 
    YEAR(p.Fecha_Pedido) AS Año,
    r.Num_Empl AS ID_Representante,
    r.Nombre AS Representante,
    SUM(p.Importe) AS Total_Ventas,
    LAG(SUM(p.Importe)) OVER (PARTITION BY r.Num_Empl ORDER BY YEAR(p.Fecha_Pedido)) AS Ventas_Año_Anterior,
    CASE 
        WHEN LAG(SUM(p.Importe)) OVER (PARTITION BY r.Num_Empl ORDER BY YEAR(p.Fecha_Pedido)) IS NULL THEN NULL
        ELSE 
            ((SUM(p.Importe) - LAG(SUM(p.Importe)) OVER (PARTITION BY r.Num_Empl ORDER BY YEAR(p.Fecha_Pedido))) 
            / LAG(SUM(p.Importe)) OVER (PARTITION BY r.Num_Empl ORDER BY YEAR(p.Fecha_Pedido))) * 100
    END AS Porcentaje_Crecimiento
FROM Pedidos p
JOIN Representantes r ON p.Rep = r.Num_Empl
GROUP BY YEAR(p.Fecha_Pedido), r.Num_Empl, r.Nombre;
select * from pedidos
SELECT * FROM vw_Ventas_Anuales;


/*
Vista de Clientes y su Nivel de Crédito
Objetivo: Evaluar a los clientes en función de su uso de crédito, clasificándolos en diferentes niveles.
*/

CREATE OR ALTER VIEW vw_Nivel_Credito_Clientes AS
SELECT 
    c.Num_Cli AS ID_Cliente,
    c.Empresa AS Cliente,
    c.Limite_Credito,
    COALESCE(SUM(p.Importe), 0) AS Total_Compras,
    (COALESCE(SUM(p.Importe), 0) * 100.0 / NULLIF(c.Limite_Credito, 0)) AS Porcentaje_Uso_Credito,
    CASE 
        WHEN c.Limite_Credito = 0 THEN 'Sin Crédito'
        WHEN COALESCE(SUM(p.Importe), 0) / NULLIF(c.Limite_Credito, 0) >= 0.9 THEN 'Crédito Excedido'
        WHEN COALESCE(SUM(p.Importe), 0) / NULLIF(c.Limite_Credito, 0) >= 0.7 THEN 'Alto Uso'
        WHEN COALESCE(SUM(p.Importe), 0) / NULLIF(c.Limite_Credito, 0) >= 0.4 THEN 'Moderado'
        ELSE 'Bajo Uso'
    END AS Estado_Credito
FROM Clientes c
LEFT JOIN Pedidos p ON c.Num_Cli = p.Cliente
GROUP BY c.Num_Cli, c.Empresa, c.Limite_Credito;


SELECT * FROM vw_Nivel_Credito_Clientes;


/*
Vista de Productos más Vendidos con Ranking
Objetivo: Ordenar los productos por ventas y asignarles un ranking de popularidad.
*/

CREATE OR ALTER VIEW vw_Productos_Mas_Vendidos AS
SELECT 
    p.Id_producto AS ID_Producto,
    p.Descripcion AS Producto,
    SUM(pd.Cantidad) AS Total_Vendido,
    RANK() OVER (ORDER BY SUM(pd.Cantidad) DESC) AS Ranking,
    CASE 
        WHEN SUM(pd.Cantidad) >= 500 THEN 'Top Ventas'
        WHEN SUM(pd.Cantidad) >= 200 THEN 'Muy Vendido'
        WHEN SUM(pd.Cantidad) >= 100 THEN 'Popular'
        ELSE 'Poco Vendido'
    END AS Popularidad
FROM Productos p
JOIN Pedidos pd ON p.Id_fab = pd.Fab AND p.Id_producto = pd.Producto
GROUP BY p.Id_producto, p.Descripcion;

SELECT * FROM vw_Productos_Mas_Vendidos;

/*
Vista de Representantes y su Eficiencia en Ventas
Objetivo: Comparar el desempeño de cada representante con la media de ventas del equipo.
*/

CREATE OR ALTER VIEW vw_Eficiencia_Representantes AS
WITH VentasPorRepresentante AS (
    SELECT 
        Rep, 
        SUM(Importe) AS Total_Ventas
    FROM Pedidos
    GROUP BY Rep
),
MediaVentas AS (
    SELECT AVG(Total_Ventas) AS Promedio_Ventas FROM VentasPorRepresentante
)
SELECT 
    r.Num_Empl AS ID_Representante,
    r.Nombre,
    vpr.Total_Ventas,
    mv.Promedio_Ventas,
    CASE 
        WHEN vpr.Total_Ventas >= mv.Promedio_Ventas * 1.5 THEN 'Excelente'
        WHEN vpr.Total_Ventas >= mv.Promedio_Ventas THEN 'Bueno'
        WHEN vpr.Total_Ventas >= mv.Promedio_Ventas * 0.5 THEN 'Regular'
        ELSE 'Bajo Desempeño'
    END AS Nivel_Desempeño
FROM VentasPorRepresentante vpr
CROSS JOIN MediaVentas mv
JOIN Representantes r ON vpr.Rep = r.Num_Empl;

SELECT * FROM vw_Eficiencia_Representantes;

/*
---

## 📌 **Cuándo usar `LEFT JOIN` y `RIGHT JOIN`**
| **Tipo de JOIN** | **Úsalo cuando...** |
|------------------|----------------------|
| **`LEFT JOIN`**  | Quieres **TODOS los registros** de la tabla izquierda, aunque no haya coincidencias en la tabla derecha. |
| **`RIGHT JOIN`** | Quieres **TODOS los registros** de la tabla derecha, aunque no haya coincidencias en la tabla izquierda. |

---
*/
/*

Ejemplo 1: Store Procedure - Clientes sin Pedidos (`LEFT JOIN`)
Objetivo: Listar clientes que no han realizado pedidos y su límite de crédito.
*/

CREATE OR ALTER PROCEDURE spu_Clientes_Sin_Pedidos
AS
BEGIN
    SELECT 
        c.Num_Cli AS ID_Cliente,
        c.Empresa AS Cliente,
        c.Limite_Credito,
        p.Num_Pedido AS Pedido
    FROM Clientes c
    LEFT JOIN Pedidos p ON c.Num_Cli = p.Cliente
    WHERE p.Num_Pedido IS NULL;  -- Solo clientes sin pedidos
END
GO


-- Ejecutar y probar

EXEC spu_Clientes_Sin_Pedidos;

/*
Usa `LEFT JOIN` para obtener TODOS los clientes, incluso los que no tienen pedidos**.  
Filtra `WHERE p.Num_Pedido IS NULL` para mostrar solo los que nunca compraron**.  
*/

/*
Ejemplo 2: Store Procedure - Representantes sin Ventas (`LEFT JOIN`)
Objetivo: Mostrar los representantes que **no han gestionado ningún pedido
*/

CREATE OR ALTER PROCEDURE spu_Representantes_Sin_Ventas
AS
BEGIN
    SELECT 
        r.Num_Empl AS ID_Representante,
        r.Nombre,
        r.Cuota,
        p.Num_Pedido AS Pedido
    FROM Representantes r
    LEFT JOIN Pedidos p ON r.Num_Empl = p.Rep
    WHERE p.Num_Pedido IS NULL;
END
GO

-- Ejecutar y probar

EXEC spu_Representantes_Sin_Ventas;

/*
Usa `LEFT JOIN` para incluir a todos los representantes, aunque no hayan hecho ventas**.  
Filtra con `WHERE p.Num_Pedido IS NULL` para mostrar solo los que no tienen pedidos asignados**.  
*/

/*
Ejemplo 3: Store Procedure - Pedidos sin Cliente (`RIGHT JOIN`)
Objetivo:** Buscar pedidos que no tienen un cliente registrado.  
(Ejemplo raro, pero útil si hay problemas de integridad en la BD).
*/

CREATE OR ALTER PROCEDURE spu_Pedidos_Sin_Cliente
AS
BEGIN
    SELECT 
        p.Num_Pedido AS Pedido,
        p.Fecha_Pedido,
        c.Num_Cli AS ID_Cliente,
        c.Empresa AS Cliente
    FROM Pedidos p
    RIGHT JOIN Clientes c ON p.Cliente = c.Num_Cli
    WHERE c.Num_Cli IS NULL;
END
GO


-- Ejecutar y probar

EXEC spu_Pedidos_Sin_Cliente;

/*
Usa `RIGHT JOIN` para incluir todos los pedidos, incluso si no tienen un cliente válido.
Filtra con `WHERE c.Num_Cli IS NULL` para encontrar pedidos sin cliente.  
*/
---


/*
Ejemplo 4: View - Clientes con su Último Pedido (`LEFT JOIN`)
Objetivo: Mostrar clientes junto con la fecha de su último pedido (si tienen).  
Si no tienen pedidos, se mostrará `"Sin Pedidos"`.
*/

CREATE OR ALTER VIEW vw_Clientes_Ultimo_Pedido AS
SELECT 
    c.Num_Cli AS ID_Cliente,
    c.Empresa AS Cliente,
    COALESCE(MAX(p.Fecha_Pedido), 'Sin Pedidos') AS Ultimo_Pedido
FROM Clientes c
LEFT JOIN Pedidos p ON c.Num_Cli = p.Cliente
GROUP BY c.Num_Cli, c.Empresa;

-- Ejecutar y probar

SELECT * FROM vw_Clientes_Ultimo_Pedido;

/*
Usa `LEFT JOIN` para incluir todos los clientes, aunque no tengan pedidos.
Usa `MAX()` para obtener la fecha más reciente de sus pedidos.
Usa `COALESCE()` para mostrar `"Sin Pedidos"` si no tienen registros.
*/
---

/*
Ejemplo 5: View - Representantes con Ventas y Sin Ventas (`LEFT JOIN`)
Objetivo: Mostrar todos los representantes con su total de ventas (0 si no tienen ventas).
*/


CREATE OR ALTER VIEW vw_Representantes_Ventas AS
SELECT 
    r.Num_Empl AS ID_Representante,
    r.Nombre,
    COALESCE(SUM(p.Importe), 0) AS Total_Ventas
FROM Representantes r
LEFT JOIN Pedidos p ON r.Num_Empl = p.Rep
GROUP BY r.Num_Empl, r.Nombre;

Ejecutar y probar

SELECT * FROM vw_Representantes_Ventas;

Usa `LEFT JOIN` para incluir todos los representantes, incluso si no tienen ventas.
Usa `COALESCE(SUM(p.Importe), 0)` para que los que no han vendido nada muestren `0`.

---
/*
Ejemplo 6: View - Productos Nunca Vendidos (`LEFT JOIN`)
Objetivo: Encontrar productos que **nunca han sido vendidos.
*/

CREATE OR ALTER VIEW vw_Productos_Sin_Ventas AS
SELECT 
    pr.Id_producto AS ID_Producto,
    pr.Descripcion AS Producto,
    pr.Stock,
    p.Num_Pedido
FROM Productos pr
LEFT JOIN Pedidos p ON pr.Id_fab = p.Fab AND pr.Id_producto = p.Producto
WHERE p.Num_Pedido IS NULL;


-- Ejecutar y probar

SELECT * FROM vw_Productos_Sin_Ventas;

/*
Usa `LEFT JOIN` para incluir todos los productos, aunque no tengan pedidos.
Filtra con `WHERE p.Num_Pedido IS NULL` para mostrar solo los productos nunca vendidos.
*/
---

/*
Conclusión
LEFT JOIN → Lo usamos cuando queremos incluir **TODOS los datos de la tabla izquierda**, incluso si no tienen relación en la tabla derecha.  
RIGHT JOIN → Lo usamos cuando queremos incluir **TODOS los datos de la tabla derecha**, incluso si no tienen relación en la tabla izquierda.  
Usamos COALESCE() para manejar `NULL` en los cálculos.  
WHERE p.Num_Pedido IS NULL`** es útil para encontrar elementos sin relación (como clientes sin pedidos).  
*/