- ¿cómo se deberían guardar las tablas en memoria?
- ¿cómo se pueden optimizar las consultas sobre estas tablas?
## procesamiento de consultas

- uno dice lo que quiere, no cómo debería ser computado
- idealmente, el motor puede elegir el mejor plan de ejecución independientemente de la expresión particular de la consulta
- el usuario no tiene que preocuparse por la optimización de la consulta
### path de la consulta
consulta -> compilador -> grafo de consulta -> optimizador -> plan de ejecución -> generador de código -> modelo compilado -> procesador / tipo de ejecución -> resultado
### ¿cómo evaluar una consulta SQL?  
- análisis sintáctico: ¿está bien escrita?
- análisis semántico: ¿qué sentido tiene?
- ¿qué posibilidades tenemos para ejecutarla?
- ¿cuál es la posibilidad más conveniente (más rápida, más “barata”, etc?  
- tomar la decisión
## optimización sintáctica
### heurística
- objetivo: reducir el tamaño de las tablas intermedias
- optimizador:
	- reglas heurísticas: modifican la representación interna de la consulta  
	- después se genera un plan de ejecución
		- para ejecutar grupos de operaciones
		- según los caminos de acceso que tengan los ficheros  
- regla principal: primero ejecutar seleccionar (σ) y proyectar (π)
- al final ejecutar reunir (x) y otras operaciones binarias
- [[heuristica.png]]
### árboles

<aside> ☝ plan: árbol de operadores de álgebra relación con la elección de  
algoritmos por cada operador</aside>

#### reglas de transformación
- x + selección : join
- descomponer σ si las condiciones tiene ANDs en varias σ en cascada
	σ c1 AND c2... AND cn(R) ≡ σ c1 (σc2 (... (σ cn(R)... )
- mover las σ lo más abajo posible (lo que admitan los atributos de C). esto es posible ya que σ es conmutativa con otras operaciones
- recolocar las hojas para que los σ más restrictivos se ejecuten antes (que producen una relación con menos tuplas). esto es válido para los operadores conmutativos y asociativos: x, |x|, ∪ y ∩
- combinar × y σ en |×|
- por cada π lista descomponer lista y mover los π sublista obtenidos lo más abajo posible. crear nuevas π si es necesario
- identificar grupos de operaciones que se puedan ejecutar con un solo algoritmo (es decir, con un solo recorrido a los ficheros implicados)
## optimización física

### sistema de costos

- bloques transferidos: depende de las estructuras de acceso y de la colocación de los bloques (contiguos, mismo cilindro, dispersos)  
- ficheros intermedios generados
- cómputos en memoria sobre los ficheros intermedios: búsqueda, ordenación, fusión, cálculos
- comunicación: envío de la consulta y recepción del resultado
**coste principal:**  
- BD grandes: bloques transferidos (generalmente se usa este)
- BD pequeñas (entran en memoria): cómputos
- BD distribuidas: comunicación
#### memoria principal vs memoria secundaria

**memoria principal:**
- datos guardados en memoria secundaria
- la lectura se hace por bloques
- un bloque tiene un tamaño de B tuplas

**memoria secundaria:**
- los datos son llevados a memoria principal
- la memoria tiene una capacidad de M tuplas
#### transferencia de bloques y tuplas a RAM
- un bloque tiene un tamaño de B tuplas
- la memoria tiene una capacidad de M tuplas

¿cuánto cuesta leer n tuplas desde la memoria secundaria? -> n/B <mark class="hltr-red">techo</mark>
¿cuántos bloques caben en memoria? -> M/B <mark class="hltr-red">piso</mark>
¿cuántos bloques usa una relación R? -> |R|/B <mark class="hltr-red">techo</mark>
### búsqueda
- devolver todas las tuplas de una relación que satisfagan alguna condición
### búsqueda secuencial
- se leen todas las tuplas de la relación R
- se seleccionan las que cumplan la condición
- ¿cuántas tuplas se leen? -> |R|
- ¿cuánto cuesta en términos de bloques? -> |R|/B
### índices
- estructura los datos para facilitar búsquedas
- la llave puede ser cualquier conjunto de atributos de la tabla
### índice hash
- la llave puede ser cualquier conjunto de atributos de la tabla
- [[funcion-hash.png]]
- costo de búsqueda con índice hash para devolver <mark class="hltr-red">una tupla</mark>
	- caso ideal: O(1)
	- peor caso: O(|R|/B)
- para devolver <mark class="hltr-blue">k</mark> tuplas, debemos sumar k/B al costo
	- caso ideal: O(max(1,k/B))
- costo de búsqueda por rangos : <mark class="hltr-blue">uso de árboles B</mark>
	- buscar n valores: O(n)
	- leer todo: O(|R|/B)
### árbol B
- árbol ordenado, balanceado (h1 - h2 <= 1), chato
- a–b árbol B: los nodos internos tienen entre a y b hijos (a >= b/2)
### árbol B+
- árbol B donde se guardan las tuplas en las hojas del árbol
- las hojas guardan todas las llaves y sus valores
- se conectan las hojas para poder hacer búsquedas por rango más eficientes
- costo de búsqueda en términos de bloques leídos con memoria secundaria
	- si se guarda cada nodo como un bloque en memoria secundaria
		- O(logb(|R|/B))
		- para devolver <mark class="hltr-red">una tupla</mark>: O(logb(|R|/B) + k/B)
	- si se cachean la raíz y los nodos internos en memoria principal
		- O(k/B)
		- para devolver <mark class="hltr-red">una tupla</mark>: O(1)
## crear índices en sql
- por defecto, se crea un índice para la llave primaria de la tabla
- para crear/borrar índices sobre otros atributos

```sql
CREATE INDEX nombre ON tabla (a1,a2) -- btree por defecto
CREATE INDEX nombre ON tabla USING hash (a1,a2) -- tabla hash
DROP INDEX nombre
```
## joins (algoritmos)
### loop anidado (sin índices)

```sql
R ⋈ S
- ﻿﻿para cada tupla r E R
	- ﻿﻿para cada tupla s E S
		- ﻿﻿si r y s satisfacen el join: escribir {r} x {s}
```

- costo: (|R|/B + |R|) * |S|/B
- memoria: 2B tuplas
- ¿elegir R y S? |R| < |S| para ahorrar tiempo
### loop anidado (con índices)

```sql
R ⋈ S
- ﻿﻿para cada tupla r E R
	- buscar s E S en el índice tal que r y s satisfagan el join:
	  escribir {r} x {s}
```

- costo:
	B(S) = costo de buscar en S
	- (|R|/B + |R|) * B(S)
	- peor caso: (|R|/B + |R|) * |S|/B
	- mejor caso en árbol B+: (|R|/B + |R|) * O(logb(|S|/B))
	- mejor caso en hash/árbol B+: (|R|/B + |R|) * O(1)
- memoria: 2B tuplas
- ¿elegir R y S? |R| < |S| para ahorrar tiempo
### hash join

```sql
R ⋈ S
- ﻿﻿guardar S en la memoria principal
- para cada tupla r E R
	- buscar s E S en la memoria principal tal que r y s satisfagan el join:
	  escribir {r} x {s}
```

- costo: |R|/B + |S|/B
- memoria: |S| + B tuplas
- ¿elegir R y S? |R| < |S| para ahorrar tiempo

### sort-merge join

```sql
R ⋈ S
- ﻿﻿ordenar R y S por los atributos del join
- aplicar un merge-sort y para cada tupla r y s que satisfaga el join:
	escribir {r} x {s}
```

- costo:
	O = costo de ordenamiento
	- |R|/B + |S|/B + O
- memoria: 2B tuplas (una vez ordenadas)
- ¿elegir R y S? no importa
- puede ser que las relaciones ya estén ordenadas por los atributos del join. si es el caso ¡es una buena opción!
#### comparación  
- loop anidado (sin índice)
	- nunca es bueno
- loop anidado (con índice)
	- cuando el índice está disponible y
		- pocas tuplas en S satisfacen el join  
- hash-join
	- cuando R cabe en memoria y
		- muchas tuplas en S satisfacen el join  
- sort-merge join
	- cuando R y S ya están ordenados por los atributos del join y
		- muchas tuplas en ambos satisfacen el join
## optimización semántica

<aside> ☝ objetivo: optimizar la pregunta inicial</aside>

## resumen

- es importante considerar que la memoria es limitada y por ello debemos escribir consultas optimizadas
- el uso reglas heurísticas para la optimización sintáctica es crucial
- hace uso de los índices sea HASH, BTree es importante para grandes volúmenes de datos
- el uso de los algoritmos de optimización depende del tipo de índice y sobre el atributo que se le aplicó

---
next: [[transacciones y ACID]]
tags: [[bd]]