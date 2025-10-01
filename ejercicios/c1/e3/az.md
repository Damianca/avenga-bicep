az deployment group create \
    --resource-group "rg-bicep-demo-001" \
    --template-file main.bicep \
    --name "vnet-deployment" \
    --mode 'Incremental'
