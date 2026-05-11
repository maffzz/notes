☝ es una variable que almacena la dirección de otra variable

```cpp
float *puntero
int *puntero
```

- dereference * : se utiliza para definir al puntero, y va de lado de la variable. a su vez, permite acceder al contenido a la cual apunta. **saca el valor de la dirección**
- address-of & : obtiene la dirección de una variable de cualquier tipo. **saca la dirección**

```cpp
#include <iostream>
using namespace std;

int main() {
    int cinco = 5; // definir variable
    int *a; // definir puntero
    a = &cinco; // asignar a qué apunta el puntero
    
    // imprimir lo que guarda el puntero (valor)
    cout << *a << endl; // imprime 5
    
    // imprimir la dirección a la que apunta el puntero
    cout << a << endl; // imprime dirección de memoria de 'cinco'
    
    // imprimir la dirección del puntero en sí
    cout << &a;} // imprime dirección de memoria de 'a'
```
### ejercicios

```cpp
short arr[5] = {1, 2, 4, 8, 16};

/* direcciones: 1 -> 1000 | 2 -> 1002 | 4 -> 1004 | 8 -> 1006 | 16 -> 1008 */
```

```cpp
cout << arr << endl; // imprime la dirección de '1' (primer elemento del array)

cout << *arr + 2; // (1) + 2 | imprime 3

cout << *(arr + 2) << endl; // *(1000 + 2) | *(1004) | imprime 4 pq avanza dos posiciones en el array

cout << *(arr + 12) << endl; // *(1000 + 12) | *(1024) | daría basura pq no existe esa posición en el array
```

```cpp
int arr[5], *ptr; // se declara un array y un puntero

ptr = arr; // ✅ válido: el puntero 'ptr' se asigna a apuntar al primer elemento del array

arr = ptr; // ❌ inválido: el array representa una dirección fija en memoria, no es una variable puntero reasignable, por lo que no puede tomar el valor de 'ptr'
```

```cpp
int number = 17, *ptr; // se declara un array y un puntero
ptr = &number; // inicializa el puntero para q apunte a la dirección de la variable 'number'
cout << *ptr << endl; // imprime '17'

int number = 13, *ptr; // se declara un array y un puntero
*ptr = number; // no inicializa el puntero
cout << *ptr << endl; // error
```

```cpp
int *ptr = new int; // memoria dinámica
*ptr = 5;

int variable = 5; // creación de variable
int *ptr = &variable; // asignación del puntero
```

**importante ->**
- i++ = incrementa pero retorna original
- ++i = incrementa y retorna nuevo valor

**equivalencias ->**
- * p++ = * (p++)
- * ++p = * (++p)
- ++ * p = ++(* p)

```cpp
int arr[5] = {1, 2, 3, 4, 5};
int *ptr = arr;

cout << *ptr << endl; // 1
cout << *ptr++ << endl; // 1 | aumenta y retorna anterior -> *ptr = 2
cout << *++ptr << endl; // 3 | aumenta y retorna nuevo -> *ptr = 3
cout << ++*ptr << endl; // 4 | aumenta y retorna nuevo -> *ptr = 4
cout << (*ptr)++ << endl; // 4 | aumenta y retorna anterior -> *ptr = 5
cout << *ptr << endl; // 5
```

los punteros a *void*, son un tipo especial de punteros donde *void* representa la ausencia de tipo. por tanto, puede ser usado para cualquier tipo con algunas restricciones en cuanto a sus operadores

```cpp
int number = 5;
void *ptr = &number; // puntero de tipo void
cout << *(int*)ptr << endl; // lo transforma en int e imprime 5
```

siempre definir tus punteros a nullptr o NULL, cuando estén vacíos, de otra forma va a apuntar a basura

```cpp
int *ptr = nullptr;
int *ptr = NULL;
```

**puntero a funciones ->**

```cpp
int sumar(int a, int b) { return a + b; } 
int main() {
	// declaramos un puntero a función que recibe dos int y devuelve un int
	int (*funcionPuntero)(int, int);
	
	// le asignamos la dirección de la función 'sumar'
	funcionPuntero = &sumar;
	
	// llamamos a la función a través del puntero
	int resultado = funcionPuntero(3, 5); 
	
	// también se puede hacer ->
	int resultado = (*funcionPuntero)(3, 5);
	
	cout << "resultado: " << resultado << endl;
	return 0;}
```
---
tags: [[progra]]