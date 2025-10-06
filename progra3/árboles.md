estructura jerárquica acíclica compuesta por nodos y aristas donde cada nodo (excepto la raíz) tiene un único padre

## características

- conjunto finito de nodos, conectados por aristas que definen relaciones padre-hijo
- un nodo raíz único, desde el cual se generan todos los demás subárboles
- subárboles disjuntos, cada nodo divide el árbol en regiones independientes
- acíclico, no existen ciclos; cada nodo, salvo la raíz, tiene exactamente un padre
## terminología

- raíz : nodo sin padre
- nodo : elemento con cero o más hijos
- hoja : nodo sin hijos
- arista : une un padre con uno de sus hijos
- ancestro : nodo en la ruta desde raíz
- descendiente : nodo en subárbol
- padre : ancestro inmediato
- hijo : descendiente inmediato
- profundidad : # aristas desde la raíz hacia un nodo
- altura : # aristas desde un nodo hacia la hoja más profunda
- grado : número de hijos del nodo
## árbol binario

- cada nodo tiene a lo más dos hijos, en otros términos el grado del árbol es 2
- la máxima cantidad de nodos que puede tener un árbol binario es 2^(h+1) - 1
- la mínima cantidad es h+1, donde h es la altura de un árbol
- un árbol vacío también se considera valido

---
tags: [[progra]]