# 📄 Consultas Avanzadas

Este documento está diseñado para ayudar a comprender y documentar los diferentes tipos de consultas avanzadas SQL.

---

## 🚩 Consultas Avanzadas

### 1. Consultas con Funciones de Texto y Fechas

l
Uso de funciones como CONCAT, YEAR, MONTH, DAY y formatos especiales.

```sql
select concat(FirstName, ' ', LastName) as 'Empleado' from Employees;
select YEAR(OrderDate) from Orders;
```

---

### 2. Uso de Operadores Lógicos (AND, OR, NOT)

```sql
select * from Products where UnitPrice >= 10 and UnitPrice <= 50;
select * from Customers where Country = 'Mexico' or Country = 'USA';
select * from Orders where NOT ShipCountry = 'Germany';
```

---

### 3. Uso de TOP para limitar resultados

```sql
select top 10 * from Orders;
```

---

### 4. Consultas con Rangos: BETWEEN

```sql
select * from Products where UnitPrice between 10 and 50;
select OrderDate from Orders where OrderDate between '1997-01-01' and '1997-06-30';
```

---

### 5. Consultas con listas: IN

```sql
select * from Products where CategoryID in (1,3,5);
select * from Orders where ShipRegion in('RJ','Táchira') or ShipRegion is null;
```

---

### 6. Consultas con Patrones: LIKE

```sql
select ProductName from Products where ProductName like 'Cha%';
select ProductName from Products where ProductName like '%e';
```

---

### 7. Ordenar resultados: ORDER BY

```sql
select ProductName, UnitPrice from Products order by UnitPrice desc;
select Country, City from Customers order by Country asc, City desc;
```

---

## 🚩 Consultas con JOIN (INNER JOIN, LEFT JOIN, RIGHT JOIN, FULL JOIN)

### Inner Join Básico

```sql
select p.ProductName, c.CategoryName from Products p
inner join Categories c on p.CategoryID = c.CategoryID;
```

---

### Inner Join con condiciones complejas y agregados

```sql
select c.CategoryName, sum(od.Quantity) as 'Total Vendido'
from Categories c
inner join Products p on c.CategoryID = p.CategoryID
inner join [Order Details] od on od.ProductID = p.ProductID
group by c.CategoryName;
```

---

### Consultas Agregadas con GROUP BY y HAVING

```sql
select EmployeeID, count(OrderID) from Orders
group by EmployeeID
having count(OrderID) > 10;
```

---

### Consultas que combinan múltiples tablas (Inner Joins múltiples)

```sql
select concat(e.FirstName, ' ', e.LastName) as Empleado, count(o.OrderID) as TotalOrdenes
from Employees e
inner join Orders o on e.EmployeeID = o.EmployeeID
inner join [Order Details] od on od.OrderID = o.OrderID
group by e.FirstName, e.LastName;
```

---

### Consultas avanzadas con LEFT, RIGHT, FULL y CROSS JOIN

**Left Join**

```sql
select c.CategoryName, p.ProductName
from Categories c
left join Products p on p.CategoryID = c.CategoryID;
```

**Right Join, Full Join y Cross Join** _(Ejemplos típicos)_

---

### Ejemplos específicos documentados:

- Ventas por categoría
- Ventas totales por empleado
- Pedidos realizados por cliente
- Pedidos gestionados por empleado específico
- Productos por proveedor
- Cantidad de envíos por empresa de transporte
- Clientes con múltiples productos pedidos
- Ingresos generados por categoría
- Gastos totales por cliente
- Pedidos realizados en rangos de fecha específicos

Cada uno de estos ejemplos ha sido claramente ilustrado en el código SQL adjunto.

---

Este documento sirve como referencia avanzada para realizar consultas SQL complejas usando la base de datos Northwind, enfocándose en técnicas de unión, agregación, filtros avanzados y agrupaciones detalladas.
