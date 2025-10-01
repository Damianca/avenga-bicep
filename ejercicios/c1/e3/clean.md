# SINTAXIS
az network vnet delete --name <NOMBRE_VNET> --resource-group <NOMBRE_RG>

# EJEMPLO (asumiendo que tu VNet se llama 'vnet-produccion')
az network vnet delete --name "vnet-produccion" --resource-group "rg-bicep-demo-001"

# ADVERTENCIA: Esto borrará TODO lo que esté dentro de este grupo.
az group delete --name "NetworkWatcherRG" --yes
