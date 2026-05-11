## 0. idea general de la clase

> no basta con guardar datos. también importa **cómo** están acomodados en disco. según la organización elegida, algunas operaciones serán más rápidas y otras más costosas

---
## 1. <mark class="hltr-green">sequential file</mark> u ordered file

un **sequential file** es un archivo donde los registros se guardan de forma **ordenada por una clave de búsqueda**, normalmente la clave primaria

ejemplo:

```text
p-102
p-231
p-250
p-452
p-587
p-612
p-682
```

### idea clave

si los registros están ordenados físicamente por la clave, entonces se puede usar **búsqueda binaria** sobre el archivo
### ventaja principal

- búsqueda eficiente: `o(log n)` accesos si se puede aplicar búsqueda binaria
### condición importante

el archivo debe mantenerse ordenado físicamente por la clave
### problema principal

mantener ese orden es caro cuando se inserta o elimina

---
## 2. búsqueda binaria en <mark class="hltr-green">sequential file</mark>

como el archivo está ordenado, se puede buscar así:

1. tomar el registro de la mitad
2. comparar su clave con la clave buscada
3. si la buscada es menor, seguir por la mitad izquierda
4. si la buscada es mayor, seguir por la mitad derecha
5. repetir hasta encontrar o agotar el rango
### complejidad

- búsqueda: `o(log n)`
### detalle importante

si hay registros marcados como eliminados, deben ignorarse durante la búsqueda.

---
## 3. problema de inserción y eliminación en <mark class="hltr-green">sequential file</mark>

aunque buscar es rápido, aparecen estas preguntas:

- ¿cómo mantener el archivo siempre ordenado?
- ¿cuál es el costo de insertar?
- ¿cuál es el costo de eliminar?
### intuición

si quieres insertar un registro en medio del archivo y mantener el orden, normalmente tendrías que:

- encontrar la posición correcta
- mover muchos registros hacia abajo

eso puede costar mucho
### costo típico

- inserción manteniendo el orden físico directo: puede llegar a `o(n)`
- eliminación física directa: también puede llegar a `o(n)` si se compacta el archivo

por eso se usan estrategias auxiliares.

---
## 4. estrategia del espacio extra o archivo auxiliar

en vez de insertar directamente dentro del archivo principal ordenado, se crea un **espacio extra** o **archivo auxiliar**.
### funcionamiento

- el archivo principal sigue ordenado
- las inserciones nuevas se guardan en el auxiliar
- la búsqueda se hace en ambos espacios
- cada cierto tiempo se reconstruye el archivo principal integrando el auxiliar
### idea práctica

esto evita reorganizar todo el archivo cada vez que entra un nuevo registro.

---
## 5. <mark class="hltr-blue">estrategia 1: auxiliar no ordenado</mark>

en esta variante:

- las nuevas inserciones se agregan al final del archivo auxiliar
- el auxiliar tiene un tamaño máximo `k`
- cuando se llena o cuando conviene, se reconstruye el archivo principal
### costos aproximados

- búsqueda:
  - búsqueda binaria en principal: `o(log n)`
  - búsqueda secuencial en auxiliar: `o(k)`
- inserción:
  - muy barata, porque solo agregas al final del auxiliar: `o(1)` amortizado
- reconstrucción:
  - más costosa, porque hay que ordenar/mezclar
### ventaja

- insertar es fácil
### desventaja

- buscar también obliga a revisar el auxiliar
- si el auxiliar crece mucho, empeora el rendimiento

---
## 6. <mark class="hltr-brown">estrategia 2: auxiliar ordenado</mark>

en esta variante:

- el auxiliar también se mantiene ordenado por la clave
### consecuencia

ahora se puede buscar tanto en el principal como en el auxiliar con búsqueda binaria
### costos aproximados

- búsqueda: `o(log n) + o(log k)`
- inserción en auxiliar ordenado:
  - puede costar `o(k)` porque hay que insertar en posición
- reconstrucción:
  - es más fácil que en el caso anterior porque ambos archivos ya están ordenados
  - se puede hacer como un merge ordenado, parecido a merge sort: `o(n + k)`
### idea importante

aquí se sacrifica inserción para mejorar búsqueda y reconstrucción

---
## 7. <mark class="hltr-yellow">estrategia 3:  registros enlazados</mark>

esta técnica mezcla:

