# 📄 Consultas Básicas y Algunas Avanzadas en la Base de Datos

Este documento está diseñado para ayudar a comprender y documentar los diferentes tipos de consultas SQL realizadas sobre la base de datos, clasificadas entre **consultas básicas** y algunas **consultas avanzadas**.

---

## 🔹 Consultas Básicas

### 1. Mostrar Tablas Completas

```sql
select * from Customers;
select * from Employees;
select * from Orders;
select * from Suppliers;
select * from Products;
select * from Shippers;
select * from Categories;
select * from [Order Details];
```

---

### 2. Proyección de Campos

```sql
select ProductID, ProductName, UnitPrice, UnitsInStock from products;
select EmployeeID, FirstName, Title, City, Country from Employees;
```

---

### 3. Alias en Columnas

```sql
select EmployeeID as 'Numero Empleado',
FirstName as 'PrimerNombre', Title as 'Cargo', City as 'Ciudad', Country as 'Pais' from Employees;
```

---

### 4. Campos Calculados

```sql
select *, (UnitPrice * Quantity) as 'Importe' from [Order Details];
```

---

### 5. Descomposición de Fechas

```sql
select OrderDate, year(OrderDate) as 'Año', MONTH(OrderDate) as 'Mes', day(OrderDate) as 'Día', CustomerID, EmployeeID from Orders;
```

---

### 6. Eliminación de Duplicados

```sql
select distinct Country as 'Paises donde se encuentran clientes' from Customers order by country;
```

---

### 7. Filtros Simples con WHERE

```sql
select * from Customers where CustomerID = 'BOLID';
select * from Customers where Country = 'Germany';
select * from Customers where Country != 'Germany';
select * from Products where UnitPrice > 100;
select * from Orders where YEAR(OrderDate) = '1996';
select * from [Order Details] where Quantity > 40;
```

---

## 🔸 Consultas Avanzadas

---

### 1. Uso de Funciones de Texto y Formato

```sql
select (FirstName + '  ' + LastName) as 'Nombre del empleado' ...
select Concat(FirstName, '  ', LastName) as [Nombre del empleado] ...
```

---

### 2. Comparaciones Avanzadas con Fechas y Condiciones

```sql
select * from Employees where YEAR(HireDate) > '1993';
select * from Employees where ReportsTo != 2;
select * from Employees where ReportsTo is null;
```

---

### 3. Uso de Operadores Lógicos (`AND`, `OR`, `NOT`)

```sql
select * from Products where UnitPrice >= 10 and UnitPrice <= 50;
select * from Orders where NOT ShipCountry = 'Germany';
select * from Customers where Country = 'Mexico' or Country = 'USA';
select * from Employees where City = 'London' and (year(BirthDate) between 1955 and 1958);
select * from Orders where Freight > 100 and (ShipCountry = 'Spain' or ShipCountry = 'France');
```

---

### 4. Límite de Registros

```sql
select top 10 * from Orders;
```

---

### 5. Condiciones Compuestas Complejas

```sql
select * from Products
where Discontinued != 1 and UnitPrice between 10 and 50 and UnitsInStock >= 20;

select * from Orders
where Freight < 50 and (ShipCountry = 'Germany' or ShipCountry = 'France');

select * from Customers
where not (Country = 'Mexico' or Country = 'USA') and fax is not null;

select * from Orders
where Freight > 100 and (ShipCountry = 'Brazil' or ShipCountry = 'Argentina') and ShippedDate is null;
```

---

Este documento sirve como referencia para comprender y diferenciar entre las consultas **básicas** (proyecciones, alias, filtros simples) y el comienzo de algunas consultas **avanzadas** (funciones, condiciones complejas, operadores lógicos múltiples) en SQL con la base de datos Northwind.
