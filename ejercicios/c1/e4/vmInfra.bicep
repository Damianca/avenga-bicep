// targetScope es implícitamente 'resourceGroup'

param location string
param vmName string
param vmSize string
param adminUsername string
@secure()
param adminPassword string

// --- RECURSOS DE RED ---

// 1. Red Virtual (VNet) y Subred
resource vnet 'Microsoft.Network/virtualNetworks@2023-05-01' = {
  name: 'vnet-${vmName}'
  location: location
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

// 2. Grupo de Seguridad de Red (NSG) - Abre el Puerto RDP (3389)
resource nsg 'Microsoft.Network/networkSecurityGroups@2023-05-01' = {
  name: '${vmName}-nsg'
  location: location
  properties: {
    securityRules: [
      {
        name: 'AllowRDP'
        properties: {
          priority: 1000
          direction: 'Inbound'
          access: 'Allow'
          protocol: 'Tcp'
          // Permite RDP desde cualquier IP. En producción, usar una IP estricta.
          sourceAddressPrefix: '*'       
          sourcePortRange: '*'
          destinationAddressPrefix: '*'
          destinationPortRange: '3389'   
        }
      }
    ]
  }
}

// 3. Dirección IP Pública
resource publicIP 'Microsoft.Network/publicIPAddresses@2023-05-01' = {
  name: '${vmName}-ip'
  location: location
  sku: {
    name: 'Standard'
  }
  properties: {
    publicIPAllocationMethod: 'Static'
  }
}

// 4. Interfaz de Red (NIC)
resource nic 'Microsoft.Network/networkInterfaces@2023-05-01' = {
  name: '${vmName}-nic'
  location: location
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          privateIPAllocationMethod: 'Dynamic'
          subnet: {
            id: vnet.properties.subnets[0].id // Referencia a la subred
          }
          publicIPAddress: {
            id: publicIP.id
          }
        }
      }
    ]
    networkSecurityGroup: {
      id: nsg.id // Asocia el NSG
    }
  }
}

// --- RECURSO DE CÓMPUTO ---

// 5. Máquina Virtual (VM) - Windows Server 2022
resource vm 'Microsoft.Compute/virtualMachines@2023-07-01' = {
  name: vmName
  location: location
  properties: {
    hardwareProfile: {
      vmSize: vmSize
    }
    osProfile: {
      computerName: vmName
      adminUsername: adminUsername
      adminPassword: adminPassword // Contraseña segura
    }
    storageProfile: {
      imageReference: { // Imagen de Windows Server 2022 Datacenter
        publisher: 'MicrosoftWindowsServer'
        offer: 'WindowsServer'
        sku: '2022-Datacenter'
        version: 'latest'
      }
      osDisk: {
        createOption: 'FromImage'
        managedDisk: {
          storageAccountType: 'Standard_LRS'
        }
      }
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: nic.id
        }
      ]
    }
  }
}

// --- SALIDAS ---
output vmPublicIP string = publicIP.properties.ipAddress
