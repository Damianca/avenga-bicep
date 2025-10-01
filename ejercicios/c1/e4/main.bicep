// targetScope es 'subscription' para crear el Resource Group
targetScope = 'subscription'

param resourceGroupName string = 'rg-windows-rdp-demo'
param location string = 'eastus' // Ubicación fija según tu solicitud
param vmName string = 'RDP-WinServer'
param vmSize string = 'Standard_B2s' 
param adminUsername string = 'azadminuser' // Usuario de Azure (no 'admin', 'administrator', etc.)
@secure()
param adminPassword string // Contraseña segura (mínimo 12 caracteres, 3 tipos de caracteres)

// 1. RECURSO: Crear el Resource Group
resource newRg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: resourceGroupName
  location: location
}

// 2. MODULO: Desplegar la VNet y la VM DENTRO del Resource Group recién creado
module vmInfra 'vmInfra.bicep' = {
  name: 'vm-infra-deployment'
  // Cambia el alcance del despliegue al nuevo RG
  scope: newRg 
  params: {
    location: location
    vmName: vmName
    vmSize: vmSize
    adminUsername: adminUsername
    adminPassword: adminPassword
  }
}

// --- SALIDA ---
output RDPConnectIP string = vmInfra.outputs.vmPublicIP
