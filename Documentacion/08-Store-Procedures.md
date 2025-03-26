# 📄 Procedimientos Almacenados (Stored Procedures)

Este documento describe la creación, ejecución y uso de **procedimientos almacenados (store procedures)** en SQL Server.

---

## 🔹 1. Procedimientos Básicos

### Mostrar todos los clientes

```sql
CREATE OR ALTER PROCEDURE spu_mostrar_clientes
AS
BEGIN
    SELECT * FROM Customers;
END;
GO

EXEC spu_mostrar_clientes;
```

---

### Mostrar clientes por país (con parámetros de entrada)

```sql
CREATE OR ALTER PROCEDURE spu_customersporpais
@pais NVARCHAR(15),
@pais2 NVARCHAR(16)
AS
BEGIN
    SELECT * FROM Customers
    WHERE Country IN (@pais, @pais2);
END;

EXEC spu_customersporpais 'Spain', 'Germany';
```

---

## 🔹 2. Procedimientos con Parámetros y Fechas

### Reporte de órdenes por rango de años

```sql
CREATE OR ALTER PROCEDURE sp_datos_de_compra
@NumerodeOrden INT,
@OrdenFecha DATETIME,
@Total MONEY
AS
SELECT * FROM VistaOrdenesdeCompra
WHERE YEAR([Fecha de Orden]) IN (1996,1998);
```

---

### Informe de ventas por cliente y rango de fechas

```sql
CREATE OR ALTER PROCEDURE spu_informe_ventas_clientes
@nombre NVARCHAR(40) = 'Berglunds snabbköp',
@fechaInicial DATETIME,
@fechaFinal DATETIME
AS
BEGIN
    SELECT [Nombre Producto], [Nombre Cliente],
    SUM(importe) AS [Monto Total]
    FROM VistaOrdenesdeCompra
    WHERE [Nombre Cliente] = @nombre
    AND [Fecha de Orden] BETWEEN @fechaInicial AND @fechaFinal
    GROUP BY [Nombre Producto], [Nombre Cliente];
END;
```

---

## 🔹 3. Parámetros de Salida

### Obtener número de clientes por ID

```sql
CREATE OR ALTER PROCEDURE spu_obtener_numero_clientes
@customerid NCHAR(5),
@totalCustomers INT OUTPUT
AS
BEGIN
    SELECT @totalCustomers = COUNT(*) FROM Customers
    WHERE CustomerID = @customerid;
END;

DECLARE @numero INT;
EXEC spu_obtener_numero_clientes @customerid= 'ANATR', @totalCustomers = @numero OUTPUT;
PRINT @numero;
```

---

## 🔹 4. Validaciones y Condicionales

### Verificar calificación de alumno

```sql
CREATE OR ALTER PROCEDURE spu_comparar_calificacion
@calif DECIMAL(10,2)
AS
BEGIN
    IF @calif >= 0 AND @calif <= 10
        IF @calif >= 8
            PRINT 'La calificación es aprobatoria';
        ELSE
            PRINT 'La calificación es reprobatoria';
    ELSE
        PRINT 'Calificación no válida';
END;
```

---

### Verificar si un cliente existe antes de mostrarlo

```sql
CREATE OR ALTER PROCEDURE spu_obtener_cliente_siexiste
@numeroCliente NCHAR(5)
AS
BEGIN
    IF EXISTS (SELECT 1 FROM Customers WHERE CustomerID = @numeroCliente)
        SELECT * FROM Customers WHERE CustomerID = @numeroCliente;
    ELSE
        PRINT 'El cliente no existe';
END;
```

---

## 🔹 5. Procedimientos para Insertar Datos

### Insertar un cliente si no existe

```sql
CREATE OR ALTER PROCEDURE spu_agregar_cliente
@id NCHAR(5),
@nombre NVARCHAR(40),
@city NVARCHAR(15) = 'San Miguel'
AS
BEGIN
    IF EXISTS (SELECT 1 FROM Customers WHERE CustomerID = @id)
    BEGIN
        PRINT 'El cliente ya existe';
        RETURN 1;
    END

    INSERT INTO Customers(CustomerID, CompanyName)
    VALUES(@id, @nombre);
    PRINT 'Cliente insertado exitosamente';
    RETURN 0;
END;
```

---

### Insertar cliente con manejo de errores (TRY...CATCH)

```sql
CREATE OR ALTER PROCEDURE spu_agregar_cliente_try_catch
@id NCHAR(5),
@nombre NVARCHAR(40),
@city NVARCHAR(15) = 'San Miguel'
AS
BEGIN
    BEGIN TRY
        INSERT INTO Customers(CustomerID, CompanyName)
        PRINT 'Cliente insertado exitosamente';
    END TRY
    BEGIN CATCH
        PRINT 'El cliente ya existe';
    END CATCH
END;
```

---

## 🔹 6. Uso de Ciclos

### Imprimir números en un ciclo WHILE

```sql
CREATE OR ALTER PROCEDURE spu_ciclo_imprimir
@numero INT
AS
BEGIN
    IF @numero <= 0
    BEGIN
        PRINT 'El número no puede ser 0 o negativo';
        RETURN;
    END

    DECLARE @i INT = 1;
    WHILE (@i <= @numero)
    BEGIN
        PRINT CONCAT('Número ', @i);
        SET @i = @i + 1;
    END
END;
```

---

Este documento proporciona ejemplos clave para crear y utilizar procedimientos almacenados en SQL Server, cubriendo desde los más simples hasta técnicas más avanzadas con condiciones, errores y ciclos.
