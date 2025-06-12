
- una transacción es una unidad lógica de procesamiento de base de datos
- lectura del elemento X -> R(X)
- escritura del elemento X -> W(X)
- confirmación -> C
- aborto -> A
- las transacciones constan de varias sub-operaciones
## tipos de conflictos

- actualización perdida (conflicto WW) : una <mark class="hltr-green">transacción</mark> reescribe los cambios que <mark class="hltr-green">otra</mark> ya había escrito
	- **ejemplito ->** cuando quieres reservar una sala de estudio y te pide iniciar sesión, pero en lo que inicias sesión otra persona te gana y lo reserva
- lectura sucia (conflicto WR) : una <mark class="hltr-green">transacción</mark> lee lo que <mark class="hltr-green">otra</mark> escribió pero aún no estaba confirmado
	- **ejemplito ->** cuando quieres reservar una sala de estudio y te sale que ya no hay más pero resulta que si habían pero estaban bloqueadas en ese momento
	- **ejemplito ->** cuando en yape quieres revisar tu saldo, lo revisas y justo después te yapean
- lectura no repetible (conflicto RW) : una <mark class="hltr-green">transacción</mark> sobreescribe un dato que <mark class="hltr-green">otra</mark> ya había leído pero aún no estaba confirmado
	- **ejemplito ->** cuando lees una fila de una tabla, se actualiza y cuando vuelves a leerla no es lo mismo
## en sql WAAA

```postgresql
START TRANSACTION;
	INSERT INTO hola VALUES (a1, a2, a3);
	-- COMMIT; (por defecto)
	UPDATE hola SET hi='a4';
	-- COMMIT; (por defecto)
ROLLBACK; -- elimina todos los cambios de la transacción
SAVEPOINT nombre_del_checkpoint; -- un checkpoint
ROLLBACK to nombre_del_checkpoint;
```
## <mark class="hltr-red">A</mark><mark class="hltr-blue">C</mark><mark class="hltr-yellow">I</mark><mark class="hltr-green">D</mark>
### <mark class="hltr-red">atomicidad</mark>
- se realizan todas las transacciones o no se realiza ninguna
- si no -> una transacción se hace a medias
### <mark class="hltr-blue">consistencia</mark>
- después de que se ejecute una transacción, se siguen satisfaciendo todas las restricciones
- si no -> 
### <mark class="hltr-yellow">aislamiento</mark>
- una transacción no puede afectar el funcionamiento de otra transacción
### <mark class="hltr-green">durabilidad</mark>
- si la transacción ha salido bien, entonces los commits se van a mantener en el tiempo en el disco duro
## modelado de una transacción

siendo un objeto X una tupla, fila, valor, etc.:
- leer(X) : leer un objeto X de la base de datos a memoria principal
- escribir(X) : escribir un objeto de memoria principal a la base de datos
### registros (logging) | archivos .log

<aside>☝ mantener un registro de la transacción | se guardan en</aside>

- **ayudan cooon ->**
	- atomicidad : permite hacer rollback si falla
	- consistencia : permite restaurar estados válidos
	- durabilidad : guarda commits permanentemente
- **no ayudan cooon ->** 
	- aislamiento : no previene interferencia entre transacciones simultáneas

### solución : ejecución serial

<aside>☝ siendo A = 400 y B = 200 -></aside>

#### ejercicio 1 : suma de A+B = 270+330 = 600
```sql
-- T1   
LEER(A)
A <- A-100
ESCRIBIR(A)
			-- T2
			LEER(A)
			v <- A*0.1
			A <- A-v
			ESCRIBIR(A)
-- T1			
LEER(B)
B <- B+100
ESCRIBIR(B)
			-- T2
			LEER(B)
			B <- B+v
			ESCRIBIR(B)
```
#### ejercicio 2: suma de A+B = 260+340 = 600
```sql
			-- T2
			LEER(A)
			v <- A*0.1
			A <- A-v
			ESCRIBIR(A)
			LEER(B)
			B <- B+v
			ESCRIBIR(B)
-- T1   
LEER(A)
A <- A-100
ESCRIBIR(A)
LEER(B)
B <- B+100
ESCRIBIR(B)
```
#### ejercicio 3: conflicto WW
```sql
-- T1   
LEER(A)
A <- A-100 -- quiere poner 300
			-- T2
			LEER(A)
			v <- A*0.1
			A <- A-v
			ESCRIBIR(A) -- lo cambia a 330
-- T1
ESCRIBIR(A) -- oh no | cambia a 300
LEER(B)
B <- B+100
ESCRIBIR(B)
			-- T2
			LEER(B)
			B <- B+v
			ESCRIBIR(B)
```
### plan secuenciable vs no secuenciable

- secuenciable : guarda lo que hace instantáneamente | tiene el mismo efecto que una planificación serial
```sql
LEER(X); X <- X-Y; ESCRIBIR(X) -- hace algo y lo guarda ahí mismito
```
- no secuenciable : demora en guardar los cambios que hace | no tiene el mismo efecto que una planificación serial
```sql
LEER(X); X <- X-Y; -- montón de cosas | más transacciones
ESCRIBIR(X) -- recién escribe
```
- para planificar un plan secuenciable hay que saber identificar los 3 tipos de conflictos

---
next: [[base de datos no relacional]]
tags: [[bd]]