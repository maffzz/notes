
| a cada tabla se le llama una relación | a cada columna se le llama **atributo** | a cada fila se le llama una **tupla** |
| ------------------------------------- | --------------------------------------- | ------------------------------------- |

- para denominar una relación con sus atributos:
    - **relación1(atributo1, atributo2, …)**
    - **relación1_atributo1**
    - **relación2_atributo1**
- **esquema relacional →** estructura de una tabla: nombre + atributos. un conjunto de **relaciones** (tablas) forma un **esquema de base de datos relacional**
- **dominio**: tipo de dato de cada atributo:
    - **relación1(tributo 1: string, atributo2: int, …)**
- **instancia**: contenido actual de una tabla (las **tuplas** que tiene en un momento). la instancia puede cambiar con el tiempo
## restricciones

<aside> ❗no hay un orden en las filas (tuplas)
</aside>
<aside> ❗no se puede tener tuplas duplicadas en teoría relacional
</aside>

**→ súper llave:** atributo o conjunto de atributos que ayuda a identificar una tupla, la diferencia de las demás. no puede haber dos filas con los mismos valores en todos los atributos que forman esa llave

**→ _llave candidata_:** una súper llave que no tiene un subconjunto propio de esos atributos que tmb sea una súper llave. la llave que tiene la menor cantidad de atributos. es lo mínimo necesario para identificar filas únicas. si le quitamos algún atributo, ya no funciona como llave. se escoge una de las _**llaves candidatas**_ para ser _**llave primaria**_

---
**→** el tema de las llaves se soluciona colocando **ID** como atributo :P dice q no es la mejor solución pero equis
**→ no** es una buena práctica inicializar columnas como nulas (NAs)

next: [[álgebra relacional]]

---

tags: [[bd]]