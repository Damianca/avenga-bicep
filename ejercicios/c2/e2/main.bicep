targetScope = 'resourceGroup'

// Parámetros del Despliegue
param location string = 'westeurope'
param sqlServerName string = 'sql-server-${uniqueString(resourceGroup().id)}'
param dbName string = 'SmallDB'
param adminLogin string
@secure()
param adminPassword string
param clientIpAddress string //  usa tu IP por defecto

// ====================================================================
// MODULO 1: SERVIDOR SQL
// ====================================================================

module serverModule 'modules/sqlServer.bicep' = {
  name: 'deploy-sql-server'
  params: {
    location: location
    sqlServerName: sqlServerName
    adminLogin: adminLogin
    adminPassword: adminPassword
    clientIpAddress: clientIpAddress
  }
}

// ====================================================================
// MODULO 2: BASE DE DATOS SQL
// ====================================================================

module dbModule 'modules/sqlDb.bicep' = {
  name: 'deploy-sql-db'
  params: {
    location: location
    dbName: dbName
    // Usamos la salida del módulo del servidor para asegurar la dependencia
    sqlServerName: serverModule.outputs.sqlServerName
  }
}

// ====================================================================
// SALIDAS
// ====================================================================

output sqlServerNameOutput string = serverModule.outputs.sqlServerName
output dbIdOutput string = dbModule.outputs.dbId
