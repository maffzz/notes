# hash table

es una estructura de datos asociativa que almacena pares (clave y valor) con claves únicas mapeando cada clave a un bucket mediante una función de dispersión (hash). resuelve las colisiones por encadenamiento o sondeo. esto permite búsquedas, inserciones y eliminaciones en tiempo promedio O(1)

existen principalmente 2 formas de implementar un mapa hash:
- [[árboles]] binarios en python y C++
- listas o vectores (hash tables)
## elementos

- <mark class="hltr-pinky">arreglo de buckets</mark>
- <mark class="hltr-yellow">función de dispersión (hash)</mark>
- <mark class="hltr-green">política de crecimiento (load factor)</mark>
### <mark class="hltr-pinky">arreglo de buckets</mark>

- es un arreglo contiguo de memoria de tamaño m, donde el bucket es el tipo de dato almacenado en este arreglo
- los tipo bucket pueden implementarse de varios modos y pueden representar:
	- una referencia a una lista de pares
	- una referencia a un solo par  
- el tamaño inicial de m se elige típicamente un número primo o una potencia de 2

```cpp
// open addressing  
using BucketType = struct {
	State state,
	Key k,
	Value v;};

// separate chaining 
using BucketType = forward_list<pair<Key, Value>>; 

// arreglo de bucket  
vector<BucketType> buckets_(m);
```
### <mark class="hltr-yellow">función de dispersión (hash)</mark>

- n el contexto de una tabla hash, es una parte esencial, genera un mapeo determinístico que toma una clave (entera, texto u objeto complejo) y la convierte en un índice dentro de un rango `[0,m)`
- la función hash se compone de 2 fases:
	1. <mark class="hltr-brown">hash code</mark> (entropización) : convertir la clave a un entero
	2. <mark class="hltr-blue">compresión</mark> (rango de buckets) : convertir el entero dentro del rango `[0,m)`
#### <mark class="hltr-brown">función hash - hash code - entropización</mark>

su misión es convertir una clave de tipo arbitrario (entero, cadena, estructura, clase... ) en un entero de "ancho fijo" (por ejemplo, 32 o 64 bits) que luego se pueda comprimir al rango de buckets

- en claves enteras, suele usarse su propia representación
- en puntero o float, se suele convertir a entero sin signos
- en texto se suele convertir usando algún algoritmo de conversión como:
	- FNV-1a | DJB2
- en objetos complejos se usa las técnicas de hash folding y hash mixing
#### <mark class="hltr-blue">función hash - rango de buckets - compresión</mark>

esta fase toma el hash code y lo mapea a un índice del bucket `[0, m)` por medio de un método de compresión, su objetivo es de forma eficiente distribuir las claves dentro del rango de los índices validos de un arreglo de buckets

- los método mas comunes de compresión son:
	- división: `idx = (hcode(key)) mod m`
	- multiplicación: `idx = floor(m * (A * hcode(key)) fmod 1)` 
		- donde: `A = (√5 − 1)/2`  
### <mark class="hltr-green">load factor</mark>

es una métrica clave en el diseño y eficiencia de una tabla hash. mide que tan llena esta una tabla hash
**∝ = n/m donde :** n = número de elementos en la tabla | m = tamaño de la tabla de buckets
- en separate chaining:
	- el tiempo promedio de acceso a un elemento es O(1 + ∝)
	- si ∝ crece las [[listas enlazadas]] crecen
- en open addressing:
	- en número de sondeos aumenta cuando ∝ se acerca a 1
- hay umbrales de valores máximos conocidos como <mark class="hltr-red">∝max</mark>
#### <mark class="hltr-red">umbrales típicos (∝max)</mark>

| estrategia      | umbral ∝ₘₐₓ | acción al superar el umbral         |
| --------------- | ----------- | ----------------------------------- |
| chaining        | 0.75 – 1.0  | redimensionar (*rehash*) doblando m |
| open addressing | 0.5 – 0.7   | *rehash* a tamaño ~2 * m o más      |
proceso de rehashing:
- crear nuevo arreglo de buckets con m′ (por ejemplo,  2 * m o el siguiente primo)
- reinsertar todos los elementos (recalculando índices)
- en caso de open addressing, reinsertar SOLO los elementos en estado `State.Occupied`
- actualizar m <- m′
## hash table : collision

si el rango de las claves es más largo que el tamaño de la clave (m) lo cual es usual, debe tomarse en cuenta que 2 diferentes registros podrían generar 2 claves que con un mismo valor de sub-índice. este problema se conoce como colisión y suele solucionarse de 2 formas:  
- open addressing  
- separate chaining
### open addressing
  
- los pares se almacenan directamente en los buckets dentro del mismo arreglo
- cada bucket es un slot único y contiene:
	- estado (`Empty, Occupied, Deleted`)
	- par (Key, Value) solo valido en caso de `Occupied`
- la inserción y búsqueda involucra un sondeo de posiciones, para ubicar los valores validos (`Empty` o `Occupied`)

```cpp
// estados  
enum class State { Empty, Occupied, Deleted }

// open addressing  
template <class Key, class Value>  
using BucketType = struct {
	State state,
	Key k,
	Value v;};

// arreglo de bucket  
template <class Key, class Value>  
using BucketsArray = vector<BucketType<Key, Value>>

// arreglo de buckets  
BucketsArray<int, string> buckets_(m);
```
#### inserción y búsqueda

el proceso de inserción y búsqueda involucra los siguientes pasos:  
1. cálculo del hash inicial `(h0 = hash(k) % m)`
2. sondeo `(hi = (h0 + f(i) % m)` hasta encontrar:
	a. primer slot `Empty` o `Deleted` para la inserción
	b. primer slot `Occupied` para la búsqueda
3. actualización del tamaño de la tabla si se excede el factor de carga (<mark class="hltr-green">load factor</mark>) seleccionado
#### eliminación

- se marca como `State.Deleted` (“tombstone”)
- marcar el slot como `State.Empty`, en vez `State.Deleted` rompería la cadena de sondeo para búsquedas posteriores
- los slot `State.Deleted` pueden degradar el rendimiento por lo que se puede reutilizar al momento de inserción o cuando se llego al límite de carga y se realiza un rehashing
##### estrategias de sondeo f(i)

| **técnica**   | **fórmula de _f(i)_**     | **notas**                                                           |
| ------------- | ------------------------- | ------------------------------------------------------------------- |
| lineal        | _f(i) = i_                | fácil, pero sufre *primary clustering*                              |
| cuadrático    | _f(i) = c1i + c2i²_       | educe *clustering*, requiere calibración de constantes (_c₁_, _c₂_) |
| doble hashing | _f(i) = i × (h2(k) % m′)_ | usa segunda función hash h2; muy buena dispersión                   |
- dominio de 𝑖 : 𝑖 ∈ {0, 1, 2, ..., m − 1}
- primary clustering: se forman grandes conglomerados de slots contiguos
- usualmente m’ = m − 1 si m es primo


---
tags: [[progra]]