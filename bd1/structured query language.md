- lenguaje de manipulación de datos : actualizar datos, consultar tablas
- lenguaje de definición de datos : crear datos, definir tablas
- disparadores (triggers), transacciones, seguridad, sql dinámico

```sql
SELECT [atributo]
FROM [tabla]
WHERE [condición]
```

<aside> ☝ SELECT → proyección (π) | WHERE → selección (σ)
</aside>

## ejemplitos →

```sql
-- * indica todo
SELECT *
FROM persona
-- edad diferente de 10
WHERE edad <> 10
```

```sql
-- no selecciona solo los únicos
SELECT planeta
FROM aterrizaje
```

```sql
-- ordenar resultados
SELECT *
FROM aterrizaje
-- edad desc y nave asc
ORDER BY edad DESC, nave
```

```sql
-- renombramiento de columnas
SELECT S.planeta AS splaneta
FROM satélite S, aterrizaje A
WHERE S.planeta = A.planeta
```

```sql
-- unión : no hay duplicados
-- misma cantidad de atributos
SELECT nombre
FROM planeta
UNION
SELECT nombre
FROM satélite
```

```sql
-- unión all : sí hay duplicados
SELECT nombre as planeta
FROM planeta
UNION ALL
SELECT nombre
FROM satélite
```

```sql
-- intersect : no hay duplicados
SELECT nombre as planeta
FROM planeta
WHERE dist > 1.00
INTERSECT
SELECT planeta
FROM satélite
```

```sql
-- not like : patrones simples
SELECT nombre
FROM planeta
-- planetas que no terminan con no
WHERE nombre NOT LIKE '%no'
      AND dist > 1.00
```

```sql
-- in : abreviatura
SELECT planeta
FROM aterrizaje
-- países de este conjuntito
WHERE país IN ('EEUU','ESA')
```

```sql
-- cross join : producto cartesiano
-- sí hay duplicados
SELECT nombre, S.planeta, nave
FROM satélite S
     CROSS JOIN aterrizaje
```

```sql
-- join using
SELECT nombre, planeta
FROM satélite
-- equivalentes
WHERE aterrizaje USING (planeta)
```

```sql
-- natural join
-- une por lo que comparten
SELECT nombre, planeta
FROM satélite
     NATURAL JOIN aterrizaje
```

```sql
-- natural join : igual al de arriba
SELECT nombre, planeta
FROM satélite
     JOIN aterrizaje
     -- la tabla comparte esto
     USING (planeta, año)
```

```sql
-- left [outer] join
SELECT nave, nombre
FROM planeta LEFT JOIN aterrizaje
ON nombre = planeta
```

```sql
-- right [outer] join
SELECT nave, nombre
FROM aterrizaje RIGHT JOIN planeta
ON nombre = planeta
```

```sql
-- is null : valores nulos
SELECT nombre
FROM satélite
WHEN descubridor IS NULL
```

```sql
-- coalesce : elije el primer dato no nulo y reemplaza por 0
SELECT nombre, 
			COALESCE(año,0) AS _año
FROM satélite
ORDER BY _año
```

```sql
-- algunos atributos
SELECT nombre, dist
FROM persona
-- no tiene prestamo
WHERE prestamo IS FALSE
```

```sql
-- selecciona solo los únicos
SELECT DISTINCT nombre
FROM planeta
```

```sql
SELECT nombre
-- la coma hace el join
FROM planeta, aterrizaje
-- condicones del join
WHERE nombre = planeta
      AND dist > 1.00
      AND año >= 2000
```

```sql
-- renombramiento de tablas
SELECT s1.nombre AS nombre1,
       s2.nombre AS nombre2
FROM satélite s1, satélite s2
WHERE s1.anio = s2.anio 
AND s1.nombre < s2.nombre
```

```sql
-- toma el valor reprobado
SELECT nombre as planeta
FROM planeta
UNION
SELECT nombre
FROM satélite
```

```sql
-- except : resta - diferencia
SELECT nombre as planeta
FROM planeta
WHERE dist > 1.00
EXCEPT
SELECT planeta
FROM satélite
```

```sql
-- like: patrones simples
SELECT nombre
FROM planeta
-- planetas que empiezan con M
WHERE nombre LIKE 'M%'
```

```sql
SELECT nombre
FROM clase
WHERE nombre LIKE 'M%'
      AND carrera = datos
```

