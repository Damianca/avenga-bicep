// Establecemos la subs
targetScope = 'subscription'

// Le ponemos nombre al grupo de recursos
param resourceGroupName string = 'rg-bicep-demo-001'

// Ubicación US east
param resourceGroupLocation string = 'eastus'

param tags object = {}

// Define the Resource Group resource
resource resourceGroup 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  // Use the parameter for the name
  name: resourceGroupName 
  // The location is now provided by the parameter value passed from the CLI
  location: resourceGroupLocation 
  // Use the tags parameter
  tags: tags
}

// Optionally, output the name and location for confirmation
output name string = resourceGroup.name
output location string = resourceGroup.location
