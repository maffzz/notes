# hash table

es una estructura de datos asociativa que mapea entre una clave y un valor en una relación unívoca. permite un acceso rápido y eficiente a un valor

existen principalmente 2 formas de implementar un mapa hash:
- árboles binarios en python y C++
- listas o vectores (hash tables)
## implementaciones

**tablas de acceso directo ->**
- almacenados en un arreglo
- ordenados por key  
**desventajas  ->**
- la clave no siempre es un valor numérico
- podría ocupar una gran cantidad de memoria  
## ¿cómo solucionar las desventajas?

- para convertir las claves a valores numéricos se realiza el proceso de hashing, que consiste en mapear la clave hacia un número entero. C++ cuenta con una función hash que genera el hashing
- para reducir el universo de claves a un número razonable de valores (<mark class="hltr-red">m</mark>)
- <mark class="hltr-red">m</mark> es un valor o cantidad que se acerca a la cantidad actual de valores que se utiliza
## hash table : collision

si el rango de las claves es más largo que el tamaño de la clave (m) lo cual es usual, debe tomarse en cuenta que 2 diferentes registros podrían generar 2 claves que con un mismo valor de sub-índice. este problema se conoce como colisión y suele solucionarse de 2 formas:  
- open addressing  
- separate chaining




---
tags: [[progra]]