- archivo principal
- espacio auxiliar
- punteros lógicos entre registros
### cómo funciona

1. se determina dónde debería ir el nuevo registro según la clave
2. si el lugar físico está libre, se inserta ahí
3. si no hay espacio, se guarda en el auxiliar
4. se actualizan punteros para mantener el orden lógico
5. periódicamente se reconstruye todo para volver a ordenar físicamente
### idea clave

aunque físicamente los registros queden dispersos, los **punteros** permiten recorrerlos en orden lógico
### eliminación

cuando se elimina un registro:

- no siempre se borra físicamente al instante
- se ajustan punteros para “saltarlo”
- luego, en la reconstrucción, se elimina completamente
### ventaja

- evita mover muchos registros de inmediato
### desventaja

- hay que mantener y actualizar punteros
- si se acumulan demasiados cambios, la reconstrucción se vuelve necesaria

---
## 8. reconstrucción

la reconstrucción consiste en:

- tomar registros válidos del principal
- integrar los del auxiliar
- eliminar los borrados
- generar nuevamente un archivo ordenado y limpio
### para qué sirve

- recuperar el orden físico
- eliminar fragmentación
- quitar registros marcados como eliminados
- reiniciar punteros o estructuras auxiliares

---
## 9. resumen de sequential file

### ventajas

- búsquedas eficientes
- muy bueno para recorridos ordenados
- útil para consultas por rango si el archivo está ordenado
### desventajas

- difícil de mantener con muchas inserciones y eliminaciones
- requiere reorganización periódica
- inserciones y eliminaciones suelen requerir localizar antes el registro

---
## 10. <mark class="hltr-green">bst file</mark>

la clase luego propone: ¿qué pasa si organizamos los registros como un **árbol binario de búsqueda** dentro del archivo?

eso se llama **bst file**
### estructura lógica

cada registro tiene además:

- puntero al hijo izquierdo
- puntero al hijo derecho
### regla del bst

para cada nodo:

- claves menores van al subárbol izquierdo
- claves mayores van al subárbol derecho
### complejidades

si el árbol está balanceado:

- búsqueda: `o(log n)`
- inserción: `o(log n)`
- eliminación: `o(log n)`

si el árbol se desbalancea:

- búsqueda: `o(n)`
- inserción: `o(n)`
- eliminación: `o(n)`
### problema principal

un bst simple puede degenerar si los datos llegan casi ordenados. por eso aparece la pregunta de cómo mantenerlo balanceado

---
## 11. <mark class="hltr-green">avl file</mark>

el ppt menciona la idea de mantener el árbol balanceado con un **avl file**
### idea

un avl es un bst auto-balanceado

para cada nodo:

- la diferencia de alturas entre subárbol izquierdo y derecho debe ser pequeña (máximo 1)
### beneficio

se garantiza que búsqueda, inserción y eliminación sean `o(log n)`
### costo

- insertar y eliminar requiere rotaciones y mantenimiento extra

---
## 12. agrupando registros en páginas

en la práctica, no se trabaja registro por registro aislado, sino que se agrupan en **páginas** o **bloques**
### bloque

es la unidad básica de almacenamiento físico en disco o ssd
### página

es una unidad lógica de gestión de memoria/archivo. muchas veces se usa para organizar registros de tamaño fijo
### idea importante

el archivo secuencial realmente se maneja en páginas ordenadas por la clave

---
## 13. blocking factor

cuando el tamaño del registro es menor que el tamaño del bloque, varios registros caben en un mismo bloque

el **blocking factor** indica cuántos registros entran en un bloque:

```text
b = floor(bloque / registro)
```

donde:

- `b` = cantidad máxima de registros por bloque
- `bloque` = tamaño del bloque en bytes
- `registro` = tamaño de cada registro en bytes

### ejemplo

si un bloque mide 400 bytes y cada registro 80 bytes:

```text
b = floor(400 / 80) = 5
```

entran 5 registros por bloque.

---

## 14. spanned organization

si el registro es más grande que el bloque, un solo registro puede abarcar varios bloques.

a eso se le llama **organización extendida** o **spanned organization**.

### idea

- un registro puede empezar en un bloque y continuar en otro

### para qué sirve

- permite almacenar registros grandes
- también puede ayudar a evitar espacios libres desperdiciados

---

## 15. dense index

