# 📄 Creacion y llenado de una base de datos

---

## 🔹 1. Creación de la Base de Datos

```sql
create database tienda1;
use tienda1;
```

Se crea la base de datos `tienda1` y se establece como la base activa para trabajar.

---

## 🔹 2. Tabla: `categoria`

**Propósito**: Almacena las distintas categorías de productos.

```sql
create table categoria(
  categoriaid int not null,
  nombre varchar(20) not null,
  constraint pk_categoria primary key(categoriaid),
  constraint unico_nombre unique(nombre)
);
```

**Restricciones**:

- `PRIMARY KEY`: `categoriaid`
- `UNIQUE`: `nombre`

**Inserciones iniciales**:

```sql
insert into categoria values(1, 'Carnes Frias');
insert into categoria(categoriaid, nombre) values(2, 'Linea Blanca');
insert into categoria(nombre, categoriaid) values('Vinos y Licores', 3);
...
```

---

## 🔹 3. Tabla: `producto1`

**Propósito**: Almacena información de los productos que vende la tienda.

```sql
create table producto1(
  productoid int not null,
  nombreProducto varchar(20) not null,
  descripcion varchar(80),
  precio money not null,
  existencia int not null,
  categoriaid int,
  constraint pk_producto1 primary key(productoid),
  constraint unico_descripcion unique(nombreProducto),
  constraint chk_precio check (precio > 0.0 and precio <= 1000),
  constraint chk_existencia check(existencia > 0 and existencia <= 200),
  constraint fk_categoria_producto1 foreign key (categoriaid) references categoria(categoriaid)
);
```

**Restricciones**:

- `PRIMARY KEY`: `productoid`
- `UNIQUE`: `nombreProducto`
- `CHECK`: Rango válido de `precio` y `existencia`
- `FOREIGN KEY`: `categoriaid` → `categoria(categoriaid)`

**Inserciones iniciales**:

```sql
insert into producto1 values (1, 'Miguelito', 'Dulce sano para la lombriz', 34.5, 45, 5);
...
```

---

## 🔹 4. Tabla: `cliente`

**Propósito**: Almacena información de los clientes.

```sql
create table cliente(
  clienteid int not null identity(1,1),
  codigocliente varchar(15) not null,
  nombre varchar(30) not null,
  direccion varchar(100) not null,
  telefono varchar(19),
  constraint pk_cliente primary key(clienteid),
  constraint unico_codigocliente unique (codigocliente)
);
```

**Restricciones**:

- `PRIMARY KEY`: `clienteid`
- `UNIQUE`: `codigocliente`
- `IDENTITY`: Autoincremento para `clienteid`

---

## 🔹 5. Tabla: `ordencompra`

**Propósito**: Almacena las órdenes de compra realizadas por los clientes.

```sql
create table ordencompra(
  ordenid int not null identity(1,1),
  fechacompra date not null,
  cliente int not null,
  constraint pk_ordencompra primary key (ordenid),
  constraint fk_ordencompra_cliente foreign key (cliente) references cliente(clienteid)
);
```

**Restricciones**:

- `PRIMARY KEY`: `ordenid`
- `FOREIGN KEY`: `cliente` → `cliente(clienteid)`

---

## 🔹 6. Tabla: `detalleorden`

**Propósito**: Representa los productos comprados en cada orden (relación muchos a muchos entre `producto1` y `ordencompra`).

```sql
create table detalleorden (
  ordenfk int not null,
  productofk int not null,
  preciocompra money not null,
  cantidad int not null,
  constraint pk_detallorden primary key (ordenfk, productofk),
  constraint chk_preciocompra check (preciocompra > 0.0 and preciocompra <= 20000),
  constraint chk_cantidad check (cantidad > 0),
  constraint fk_detalleorden_producto foreign key (productofk) references producto1(productoid)
);
```

**Restricciones**:

- `PRIMARY KEY COMPUESTA`: (`ordenfk`, `productofk`)
- `CHECK`: Validación de `preciocompra` y `cantidad`
- `FOREIGN KEY`: `productofk` → `producto1(productoid)`

**Relación con `ordencompra`** (agregada posteriormente):

```sql
alter table detalleorden
add constraint fk_detalleorden_ordencompra foreign key (ordenfk) references ordencompra(ordenid);
```

---

## 🧩 Diagrama Relacional (Resumen)

- **categoria** 1 ──── \* **producto1**
- **cliente** 1 ──── \* **ordencompra**
- **ordencompra** 1 ──── _ **detalleorden** _ ──── 1 **producto1**
