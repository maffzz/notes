## 📌 definición

una ecuación diferencial de variables separables es aquella que puede escribirse de la forma:
$$
\frac{dy}{dx} = f(x)g(y)
$$
es decir, el lado derecho es el producto de una función de (x) y una función de (y)

---
## 🧮 método de resolución

### paso 1: reescribir la ecuación

separar las variables:

$$
\frac{1}{g(y)} \, dy = f(x) \, dx
$$
### paso 2: Integrar ambos lados

se integran ambos miembros de la ecuación:

$$
\int \frac{1}{g(y)} \, dy = \int f(x) \, dx
$$
### paso 3: resolver la ecuación obtenida

se resuelve la igualdad obtenida tras integrar para encontrar (y) en función de (x)

---
## 🧪 ejemplo

resolver:
$$
\frac{dy}{dx} = x y^2
$$
### ✍️ paso 1: separar las variables

dividimos ambos lados por (y^2) y multiplicamos por (dx):

$$
\frac{1}{y^2} \, dy = x \, dx
$$
### ✍️ paso 2: integrar ambos lados

$$
\int \frac{1}{y^2} \, dy = \int x \, dx
$$
$$
- \frac{1}{y} = \frac{x^2}{2} + C
$$
### ✍️ paso 3: despejar (y)

$$
y = \frac{-1}{\frac{x^2}{2} + C}
$$

---
## 🔍 importante

- el método sólo es aplicable si se pueden separar las variables
- no olvidar **la constante de integración** (C)
- la solución puede dejarse implícita si no se puede despejar fácilmente (y)
- **recuerda:** este método es útil para resolver muchas ecuaciones de primer orden

---
next: [[factor integrante]]
tags: [[mate]]