```sql
-- between : abreviatura
SELECT planeta
FROM aterrizaje
-- años en ese rango cerrado
WHERE año BETWEEN 1971 AND 1978
```

```sql
-- equi join : solo basta el =
SELECT nombre
FROM planeta, aterrizaje
-- equivalentes
WHERE nombre = planeta
```

```sql
-- equi join : igual al de arriba
SELECT nombre
FROM planeta JOIN aterrizaje
-- equivalentes
ON nombre = planeta
```

```sql
-- self join
SELECT A1.planeta, A2.planeta
FROM aterrizaje A1, aterrizaje A2
ON A1.anio = A2.anio
   AND A1.planeta <> A2.planeta
```

```sql
-- inner join
SELECT nave, nombre
FROM planeta INNER JOIN aterrizaje
ON nombre = planeta
```

```sql
-- inner join : join xd
-- equivalente al de arriba
SELECT nave, nombre
FROM planeta JOIN aterrizaje
ON nombre = planeta
```

```sql
-- full [outer] join
SELECT nave, nombre
FROM planeta FULL JOIN aterrizaje
ON nombre = planeta
```

```sql
-- is not null : valores no nulos
SELECT nombre
FROM satélite
WHEN descubridor IS NOT NULL
```

```sql
-- coalesce
SELECT nombre, COALESCE(edad,18)AS _edad
FROM clientes
WHERE prestamo = true
      AND vivienda = true
ORDER BY edad
```
## consultas anidadas →

```sql
-- where/in
SELECT nave, planeta
FROM aterrizaje
WHERE planeta IN
      (SELECT nombre
       FROM planeta
       WHERE grav > 9.8)
AND año > 2000
```

```sql
-- where/not in
SELECT nave, planeta
FROM aterrizaje
WHERE planeta NOT IN
      (SELECT nombre
       FROM planeta
       WHERE grav > 9.8)
AND año > 2000
```

```sql
-- where/exists
SELECT nombre, dist
FROM planeta
WHERE EXISTS
      (SELECT *
       FROM aterrizaje
       WHERE año >= 2000 
             AND nombre = planeta)
```

```sql
-- where/not exists
SELECT nombre, dist
FROM planeta
WHERE NOT EXISTS
      (SELECT *
       FROM aterrizaje
       WHERE año >= 2000 
             AND nombre = planeta)
ORDER BY dist DESC
```

<aside> ☝ las consultas anidadas deben devolver solo una fila y solo una columna
</aside>

```sql
-- consultas anidadas por fila
SELECT S1.nombre, S1.planeta
FROM satélite S1
WHERE (S1.año, S1. descubridor) =
   (SELECT S2.año, S2.descubridor
    FROM satélite S2
    WHERE S2.planeta = "Júpiter")
```

```sql
SELECT A1.aprobarBD1 = true **# xd**
```

```sql
-- equivalente al costado
SELECT nave, P.planeta
FROM aterrizaje A, planeta P
WHERE A.planeta = P.nombre
      AND grav > 9.8
      AND año > 2000
-- no era necesaria una subconsulta
```

```sql
-- where/not in
SELECT nave, planeta
FROM aterrizaje
WHERE planeta NOT IN
      (SELECT nombre
       FROM planeta
       WHERE grav > 9.8
       OR planeta IN
      (SELECT planeta
       FROM aterrizaje
       WHERE país = "ESA"))
AND año > 2000
-- monstruo
```

```sql
-- where/[not] unique
SELECT nombre, dist
FROM planeta
WHERE [NOT] UNIQUE      
      (SELECT *
       FROM aterrizaje
       WHERE nombre = planeta)
ORDER BY dist DESC
-- no para postgres buuu
```

```sql
-- where/any
-- where/some
SELECT nombre, dist
FROM planeta P1
WHERE P1.grav > ANY
      (SELECT P2.grav
       FROM planeta p2
       WHERE P2.dist > 1.00)
ORDER BY P1.dist DESC
```

```sql
-- consultas anidadas from
SELECT nombre, grav
FROM
 (SELECT A1.planeta
  FROM aterrizaje A1, aterrizaje A2
  WHERE A1.planeta = A2.planeta
        AND A1.país <> A2.país)
  multi.planeta -- alias
  WHERE nombre = multi.planeta
        AND grav > 8.0
  ORDER BY grav
```

## agregación →

