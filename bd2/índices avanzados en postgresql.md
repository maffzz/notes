## limitaciones del b+ tree
- óptimo para igualdad (`=`) y orden (`<`, `>` y `BETWEEN`)
- no es eficiente en búsqueda por similitud o intersección
- no funciona bien con arrays, jsonb o datos espaciales
- pueden ser grandes y costosos en inserciones masivas
## brin (block range index)
> es un mapeo no se necesita una estructura de datos
- almacena resúmenes de bloques de datos (min/máx)
- ideal para tablas grandes con ordenamiento natural (fechas)
- muy compactos y rápidos de construir
- consultas aproximadas que reducen la cantidad de bloques leídos

| page range | value range |
| ---------- | ----------- |
| 1-2        | año1 - año2 |
| 3-4        | año3 - año4 |
- diferencia con el b+ tree : el árbol es una desventaja que brin arregla. con una sola lectura ya tienes el mapeo
## gist (generalized search tree)
> índice genérico
- soporta múltiples tipos de consultas: igualdad, rango, proximidad
- índices para datos espaciales : PostGIS, texto completo, etc
- estructura de árbol balanceado como b-tree
- flexible y extensible mediante operadores personalizados
- soporta estructuras como r-tree y inverted index
## sp-gist (space-particioned gist)
- se basa en particiones del espacio
- aaa
## problema de las escalas

### two-phase multiway merge sort

`SELECT * FROM R ORDER BY R.a`
- pero no hay ningún índice en R.a
- pero la tabla R es muy grande
- pero la memoria RAM es muy limitada

 leer M páginas en memoria
2. ordenar internamente (no importa con qué algoritmo)
3. escribir como run ordenado en el disco
4. hacer merge de páginas hasta que todo esté ordenado

> asumiendo 3 buffers

1. tomar cada página, ordenar y regresar
L = 1 -> 2^1 = 2
2. tomar de dos en dos y vaciar cuando se llene el buffer y continuar
3. así con todo lol
4. regresar con ese orden
L = 2 -> 2^2 = 4
5. tomar de cuatro en cuatro pero como solo tenemos 2 buffers en RAM -> tomar primero de cada bloque de dos
	1. si se vacía algún buffer, automáticamente sacar la siguiente de la parte correspondiente
6. así con todo lol
7. regresar con ese orden
L = 3 -> 2^3 = 8
8. tomar de ocho en ocho pero como solo tenemos 2 buffers en RAM -> tomar primero de cada bloque de cuatro
	1. si se vacía algún buffer, automáticamente sacar la siguiente de la parte correspondiente
9. así con todo lol
10. regresar con ese orden

> pero con 3 buffers desperdiciamos mucha memoria

si tienes una cantidad n de listas ordenadas y tienes q generar una lista ordenada tmb q haces ¿? ns chau -> min-heap
### external hashing

`SELECT R.a, COUNT(*) FROM R ORDER BY R.a`
- pero no hay ningún índice en R.a
- pero la tabla R es muy grande
- pero la memoria RAM es muy limitada
-> índice no agrupado sobre R.a

1. particionar por páginas -> # páginas equivalente a la RAM disponible
	B buffers disponible -> B-1 buffers 
2. llevar página por página a la RAM 
3. aplicar hash en el atributo R.a % B-1 registro pot registro
4. colocar en el bucket resultante
5. hacer eso para todas las páginas
6. si un bucket se llena -> se manda al disco y se produce un chaining de buckets
construcción del resultado:
7. partición por partición se lleva a la RAM y se hacen los conteos

> con eso separamos los valores en espacios similares en el hash

### ejercicios

`select * from r, s where r.a = s.a`
de las dos tablas hacer las tablas hash y al unir juntas en los buffers y escribir junto

`select distinct name from users`
mismo que arriba solo que en los conteos solo contar una vez cada uno

---
next: [[bases de datos espaciales]]
tags: [[bd]]