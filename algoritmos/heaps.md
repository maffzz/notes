árboles binarios completos que ordenan de mayor a menor o de menor a mayor
# max heaps
el padre siempre es mayor a sus dos hijos
# min heaps
el padre siempre es menor a sus dos hijos

# ¿cómo se representa un heap?

como un array
![[max_heap.png]]
![[max_heap_array.png]]

para hallar left, right y parents en heap como array ->
- left( i ) = 2 * i + 1
- right( i ) = 2 * i + 2
- parent( i ) = (i–1) / 2 
# ¿cómo armamos un heap desde un array?
1. construir un BST <mark class="hltr-pinky">completo</mark> de base directamente del array
2. para cada nodo padre aplicar un <mark class="hltr-blue">heapify-down</mark>:
	(dependiendo del tipo de heap) cambia al mayor/menor de los hijos con el padre
# ¿a cuántos nodos se aplica el heapify-down?
- como el árbol es completo, el heapify se va a llamar $\frac{n}{2}$ veces
- la complejidad de las $\frac{n}{2}$ llamadas O(n * logn)
- la cota más correcta es O(n), ya que heapify no siempre toma O(logn)
# ¿cómo se inserta un elemento en un heap?
1. se inserta siempre en el siguiente espacio vacío
2. sobre dicho nodo se realiza un <mark class="hltr-blue">heapify-up</mark>:
	compara el nodo con su padre hasta encontrar su posición correcta
# ¿cómo se haría el pop?
1. swap del root (0) con el último (n-1) y se remueve el último (n--)
2. se ubica el nuevo valor del root en su posición correcta usando <mark class="hltr-blue">heapify-down</mark>:
	compara y cambia (de ser necesario) al nodo con alguno de sus hijos
# ¿cómo podríamos saber si un nodo tiene hijo izquierdo o hijo derecho?
bastaría con validar que el índice del hijo sea menor al tamaño del array  
# tiempo de ejecución para sus funciones
- insertar: O(log n)  
- remover: O(log n)  
- construir el heap: O(n log n)  
- encontrar el máximo o mínimo: O(1)  

```
la altura de un árbol completo es aproximadamente O(logn)
```
# ¿cuáles serían los usos de los heaps?
- colas de prioridad
- scheduling
- prim o kruskal
- ordenamientos

---
tags: [[progra]]