¿qué es?
mide cómo crece el tiempo de ejecución (o el espacio que usa) de un algoritmo cuando aumenta el tamaño de los datos (n). se enfoca en el peor caso (nunca tardará más que esa cota)

solo importa el término que más crece ->
- T = a = O(1)
- T = an + b = O(n)
- T = an² + bn + c = O(n²)
### clases de complejidad

| notación       | crecimiento        | descripción                               | ejemplito                     |
| -------------- | ------------------ | ----------------------------------------- | ----------------------------- |
| **O(1)**       | constante          | siempre tarda lo mismo                    | acceder a `lista[2]`          |
| **O(log n)**   | logarítmico        | cada iteración reduce el rango a la mitad | búsqueda binaria              |
| **O(n)**       | lineal             | recorre todos los elementos               | recorre un array              |
| **O(n log n)** | logarítmico lineal |                                           | quicksort promedio, mergesort |
| **O(n²)**      | cuadrático         | doble bucle anidado                       | doble bucle anidado           |
| **O(2ⁿ)**      | exponencial        |                                           | fuerza bruta de subconjuntos  |
- se dice que un algoritmos es bueno cuando es de complejidad polinomial

¿por qué usamos [[punteros]]?
- los [[punteros]] siempre van acompañados de `new` o `delete`
- se utilizan en contextos de control de memoria

---
tags: [[progra]]