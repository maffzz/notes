# conceptos
## web clásica
es una red de documentos **interpretable por humanos** donde las relaciones entre documentos <mark class="hltr-red">no tienen</mark> un significado
## web de datos
es una red de afirmaciones **interpretable por humanos y máquinas** donde las afirmaciones se relacionan y <mark class="hltr-green">tienen</mark> un significado
# nociones básicas y el modelo de datos RDF
## web actual
es un conjunto de documentos, en general páginas web escritas en HTML
esas páginas web HTML están formadas por contenido y enlaces:
- contenido : texto, imágenes, videos, audios, etc
- enlaces : redirigen a otro documento (página web)
### desafíos

- **heterogénea :** múltiples organizaciones generan datos, de forma independiente
- **masiva :** la cantidad de información existente es enorme
- **cambia muy rápido :** cada día son publicados y borrados enormes volúmenes de información
- **hecha para humanos :** en general, sólo una persona puede interpretar la información de la una página web
## requisitos para una web efectiva

1. es necesario tener una lenguaje que permita especificar recursos en la web y las relaciones entre ellos. un requisito fundamental: este lenguaje debe ser procesable por un computador
2. necesitamos poder consultar estos datos mediante aplicaciones computacionales. dos requisitos fundamentales:
	- debemos tener un lenguaje para escribir consulta que sean procesable por un computador
	- debemos ser capaces de sacar conclusiones de los datos de manera automática
# la web semántica
es una extensión de la web actual en la cual <mark class="hltr-brown">se da un significado bien definido a la información</mark>, permitiendo mejorar la colaboración entre personas y computadores en la web
## recomendaciones
es un conjunto de recomendaciones desarrolladas por el World Wide Web Consortium, cuyo objetivo es que los computadores sean capaces de entender los datos en la web
- una recomendación es una descripción formal de una tecnología que debería ser utilizadas por todos. es decir, un lenguaje común para todos
- el w3c es el organismos regular de la web
# la noción de uri

- construir un lenguaje:
	- recursos web
	- relaciones entre los recursos web
	- requisitos:
		- debe ser procesable por un computador -> lenguaje RDF

## características básicas de RDF
RDF es la propuesta del World Wide Web Consortium (W3C) para representar información sobre recursos en la web

- RDF está basada en el uso de grafos dirigidos y etiquetados  
- una especificación RDF puede ser procesada por un computador  
- las piezas básicas para construir una especificación RDF son los URIs y los literales
## URI (uniform resource identifier)

un URI es un identificador de un recurso en la WEB
un recurso corresponde a un elemento mencionado en la web, por ejemplo:
- en página web
- una persona
- un libro
- una ciudad
- un gen
- una película

[[componentes_uri.png]]
# las nociones de literal y triple RDF

## literales
representa un valor concreto de una especificación RDF. un literal es simplemente una cadena de caracteres. un literal puede tener un tipo asociado
## un triple RDF
en una especificación RDF, una relación entre dos recursos es dada a través de un triple
puede ser utilizado para dar el valor de un atributo asociado a un recurso [[triple_rdf.png]]
## abreviación
usualmente, los URIs son abreviados utilizando prefijos

```python
@prefix dbpedia: http://dbpedia.org/resource

entonces: dbpedia:Lionel_Messi  
es la abreviación de: http://dbpedia.org/resource/Lionel_Messi
```
### ejemplos

- el siguiente ejemplo indica que Messi nació en argentina ->
```python
dbpedia: Lionel_Messi
predicado: birthPlace
dbpedia: argentina
```
`este triple indica una relación entre los recursos:`
	`- dbpedia: Lionel_Messi`
	`- dbpedia: Argentina`

- el siguiente ejemplo indica que Messi juega en el club barcelona ->
```python
dbpedia: Lionel_Messi
predicado: currentClub
dbpedia: FC_Barcelona
```
`este triple indica una relación entre los recursos:`
	`- dbpedia: Lionel_Messi`
	`- dbpedia: FC_Barcelona`
	
- el siguiente ejemplo indica que Messi nació el 24 junio de 1987 ->
```python
dbpedia: Lionel_Messi
example: birthday
dbpedia: "1987-06-24"
```
`este triple indica que el valor del atributo example:birthday para el recurso dbpedia:Lionel_Messi es "1987-06-24"`
# grafo RDF
un grafo RDF está formado por un conjunto de triples RDF
## en la web

```
- Messi nació en Rosario  
- Messi vive en Barcelona  
- Rosario es parte de la Provincia de Santa fe  
- Barcelona es parte de la Provincia de Barcelona
```

este grafo se almacena en la web como un <mark class="hltr-blue">archivo</mark> ->

```
@prefix dbpedia: <http://dbpedia.org/resource>
@prefix dbpprop: <http://dbpedia.org/property>
@prefix dbpedia-owl:<http://dbpedia.org.ontology>

dbpedia:Lionel_Messi dbpprop:birthPlace dbpedia:Rosario
dbpedia:Lionel_Messi dbpedia-owl:residence dbpedia:Barcelona
dbpedia:Rosario dbpedia-owl:isPartOfdbpedia:Santa_Fe_Province
dbpedia:Barcelona dbpedia-owl:isPartOfdbpedia:Province_of_Barcelona
```

[[grafo_ejemplo.png]]
# SPARQL protocol and RDF query language

```sparql
PREFIX ex: <http://ex.org/voc#>
SELECT *
WHERE {
	?p a ex:Movie .
	?p ex:titulo ?t .
	OPTIONAL
		{ ?p ex:fechaDeEstreno ?f }
}
```

```sparql
PREFIX ex: <http://ex.org/voc#>
SELECT *
WHERE {
	?p a ex:Movie .
	?p ex:fecha ?f .
	FILTER ( ?f > "2013-12-31"^^xsd:date
			&& ?f <= "2014-12-31"^^xsd:date )
}
```

---
tags: [[bd]]