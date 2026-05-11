# parte 1 - exploración del catálogo del sistema

la base de datos guarda información sobre sus propias tablas:
- cuántas filas cree que tiene una tabla
- cuántas páginas ocupa
- qué columnas tiene
- qué tipo de dato tiene cada columna
- qué índices existen

antes de correr un query, <mark class="hltr-yellow">el optimizador piensa</mark> algo como:
- esta tabla es pequeña o grande?
- conviene leerla completa?
- conviene usar índice?
- conviene hacer hash join o nested loop?
y <mark class="hltr-blue">para decidir eso usa estadísticas del catálogo</mark>
## consulta A

mostrar por tabla:
- número estimado de filas
- número estimado de páginas
- tamaño total
usando `pg_class` y `pg_namespace`

```sql
SELECT
    c.relname AS tabla,
    c.reltuples::BIGINT AS filas_estimadas,
    c.relpages AS paginas_estimadas,
    pg_total_relation_size(c.oid) AS tamaño_bytes,
    pg_size_pretty(pg_total_relation_size(c.oid)) AS tamaño_legible
FROM pg_class c JOIN pg_namespace n
	    ON n.oid = c.relnamespace 
	WHERE n.nspname = 'employees' AND c.relkind = 'r'
ORDER BY c.reltuples DESC;
```
## consulta B

mostrar:
- columnas
- tipos de dato
usando `pg_class`, `pg_namespace`, `pg_attribute`, `pg_type`

```sql
SELECT
    c.relname AS tabla,
    a.attnum AS posicion,
    a.attname AS columna,
    t.typname AS tipo_dato
FROM pg_class c JOIN pg_namespace n
	    ON n.oid = c.relnamespace
	JOIN pg_attribute a
	    ON a.attrelid = c.oid
	JOIN pg_type t
	    ON t.oid = a.atttypid
WHERE n.nspname = 'employees'
  AND c.relkind = 'r'
  AND a.attnum > 0
  AND NOT a.attisdropped
ORDER BY c.relname, a.attnum;
```
## consulta C

mostrar:
- índices existentes
- si están asociados a primary key
- columnas cubiertas
usando `pg_class`, `pg_namespace`, `pg_attribute`, `pg_index`

```sql
SELECT
    t.relname AS tabla,
    idx.relname AS indice,
    i.indisprimary AS es_primary_key,
    i.indisunique AS es_unique,
    string_agg(a.attname, ', ' ORDER BY a.attnum) AS columnas_indexadas
FROM pg_class t JOIN pg_namespace n
    	ON n.oid = t.relnamespace
	JOIN pg_index i
    	ON t.oid = i.indrelid
	JOIN pg_class idx
    	ON idx.oid = i.indexrelid
	JOIN pg_attribute a
    	ON a.attrelid = t.oid AND a.attnum = ANY(i.indkey)
WHERE n.nspname = 'employees' AND t.relkind = 'r'
GROUP BY
    t.relname,
    idx.relname,
    i.indisprimary,
    i.indisunique
ORDER BY t.relname, idx.relname;
```
# parte 2 - optimización de consultas

## ¿cuándo optimizar una consulta?

una consulta suele necesitar optimización cuando ves una o varias de estas señales:
### 1. hace demasiado trabajo

- une <mark class="hltr-brown">muchas tablas</mark>
- <mark class="hltr-brown">repite</mark> cálculos
- recorre tablas grandes <mark class="hltr-brown">completas</mark>
- genera muchas <mark class="hltr-brown">filas intermedias</mark>
### 2. tiene lógica redundante

- <mark class="hltr-pinky">misma subconsulta repetida</mark> varias veces
- <mark class="hltr-pinky">mismo filtro</mark> escrito en distintos sitios sin necesidad
### 3. usa mal la estructura de los datos

- trabaja con tablas históricas <mark class="hltr-red">sin filtrar primero</mark> registros vigentes
- hace `COUNT(DISTINCT ...)` porque antes generó duplicados evitables
### 4. `EXPLAIN ANALYZE` muestra cosas costosas

