## 📌 definición

la **transformada de laplace** de una función f(t), definida para valores de t mayores o iguales que cero, es una transformación integral definida como:

$$
\mathcal{L}\{f(t)\} = F(s) = \int_0^{\infty} e^{-st} f(t) \, dt
$$

donde:
> - L{} es el símbolo de la transformada de laplace
> - f(t) es la función original en el tiempo
> - F(s) es la función transformada en el **dominio de (s)** | *no confundir con el número 5 q sí pasa :(* 
> - (s) es un número en general

---
## 🎯 ¿para qué se usa?

- resolver **ecuaciones diferenciales** ordinarias (edos) lineales
- facilita el análisis de sistemas lineales (ingeniería)
- convierte derivadas en **productos algebraicos**
- <mark class="hltr-red">esto es puro fracciones parciales de c1v (repasar)</mark>
- <mark class="hltr-red">tmb es puro completas cuadrados (repasar)</mark>

---
## 📖 propiedades importantes

### 1️⃣ linealidad

$$
\mathcal{L}\{a*f(t) + b*g(t)\} = a*F(s) + b*G(s)
$$
### 2️⃣ transformada de derivadas

- primera derivada:

$$
\mathcal{L}\{f'(t)\} = sF(s) - f(0)
$$

- segunda derivada:
$$
\mathcal{L}\{f''(t)\} = s^2F(s) - sf(0) - f'(0)
$$
### 3️⃣ función escalón unitario (tema aparte no worries) 

para u_c(t):
$$
\mathcal{L}\{u_c(t)\} = \frac{e^{-cs}}{s}
$$
y para u_c(t) * f(t-c):
$$
\mathcal{L}\{u_c(t)f(t-c)\} = e^{-cs}F(s)
$$

---
## 🧮 tabla de transformadas comunes

f: $$1$$
transformada: 
$$\frac{1}{s}$$
---
f:  
$$t^n$$
transformada:  
$$\frac{n!}{s^{n+1}}$$
---
f:  $$e^{at}$$
transformada:  
$$\frac{1}{s - a}$$
---
f:  $$\sin(at)$$
transformada:  
$$\frac{a}{s^2 + a^2}$$
---
f:  $$\cos(at)$$
transformada:  
$$\frac{s}{s^2 + a^2}$$
---
f:  (función escalón unitario)  $$u(t)$$
transformada:  
$$\frac{1}{s}$$
---
f: ([[translación en el eje s]] | otro tema tmb) 
$$t \cdot e^{at}$$  
transformada:  
$$\frac{1}{(s - a)^2}$$
--- 
## 🧪 ejemplo clásico

resolver:

$$
y'' + 3y' + 2y = 0, \quad y(0) = 1, \quad y'(0) = 0
$$

### ✍️ paso 1: aplicar la transformada de laplace

aplicamos la transformada a cada término:

- L{y''} = s^2 * Y(s) - s * y(0) - y'(0)
- L{y'} = sY(s) - y(0)
- L{y} = Y(s)

reemplazamos y agrupamos:
$$
s^2Y(s) - s + 3(sY(s) - 1) + 2Y(s) = 0
$$
### ✍️ paso 2: resolver para Y(s)

agrupamos términos:
$$
[s^2 + 3s + 2]Y(s) = s + 3
$$
entonces:
$$
Y(s) = \frac{s + 3}{s^2 + 3s + 2}
$$

### ✍️ paso 3: fracciones parciales e inversa

factorizamos el denominador:
$$
s^2 + 3s + 2 = (s + 1)(s + 2)
$$
descomponemos en fracciones parciales:
$$
Y(s) = \frac{A}{s + 1} + \frac{B}{s + 2}
$$
resolvemos para A y B, luego aplicamos la [[transformada inversa de laplace]] (tema aparte maso) y obtenemos:
$$
y(t) = C_1 e^{-t} + C_2 e^{-2t}
$$

---
## ✨ observaciones

- muy útil en ecuaciones diferenciales **lineales con coeficientes constantes**
- la función inicial debe estar definida para valores de t mayores o iguales que cero
- se puede extender a funciones por tramos usando [[función de escalón unitario]]

---
next: [[transformada inversa de laplace]]
tags: [[mate]]