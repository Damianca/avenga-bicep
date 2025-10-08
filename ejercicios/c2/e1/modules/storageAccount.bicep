// Define los parámetros necesarios para la Cuenta de Almacenamiento
param storageName string
param location string
param tags object = {}

// Parámetros de configuración (variables)
var storageSku = 'Standard_LRS' // Opciones: Standard_GRS, Standard_LRS
var storageKind = 'StorageV2'

// Definición del recurso Storage Account
resource storageAccount 'Microsoft.Storage/storageAccounts@2022-09-01' = {
  name: storageName
  location: location
  sku: {
    name: storageSku
  }
  kind: storageKind
  properties: {
    // Configuración estándar: acceso público inhabilitado, https requerido
    allowBlobPublicAccess: false
    minimumTlsVersion: 'TLS1_2'
  }
  tags: tags
}

// Salidas del módulo
output storageId string = storageAccount.id
output storageEndpoint string = storageAccount.properties.primaryEndpoints.blob
