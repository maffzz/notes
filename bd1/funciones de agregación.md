# 🔍 ¿qué son?

las **funciones de agregación** se utilizan en álgebra relacional **extendida** para realizar **operaciones de resumen** sobre los datos. no forman parte del álgebra relacional básica, pero son muy comunes en consultas reales (como en SQL)

sirven para:

- contar tuplas
- calcular sumas, promedios
- encontrar máximos o mínimos
- agrupar datos y aplicar funciones sobre grupos

---

# 📦 funciones de agregación disponibles:

| función | qué hace                      | ejemplo práctico                   |
| ------- | ----------------------------- | ---------------------------------- |
| `COUNT` | cuenta el número de tuplas    | ¿cuántos empleados hay?            |
| `SUM`   | suma de los valores numéricos | ¿cuál es la suma total de sueldos? |
| `AVG`   | promedio de valores numéricos | ¿cuál es el salario promedio?      |
| `MIN`   | mínimo valor de una columna   | ¿cuál es la edad más baja?         |
| `MAX`   | máximo valor de una columna   | ¿cuál es el salario más alto?      |

---

# 📘 notación: operador gamma (𝛾)

la sintaxis básica es:

```
𝛾 atributos_de_agrupación, función(atributo) (relación)
```

- si se omiten los atributos de agrupación, se aplica a toda la tabla
- si se incluyen atributos, se agrupa por ellos

---

## 📁 supongamos esta tabla `empleados`:

|id|nombre|departamento|salario|edad|cargo|
|---|---|---|---|---|---|
|1|ana|ventas|3000|30|vendedora|
|2|bruno|ventas|3200|35|vendedor|
|3|carla|TI|5000|40|ingeniería TI|
|4|david|TI|5200|28|ingeniería TI|
|5|elena|recursos|4000|50|gerente RRHH|

### ejemplo 1: ¿cuántos empleados hay?

```
𝛾 COUNT(*) (empleados)
```

📌 **explicación paso a paso:**

1. no hay agrupación → cuenta todas las filas
2. `COUNT(*)` devuelve el total de tuplas

✅ **resultado:**

|count|
|---|
|5|

### ejemplo 2: ¿cuál es el salario total?

```
𝛾 SUM(salario) (empleados)
```

**📌 explicación:**

- suma todos los valores de la columna `salario`

**✅ resultado:**

|sum_salario|
|---|
|20400|

### ejemplo 3: promedio de salario por departamento

```
𝛾 departamento, AVG(salario) (empleados)
```

📌 **paso a paso:**

1. agrupa las tuplas por el campo `departamento`
2. calcula el promedio de salario dentro de cada grupo

**✅ resultado:**

|departamento|avg_salario|
|---|---|
|ventas|3100|
|TI|5100|
|recursos|4000|

### ejemplo 4: edad mínima por cargo

```
𝛾 cargo, MIN(edad) (empleados)
```

📌 **paso a paso:**

1. agrupa por el campo `cargo`
2. aplica la función `MIN` sobre `edad` para cada grupo

**✅ resultado:**

|cargo|min_edad|
|---|---|
|vendedora|30|
|vendedor|35|
|ingeniería TI|40|
|ingeniería TI|28|
|gerente RRHH|50|

### ejemplo 5: para cada departamento, obtener el número de empleados y el salario máximo

```
𝛾 departamento, COUNT(*), MAX(salario) (empleados)
```

📌 **paso a paso:**

1. agrupa por `departamento`
2. calcula cuántos empleados hay por grupo (`COUNT(*)`)
3. encuentra el salario más alto por grupo (`MAX(salario)`)

**✅ resultado:**

|departamento|count|max_salario|
|---|---|---|
|ventas|2|3200|
|TI|2|5200|
|recursos|1|4000|

---
## ⚠️ consideraciones Importantes:

- **COUNT()** incluye todas las tuplas, incluso si hay valores `null`. si tu álgebra considera `nulls`, puede cambiar
- puedes **combinar varias funciones** de agregación en una sola operación
- si necesitas **filtrar antes de agrupar**, puedes hacer una **selección (σ)** previa:

ejemplo:

```
𝛾 departamento, AVG(salario) (σ edad > 30 (empleados))
```

✅ calcular el salario promedio por departamento **solo de empleados mayores de 30 años**

---
next: [[structured query language]]
tags: [[bd]]