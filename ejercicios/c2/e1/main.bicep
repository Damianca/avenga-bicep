// Establece el ámbito del archivo principal a nivel de suscripción
targetScope = 'subscription' // siempre en este archivo

// otras opciones 
// tenant → nivel organización
// managementGroup → nivel grupo de administración
// subscription → nivel de suscripción
// resourceGroup → nivel de grupo de recursos (por defecto)

// Declaraciones: El archivo de parámetros main.parameters.json proporcionará los valores
param rgName string
param deployLocation string
param storageAccountName string

// ====================================================================
// 1. CREACIÓN DIRECTA DEL RESOURCE GROUP (Ámbito de Suscripción)
// ====================================================================

// El tipo de recurso Resource Group (Microsoft.Resources/resourceGroups)
// siempre se despliega en el ámbito de suscripción.
resource rg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: rgName
  location: deployLocation
}

// ====================================================================
// 2. MÓDULO DE STORAGE (Ámbito del Resource Group)
// ====================================================================

module storageAccountModule 'modules/storageAccount.bicep' = {
  // El ámbito del módulo ahora apunta al Resource Group creado por el recurso 'rg'.
  // Se usa la función de ámbito 'resourceGroup()' y se le pasa el nombre del RG.
  scope: resourceGroup(rg.name) 
  name: 'storage-deployment'
  params: {
    // Los parámetros del módulo Storage deben usar las propiedades del RG.
    storageName: storageAccountName
    location: rg.location
    tags: {
      Environment: 'Demo'
      Owner: 'BicepUser'
    }
  }
}

// ====================================================================
// SALIDAS GLOBALES
// ====================================================================

output resourceGroupName string = rg.name
output storageEndpoint string = storageAccountModule.outputs.storageEndpoint
