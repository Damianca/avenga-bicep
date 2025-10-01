// Set the target scope to subscription explicitly (Good practice when creating RGs)
targetScope = 'subscription'

// Define the parameters for the Resource Group
param resourceGroupName string = 'rg-bicep-demo-001'

// Remove the default value. The location will be provided by the CLI parameter.
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
