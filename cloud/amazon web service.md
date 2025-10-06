### ☝conceptos fundamentales

- región -> una región es un lugar en el mundo donde hay varios data centers
- zonas de disponibilidad -> lugares en donde se ubican estratégicamente los data centers para cubrir la zona. facilitan la partición de las aplicaciones para mejor disponibilidad
- latencia -> tiempo en el que se realiza una acción y el dispositivo responde
- AWS ofrece más de 160 servicios
### ☝modelos de servicios

| IaaS (host – alojar)                                                                                                     | PaaS (build – construir)                                                               | SaaS (consume – usar)                                                       |
| ------------------------------------------------------------------------------------------------------------------------ | -------------------------------------------------------------------------------------- | --------------------------------------------------------------------------- |
| provee los recursos incluyendo servidores, almacenamiento, direcciones IP, redes, firewalls, balanceadores de carga, etc | provee el entorno o ambiente para desarrollar, ejecutar y administrar aplicaciones web | provee la habilidad de usar aplicaciones de software a demanda por internet |
### ☝modelos de despliegue

| nube pública                                                                                                                                                      | nube híbrida                                                                                                                                                | nube privada                                                                                                                                                                      | nube comunitaria                                                                 |
| ----------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------- |
| el proveedor es el propietario de la infraestructura, se encarga de su alojamiento y facilita sus recursos de forma abierta a todas las empresas que lo requieran | aprovecha las ventajas de ambos tipos de nube: las aplicaciones de software más críticas se despliegan sobre nubes privadas y el resto sobre nubes públicas | es propiedad de la empresa que la utiliza, es necesaria inversión inicial mayor en infraestructura y virtualización. la nube puede estar dentro de la empresa o fuera de la misma | puede ser utilizada por n organizaciones con los mismos intereses y  necesidades |
|                                                                                                                                                                   |                                                                                                                                                             | tu propio sistema de datos. tu propio data center. aquí suelen estar los sistemas core                                                                                            |                                                                                  |
### maneras de interactuar con AWS
- consola web
- CLI
- [[infraestructura como código IaC]]
- APIs rest

---
tags: [[cloud]]