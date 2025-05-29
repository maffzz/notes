la **complejidad algorítmica** mide cómo **crece el tiempo o espacio que usa un algoritmo** conforme crece el tamaño de la entrada (`n`). se expresa con **notación Big-O (O grande)**

---
## tipos comunes de complejidad (ordenadas de mejor a peor)

| notación   | nombre             | ejemplo                        |
| ---------- | ------------------ | ------------------------------ |
| O(1)       | constante          | acceso directo a un array      |
| O(log n)   | logarítmica        | búsqueda binaria               |
| O(n)       | lineal             | recorrer un arreglo            |
| O(n log n) | lineal logarítmica | merge sort, quicksort promedio |
| O(n²)      | cuadrática         | doble for anidado              |
| O(2ⁿ)      | exponencial        | recursión tipo fibonacci       |
| O(n!)      | factorial          | algoritmos de permutación      |

---
## ¿qué mirar en el código para hallarla?

### 1. bucles (`for`, `while`)

- si el `for` va de 0 a `n`, contribuye O(n)
- si hay dos bucles anidados de 0 a `n`, es O(n²)
- si un `for` reduce `i` por mitad (`i = i/2`), es O(log n)

```cpp
for (int i = 0; i < n; i++) {} // total O(n)
```

```cpp
for (int i = 0; i < n; i++) { // total O(n²)
    for (int j = 0; j < n; j++) {}}
```

---
### 2. recursividad

- se resuelve con **ecuaciones de recurrencia**
- ejemplo clásico:

```cpp
int fib(int n) { // complejidad: O(2ⁿ)
	if (n <= 1) return n;
	return fib(n-1) + fib(n-2);}
```

---
### 3. condicionales (`if`)

- no afectan la complejidad a menos que contengan bucles o llamadas recursivas

```cpp
if (n > 0) { // O(1)
  cout << "snupi"; }
```

---
### 4. funciones auxiliares

- si llamas funciones dentro de otras, suma sus complejidades

```cpp
void f1(int n) {
  for (int i = 0; i < n; i++) {
  cout << i;}} // O(n)
void f2(int n) {
  f1(n); // O(n)
  f1(n);} // O(n) → total: O(n + n) = O(n)
```

---
## trucos y reglas generales

- **ignorar constantes**: `O(2n)` se simplifica a `O(n)`
- **suma de pasos secuenciales**: O(n) + O(n²) = O(n²)
- **pasos anidados → multiplican**: un for dentro de un for = O(n * n) = O(n²)
- siempre toma el **peor caso**, a menos que te pidan mejor o promedio
---
## ejemplo completo en C++

```cpp
void ejemplo(int n) {
	for (int i = 0; i < n; i++) { // O(n)
		for (int j = 0; j < n; j++) { // O(n)
		    cout << i << j;}} // O(1)

  for (int k = 0; k < n; k++) { // O(n)
    cout << k;}}
```

**complejidad total:**  
- primer for anidado: O(n²)
- segundo for: O(n)
- -> total: **O(n² + n) = O(n²)**

---
## ejercicios ->

### ejercicio 1: Bucle simple

```cpp
void ejemplo1(int n) {
	for (int i = 0; i < n; i++) {
		cout << i << endl;}}
```
### ✅ análisis:
- el `for` se ejecuta `n` veces
- dentro hay una instrucción `O(1)` 
**complejidad total:**  `O(n)`

---
### ejercicio 2: doble bucle anidado

```cpp
void ejemplo2(int n) {
	for (int i = 0; i < n; i++) {
	    for (int j = 0; j < n; j++) {
		    cout << i << j << endl;}}}
```
### ✅ análisis:
- dos bucles anidados de 0 a `n`
- cada iteración interna hace `O(1)`
**complejidad total:**  `O(n²)`

---
### ejercicio 3: Bucle logarítmico

```cpp
void ejemplo3(int n) {
	while (n > 1) {
		n = n / 2;}}
```
### ✅ análisis:
- cada vez `n` se reduce a la mitad
- ¿cuántas veces puedes dividir `n` entre 2 hasta llegar a 1?  
    → log₂(n) veces
**complejidad total:**  `O(log n)`

---
### ejercicio 4: mezcla de bucles

```cpp
void ejemplo4(int n) {
	for (int i = 0; i < n; i++) {
	    cout << i;}
	for (int j = 0; j < n * n; j++) {
    cout << j;}}
```
### ✅ análisis:
- primer bucle: `O(n)`
- segundo bucle: `O(n²)`
**complejidad total:**  `O(n + n²) = O(n²)` (domina la más grande)

---
### ejercicio 5: recursión simple

```cpp
void ejemplo5(int n) {
	if (n == 0) return;
		ejemplo5(n - 1);}
```
### ✅ análisis:
- se llama a sí misma `n` veces
- cada llamada hace `O(1)`
**complejidad total:**  `O(n)`

---

tags: [[progra]]