````markdown
# Configuración y Despliegue en Azure CLI

Este es el flujo estándar para realizar un despliegue de Bicep a nivel de suscripción, típicamente utilizado para crear un Resource Group (RG).

## 1. Establecer la Suscripción Activa

Este comando asegura que cualquier comando subsiguiente de Azure CLI se ejecute contra la suscripción correcta.

```
az account set --subscription "TU NRO AQUI"
````

-----

## 2\. Crear el Despliegue a Nivel de Suscripción

Este comando ejecuta el archivo Bicep (`main.bicep`) con alcance en la suscripción, lo cual es necesario para crear un Resource Group.

```bash
az deployment sub create --location "eastus" --template-file main.bicep
```

-----
## 3\. Eliminar el resource group
```bash
az group delete --name "rg-bicep-demo-001" --yes
```
