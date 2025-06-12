# heap

un heap es un árbol binario con 2 propiedades especiales:
- debe tener todos sus nodos en un orden especifico, donde cada nodo debe ser mayor a sus nodos hijos
- debe ser un <mark class="hltr-brown">árbol completo</mark>
- i_left = i_parent * 2
- i_right = i_parent * 2 + 1
- i_parent = i // 2
## <mark class="hltr-brown">árbol completo</mark>

se cumplen estas condiciones:  
- los niveles anteriores al último deben estar completamente llenos, pudiendo el último estar parcialmente lleno.
- el último nivel debe ser llenado hoja a hoja desde la izquierda hacia la derecha
## <mark class="hltr-blue">min-heap</mark> y <mark class="hltr-pinky">max-heap</mark>

en un <mark class="hltr-blue">min-heap</mark>, todo nodo padre incluyendo el nodo raíz debe ser menor o igual que el valor de sus nodos hijos, por lo que el nodo de menor valor siempre debe ser el nodo raíz
en un <mark class="hltr-pinky">max-heap</mark>, todo nodo padre incluyendo el nodo raíz debe ser mayor o igual que el valor de sus nodos hijos, por lo que el nodo de mayor valor siempre debe ser el nodo raíz
## operaciones y métodos

- <mark class="hltr-red">top</mark> -> buscar max en caso de max-heap
- <mark class="hltr-red">push</mark> -> inserción | adicionar un nuevo valor en el heap <mark class="hltr-yellow">(percólate up) | O(log n)</mark>
- <mark class="hltr-red">pop</mark> -> borrado | remover el máximo en caso de max-heap <mark class="hltr-yellow">(percólate down) | O(log n)</mark>
- <mark class="hltr-red">replace</mark> -> (percólate up) si el nodo es mayor al padre o (percólate down) si el nodo es menor que los hijos

## algoritmo <mark class="hltr-yellow">percólate up | O(log n)</mark>

**condiciones básicas ->**
- si es root, detenerse
- obtener índice del parent
- si el valor de child es menor que valor de parent detener (<mark class="hltr-pinky">max-heap</mark>)
- si el valor de child es mayor que valor de parent detener (<mark class="hltr-blue">min-heap</mark>)  

**condiciones recursivas ->**
- intercambiar valor de child con valor de parent
- llamar <mark class="hltr-yellow">percólate up</mark> con índice del parent
## algoritmo <mark class="hltr-yellow">percólate down | O(log n)</mark>

**condiciones básicas ->**
- si no tiene child detenerse
- obtener índice del child con valor mayor (<mark class="hltr-pinky">max-heap</mark>)
- si valor de child es menor que valor de índice detener (<mark class="hltr-pinky">max-heap</mark>)
- obtener índice del child con valor menor (<mark class="hltr-blue">min-heap</mark>)
- si valor de child es mayor que valor de índice detener (<mark class="hltr-blue">min-heap</mark>)

**condiciones recursivas ->**
- intercambiar valor de child con valor de parent
- llamar <mark class="hltr-yellow">percólate down</mark> con índice del child
## algoritmo <mark class="hltr-green">heapify up | O(n)</mark>

- obtener índice del parent (índice del current)  
**mientras sea un índice valido (>= 1) ->**
- llamar percólate down con índice del current
- disminuir en 1 el índice del current
## casos de uso

- algoritmos de planificación de tareas (OS schedule)  
- rutas más cortas
- compresión de datos
- sistemas de colas
- algoritmo **prim**
- simuladores  
## ¿cómo crear un heap?

existen 2 posibilidades para generar un heap: a través de inserciones sucesivas O(n * log n) o usando el algoritmo <mark class="hltr-green">heapify O(n)</mark>, que usa la técnica similar al borrado

**heapify ->**
- se parte del último valor y se evalúa hacia adelante si tiene hijos
- cuando se detecta un nodo con hijos se ejecuta el <mark class="hltr-yellow">percólate down</mark>
- se repite el proceso anterior hasta alcanzar el primer valor
## implementación

```cpp

```
---
tags: [[progra]]