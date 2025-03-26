use Northwind

-- View numero 1
select * from Customers
select * from Orders
select * from Shippers
go
create or alter view view_pedidos_cliente_empleado
as
select
c.CustomerID as 'ID del Cliente',
c.CompanyName as 'Nombre del Cliente',
concat(e.FirstName, ' ', e.LastName) as 'Nombre del Empleado',
o.OrderID as 'Numero de Pedido',
o.OrderDate as 'Fecha del Pedido',
o.RequiredDate as 'Fecha Requerida',
s.CompanyName as 'Transportista',
o.Freight as 'Peso'
from Orders as o
inner join
Customers as c 
on o.CustomerID = c.CustomerID
inner join
Employees as e 
on o.EmployeeID = e.EmployeeID
inner join
Shippers as s 
on o.ShipVia = s.ShipperID;
go

-- Pruebas de la view 1
select * from view_pedidos_cliente_empleado;

-- View numero 2
go
create or alter view vista_productos_categorias
as
select
p.ProductID as 'ID del Producto',
p.ProductName as 'Nombre del Producto',
c.CategoryName as 'Categoria',
s.CompanyName as 'Proveedor',
p.UnitPrice as 'Precio Unitario',
od.Quantity as 'Cantidad vendida',
p.UnitsInStock as 'Stock Disponible'
from 
[Order Details] as od
inner join
Products as p
on od.ProductID = p.ProductID
inner join 
Categories as c 
on p.CategoryID = c.CategoryID
inner join 
Suppliers as s 
on p.SupplierID = s.SupplierID;
go
select * from [Order Details]
-- Pruebas de la view 2
select * from vista_productos_categorias
go
create or alter procedure sp_RegistrarNuevoPedido
@customerID nvarchar(5),
@employeeID int,
@orderDate datetime,
@requiredDate datetime,
@shipVia int,
@freight money
AS
begin
	begin transaction

    -- Validar que el Cliente existe
    if not exists (select 1 from Customers where CustomerID = @customerID)
    begin
        raiserror('El cliente no existe.',16,1);
		rollback transaction;
        return -1;
    end

    -- Validar que el Empleado existe
    if not exists (select 1 from Employees where EmployeeID = @employeeID)
    begin
        raiserror('El empleado no existe.',16,1);
		rollback transaction;
        return -2;
    end

    -- Validar que la Fecha Requerida sea posterior a la Fecha del Pedido
    if @RequiredDate <= @OrderDate
    begin
        raiserror('La fecha requerida debe ser posterior a la fecha del pedido.',16,1);
		rollback transaction;
        return -3;
    end

    -- Validar que el Transportista existe
    if not exists (select 1 from Shippers where ShipperID = @shipVia)
    begin
        raiserror('El transportista no existe.',16,1);
		rollback transaction;
        return -5;
    end

    begin try

        -- Insertar nuevo pedido en Orders
        insert into Orders (CustomerID, EmployeeID, OrderDate, RequiredDate, ShipVia, Freight)
        values (@customerID, @employeeID, @orderDate, @requiredDate, @shipVia, @freight);
        print('Pedido registrado correctamente.');
    end try

    begin catch
		rollback transaction;
		raiserror('Error inesperado al registrar el pedido.',16,1);
		return -4;
    end catch
end;
go

select * from Orders
order by CustomerID 
-- pruebas de uso

-- Prueba 1
-- El cliente no existe
execute sp_RegistrarNuevoPedido
    @customerID = 'ALFRESI',
    @employeeID = 1,
    @orderDate = '1997-07-01',
    @requiredDate = '1997-07-10',
    @shipVia = 1,
    @freight = 50.00;

-- Prueba 2
-- El empleado no existe
execute sp_RegistrarNuevoPedido
    @CustomerID = 'ALFKI',
    @EmployeeID = 10,
    @OrderDate = '1997-07-01',
    @RequiredDate = '1997-07-10',
    @ShipVia = 1,
    @Freight = 50.00;

-- Prueba 3
-- La fecha requerida es posterior a la fecha del pedido
execute sp_RegistrarNuevoPedido
    @CustomerID = 'ALFKI',
    @EmployeeID = 1,
    @OrderDate = '1997-07-10',
    @RequiredDate = '1997-07-01', 
    @ShipVia = 1,
    @Freight = 50.00;

-- Prueba 4
-- El transportista no existe
execute sp_RegistrarNuevoPedido
    @CustomerID = 'ALFKI',
    @EmployeeID = 1,
    @OrderDate = '1997-07-01',
    @RequiredDate = '1997-07-10', 
    @ShipVia = 10,
    @Freight = 50.00;

select * from Orders
where CustomerID = 'ALFKI'
order by CustomerID 
-- Insercion exitosa de un pedido
execute sp_RegistrarNuevoPedido
    @CustomerID = 'ALFKI',
    @EmployeeID = 5,
    @OrderDate = '1997-07-01',
    @RequiredDate = '1997-07-10', 
    @ShipVia = 2,
    @Freight = 74.00;

rollback transaction;

