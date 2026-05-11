# 1. organización de archivos

- una base de datos es almacenada como una colección de archivos
- cada archivo se organiza en páginas
- cada página contiene una secuencia de registros
- un registro es una secuencia de campos

> un archivo <-> una tabla
> un registro <-> una tupla
> un campo <-> una columna

¿por qué los registros se agrupan en páginas?
- cuando un archivo es dms grande, se divide en páginas
- página -> tamaño del buffer (depende del hardware)
- el gestor de base de datos asume un tamaño fijo y a eso lo llama página (8 BYTES)
## tipos de archivos
- archivos secuenciales : 
- archivos indexados : 
- archivos de texto : guardan datos como caracteres (número como "123")
- archivos binarios : guardan datos en formato binario (números en código de máquina)
## operaciones básicas en archivos
- read : recupera datos de un archivo. puede ser secuencial (uno tras otro) o directa (usando un índice o clave). la eficiencia depende de la estructura del archivo y el uso de buffers
- write : agrega registros al archivo. puede hacerse al final, en una posición específica o sobrescribiendo registros existentes. la reorganización y fragmentación pueden afectar el rendimiento
- delete : remueve registros mediante eliminación lógica (marcado como inactivo) o física (borrado definitivo). puede requerir reorganización o reutilización del espacio
## operaciones básicas en archivos con c++

![[ops_c++.png]]
## operaciones básicas en archivos con python

> sos cómo q python -> puro ppt

# 2. modelos de almacenamiento

heap files -> estructura de almacenamiento más básica : un conjunto de páginas en donde los registros se insertan siempre al final
	ventajas : 
	- inserción rápida (append al final)
	- 
	desventajas :
	- búsqueda secuencial - O(n)
	- sin garantía de orden de recuperación
	- espacio fragmentado con DELETEs frecuentes
	- requiere VACUUM para recuperar espacio

## registros de longitud fija

- registros cuyos campos tmb tienen longitud fija
- para que todos los registros tengan longitud fija, los campos tmb deben tener longitud fija
- todos los registros de un archivo tienen la misma longitud y cantidad de campos
- permiten un acceso directo a la ubicación del archivo de manera rápida
- al diseñar físicamente las tablas -> usar registros de longitud fija
## registros de longitud variable

- registros cuyos campos se ajustan al contenido almacenado
- incluyen una cabecera adicional para indicar la longitud
- cuando los archivos son de tipo texto, se usan delimitadores (caracteres especiales)
	- en archivos binarios : indicadores de longitud para definir el tamaño de cada campo. se coloca al inicio y solo es necesario especificar el tamaño de campos de tipo texto. 
		```text
		6:4:hola:2:hi
		```
		problemas : 
		- acceso directo a un registro : guardar la posición física del inicio de cada registro y su peso. por cada registro, se guarda un slot
			```pseudo
			read(pos):
			- open(file)
			- slot_offset = sizeof(header) + sizeof(slot) * pos
			- seek(slot_offset)
			- read(slot_record, sizeof(slot))
			- seek(slot_record.location)  
			- read(record_bytes, slot_record.size)
			- Record record = unpack(record_bytes)
			- close(file)
			```
		- eliminar un registro
	- en archivos de texto : caracteres especiales como comas o saltos de línea

---
next: [[técnicas de indexación]]
tags: [[bd]]