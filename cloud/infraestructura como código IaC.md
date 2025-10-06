es la capacidad de aprovisionar y respaldar su infraestructura de computación a través de código en lugar de procesos y configuraciones manuales

existen dos formas de hacerlo en AWS: CloudFormation (se usa .json o .yaml que son de lenguaje declarativo) y CDK (lenguajes imperativos)

en multinube: terraform (se usa .json o .yaml que son de lenguaje declarativo) y pulumi (lenguajes imperativos)
### beneficios ->

- configurar rápidamente entornos completos, desde el desarrollo hasta la producción
- duplique fácilmente un entorno
- reduzca los errores de configuración manual
## comandos CLI

```txt
aws cloudformation create-stack --stack-name "crear-mv-con-webs" --template-body file://plantilla_crear_mv_con_webs.yaml --parameters ParameterKey=InstanceName,ParameterValue="MV con 2 Webs" ParameterKey=AMI,ParameterValue="ami-08d434e92c0cfa0c0"

aws cloudformation describe-stacks --stack-name "crear-mv-con-webs"

aws cloudformation delete-stack --stack-name "crear-mv-con-webs"

aws cloudformation describe-stacks --stack-name "crear-mv-con-webs"
```
### AMI data

```txt
id del ami: ami-08d434e92c0cfa0c0
ip pública: 3.90.140.211
```

---
tags: [[cloud]]