param location string
param dbName string
param sqlServerName string // Nombre del servidor padre
param dbSkuName string = 'Basic' // SKU (nivel de servicio)
param dbSkuTier string = 'Basic' // Nivel

resource sqlDb 'Microsoft.Sql/servers/databases@2023-08-01' = {
  name: '${sqlServerName}/${dbName}' 
  location: location
  sku: {
    name: dbSkuName
    tier: dbSkuTier
  }
  properties: {
    collation: 'SQL_Latin1_General_CP1_CI_AS'
    // 2 GB en bytes (el máximo permitido para el nivel Basic)
    maxSizeBytes: 2147483648 
  }
}

output dbId string = sqlDb.id