<aside> ☝ operadores COUNT([DISTINCT] A) | SUM([DISTINCT] A) | AVG([DISTINCT] A) | MAX(A) | MIN(A)
</aside>

```sql
-- avg
SELECT AVG(año) AS promedio
FROM aterrizaje
```

```sql
-- avg disctinct dentro
SELECT AVG(DISTINCT año) AS promedio
FROM aterrizaje
```

```sql
-- avg con casting
SELECT AVG(CAST(año AS FLOAT)) AS promedio
FROM aterrizaje
```

```sql
-- min
SELECT MIN(año) AS mínimo
FROM aterrizaje
```

<aside> ☝ cuando hay operadores de agregación solo se puede devolver una fila. se deben usar consultas anidadas o group by
</aside>

```sql
-- min anidado
SELECT A1.planeta, A1.anio
FROM aterrizaje A1
WHERE A1.anio =
      (SELECT MIN(A2.anio)
       FROM aterrizaje A2)
```

```sql
SELECT grupos, COUNT(*) as personas
FROM estadística
HAVING personas > 5 -- falso
GROUP BY grupos
```

```sql
-- count
SELECT COUNT(planeta) AS conteo
FROM aterrizaje
```

```sql
-- count distinct afuera : total de filas
SELECT DISTINCT COUNT(planeta) 
       AS conteo
FROM aterrizaje
```

```sql
-- count distinct dentro : valores únicos
SELECT COUNT(DISTINCT planeta) 
       AS conteo
FROM aterrizaje
```

```sql
-- count dentro * : filas totales
SELECT COUNT(*) AS conteo
FROM aterrizaje
```

```sql
-- group by
SELECT planeta, COUNT(*) AS conteo
FROM aterrizaje
GROUP BY planeta
```

```sql
-- group by/having
SELECT planeta, COUNT(*) AS conteo
FROM aterrizaje
GROUP BY planeta
HAVING MAX(año) < 2000
```

```sql
-- group by/having/every
SELECT planeta, COUNT(*) AS conteo
FROM aterrizaje
GROUP BY planeta
HAVING EVERY(año BETWEEN 2000 AND 2005)
```

```sql
-- group by/having/any
SELECT planeta, COUNT(*) AS conteo
FROM aterrizaje
GROUP BY planeta
HAVING bool_or(año BETWEEN 2000 AND 2005)
```
## limitar resultados →

```sql
-- ordenar
SELECT *
FROM aterrizaje
ORDER BY año DESC, nave
```

```sql
-- top x : devuelve las primeras x filas
SELECT TOP 3 *
FROM aterrizaje
ORDER BY año DESC, nave
```

```sql
-- row_number() : devuelve las x filas
SELECT * FROM 
  (SELECT ROW_NUMBER()
   OVER (ORDER BY año DESC, nave)
   AS row, * 
   FROM aterrizaje)
AS ans
WHERE row <= 3
```

```sql
-- fetch first x rows only
SELECT *
FROM aterrizaje
ORDER BY año DESC, nave
FETCH FIRST 3 ROWS ONLY
```

```sql
-- limit x : devuelve x resultados
SELECT *
FROM aterrizaje
ORDER BY año DESC, nave
LIMIT 3
```

```sql
-- offset (x) + limit (n) : saltar x filas y mostrar n
SELECT *
FROM aterrizaje
ORDER BY año DESC, nave
OFFSET 1 LIMIT 3
```

<aside> ☝ funciones aritméticas | ABS(A) | CEIL(A) o CEILING(A) | FLOOR(A) | EXP(A,B) o POWER(A,B) | ROUND(A) o ROUND(A,B) | SQRT(A)
</aside>

<aside> ☝ funciones para strings | LOWER(A) o LCASE(A) | UPPER(A) o UCASE(A) | TRIM(A) | SUBSTRING(A,B) o SUBSTRING(A,B,C) | STARTSWITH(A,B)
</aside>

<aside> ☝ funciones condicionales | IF... | THEN... | ELSE IF... ELSE ... | CASE... | WHEN.. THEN... | ELSE...
</aside>
## gestionar y crear tablas →

```sql
CREATE DATABASE name -- crear base de datos
[[ WITH ] [ OWNER [=] user_name]
[TEMPLATE [=] template]
[ENCODING [=] encoding]
[CONNECTION LIMIT [=] connlimit]]
```

