// Define el prefijo del nombre y la ubicación de los recursos
param storageAccountPrefix string = 'stgdemo'
param location string = resourceGroup().location

// Genera una cadena única basada en el ID del Resource Group
var uniqueSuffix = uniqueString(resourceGroup().id)
var storageAccountName = '${storageAccountPrefix}${uniqueSuffix}' // Nombre final (ej: stgdemo1a2b3c4d)
var storageSku = 'Standard_LRS' // SKU estándar: LRS (Almacenamiento Redundante Local)

// ----------------------------------------------------------------------
// 1. RECURSO: Azure Storage Account (StorageV2)
// ----------------------------------------------------------------------
resource storageAccount 'Microsoft.Storage/storageAccounts@2023-01-01' = {
  name: storageAccountName
  location: location
  sku: {
    name: storageSku
  }
  kind: 'StorageV2' // El tipo de cuenta más reciente y recomendado
  properties: {
    accessTier: 'Hot' // Nivel de acceso frecuente
    supportsHttpsTrafficOnly: true // Siempre usar HTTPS
    minimumTlsVersion: 'TLS1_2' // Asegurar el mínimo de seguridad TLS
  }
}
// ... Storage Account definition (storageAccount) ...

// 2. Definir el Blob Service (Recurso Hijo de la Storage Account)
resource blobService 'Microsoft.Storage/storageAccounts/blobServices@2023-01-01' = {
  // Se anida directamente en el Storage Account. Nombre fijo: 'default'
  parent: storageAccount 
  name: 'default' 
}

// 3. Definir el Contenedor/Bloqueo (Recurso Hijo del Blob Service)
resource publicAccessBlock 'Microsoft.Storage/storageAccounts/blobServices/containers@2023-05-01' = {
  // El padre es AHORA el blobService
  parent: blobService 
  // El nombre es solo el nombre del contenedor (que para la config. de acceso es 'default')
  name: 'default' 
  properties: {
    publicAccess: 'None' // 'None' es equivalente al bloqueo
  }
}

// ----------------------------------------------------------------------
// 3. SALIDA
// ----------------------------------------------------------------------
output storageUri string = storageAccount.properties.primaryEndpoints.blob
