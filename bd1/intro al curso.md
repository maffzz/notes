---

---
## 1. definición de base de datos
es un conjunto organizado de datos que permite su almacenamiento, acceso y manipulación de manera eficiente. se utilizan para gestionar grandes volúmenes de información en diversos ámbitos como empresas, gobiernos y aplicaciones digitales
### características principales:

- **estructurada:** los datos se organizan de manera lógica
- **persistente:** se almacenan de manera permanente
- **compartida:** puede ser utilizada por múltiples usuarios
- **relacionada:** los datos pueden estar vinculados entre sí

---
## 2. sistemas de gestión de bases de datos (DBMS)
un **DBMS** (Database Management System) es un software que facilita la creación, manipulación y administración de bases de datos
### funciones principales:

- **definir** la estructura de la base de datos
- **almacenar** y recuperar datos de manera eficiente
- **controlar** la integridad y seguridad de los datos
- **facilitar** el acceso concurrente a los datos

ejemplos de **DBMS**: MySQL, PostgreSQL, Oracle, SQL Server, MongoDB

---
## 3. tipos de bases de datos

1. **bases de datos jerárquicas:** datos organizados en una estructura de árbol
2. **bases de datos en red:** relaciones más complejas que las jerárquicas
3. **bases de datos relacionales (RDBMS):** datos organizados en tablas y relacionados entre sí mediante claves primarias y foráneas
4. **bases de datos NoSQL:** diseñadas para trabajar con grandes volúmenes de datos no estructurados (ejemplo: MongoDB, Cassandra)
5. **bases de datos distribuidas:** los datos están repartidos en varios servidores

---
## 4. ventajas del uso de un DBMS

- **reducción de redundancia:** evita duplicación de datos
- **integridad de los datos:** garantiza la exactitud y consistencia
- **seguridad:** protege los datos mediante permisos y autenticación
- **facilidad de acceso y consulta:** permite recuperar información de manera rápida
- **escalabilidad:** capacidad de manejar grandes volúmenes de datos
- **control de concurrencia:** múltiples usuarios pueden acceder simultáneamente sin conflictos

---
## 5. modelo relacional y SQL

el **modelo relacional** organiza los datos en tablas y establece relaciones entre ellas mediante:

- **claves primarias (PK):** identifican únicamente un registro
- **claves foráneas (FK):** relacionan una tabla con otra

**SQL (Structured Query Language)** es el lenguaje utilizado para gestionar bases de datos relacionales. permite:

- **definir datos:** `CREATE TABLE`, `ALTER TABLE`
- **manipular datos:** `INSERT`, `UPDATE`, `DELETE`
- **consultar datos:** `SELECT`, `JOIN`, `WHERE`

---
## 6. arquitectura de un DBMS

1. **nivel físico:** almacenamiento de datos en disco
2. **nivel lógico:** organización y relaciones de datos
3. **nivel de vista:** interfaz para los usuarios

tipos de usuarios en un DBMS:

- **usuarios finales:** consultan y manipulan datos
- **administradores de base de datos (DBA):** gestionan el sistema y la seguridad
- **desarrolladores:** crean aplicaciones que interactúan con la base de datos

---
## 7. transacciones y control de concurrencia

una **transacción** es una secuencia de operaciones que deben ejecutarse como una unidad lógica. debe cumplir con las propiedades **ACID**:

- **atomicidad:** todas las operaciones se completan o ninguna se ejecuta
- **consistencia:** la base de datos permanece en un estado válido antes y después de la transacción
- **aislamiento:** las transacciones no interfieren entre sí
- **durabilidad:** los cambios persisten incluso tras fallos del sistema

el **control de concurrencia** evita problemas cuando varios usuarios acceden simultáneamente a los datos

---
## 8. seguridad en bases de datos

para garantizar la seguridad, se implementan:

- **autenticación:** verificación de identidad del usuario
- **autorización:** permisos de acceso a los datos
- **cifrado:** protección de datos sensibles
- **copias de seguridad:** respaldo ante pérdidas de datos

---
## 9. tendencias en bases de datos

- big data y análisis de datos
- bases de datos en la nube
- bases de datos NoSQL para datos no estructurados
- uso de inteligencia artificial en la gestión de bases de datos

---
next: [[modelo entidad-relación]]
tags: [[bd]]