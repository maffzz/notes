> colección de datos geográficos -> se quiere consultar aquellos puntos que pertenecen a una región específica

-> recorrer todo y medir la distancia : O(n)
-> se necesita un índice basado en espacio

**aplicaciones :** servicios de movilidad, ciudades inteligentes, gestión de cajas logísticas en 3D
## conceptos
- datos espaciales : colección de datos que representan objetos con ubicación y forma
	- posiciones de robots 
	- planos CAD de hospital
	- modelo 3D de piezas mecánicas
- datos geo-espaciales : subconjunto de datos espaciales que están geo referenciados en superficie terrestre
- para espacios geométricos
	- distancia entre dos puntos = $euclidiana = \sqrt{(x_2 - x_1)^2 + (y_2 - y_1)^2}$
- para espacios geográficos
	- distancia entre dos puntos = $manhattan = |x_1 - x_2| + |y_1 - y_2|$
- búsqueda por intersección
- búsqueda por rango 
- búsqueda k 
## GIS
- combina mapas y bases de datos
- instalar postGIS
---
next: [[control de concurrencia]]
tags: [[bd]]