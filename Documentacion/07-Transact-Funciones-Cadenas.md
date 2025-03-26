# 📄 Funciones de Cadena

Este documento describe el uso de **funciones de cadena** en SQL Server. Estas funciones permiten manipular y transformar valores de texto (`varchar`, `nvarchar`, `char`, `nchar`).

---

## 🔹 Variables y Uso Básico

```sql
DECLARE @numero int;
SET @numero = 10;
PRINT @numero;
```

```sql
DECLARE @Texto varchar(50) = 'Hola, Mundo!';
```

---

## 🔹 Funciones de Texto

### 1. `LEN()`

Devuelve la longitud de una cadena:

```sql
SELECT LEN(@Texto) AS [Longitud];
```

---

### 2. `LEFT()` y `RIGHT()`

Extraen caracteres desde el inicio o el final de la cadena:

```sql
SELECT LEFT(@Texto, 4) AS Inicio;
SELECT RIGHT(@Texto, 6) AS Final;
```

---

### 3. `SUBSTRING()`

Extrae parte de la cadena a partir de una posición y longitud:

```sql
SELECT SUBSTRING(@Texto, 7, 4);
```

---

### 4. `REPLACE()`

Reemplaza una subcadena por otra:

```sql
SELECT REPLACE(@Texto, 'Mundo', 'Amigo');
```

---

### 5. `CHARINDEX()`

Devuelve la posición de una subcadena dentro de otra:

```sql
SELECT CHARINDEX('Hola', @Texto);
```

---

### 6. `UPPER()` y `LOWER()`

Convierte cadenas a mayúsculas o minúsculas:

```sql
SELECT UPPER(@Texto) AS Mayusculas;
```

---

### 7. `CONCAT()`

Combina múltiples expresiones de texto:

```sql
SELECT CONCAT(
  LEFT(@Texto, 6),
  UPPER(SUBSTRING(@Texto, 7, 5)),
  RIGHT(@Texto, 1)
) AS Textonuevo;
```

---

### 8. `TRIM()`, `LTRIM()`, `RTRIM()`

Eliminan espacios en blanco al inicio, final o ambos lados de la cadena:

```sql
SELECT TRIM('   test   ') AS Resultado;
SELECT LTRIM('     Inicio') AS Resultado;
SELECT RTRIM('Fin     ') AS Resultado;
```

---

## 🔹 Ejemplo Aplicado en una Tabla

Actualizar nombres de compañía a mayúsculas:

```sql
UPDATE Customers
SET CompanyName = UPPER(CompanyName)
WHERE Country IN ('Mexico', 'Germany');
```

Obtener análisis de texto por columna:

```sql
SELECT
  CompanyName,
  LEN(CompanyName) AS 'Numero de Caracteres',
  LEFT(CompanyName, 4) AS Inicio,
  RIGHT(CompanyName, 6) AS Final,
  SUBSTRING(CompanyName, 7, 4) AS 'SubCadena'
FROM Customers;
```

---

Estas funciones son esenciales para el manejo de datos de tipo texto en SQL Server, especialmente cuando se trabaja con información como nombres, direcciones, códigos, etc.