```sql
CREATE SCHEMA SistemaSolar -- crear un esquema
-- solo lectura
GRANT USAGE ON SCHEMA SistemaSolar TO uniqua
-- todos los permisos
GRANT ALL PRIVILEGES ON SCHEMA SistemaSolar TO maf
```

```sql
CREATE TABLE SistemaSolar.Aterrizaje ( -- añadir tabla Aterrizaje al esquema SistemaSolar
	nave VARCHAR (255),
	planeta VARCHAR (255),
	pais VARCHAR (255),
	año SMALLINT);
DROP TABLE SistemaSolar.Aterrizaje; -- eliminar la tabla Aterrizaje del esquema**
```

```sql
SET search_path = my_schema, "$user", public; -- para la sesión actual
ALTER ROLE your_role SET search_path = my_schema, "$user", public; -- para siempre
```

```sql
CREATE SCHEMA SistemaSolar; -- crear una agrupación de tablas
SHOW search_path; -- public
ALTER USER maf SET search_path TO SistemaSolar, public;
CREATE TABLE Aterrizaje ( ... );
```

## llenar y actualizar tablas →

```sql
CREATE TABLE Aterizaje (...);
INSERT INTO Aterrizaje VALUES ("Messenger","Mercurio","EEUU",2015) -- insertar valores en Aterrizaje
INSERT INTO Aterrizaje (país, nave, planeta) VALUES ("EUUU","Messenger","Mercurio") -- setear orden del insertar
```

```sql
CREATE TABLE AterrizajeEEUU (...);
-- llenar nueba tabla con un query
INSERT INTO AterrizajeEEUU (SELECT * FROM Aterrizaje WHERE país="EEUU")
```

```sql
UPDATE Aterrizaje SET año=1971, país=ERRS WHERE nave="Mars 2 lander"
-- reemplazar con condiciones
```

```sql
DELETE FROM AterrizajeEEUU WHERE año IS NULL -- eliminar filas con condiciones
```

```sql
ALTER TABLE AterrizajeEEUU DROP COLUMN país -- eliminar columnas
```

```sql
ALTER TABLE AterrizajeEEUU ADD COLUMN despegue DATE -- agregar columna con su tipo de datos
```

```sql
ALTER TABLE AterrizajeEEUU ALTER COLUMN despegue VARCHAR (255) -- actualizar tipo de dato de columnas
```

```sql
COPY Aterrizaje FROM "/home/maf/aterrizaje.tsv" DELIMITER E"\\t" -- mismo orden que en la tabla
```
## restricciones →

### llaves, nulos y dominios →

```sql
CREATE TABLE Cuenta (
	-- primary key: declara llaves
	número BIGINT PRIMARY KEY, 
	-- not null: prohíbe nulos
	-- dominios: tipos de dato
	rut VARCHAR (12) NOT NULL, 
	tipo VARCHAR (12) NOT NULL,
	saldo_clp BIGINT NOT NULL,
	saldo_usd DOUBLE PRECISION NOT NULL);
```

### unicidad →

```sql
CREATE TABLE Cuenta (
	número INTEGER PRIMARY KEY,
	rut VARCHAR (12) NOT NULL,
	tipo VARCHAR (12) NOT NULL,
	saldo_clp BIGINT NOT NULL DEFAULT O,
	saldo_usd FLOAT NOT NULL DEFAULT O,
	-- el par (rut,tipo) no debe repetirse
	UNIQUE (rut, tipo))
```
### llaves foráneas →

```sql
CREATE TABLE Ingreso (
	-- references: declara llave foránea
	cuenta BIGINT REFERENCES Cuenta(número),
	comentario VARCHAR (255),
	fecha DATE NOT NULL,
	hora TIME NOT NULL,
	monto BIGINT NOT NULL,
	saldo INT NOT NULL,
	id VARCHAR (12) PRIMARY KEY)
```
### sobre varias columnas →

```sql
CREATE TABLE Cuenta (
	número BIGINT PRIMARY KEY,
	rut VARCHAR (12) NOT NULL,
	tipo VARCHAR (12) NOT NULL,
	saldo_clp BIGINT NOT NULL,
	saldo_usd DOUBLE PRECISION NOT NULL,
	-- verificación con ecuación y columnas
	CHECK (ROUND(
		(saldo_clp/saldo_usd)::NUMERIC - 652.175,1) = 0))
```
### sobre varias tablas →

