- descripción: contiene **todo** lo que necesita una aplicación de software para funcionar, cada contenedor debe hacer **una cosa** y hacerlo **bien**
- solución al transporte de software
- contenerizar/**dockerizar** -> llevar una api a un contenedor de docker
- la api corre en un contenedor y el contenedor es la imagen en ejecución
- la imagen es como la plantilla o el objeto y el contenedor es como el objeto
### comandos de clase 1
```cmd
docker -v

docker build -t web-simple .
docker run -d --rm --name websimple_c -p 8080:80 web-simple

docker build -t api-students .
docker run -d --rm --name api-students_c -p 8000:8000 api-students
docker logs api-students_c
docker exec -it api-students_c bash
```
### comandos de clase 2
```cmd
docker login -u maffzz18
docker tag api-students maffzz18/api-students
docker push maffzz18/api-students
docker logout

docker run -d -p 8000:8000 maffzz18/api-students
```
## contenedores vs máquinas virtuales


## arquitectura de solución
- es lo primero que se hace: analizar requerimientos, plantear un diseño y luego implementar en base a eso
- profesional con la experiencia necesaria para saber “de todo un poco” pero teniendo una visión end-to- end (extremo a extremo) de la solución
- es el encargado de escuchar las necesidades del cliente y diseñar una solución, mapeando los requerimientos funcionales hacia tecnologías
- el arquitecto es el puente entre el cliente con sus necesidades, y los ingenieros que implementarán la solución
- la arquitectura de la solución en sí misma, abarca la arquitectura de negocios, sistemas, información, seguridad, aplicaciones y tecnología
- el arquitecto debe tener habilidades de liderazgo sólidas y también habilidades comunicativas. además, debe tener conocimientos técnicos y comerciales



---
tags: [[cloud]]