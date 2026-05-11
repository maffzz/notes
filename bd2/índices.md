
```cpp
const int tam_page = 8000;

struct IndexPage {
	T keys[m-1];
	int children[m];
	int size; }
// hallar m
// (m-1)*sizeof(T) + m*sizeof(int) + sizeof(int) = 8000
// despejar


struct Page {
	// datos
	Records records[b];
	// header
	int size;
	int next_page;
	int prev_page; }
// hallar b
// b*sizeof(Record) + 3*4 = 8000
// despejar
```

¿más eficiente agrupado o no agrupado?
- el índice agrupado aprovecha las páginas como el nivel de hojas. queda crear los nodos internos (se construye hacia arriba) - sparse. no se le puede aplicar al unique. solo puedo tener 1 índice agrupado (pk). a la llave
- el índice no agrupado : en el último nivel de inserción, cada nodo apunta a un registro (RID). necesito un nivel más de indexación (más nodos) - dense. se aplica al unique. requiere que físicamente los registros estén ordenados. cualquiera que no sea llave. se debe dar soporte a los repetidos

# bitmap

> técnica de optimización cuando se tienen múltiples predicados en índices no agrupados (el que trae una página solo por un registro). se usa para evitar leer páginas más de 1 vez

---
next: [[índices avanzados en postgresql]]
tags: [[bd]]