un **índice denso** tiene una entrada para **cada registro** del archivo de datos.

### forma general

```text
clave -> ubicación exacta del registro
```

### ventaja

- búsqueda individual muy rápida

### desventaja

- el índice ocupa más espacio
- mantenerlo cuesta más al insertar o borrar

---

## 16. sparse index

un **índice sparse** tiene entradas solo para **algunos registros**, normalmente uno por página, como el primer registro de cada página.

### búsqueda con sparse index

1. buscar en el índice la página que podría contener la clave
2. ir a esa página de datos
3. buscar dentro de la página

### condición obligatoria

solo funciona bien si el archivo de datos está **ordenado**.

### ventaja

- el índice es más pequeño

### desventaja

- después de localizar la página, todavía hay que buscar dentro de ella

---

## 17. inserción en sparse index

cuando se inserta un nuevo registro pueden pasar dos cosas:

### caso 1: hay espacio en la página o en la estructura necesaria

- se divide la página si hace falta
- se actualiza la clave correspondiente en el índice

### caso 2: no hay espacio

- se crea una nueva página
- se enlaza o actualiza el índice para apuntar a la nueva página

---

## 18. multilevel index

si el archivo y el índice crecen mucho, un índice de un solo nivel puede resultar insuficiente.

entonces se usa **indexación multinivel**:

- un índice superior apunta a bloques de índices inferiores
- esos índices inferiores apuntan a datos o a niveles más bajos

### idea

es una jerarquía de índices.

---

## 19. b+ tree

el **b+ tree** combina la idea de árbol balanceado con organización pensada para disco.

### definición

es una estructura auto-balanceada que mantiene los datos ordenados y permite:

- búsquedas
- inserciones
- eliminaciones
- recorridos secuenciales
- consultas por rango

en tiempo logarítmico.

### por qué es tan bueno para bases de datos

porque reduce accesos a disco:

- cada nodo guarda muchas claves
- eso reduce la altura del árbol
- menos altura = menos i/o

---

## 20. propiedades del b+ tree

### propiedades importantes

- todos los nodos hoja están al mismo nivel
- los nodos hoja apuntan a los registros reales o a las páginas de datos
- las hojas están enlazadas entre sí
- los nodos internos forman el directorio del índice
- los nodos internos no guardan el registro completo
- cada nodo debe estar al menos medio lleno

### consecuencia

- el árbol siempre permanece balanceado
- range scans y búsquedas ordenadas son eficientes

---

## 21. clustered vs unclustered

### clustered index

un índice es **clustered** si está construido sobre el mismo atributo que define el orden físico del archivo de datos.

#### características

- solo puede haber **uno** por tabla
- los datos están físicamente ordenados por esa clave
- excelente para búsquedas por rango
- las páginas relevantes suelen leerse de forma contigua

#### idea clave

orden del índice = orden físico de los datos

### unclustered index

un índice es **unclustered** si está en una estructura separada y apunta al heap o archivo de datos desordenado.

#### características

- puede haber muchos por tabla
- muy bueno para búsquedas selectivas
- en range scans puede costar más por accesos dispersos

#### problema típico

el índice encuentra muchas referencias a páginas alejadas entre sí, lo que genera i/o aleatorio.

---

## 22. index-only scan y covering index

### index-only scan

ocurre cuando toda la información necesaria para una consulta ya está en el índice.

entonces:

- no hace falta ir al heap
- se evita el heap fetch

### covering index

es un índice no agrupado que incluye todas las columnas necesarias para resolver la consulta.

### beneficio

- mejora mucho el rendimiento en ciertas consultas

---

## 23. bitmap index scan en postgresql

cuando un índice no agrupado devuelve muchos rids dispersos, postgresql puede usar un **bitmap index scan**.

### idea

1. recorre el índice b+ tree
2. marca en memoria qué páginas del heap contienen coincidencias
3. luego lee esas páginas en orden físico

### beneficio

- evita saltos aleatorios excesivos
- mejora la lectura del heap
- reduce el problema de thrashing de caché

### además

si hay varias condiciones, se pueden combinar bitmaps con:

- `and`
- `or`

---

## 24. inserción en b+ tree

pasos generales:

1. bajar desde la raíz hasta la hoja correcta según la clave
2. insertar la nueva entrada en la hoja si hay espacio
3. si no hay espacio, dividir la hoja
4. propagar la división al padre si es necesario
5. puede haber actualización en cascada hasta la raíz

