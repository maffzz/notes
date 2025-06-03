<aside> ☝ ¿cómo saber si un modelo es bueno?
</aside>

## directrices informales →

- semántica de los atributos: fáciles de leer y entendibles
- reducción de información redundante en tuplas
- reducción de valores nulos en tuplas
- prohibe la posibilidad de generar **tuplas falsas**
    - no todas las descomposiciones de una tabla se pueden combinar utilizando join natural para reproducir la tabla original
    - pueden aparecer tuplas o desaparecer tuplas
# dependencias funcionales →

- es cuando un atributo (o grupo de atributos) determina de manera única a otro atributo
- permite expresar hechos acerca de la realidad que se esta modelando con la base de datos
- **completa** e **incompleta**
### ¿cómo se lee?

- R es un conjunto de funciones
- X(conjunto de atributos), Y (conjunto de atributos)
- cuando escribimos **X → Y** significa que **Y depende funcionalmente de X** o **X determina funcionalmente a Y**

<aside> ☝ importante: la relación solo funciona en una dirección (no al revés)⁠
</aside>
### ¿qué significa en la práctica?

- si dos registros (tuplas) tienen el mismo valor en X, entonces siempre tendrán el mismo valor en Y⁠⁠
- un atributo puede determinar a uno o más atributos
## teoría →

- es una propiedad del esquema, no de la instancia (no necesito datos)
- una DF no puede ser inferida automáticamente de la instancia
- una instancia por si sola no es suficiente para determinar si una DF se cumple en una relacion **a menos que la muestra sea representativa**
- si se puede demostrar que una DF no se cumple, las instancias son solo para dar contraejemplos
- F : muchas dependencias funcionales
    - habitualmente se especifican las DFs que son obvias (literal dice en el texto)
    - algunas DFs pueden estar en las instancias y entre conjuntos de atributos que pueden derivarse y depender de otros
### clausura →

- conjunto de dependencias que incluyen a F junto con todas las dependencias que pueden inferirse de F: F+ = TODOOO (ya no hay mas inferencias despues de F+)
- F(F+) es el conjunto de DF que implica F lógicamente
- dado F se puede calcular F+ directamente de la definicion formal de DF
## reglas de inferencias funcionales →

- reflexiva: si Y está incluido en X entonces X → Y, tambien: X→ X, atributos se determinan a si mismos
- aumento : si X → Y entonces XY → YZ
- transitiva : si X→Y y Y → Z entonces X → Z
- descomposicion o proyeccion : si X→YZ entonces X→Y
- unión o aditiva : si X → Y y X → Z entonces X → YZ
- pseudotransitividad : si X → Y y WY → Z entonces WX → Z
### ejemplos →

*la tabla es solo para aprender, en si no se deberían usar instancias (tabla llena)
manda la que esta a la izquierda **POWER → NO_POWER**

R es el conjunto de dependencias funcionales

| **A**  | **B** | **C**  | **D** |
| ------ | ----- | ------ | ----- |
| **a1** | b1    | **c1** | d1    |
| **a1** | b2    | **c1** | d2    |
| **a2** | b2    | **c2** | d2    |
| **a2** | b3    | **c2** | d3    |
| **a3** | b3    | **c2** | d4    |

**A→ C se satisface**

- las 2 tuplas con valor **a1** en A tienen el mismo valor **c1** en C
- las 2 tuplas con valor **a2** en A tienen el mismo valor **c2** en C

**C→ A no se satisface**

- todos los **c2** deberían corresponder a un **a2**, pero el ultimo **c2** tiene un **a3**

**¿qué se cumple?**

- AB →D
- A→ A
- una DF de la forma a → b es trivial si B esta incluido en a
## cerraduras →

- una llave candidata determina a una tupla funcionalmente
- X → Y : si Y contiene a todos los atributos, X es super llave
# formas normales →

- sirven para determinar qué tan bien está hecho el diseño de una base de datos
- normalización : es el proceso de descomponer tablas “malas” en relaciones más pequeñas
- es una condición mediante el uso de **claves y DF** de una relación para certificar si un esquema de relación se encuentra en una forma normal en particular
## primera forma normal →

- tablas sin atributos compuestos o multivaluados
- un valor por celda
- estándar de los SGBD
### —descomposición →

sea la relación R y sus DFs F → descomposición R1 y R2

1. conservar los atributos de R : R = R1 U R2
2. conservar DFs : F+ = {F1 U F2}+
3. no generar tuplas falsas : {R1 ∩ R2} → R1 o {R1 ∩ R2} → R2

**ejemplo →** sea R(A, B, C, D, E) y F = {AB→C, C→D, C→E}

la descomposición R1(A, B, C, D) y R2(C, E) genera F1 = {AB→C, C→D} y F2 = {C→E}

- sí conserva los atributos de R
- sí conserva las DFs
- no genera tuplas falsas ya que:
	{R1 ∩ R2} → R2 que incluye a (C, E) y C→E está incluido en F = {AB→C, C→D, C→E}
## segunda forma normal →

- debe estar en la primera forma normal
- cada atributo no primo depende funcionalmente de manera total de toda clave de R
### —descomposición →

1. las dependencias funcionales parciales se llevan a nuevas tablas
2. en la tabla original, queda la clave y los atributos que dependen totalmente de ella

**ejemplo →** sea R(**A, B**, C, D, E) y F = {AB→CE, B→D}

la DF parcial es AB→CE, entonces:

- R1(**A, B**, C, E)
- R2(**B**, D)
## tercera forma normal →

- debe estar en la segunda forma normal
- cada atributo no trivial X→Y en R : X es super llave o Y es atributo primo
### —descomposición →

**ejemplo →** sea R(A, X, Y, B) y F = {A→XB, X→Y} donde X→Y incumple 3FN

1. crear otra relación X+ donde X es clave
2. eliminar Y de R
## boyce-codd forma normal →

- debe estar en tercera forma normal
- para toda X de X→Y en R : X es súper llave
### —descomposición →

<aside> ☝ esta estrategia de normalización no asegura preservar dependencias, pero sí la recuperación de la información por join
</aside>

**ejemplo →** sea R(A, X, Y, B) donde X→Y incumple FNBC
1. crear dos relaciones
2. R1 = R - Y
3. R2(X, Y)

---
next: [[seguridad en la base de datos y acceso programático]]
tags: [[bd]]