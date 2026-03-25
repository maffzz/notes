gestor de bases de datos -> el software que gestiona bases de datos

el sistema de gestión de bases de datos <mark class="hltr-red">decide</mark> si usar o no usar índices, hacer o no un escaneo completo, cómo acceder al disco, cómo usar la memoria, etc
# componentes de la arquitectura de un DBMS
![[estructura_dbms.png]]

# flujo sql -> disco
1. se hace la query cute
2. entra al espacio de <mark class="hltr-green">query processor (procesador de consultas</mark>)
	1. parser -> analiza la sintaxis del sql recibido
	2. optimizer -> genera el plan de ejecución óptimo
	3. executor -> ejecuta el plan nodo por nodo
3. entra al espacio de <mark class="hltr-pinky">storage manager</mark>
	1. buffer mgr -> gestiona páginas en memoria RAM
	2. file mgr -> lee/escribe páginas en disco físico
4. disco :p

## el parser recibe la consulta
1. análisis léxico (tokenización)
	lee el texto sql y lo divide en unidades mínimas con significado : los tokens -> descomponer el texto en términos
2. análisis sintáctico (abstract syntax tree)
	el parser verifica que la secuencia de tokens sigue las reglas gramaticales del SQL y construye un Árbol de Sintaxis Abstracta
	![[ast.png]]
![[operadores_ar.png]]
3. verificación semántica
	el AST es sintácticamente correcto, ¿pero existen realmente esas tablas y columnas? ¿los tipos son compatibles?
	![[verificacion_semantica.png]]

## el optimizador arma el plan de ejecución
1. plan de ejecución óptimo
	sql reorganiza los filtros de la manera más óptima, decide si usar índices o no
	![[pipeline_optimizer.png]]
	optimización semántica -> lleva las condiciones y proyecciones lo más abajo posible
	![[optimizacion_semantica.png]]

ejercicio -> optimizar esta cosa en un árbol
```sql
SELECT NOMBRE
FROM EST, ACT, PROY
WHERE EST.COD = ACT.COD
AND ACT.COD = PROY.COD
AND EST.NOMBRE != "Jorge"
AND EST.CARRERA = "CS"
AND (ACT.HORAS = 4 OR ACT.HORAS = 6)
```
- siempre filtrar antes de hacer joins

## el executor evalúa el plan nodo por nodo
1. recorre el plan físico como un árbol
	llama a cada nodo para que produzca tuplas, que pasan al nodo padre
	![[nodos_executor.png]]

seq scan vs index scan:
![[seq_vs_in.png]]

## buffer manager - la caché de páginas de DBMS
1. mantiene un pool de páginas en RAM
	su objetivo es minimizar el I/O a disco satisfaciendo las peticiones del executor
	![[buffer_manager.png]]
2. cuando el buffer está lleno y se necesita cargar una nueva página, el sistema debe decidir qué página reemplazar
	![[pag_reemplazo.png]]

## file manager - organización en disco
1. traduce abstracciones lógicas (page_id, tabla) a posiciones físicas en disco
	opera por debajo del buffer manager
	![[pag_estructura.png]]

## transaction manager (clase aparte)

## disco - almacenamiento físico
objetivo de todo lo anterior: reducir la cantidad de veces que se accede al disco
![[tiempo_acceso.png]]
# recapitulación -> flujo completo
![[flujo_completo_consulta.png]]

---

tags: [[bd]]