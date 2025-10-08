param location string
param sqlServerName string
param adminLogin string
@secure()
param adminPassword string
param clientIpAddress string 


resource sqlServer 'Microsoft.Sql/servers@2023-08-01' = {
  name: sqlServerName
  location: location
  properties: {
    administratorLogin: adminLogin
    administratorLoginPassword: adminPassword
    version: '12.0' // Versión estándar de Azure SQL Database
  }
}

resource firewallRule 'Microsoft.Sql/servers/firewallRules@2021-11-01' = {
  // Asegúrate de usar el nombre del servidor SQL como recurso padre.
  parent: sqlServer
  name: 'AllowClientIP'
  properties: {
    startIpAddress: clientIpAddress
    endIpAddress: clientIpAddress
  }
}

// Salida: El nombre del servidor es crucial para el módulo de la DB
output sqlServerName string = sqlServer.name
