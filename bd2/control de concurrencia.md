
transacción : ACID
- Atomicidad -> todas las transacciones deben ejecutarse correctamente. se hace todo o no se hace nada
- Consistencia -> cuando se hace commit, se verifican todas las restricciones de la base de datos 
- aIslamiento -> cuando hayan n transacciones concurrentes, deben aislarse y ejecutarse todas por separado
- Durabilidad -> cuando una transacción hace commit, esos cambios deben reflejarse en memoria secundaria

# planificación de transacciones concurrentes

-> tiene problemas que no tiene la planificación secuencial
-> las transacciones copian en su memoria propia una copia del atributo en memoria compartida (disco)
-> problema de actualización perdida
-> dependencia no confirmada
-> cada transacción tiene su propia área de trabajo
# planificaciones serializables
-> da el mismo resultado que usar planificación secuencial
## crear grafo de precedencia

1) i escribe x y j lee x
2) i lee x y j escribe x
3) i escribe x y j escribe x

- si el grafo es cíclico, no es serializable
- si el grafo no es cíclico, es serializable

que sea serializable significa que el resultado es equivalente al de una planificación secuencial
¿a cuál?
ordenamiento topológico en grafos
# técnicas de control de concurrencia

## técnicas de bloqueo
una transacción bloquea una tabla, una tupla, una columna. el bloqueo se da a nivel de tablas. otra transacción no puede acceder a ella
### bloqueo exclusivo (protocolo PX)

- no permite que otras transacciones accedan al recurso
- la otra transacción va a esperar hasta que ese recurso sea desbloqueado

```
data: an element X of the db
result: update of variable block(X)

B ->
	if block(X) == 0 then
		block(X) = 2
	else
		wait(until block(X) = 0 and DBMS wakes up the transaction)
		go to B
	end
end
```
### bloqueo compartido (protocolo PS)

- cuando otra transacción solicita el recurso con el mismo protocolo, se le concede el acceso
- si otra transacción quiere bloqueo exclusivo, debe esperar

```
data: an element X of the db
result: update of variable block(X)

B ->
	if block(X) == 0 then
		block(X) = 1
		num_read = 1
	else
		if block(X) == 1 or block(X) == 3 then
			num_read += 1
		else
			wait(until block(X) = 0 and DBMS wakes up the transaction)
			go to B
		end
	end
end
```
### bloqueo de actualización (protocolo PU)

- es compatible con el bloqueo compartido. si una transacción solicita bloqueo compartido al mismo recurso, se le concede
- si una transacción solicita bloqueo exclusivo o bloqueo de actualización al mismo recuso, no se le concede

```
data: an element X of the db
result: update of variable block(X)

B ->
	if block(X) == 0 then
		block(X) = 3
		num_read = 1
	else
		if block(X) == 2 then
			wait(until block(X) = 0 and DBMS wakes up the transaction)
			go to B
		else
			num_read += 1
		end
	end
end
```
### algoritmo de liberación

```
data: an element X of the db
result: update of variable block(X)

B ->
	if block(X) == 2 then
		block(X) = 0
		wake up the waiting transactions
	else
		if block(X) == 1 then
			num_read -= 1
			if num_read == 0 then
				block(X) = 0
				wake up the waiting transactions
		end
	end
end
```
---
next: [[recuperación de bases de datos]]
tags: [[bd]]