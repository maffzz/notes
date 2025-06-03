## <mark class="hltr-blue">LIFO</mark>

<aside>☝ el último en insertarse es el primero en salir </aside>
## <mark class="hltr-pinky">FIFO</mark>

<aside>☝ el primero en insertarse es el primero en salir </aside>
## <mark class="hltr-brown">HEAP</mark>

<aside>☝ los elementos se organizan por medio de un criterio de prioridad, el de mayor prioridad es el primero en salir </aside>
## tipos de adaptadores 

- std::stack -> comportamiento <mark class="hltr-blue">LIFO</mark> | revertir una operación | evaluar expresiones
- std::queue -> comportamiento <mark class="hltr-pinky">FIFO</mark> | pool de threads | procesamiento de archivos
- std::priority_queue -> comportamiento <mark class="hltr-brown">HEAP</mark> | alerta de stock de inventario | balanceo de mensajes
## ventajas de los adaptadores

- semántica clara y explicita, comportamientos definidos
- menos superficie de errores, solo los métodos que se requieren
- facilidad de mantenimiento, interface simple y fácil de entender
- facilidad el cambio de contenedor, cambio de contenedor sin cambiar la interface
## <mark class="hltr-sage">std::stack</mark>

```cpp
#include <stack>
```

- comportamiento: LIFO  
- 5 métodos básicos
	- push
	- pop
	- top
	- size
	- empty  
- contenedores validos: con inserción y borrado al final (push_back/pop_back)
	- std::vector
	- std::deque
	- std::list
## <mark class="hltr-sage">std::queue</mark>

```cpp
#include <queue>
```

- comportamiento: FIFO
- 6 métodos básicos
	- push
	- pop
	- front
	- back
	- size
	- empty
- contenedores validos: con inserción al final (push_back) y borrado al inicio (pop_front)
	- std::deque
	- std::list
## <mark class="hltr-sage">std::priority_queue</mark>

```cpp
#include <queue>
```

- comportamiento: heap
- 5 métodos básicos
	- push
	- pop
	- top
	- size
	- empty
- contenedores validos: con inserción y borrado al final (push_back/pop_back)
	- std::vector
	- std::deque
	- std::list

---
tags: [[progra]]