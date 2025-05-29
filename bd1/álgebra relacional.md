- lenguaje formal para manipular datos en tablas
- generalizar preguntas sobre el modelo relacional
- cada operación es una herramienta para transformar tablas

---

**RELACIONES → R** : devuelve las filas de la tabla
ejem: **(Agua)** : devuelve la tabla con información de agua

**SELECCIÓN DE TUPLAS/FILAS →** **σ** condición (**R**)
ejem: **σ marca=Cielo (Agua)** : devuelve las aguas de marca Cielo

**CONDICIÓN →** se puede mezclar con =, <, ≤, >, ≥, ^, v
ejem: **σ marca=Cielo^precio<2 (Agua)** : devuelve las aguas de marca Cielo y con precio menor a 2 soles

**PROYECCIÓN → π** columna (**R**)
ejem: **π marca (Agua)** : devuelve la columna de marcas de agua
ejem: **π marca,tipo (Agua)** : devuelve las columnas de marcas y tipos de agua

**mezclando selección y proyección →**
- paso 1: **σ marca=Cielo (Agua)** : ****devuelve las aguas de marca Cielo
- paso 2: **π precio (.)** : ****devuelve los precios de agua
- en un solo pasito: **π precio (σ marca=Cielo (Agua))** : devuelve los precios de las aguas de marca Cielo

<aside> ❗se ejecuta de adentro hacia afuera
</aside>

**INTERSECCIÓN →** **R1** ∩ **R2** _(deben tener los mismos atributos)_
ejem: **π marca (σ precio=1 (Agua)) ∩ π marca (σ precio=2 (Agua)** : devuelve las marcas que tienen aguas con precios de 1 sol y 2 soles

**DIFERENCIA →** **R1** - **R2** _(deben tener los mismos atributos)_
ejem: **π marca (σ precio=1 (Agua)) - π marca (σ precio=2 (Agua))** : devuelve las marcas que tienen aguas con precio de 1 sol y no precio de 2 soles

**UNIÓN →** **R1** U **R2** _(deben tener los mismos atributos)_
ejem: **π marca (σ precio=2 (Agua)) U π marca (σ precio=2 (Jugo)** : devuelve las marcas que tienen aguas y jugos con precio de 2 soles

**PRODUCTO CRUZ →** **R1** **X** **R2** _(**no** deben tener los mismos atributos)_
ejem: **π marca (σ precio=2 (Agua)) X π colegio (σ edad=10 (Alumnos))** : devuelve las marcas que tienen aguas con precio de 2 soles y los colegios de alumnos con edad de 10 años

**RENOMBRAMIENTO →** **ρ A1/A2 (R)**
ejem: **π nombre1,nombre2 (σ grados1>grados2(Cerveza1 X Cerveza2))** : devuelve los nombres de las cervezas que tengan el grado de la primera menor al de la segunda

**DIVISIÓN → R1 % R2**

**JOINS**
## basado en tuplas (CRT | filas)

- cálculo de predicados de primer orden
- devolver todas las tuplas que satisfacen una condicion

<aside> ☝

**una consulta se expresa comooo → {t | COND(t)} en dondeee…**

resultado: conjunto de tuplas t que satisfacen la condición COND(t)

COND(t): expresión condicional en la que interviene la variable de tupla t basado en dominios

</aside>

**ejemplitos →**

1. averiguar todos los marineros con categoría superior a 7: {M | M∈Marineros ∧ M.categoría>7}
2. nombre y nacionalidad de los actores cuyo sueldo supera los 5000: {t.nombre, t.nacionalidad | ACTOR(t) and t.sueldo > 5000}

**algunas equivalencias con álgebra relacional →**

- entidades:
    - álgebra: Cerveza
    - cálculo: {C | C∈Cerveza}
- selección:
    - álgebra: σ marca=Austral ^ grados>4.8 (Cerveza)
    - cálculo: {C | C∈Cerveza ^ C.marca=Austral ^ C.grados>4.8}

## basado en dominios (CRD | columnas)

### funciones de agregación

|AVG : promedio|MIN : mínimo|MAX : máximo|SUM : suma|COUNT : recuento|
|---|---|---|---|---|

**estructura →**

<atributos> γ(funcion de agregación)(llave, lo que se cuenta) (entidad)

**ejemplitos → @ es ganma (γ)**

1. servidor con la mayor cantidad de mensajes:
    
    R1 ← [S.name](http://S.name) @count(id) (M)
    
    R2 ← p count/n_mensajes (R1)
    
    R3 ← @max(n_mensajes) (R2)
    
    R4 ← R2 X R3
    
    R5 ← π [S.name](http://S.name) (σ n_mensajes=max (R4))
    
2. obtener el director y episodio con el sueldo más bajo:
    
    R1 ← p Dirige1 (Dirige)
    
    R2 ← p Dirige2 (Dirige)
    
    R3 ← p Dirige3 (Dirige)
    
    R4 ← R1 ⋈(R1.sueldo>R2.sueldo) R2
    
    R5 ← π sueldo (Dirige) - π R4.R1.sueldo (R4)
    
    R6 ← Dirige ⋈(sueldo=R5.R4.R1.sueldo) R5
    
    R7 ← π Dnombre,Enombre (R6)
    
3. mostrar nombre de los ciudadanos que hayan sido beneficiados con el bono independiente y el bono universal
    
    B_ind_dni ← π DNI (σ nombre=independiente (Bono X Beneficio))
    
    B_uni_dni ← π DNI (σ nombre=universal (Bono X Beneficio))
    
    B_ambos ← B_ind_dni ∩ B_uni_dni
    
    Final ← π nombre (Ciudadano ⋈ B_ambos)
    
    —
    
    B_ind ← π BId (σ nombre=independiente (Bono))
    
    B_uni ← π BId (σ nombre=universal (Bono))
    
    B_ambos ← B_ind ∩ B_uni
    
    B_dni ← π DNI (Beneficio ⋈DNI=B_ambos.DNI B_ambos(Beneficio X )
    
    Final ← π nombre (Ciudadano ⋈ B_dni)
    

---

1. <tipo> (@count(marca, nombre) @avg(precios) (Cerveza))
2. @count(dni) (Alumno)
3. <genero> @count(dni) (Alumno)
4. <genero,nombre> @count(dni) (Alumno)
5. @count(marca,nombre)
6. <tipo> @count(marca, nombre(Cerveza))
7. <tipo> @count(marca, nombre) AVG(precio)(Cerveza))

---

tags: [[bd]]