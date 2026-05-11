# fallas del gestor de bases de datos

- fallas locales a la transacción
- fallas en el sistema
- fallas en los medios de almacenamiento
# recuperación basado en logs

estructura de los registros de log:
- inicio de la transacción 
- nombre de la transacción
- recurso al que modifica
- estado anterior
- cambio realizado

cada vez que la transacción aplica un write, se actualiza el recurso X y aparte tiene como alta prioridad guardar esa operación en la bitácora (CON ALTA PRIORIDAD). cada vez que el buffer del log se llena, se vacía en un heap sin ningún tipo de indexación, se guarda al final

deshacer transacción: acción de colocar las imágenes antes (estado anterior) de los registros modificados por una transacción
rehacer transacción: acción de escribir la imagen después (estado porterior) de los registros modificados por una transacción

## estrategias de modificación
>el log tiene alta prioridad, así que siempre está actualizado
### inmediata

apenas ocurra una acción, esa acción se serializa y se guarda en memoria secundaria 
### diferida

las actualizaciones se guardan en el log pero se espera hasta ejecutar el commit para serializar y guardar en memoria secundaria
si una transacción se interrumpe, se necesita la imagen del después. se interrumpió el commit así que no hay que aplicar rollback. 
las transacciones que no hayan commiteado se ignoran

si se va la luz, postgres...
- DESHACE las transacciones que NO terminaron. se recorre el log del final al inicio
- REHACE las transacciones que SÍ terminaron. se recorre el log del inicio al final 
## checkpoint

se marcan checkpoints para establecer que a partir de allí se van a rehacer los logs en caso de fallos. se ejecuta periódicamente
### pasos de recuperación

1. Pausar las transacciones. Impedir que las transacciones hagan actualizaciones
2. Agrego en la bitácora el checkpoint (only transacciones activas se guardan en L)
3. Forzar la salida de los buffers a memoria secundaria
4. Guardar un puntero al ultimo checkpoint(archivo de re-comienzo)

### pasos de recuperación antes una falla

1. obtener del archivo de recomienzo la dirección del último checkpoint
2. crear dos listas UNDO = L (transacciones vigentes que no hicieron commit)
3. recorrer el log desde el checkpoint hasta el final y completar las listas
4. recorrer el log desde el checkpoint hasta el final para rehacer las transacciones que sí terminaron
5. recorrer el log desde el final hasta el inicio de cada una de las transacciones en UNDO

---
next: 
tags: [[bd]]

