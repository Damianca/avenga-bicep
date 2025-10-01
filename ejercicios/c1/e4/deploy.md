az deployment sub create \
  --location "eastus" \
  --template-file main.bicep \
  --parameters \
    adminPassword='$$AlgoAqui734' \
  --name "win-rdp-deployment"

