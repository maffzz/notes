### forward list (lista enlazada simple)
es un contenedor secuencial -> permite tener datos en espacios de almacenamiento no relacionados (memoria)

```cpp
struct Node {
	int data;
	Node* next; };

class List {
private:
	Node* head; };
	
// iteraciones desde el principio hasta el final
Nodo* temp = head;
while (temp != NULL) {
	cout << temp->data;
	temp = temp->next; }
```
### push front
```cpp
Nodo* nodo = new Nodo; // crear un nuevo nodo
nodo->data = 5; // asignarle 5 a ese nodo
nodo->next = head; // hacer que ese nodo apunte al head actual
head = nodo; // volver head al nodo nuevo
```
### push back
```cpp
Nodo* nodo = new Nodo;  
nodo->data = 5;  
Nodo* temp = head;  
while (temp->next !=NULL) {
	temp = temp->next; }
temp->next = nodo;  
nodo->next = NULL;
```
### pop front
```cpp
Nodo* temp = head;  
head = head->next;  
delete temp;
```
### pop back
```cpp
if (head->next == NULL) {
	delete head;
	head = NULL; }  
else {  
	Nodo* temp = head;  
	while(temp->next->next != NULL) {
		temp = temp->next; }
	delete temp->next;  
	temp->next = NULL;
```
### insert at location
```cpp
Nodo* nodo = new Nodo(5);  
Nodo* temp = head;  
int i = 0;  
while (i++ < pos-1) {
	temp = temp->next; }
nodo->next = temp->next;  
temp->next = nodo;
```
### clear
```cpp
while (head != NULL) {  
	Nodo* temp = head;
	head = head->next;
	delete temp; }
```

## forward list vs array

¿cuál es la diferencia con un arreglo?  
- ubicación en la memoria
- tiempos de acceso
- tamaño y dimensiones : las listas enlazadas son más fáciles de redimensionar que los arrays

---
tags: [[progra]]