como:
- `Seq Scan` sobre tablas grandes
- muchos `loops`
- nodos con tiempos altos
- estimaciones muy alejadas de la realidad
- sorts pesados
- joins costosos

al hacer `EXPLAIN (ANALYZE, BUFFERS, FORMAT TEXT)`, siempre mirar:
- tipo de scan
- tipo de join
- filas estimadas y reales
- loops
- nodo más costoso
## ¿cuándo optimizar una subconsulta?

- aparece la misma subconsulta más de una vez
- depende de una fila externa
- hace agregaciones (`AVG`, `COUNT`, etc.)
- se ejecuta dentro de `WHERE` para cada fila
## ¿cuándo no optimizar con índices?

no tiene sentido crear índices:
- sobre tablas muy pequeñas
- sobre columnas que no se usan en filtros/joins
siempre se debe justificar con el acceso real de la consulta
## ejercicio 1: consulta con JOIN

**consulta original ->**

```sql
SELECT
 d.dept_name,
 AVG(s.amount) AS salario_promedio,
 COUNT(DISTINCT e.id) AS total_empleados
FROM employees.employee e,
 employees.department_employee de,
 employees.salary s,
 employees.department d
WHERE e.id = de.employee_id
 AND e.id = s.employee_id
 AND de.department_id = d.id
 AND de.to_date > CURRENT_DATE
 AND s.to_date > CURRENT_DATE
GROUP BY d.dept_name
ORDER BY salario_promedio DESC;
```
nos da el salario promedio y número de empleados por cada departamento

**analizando la consulta ->**

- usa JOINS implícitos, no usa JOIN ... ON : no vuelve más lenta la consulta pero puede no ser lo mejor en cuanto a legibilidad
- usa tablas periódicas y filtra como > CURRENT_DATE : si las tablas son grandes, el motor tiene que buscar dentro de mucho historial para encontrar los vigentes (son fechas)
- COUNT(DISTINCT e.id) es una pista de que antes del GROUP BY se generan duplicados
- no filtra lo antes posible (antes de los JOINs)

**consulta optimizada ->**

<mark class="hltr-green">1 reescribir con JOINs explícitos</mark>
```sql
SELECT 
	d.dept_name, 
	AVG(s.amount) AS salario_promedio, 
	COUNT(DISTINCT e.id) AS total_empleados
FROM employees.employee e  
	JOIN employees.department_employee de  
		ON e.id = de.employee_id  
	JOIN employees.salary s  
		ON e.id = s.employee_id  
	JOIN employees.department d  
		ON de.department_id = d.id
WHERE
	de.to_date > CURRENT_DATE
	AND s.to_date > CURRENT_DATE
GROUP BY d.dept_name
ORDER BY salario_promedio DESC;
```

<mark class="hltr-green">2 ¿qué columnas participan en JOINs y filtros?</mark>

JOINs : 
- e.id = de.employee_id
- e.id = s.employee_id  
- de.department_id = d.id

filtros :
- de.to_date > CURRENT_DATE
- s.to_date > CURRENT_DATE

<mark class="hltr-green">3 verificar en dónde crear índices útiles</mark>

tanto en los JOINs como en los filtros se usa la tabla `department_employee` : columnas `employee_id` y `to_date`

```sql
CREATE INDEX idx_de_employee_to_date
ON employees.department_employee (employee_id, to_date);
```

también podría servir de la misma tabla  `department_employee` : columnas `department_id` y `to_date`

```sql
CREATE INDEX idx_de_department_to_date
ON employees.department_employee (department_id, to_date);
```

tanto en los JOINs como en los filtros se usa la tabla `salary` : columnas `employee_id`y `to_date`porque de eso se trata la consulta

```sql
CREATE INDEX idx_salary_employee_to_date
ON employees.salary (employee_id, to_date);
```

> siempre basarse en las tablas que participan en los filtros y matchear con los JOINs

## ejercicio 2: consulta con subconsultas

**consulta original ->**