### complejidad

- búsqueda de hoja: `o(log n)`
- inserción total: `o(log n)` amortizado, aunque puede incluir splits

---

## 25. eliminación en b+ tree

pasos generales:

1. buscar la hoja que contiene la clave
2. eliminar la entrada
3. si el nodo queda con muy pocas entradas:
   - fusionar con un hermano, o
   - redistribuir con un hermano
4. actualizar el padre
5. si hace falta, propagar cambios hacia arriba

### complejidad

- `o(log n)` más el costo de rebalanceo local

---

## 26. complejidad del b+ tree

si cada nodo interno tiene entre `r/2` y `r` entradas, y hay `m` claves:

- altura aproximada: `log_(r/2)(m)`

entonces:

- búsqueda: `o(log m)`
- inserción: `o(log m)` + splits posibles
- eliminación: `o(log m)` + merges/redistribuciones posibles

en realidad, para disco, lo importante es el número de accesos a páginas, no solo el conteo abstracto.

---

## 27. ventajas del b+ tree

- se reorganiza automáticamente con cambios locales
- no hace falta reconstruir todo el archivo frecuentemente
- soporta `order by`, `between`, igualdad y rango
- es excelente para almacenamiento en disco
- las hojas enlazadas permiten recorridos ordenados eficientes

## 28. desventajas del b+ tree

- implementar bien la estructura es más complejo
- si crece mucho y hay overflow/mala organización, el rendimiento puede degradarse
- requiere mantenimiento de nodos, splits, merges y punteros

---

## 29. comparación conceptual rápida

### heap

- bueno para insertar rápido
- malo para búsqueda por igualdad y rango si no hay índice

### sorted file

- muy bueno para búsqueda binaria y rango
- malo para inserciones y eliminaciones frecuentes

### static hash

- excelente para igualdad
- malo para rango

### b+ tree

- muy bueno para igualdad y rango
- balancea muy bien búsqueda, inserción y eliminación

---

## 30. qué debes recordar sí o sí para examen

### sobre sequential file

- está ordenado físicamente por la clave
- permite búsqueda binaria
- insertar y eliminar son complicados
- por eso se usan archivos auxiliares y reconstrucción

### sobre auxiliar

- puede ser no ordenado o ordenado
- no ordenado: insertar más fácil
- ordenado: buscar y reconstruir más fácil

### sobre registros enlazados

- el orden lógico puede mantenerse con punteros aunque el orden físico se rompa
- eliminación muchas veces es lógica, no física inmediata

### sobre páginas y bloques

- el disco trabaja con bloques
- varios registros caben en una página
- `blocking factor = floor(bloque / registro)`

### sobre dense y sparse

- dense: una entrada por registro
- sparse: una entrada por algunas páginas o registros representativos
- sparse requiere archivo ordenado

### sobre b+ tree

- siempre balanceado
- hojas al mismo nivel
- hojas enlazadas
- excelente para rango y búsqueda
- clustered: orden físico coincide con el índice
- unclustered: el índice apunta a datos desordenados

---

## 31. mini mapa mental final

```text
organización física
|
|-- sequential file
|   |-- búsqueda binaria
|   |-- inserción/eliminación costosas
|   |-- auxiliar no ordenado
|   |-- auxiliar ordenado
|   |-- registros enlazados
|   |-- reconstrucción
|
|-- bst file
|   |-- left/right
|   |-- si se desbalancea empeora
|   |-- avl para balancear
|
|-- páginas y bloques
|   |-- blocking factor
|   |-- spanned organization
|
|-- índices
|   |-- dense
|   |-- sparse
|   |-- multilevel
|   |-- b+ tree
|       |-- clustered
|       |-- unclustered
|       |-- hojas enlazadas
|       |-- split/merge
|       |-- range scan eficiente
```

---

## 32. cierre conceptual

la gran idea de toda la clase es esta:

**buscar rápido no es gratis**.

si ordenas o indexas mejor los datos:

- las búsquedas mejoran
- pero mantener la estructura cuesta más

por eso cada técnica intenta encontrar un equilibrio entre:

- costo de búsqueda
- costo de inserción
- costo de eliminación
- costo de reorganización
- cantidad de accesos a disco

---
next: [[índices]]
tags: [[bd]]