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

---
next: [[]]
tags: [[bd]]