```sql
SELECT
	d.dept_name,
	( SELECT AVG(s.amount)
	  FROM employees.salary s
	  JOIN employees.department_employee de 
		  ON de.employee_id = s.employee_id
	  WHERE de.department_id = d.id
		  AND s.to_date > CURRENT_DATE
		  AND de.to_date > CURRENT_DATE ) AS promedio_depto
FROM employees.department d
WHERE
 ( 
	SELECT AVG(s.amount)
	FROM employees.salary s
	JOIN employees.department_employee de 
		ON de.employee_id = s.employee_id
	WHERE de.department_id = d.id
		AND s.to_date > CURRENT_DATE
		AND de.to_date > CURRENT_DATE 
)
>
(
	SELECT AVG(s2.amount)
	FROM employees.salary s2
	WHERE s2.to_date > CURRENT_DATE
)
ORDER BY promedio_depto DESC;
```
nos da los departamentos que tienen salario promedio mayor al salario global

**analizando la consulta ->**

- la consulta que calcula el salario promedio por departamento se repite 2 veces igualita
- la subconsulta hace el cálculo para cada departamento : esta se repite así que es aún más caro
- la consulta hace sobretrabajo:
	- calcula el promedio por departamento
	- vuelve a calcular el mismo promedio por departamento
	- calcula promedio global

**consulta optimizada ->**

separar:
1. promedio por departamento
2. promedio global
3. comparación final

<mark class="hltr-green">1 escribir con WITH las subconsultas</mark>

```sql
WITH 
promedio_departamento AS (
    SELECT
        de.department_id,
        AVG(s.amount) AS promedio_depto
    FROM employees.salary s
    JOIN employees.department_employee de
        ON de.employee_id = s.employee_id
    WHERE s.to_date > CURRENT_DATE
      AND de.to_date > CURRENT_DATE
    GROUP BY de.department_id),
promedio_global AS (
    SELECT AVG(amount) AS promedio_global
    FROM employees.salary
    WHERE to_date > CURRENT_DATE)
    
SELECT
    d.dept_name,
    pd.promedio_depto
FROM employees.department d
JOIN promedio_departamento pd
    ON pd.department_id = d.id
CROSS JOIN promedio_global pg
WHERE pd.promedio_depto > pg.promedio_global
ORDER BY pd.promedio_depto DESC;
```

<mark class="hltr-green">2 ¿qué columnas participan en JOINs y filtros</mark>

JOINs :
- de.employee_id = s.employee_id
- pd.department_id = d.id

filtros :
- s.to_date > CURRENT_DATE
- de.to_date > CURRENT_DATE

<mark class="hltr-green">3 verificar en dónde crear índices útiles</mark>

usamos la tabla `salary` con los atributos `employee_id`y `to_date`ya que se realiza con JOIN y un filtro con estos

```sql
CREATE INDEX idx_salary_employee_to_date
ON employees.salary (employee_id, to_date);
```

en la tabla `department_employee`usamos los atributos `employee_id`, `department_id` y `to_date` ya que se hace un JOIN, nos interesa agrupar por departamentos y se filtra por fecha

```sql
CREATE INDEX idx_de_employee_department_to_date
ON employees.department_employee (employee_id, department_id, to_date);
```
# parte 3 - procedimiento almacenado y triggers

esta parte introduce 3 conceptos importantes:
- tabla de auditoría -> guardar rastro de cambios
- trigger -> validar reglas automáticamente
- stored procedure -> ejecutar varios pasos de negocio en orden

lógica de negocio dada: 
	el historial de salarios no se modifica, se cierra el registro vigente y se inserta uno nuevo. cada ajuste debe quedar en una tabla de auditoría cuyo nombre incluye el año en curso (ej. audit_salary_2025), por lo que el INSERT de auditoría debe construirse dinámicamente
## ¿qué es un trigger?

un trigger es una acción automática que ocurre cuando pasa algún evento en una tabla

ejemplos de eventos:
- `INSERT`
- `UPDATE`
- `DELETE`
## ¿qué es un stored procedure?

una procedure es un bloque de lógica guardado dentro de la base de datos. se invoca con: `CALL employees.sp_ajustar_salario(...);`
## parte 1: creación de la tabla `audit_salary_2025`

