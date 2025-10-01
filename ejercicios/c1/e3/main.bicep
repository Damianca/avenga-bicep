// Ejemplo de VNet y Subnet
resource vnet 'Microsoft.Network/virtualNetworks@2023-05-01' = {
  name: 'vnet-produccion'
  location: 'eastus'
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.0.0.0/16'
      ]
    }
    subnets: [
      {
        name: 'subnet-web'
        properties: {
          addressPrefix: '10.0.1.0/24'
        }
      }
    ]
  }
}
