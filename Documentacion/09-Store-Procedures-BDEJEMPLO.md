# 📄 Ejemplos Prácticos para Estudio de Store Procedures

Este documento reúne **ejemplos reales y prácticos** utilizados para estudiar procedimientos almacenados en SQL Server, centrados en validaciones, transacciones, ciclos, errores, `JOINs`, y creación de vistas. Fue una pieza clave para el desarrollo de habilidades prácticas en la preparación de mi examen sobre store procedures y views.

---

## 🛒 1. Procedimiento para Registrar un Pedido

- Valida que el pedido no exista.
- Verifica la existencia de cliente, representante, producto.
- Comprueba que haya stock suficiente.
- Calcula importe.
- Inserta pedido y actualiza stock.

```sql
EXEC spu_pedido_submit @numpedido = 113070, @cliente = 2117, @rep = 107,
@fab = 'ACI', @producto = '4100X', @cantidad = 20;
```

---

## 🧾 2. Registrar Nuevo Cliente

- Evita duplicados.
- Verifica existencia del representante.
- Valida crédito.
- Usa TRY...CATCH.

```sql
EXEC spu_registrar_cliente_nuevo @numcli = 2127, @empresa = 'Azulejo Corp',
@repcli = 102, @limcredito = 78000;
```

---

## 📈 3. Actualización de Cuotas con Validaciones y Auditoría

- Verifica existencia.
- Valida cuota > 0 y mayor que ventas actuales.
- Inserta registro en tabla `Historial_Cuotas`.

```sql
EXEC spu_nuevas_cuotas @numempleado = 102, @nuevacuota = 491000;
```

---

## ❌ 4. Cancelación de Pedidos

- Verifica existencia.
- Valida cliente.
- Revierte stock solo si no ha sido alterado manualmente.

```sql
EXEC spu_cancelar_pedido @numpedido = 112961;
```

---

## 📊 5. Reporte de Desempeño por Representante

- Total de pedidos, productos vendidos, ventas.
- Cumplimiento de cuota.
- Muestra "Sin Ventas" si es necesario.

```sql
EXEC spu_reporte_desempeño @numempleado = 104;
```

---

## 👁 6. Vistas Relevantes

- **vw_Pedidos_Detallados**: Información completa de cada pedido.
- **vw_Cumplimiento_Cuotas**: Evaluación de cuotas cumplidas o no.
- **vw_Stock_Critico**: Productos con bajo stock.
- **vw_Ventas_Anuales**: Análisis por año con crecimiento.
- **vw_Nivel_Credito_Clientes**: Clasificación de clientes según uso del crédito.
- **vw_Productos_Mas_Vendidos**: Ranking de productos.
- **vw_Eficiencia_Representantes**: Desempeño comparado con la media.

---

## 🔁 7. Store Procedures con LEFT JOIN y RIGHT JOIN

- `spu_Clientes_Sin_Pedidos`
- `spu_Representantes_Sin_Ventas`
- `spu_Pedidos_Sin_Cliente`

---

## 🧠 8. Vistas Especiales de Apoyo

- `vw_Clientes_Ultimo_Pedido`: Último pedido por cliente.
- `vw_Representantes_Ventas`: Total de ventas por representante.
- `vw_Productos_Sin_Ventas`: Productos nunca vendidos.

---

## ✅ Conclusión

Este archivo fue clave para:

- Aprender validaciones complejas con SQL Server.
- Aplicar lógica condicional, control de errores y transacciones.
- Implementar prácticas reales usadas en entornos laborales.
- Estudiar eficientemente para el examen y fortalecer bases sólidas para el trabajo diario.

📚 **Recomendación**: Guardar este documento como referencia continua para prácticas avanzadas de SQL.

---