```sql
CREATE TABLE IF NOT EXISTS employees.audit_salary_2025 (
	id BIGSERIAL PRIMARY KEY,
	employee_id BIGINT NOT NULL,
	old_amount BIGINT,
	new_amount BIGINT NOT NULL,
	changed_at TIMESTAMPTZ NOT NULL DEFAULT NOW() );
```

## parte 2: trigger - validar salario mínimo

aquí piden un trigger `BEFORE INSERT` sobre la tabla `employees.salary`. eso significa:

> **antes de insertar** una nueva fila en `salary`, postgreSQL ejecuta una función y decide si deja pasar o no el insert

el trigger debe funcionar así:
	cuando se hace un `INSERT`, postgreSQL crea una fila “nueva” todavía no guardada, llamada `NEW`. en una función trigger puedes revisar `NEW.amount`. entonces el razonamiento es:
	- si `NEW.amount < 30000` → lanzar error
	- si no → devolver `NEW` y dejar que se inserte

**creamos la función que usará el trigger ->**

```sql
CREATE OR REPLACE FUNCTION employees.fn_validar_salario()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
    IF NEW.amount < 30000 THEN
        RAISE EXCEPTION "no se puede insertar un salario menor a 30000. valor recibido: %", NEW.amount;
    END IF;
    RETURN NEW;
END;
$$;
```

**creamos el trigger que usa a la función ->**

```sql
CREATE OR REPLACE TRIGGER trg_validar_salario
BEFORE INSERT ON employees.salary
FOR EACH ROW
EXECUTE FUNCTION employees.fn_validar_salario();
```
## parte 3: procedimiento almacenado - ajustar salario

aquí piden el procedimiento `sp_ajustar_salario`. el paso de auditoría debe usar `EXECUTE` con el nombre de tabla construido a partir del año recibido como parámetro 

**pasos que debe seguir el procedimiento ->**

1. obtener salario vigente
2. cerrar registro de salario vigente (`to_date = CURRENT_DATE`)
3. insertar nuevo salario (el trigger valida el monto)
4. insertar auditoria, generar dinámicamente el nombre de la tabla según el año

como el nombre de la tabla cambia, no puedes dejar escrito un `INSERT INTO employees.audit_salary_2025` fijo para todos los casos. por eso se usa `EXECUTE`

**creamos el procedimiento ->**

```sql
CREATE OR REPLACE PROCEDURE employees.sp_ajustar_salario(
    p_employee_id BIGINT,
    p_nuevo_monto BIGINT,
    p_anio INT )
LANGUAGE plpgsql
AS $$
DECLARE
    v_old_amount BIGINT;
    
BEGIN

    -- 1. obtener salario vigente
    SELECT amount
    INTO v_old_amount
    FROM employees.salary
    WHERE employee_id = p_employee_id
	    AND to_date > CURRENT_DATE
    ORDER BY from_date DESC
    LIMIT 1;

    IF v_old_amount IS NULL THEN
        RAISE EXCEPTION "no se encontró salario vigente para el empleado %", p_employee_id;
    END IF;

    -- 2. cerrar registro vigente
    UPDATE employees.salary
    SET to_date = CURRENT_DATE
    WHERE employee_id = p_employee_id
      AND to_date > CURRENT_DATE;

    -- 3. insertar nuevo salario
    INSERT INTO employees.salary (employee_id, amount, from_date, to_date)
    VALUES (p_employee_id, p_nuevo_monto, CURRENT_DATE, DATE '9999-01-01');
    -- colocamos una fecha vieja para que funcione la lógica de los filtros hechos sí o sí 

    -- 4. insertar auditoría dinámicamente
    EXECUTE format (
        'INSERT INTO %I.%I (employee_id, old_amount, new_amount, changed_at)
         VALUES ($1, $2, $3, NOW())',
        'employees',
        'audit_salary_' || p_anio)
    USING p_employee_id, v_old_amount, p_nuevo_monto;
    
END;
$$;
```
# parte 4 - integración y concurrencia

