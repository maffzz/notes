virtualización -> hay 2 maneras de visualizar hardware en un servidor
1) instalar el software del hipervisor directamente sobre el hardware
2) ejecutar el software del hipervisor en un sistema operativo host

modelo de precios -> AWS ofrece un sistema de pago por uso. solo se pagan los servicios durante el tiempo que se utilicen. una vez que se cancela el servicio, no se aplican costos adicionales. solo se paga por:
1) compute (CPU, memoria RAM)
2) storage (almacenamiento: disco)
3) data out (transferencia de datos saliente)

- una máquina virtual se llama **instancia** en AWS
- existen cinco modelos de compra de instancias en EC2:
	- bajo demanda
	- savings plans (planes de ahorro)
	- instancias reservadas
	- instancias de spot
	- alojamientos dedicados que le proporcionan instancias EC2 en servidores físicos exclusivos
- el modelo de compra “bajo demanda” es el más utilizado
---
tags: [[cloud]]