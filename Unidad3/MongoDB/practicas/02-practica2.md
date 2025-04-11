# Práctica 2: MongoDB

## Consultas

### 1. **Cargar el archivo empleados.json**

```json
db.empleados.insertMany([
{
"nombre": "Gregory",
"apellidos": "Juarez",
"correo": "nisi.mauris.nulla@google.edu",
"direccion": "2727 Nec, St.",
"region": "Mizoram",
"pais": "Norway",
"empresa": "Google",
"ventas": 26890,
"salario": 3265,
"departamentos": "Legal Department, Accounting, Media Relations, Research and Development"
},
{
"nombre": "Candace",
"apellidos": "Buck",
"correo": "donec.dignissim@google.ca",
"direccion": "Ap #559-7631 Donec Road",
"region": "Møre og Romsdal",
"pais": "India",
"empresa": "Google",
"ventas": 1023,
"salario": 6657,
"departamentos": "Asset Management, Sales and Marketing, Media Relations"
},
...
{
"nombre": "Brady",
"apellidos": "Castillo",
"correo": "suscipit.nonummy.fusce@yahoo.com",
"direccion": "1321 Suspendisse Ave",
"region": "Magallanes y Antártica Chilena",
"pais": "Italy",
"empresa": "Google",
"ventas": 14054,
"salario": 5272,
"departamentos": "Quality Assurance, Human Resources, Advertising, Sales and Marketing"
}
])
```

---

### 2. **Usar la base de datos cursos**

```json
use cursos
```

---

### 3. _Buscar empleados que trabajen en Google_

```json
db.empleados.find({
empresa: "Google"
})
```

---

### 4. _Empleados que vivan en Perú_

```json
db.empleados.find({
pais: "Peru"
})
```

---

### 5. _Empleados que ganen más de $8000_

```json
db.empleados.find({
salario: { $gt: 8000 }
})
```

---

### 6. _Empleados con salario menor a $8000_

```json
db.empleados.find({
salario: { $lt: 8000 }
})
```

---

### 7. _Consulta anterior pero devolviendo una sola fila_

```json
db.empleados.findOne({
salario: { $lt: 8000 }
})
```

---

### 8. **Empleados que trabajen en Google o Yahoo (uso de $in)**

```json
db.empleados.find({
empresa: { $in: ["Google", "Yahoo"] }
})
```

---

### 9. _Empleados de Amazon que ganen más de $9000_

```json
db.empleados.find({
empresa: "Amazon",
salario: { $gt: 9000 }
})
```

---

### 10. **Empleados que trabajen en Google o Yahoo (uso de $or)**

```json
db.empleados.find({
$or: [
{ empresa: "Google" },
{ empresa: "Yahoo" }
]
})
```

---

### 11. _Yahoo con salario > $6000 o Google con ventas < 20000_

```json
db.empleados.find({
$or: [
{ empresa: "Yahoo", salario: { $gt: 6000 } },
{ empresa: "Google", ventas: { $lt: 20000 } }
]
})
```

---

### 12. _Mostrar nombre, apellidos y país de los empleados_

```json
db.empleados.find(
{},
{
nombre: 1,
apellidos: 1,
pais: 1,
\_id: 0
}
)
```

---
