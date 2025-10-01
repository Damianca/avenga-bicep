````markdown
# 💻 Configuración y Despliegue en Azure CLI

Este es el flujo estándar para realizar un despliegue de Bicep a nivel de suscripción, típicamente utilizado para crear un Resource Group (RG).

## 1. Establecer la Suscripción Activa

Este comando asegura que cualquier comando subsiguiente de Azure CLI se ejecute contra la suscripción correcta.

```bash
az account set --subscription "7e7e194d-45b8-4739-afb4-0140968f5a7a"
````

-----

## 2\. Crear el Despliegue a Nivel de Suscripción

Este comando ejecuta el archivo Bicep (`main.bicep`) con alcance en la suscripción, lo cual es necesario para crear un Resource Group.

```bash
az deployment sub create --location "eastus" --template-file main.bicep
```

```
```