esta parte es sobre entender cómo una aplicación en python puede:
- conectarse a la base de datos
- reutilizar conexiones
- llamar un procedimiento almacenado
- ejecutar varias llamadas al mismo tiempo
- observar qué pasa cuando hay errores o competencia entre hilos
aquí se ve la base de datos **como sistema real**, no solo como ejercicio de SQL
## configuración del pool de conexiones

```python
import psycopg2
from psycopg2 import pool, sql, errors
import threading
import random

# configurar con credenciales
DB_CONFIG = {
	"host": "localhost",
	"port": 55000,
	"dbname": "employees",
	"user": "postgres",
	"password": "postgres" }

# pool con mínimo 2 y máximo 10 conexiones
connection_pool = pool.ThreadedConnectionPool (
	minconn=2,
	maxconn=10,
	**DB_CONFIG )
```

## función para llamar al procedimiento almacenado

esta función debe:
1. pedir una conexión al pool
2. desactivar `autocommit` o manejar transacción correctamente
3. crear cursor
4. llamar a la procedure
5. si todo sale bien, `commit`
6. si falla, `rollback`
7. imprimir qué pasó
8. devolver la conexión al pool

```python
def ajustar_salario(employee_id: int, nuevo_salario: int, thread_id: int):
    conn = connection_pool.getconn() # pide una conexión al pool
    
    try:
        conn.autocommit = False # desactiva la confirmación automática
        with conn.cursor() as cur: # abre un cursor para ejecutar sql
	        # llamada al procedimiento de la parte 3
            cur.execute (
                "CALL employees.sp_ajustar_salario(%s, %s, %s);",
                (employee_id, nuevo_salario, 2025) ) 
        conn.commit() # confirma los cambios si todo salió bien
        print(f"[hilo {thread_id}] OK -> empleado {employee_id}, nuevo salario {nuevo_salario}")
    
    except Exception as e: # captura los errores
        conn.rollback() # hace rollback lol ahí dice :p
        print(f"[hilo {thread_id}] ERROR -> empleado {employee_id}, salario {nuevo_salario} | {e}")

    finally:
        connection_pool.putconn(conn) # devuelve la conexión al pool
```
## simulación concurrente

cada hilo debe poder:
- escoger un empleado de `EMPLEADOS_PRUEBA`
- escoger un salario nuevo al azar
- algunos salarios pueden ser válidos
- alguno puede ser inválido para probar trigger
arrancar todos los hilos y esperar que terminen

```python
EMPLEADOS_PRUEBA = [10001, 10002, 10003, 10004, 10005]

def simular_ajustes_concurrentes(n_hilos=6):
    threads = [] # guarda todos los hilos para luego esperar a que terminen
    salarios_prueba = [75000, 82000, 91000, 20000, 67000, 88000]
    
    # va creando cada hilo
    for i in range(n_hilos):
        employee_id = random.choice(EMPLEADOS_PRUEBA)
        nuevo_salario = salarios_prueba[i % len(salarios_prueba)]
        # crea un hilo que ejecutará el procedure
        t = threading.Thread (
            target=ajustar_salario,
            args=(employee_id, nuevo_salario, i + 1) )
        threads.append(t)
        t.start() # inicia el hilo
    
    for t in threads:
        t.join() # espera a que terminen todos
    
    print("simulación concurrente finalizada")
```
## verificación de auditoría

el lab ya da este código

```python
def ver_auditoria():
	conn = connection_pool.getconn()
	
	try:
		with conn.cursor() as cur:
			cur.execute("""
				SELECT employee_id, old_amount, new_amount, changed_at
				FROM employees.audit_salary_2025
				ORDER BY changed_at DESC
				LIMIT 20;
			""")
			rows = cur.fetchall()
			cols = [desc[0] for desc in cur.description]
		import pandas as pd
		df = pd.DataFrame(rows, columns=cols)
		display(df)
	
	finally:
		connection_pool.putconn(conn)

ver_auditoria()
```

en consola, debe decir algo como:
- hilos exitosos
- hilos que fallan por trigger
- quizá mensajes de error SQL
- al final, auditorías solo de las operaciones exitosas
si una operación falla, no debería aparecer en auditoría si la transacción hizo `rollback` correctamente

---
next: [[]]
tags: [[bd]]