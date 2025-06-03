
- ¿cómo asegurar la manipulación segura de los datos?
- ¿cómo evitar cambios no permitidos?
- libro : system design interview
# error de capa 8 →
- la capa 8 no existe 😛 : es un error por parte del usuario
# java database c →

## SQL injection → validación de inputs !!! 1=1

- “escapar” los strings → función para validar los inputs en java
- consultas pre-compiladas : sql dinámico
    1. se realiza la consulta sin el valor del input
    2. se reemplaza el valor del input
    3. devuelve la información
- procedimientos almacenados → funciones
## respaldos →

- info disponible en otro servidor - centros de datos : backups
- balanceador de requests en varios servidores : distribuir equitativamente
- memoria caché : limitada pero con mayor facilidad de acceso
- nivel de sistemas de archivos → discos duros : protección ante errores de hardware. no provee protección ante errores humanos o de software
- nivel de hardware → replica de discos o máquinas
- nivel de sistema de bases de datos → respaldos periódicos
---
next: [[procesamiento y optimización de consultas]]
tags: [[bd]]