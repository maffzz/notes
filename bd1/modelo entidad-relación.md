## enfoque de bases de datos

1. obtención y análisis de requerimientos
2. diseño conceptual
3. diseño lógico
4. programa DBMS
5. diseño de programa de aplicación
6. diseño físico
7. implementación de transacciones

<aside> ☝ caso: una base de datos de una empresa de marketing necesita almacenar información de cada compañía asociada (identificada por nombre y su valor-acción en el mercado), y los productos que fabrica cada compañía (identificado por nombre, precio y categoría).
</aside>

| entidades (sustantivo) | atributos de entidades | relación entre entidades (verbo) |
| ---------------------- | ---------------------- | -------------------------------- |

<aside> ❗la relación nunca tiene llave
</aside>
<aside> ❗notación aceptada en el curso
</aside>
<aside> ❗ver flechas de izquierda a derecha
</aside>
<aside> ❗de las relaciones entra y sale una sola flecha
</aside>

### arcos etiquetados (roles)

- se utilizan cuando una misma entidad participa más de una vez en una misma relación pero con diferentes roles
- **ejemplo →** una persona puede realizar un arriendo desde dos perspectivas: como **cliente** o como **cajero**
## jerarquía de clases

- básicamente una clase madre (superclases) con clases hijas (subclases) :P
- se usa IsA (”es una” o “es un” en inglés)
- **por ejemplo:** bebidas se puede dividir en dos →
- **restricciones:**
	- generalización: bebida generaliza vino y cerveza (⭣)
	- especialización: vino y cerveza especializan a bebida (⭡)
	- solapamiento: ¿se permite que dos subclases contengan la misma entidad?
	- si no hay solapamiento, no hay intersecciones entre las entidades
	- cobertura: ¿todas las subclases son la superclase? aquí no con fe otra vez
	- si sí hay cobertura, todas las clases hijas juntas son la totalidad de la clase madre
## restricciones avanzadas

- multiplicidad de relaciones (check)
- **participación + multiplicidad →** cada profesor (todos =) trabajan en una o muchas universidades (al menos una (1,N)

| (0,1) :       | 0 o 1 (no más)                 |
| ------------- | ------------------------------ |
| (1, ) o (1,N) | 1 o muchos / al menos 1 (no 0) |
| (1,1)         | uno solo (no 0 ni más de 1)    |
| =             | participación total (cada uno) |

## entidades débiles

→ las **entidades débiles** son aquellas cuya **clave** **depende** de la **clave** de **otra entidad**

<aside> ❗dos entidades nunca pueden compartir llaves
</aside>

**ejemplo: entidades curso y evaluación →** las evaluaciones no pueden existir sin un curso a ser evaluado

- curso:
    - código (llave)
    - nombre
- evaluación (participación total =):
    - nombre (llave parcial)
    - fecha

**ejemplo: agregamos la entidad notas →**

<aside> ☝ las notas necesitan evaluaciones para existir y las evaluaciones necesitan cursos para existir
</aside>

**ejemplo: agregamos nombre del alumno y notas diferentes por pregunta →**

- preguntas es la **llave parcial** de la entidad nota
- las notas pertenecen a otra entidad llamada alumna con llave dni y atributo nombre

<aside> ☝ un alumno puede tener varias notas en varias evaluaciones en un mismo curso
</aside>

---
next: [[modelo relacional]]
tags: [[bd]]