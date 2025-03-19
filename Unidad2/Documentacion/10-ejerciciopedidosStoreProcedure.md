# Ejercicio: Gestión de Pedidos con Stored Procedure

Este ejercicio consiste en la implementación de un **procedimiento almacenado (Stored Procedure)** para gestionar pedidos en un sistema de ventas. El procedimiento debe realizar las siguientes validaciones y operaciones:

## 📌 Validaciones previas al registro del pedido

1. **Verificación de existencia del pedido:** Antes de registrar un nuevo pedido, se debe comprobar que no exista previamente en la base de datos.
2. **Disponibilidad de stock:** La cantidad solicitada debe compararse con el stock disponible del producto.
3. **Validación de entidades:** Se debe confirmar que el **cliente**, el **empleado** que realiza el pedido y el **producto** existan en el sistema.

## ⚙️ Operaciones a realizar al registrar el pedido

1. **Cálculo del importe total:**
   - Se debe insertar el pedido en la base de datos.
   - Se calculará el importe total **multiplicando el precio del producto por la cantidad solicitada**.
2. **Actualización del stock:**
   - Una vez registrado el pedido, se actualizará el stock del producto.
   - Se restará del stock disponible la cantidad vendida.

---

📌 **Este ejercicio ayuda a comprender cómo utilizar procedimientos almacenados para gestionar la lógica de negocio en una base de datos, asegurando la integridad y eficiencia en el procesamiento de pedidos.**

# Pruebas

```sql
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
```
