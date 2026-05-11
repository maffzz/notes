- hay punteros que van al siguiente y otro que va hacia atrás
- hay un head y un tail y ambos apuntan a NULL
- en el push back -> 0(1) y la lista enlazada simple era O(n)

```cpp
struct Node {  
	int data;  
	Node* next;  
	Node* prev; };  

class List {  
	private:  
	Node* head;  
	Node* tail; };
```

### push front
```cpp

```

### push back
```cpp

```
### pop front
```cpp
Nodo* temp = head;
head = head->next;
head->prev = NULL;
delete temp;
```
### pop back
```cpp

```
### insert at location
```cpp

```



---
tags: [[progra]]