```sql
CREATE TABLE Cuenta (
	número BIGINT PRIMARY KEY,
	rut VARCHAR (12) NOT NULL,
	tipo VARCHAR (12) NOT NULL,
	saldo_clp BIGINT NOT NULL,
	saldo_usd DOUBLE PRECISION NOT NULL,
	-- verificación con ecuación y query
	CHECK (ROUND(
		(saldo_clp/saldo_usd)::NUMERIC -
			(SELECT valor
			 FROM Divisa
			 WHERE d1='USD' AND d2='CLP'), 1) = 0))
```

```sql
CREATE TABLE Ingreso (
	cuenta INTEGER,
	CHECK(
		(SELECT COUNT(*) FROM Ingreso I
		 WHERE I.fecha=fecha AND I.cuenta=cuenta) +
		(SELECT COUNT (*) FROM Gasto G
		 WHERE G. fecha=fecha AND G.cuenta=cuenta) < 1000))
```
### tipos →

- no se pueden comparar ni usar operaciones de otros tipos base

```sql
CREATE TYPE c_no_t UNDER BIGINT
CREATE TABLE Ingreso (
	cuenta c_no_t, ...)
CREATE TABLE Cuenta (
	número c_no_t PRIMARY KEY, ...)
```

<aside> ☝ postgres solo soporta tipos compuesto
</aside>

```sql
CREATE TYPE valor AS (clp BIGINT, usd DOUBLE PRECISION)
CREATE TABLE Cuenta AS (numero..., saldo valor);
INSERT INTO Cuenta VALUES (
	7873698669, '32.000.273-K', 'Estacional',
	ROW(225000, 344.94));
```
### valores por defecto →

```sql
CREATE TABLE Cuenta (
	número BIGINT PRIMARY KEY, rut VARCHAR (12) NOT NULL,
	tipo VARCHAR (12) NOT NULL,
	-- default: setea valores iniciales
	saldo_clp BIGINT NOT NULL DEFAULT 0,
	saldo_usd DOUBLE PRECISION NOT NULL DEFAULT 0);
```
### nombrar y borrar restricciones →

```sql
CREATE TABLE Cuenta (
	número INTEGER,
	rut VARCHAR (12) NOT NULL,
	tipo VARCHAR (12) NOT NULL,
	saldo_clp BIGINT NOT NULL DEFAULT 0,
	saldo_usd FLOAT NOT NULL DEFAULT O,
	-- constraint: nombra restricciones
	CONSTRAINT cuenta_uni_rt UNIQUE (rut,tipo),
	CONSTRAINT cuenta_pk PRIMARY KEY (número))
```

```sql
-- eliminar una restricción
ALTER TABLE Cuenta DROP CONSTRAINT cuenta_uni_rt
```
### llaves compuestas →

```sql
CREATE TABLE Divisa (
	d1 VARCHAR (3),
	d2 VARCHAR (3),
	valor DOUBLE PRECISION,
	PRIMARY KEY (d1, d2))
```

```sql
CREATE TABLE Cambio (
	id VARCHAR (12),
	venta VARCHAR (3),
	compra VARCHAR (3),
	monto DOUBLE PRECISION,
	-- referencia como llaves foráneas
	FOREIGN KEY (venta, compra)
	REFERENCES Divisa(d1, d2),
	PRIMARY KEY (id, venta, compra)
```
### aserciones independientes →

```sql
CREATE ASSERTION MaxTransferenciasDiarias (
	CHECK (
		(SELECT MAX(num) FROM
			(SELECT COUNT (*) AS num FROM
				(SELECT * FROM Ingreso
				 UNION
				 SELECT * FROM Gasto) Trans
				GROUP BY fecha, cuenta) TransC)) < 1000)
```
### definir dominios y tipos →

<aside> ☝ se pueden comparar dominios con la misma base
</aside>

**varchar →**

```sql
CREATE DOMAIN tr_str VARCHAR (12) 
	CHECK (VALUE LIKE 'TRC%');
CREATE TABLE Ingreso (... 
	id tr_str PRIMARY KEY); 
CREATE TABLE Gasto (
	id tr_str PRIMARY KEY);
```

**integer →**

```sql
CREATE DOMAIN c_no BIGINT
	CHECK (VALUE > 999999999
				 AND VALUE <= 9999999999)
CREATE TABLE Ingreso (cuenta c_no, ...)
CREATE TABLE Cuenta (
	número c_no PRIMARY KEY, ...)
```

---

next: [[vistas y disparadores]]
tags: [[bd]]