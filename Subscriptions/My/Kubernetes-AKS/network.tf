resource "azurerm_virtual_network" "vnet" {
  name                = local.network_name
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name
  address_space       = local.address_space



}

resource "azurerm_subnet" "subnet1" {
  name                 = "${azurerm_virtual_network.vnet.name}-subnet1"
  resource_group_name  = azurerm_virtual_network.vnet.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  #address_prefixes     = [cidrsubnet(var.cidr_cps[0], 2, 0)]
  #address_prefixes     = [cidrsubnet("10.4.0.0/16", 2, 0)]
  address_prefixes     = [local.vnet_subnet_prefix]
  
  depends_on = [ azurerm_virtual_network.vnet ]

  service_endpoints                              = tolist(["Microsoft.KeyVault", "Microsoft.Sql", "Microsoft.Storage", "Microsoft.Web", "Microsoft.EventHub", "Microsoft.AzureCosmosDB", "Microsoft.ServiceBus"])

}


resource "azurerm_subnet" "container" {
  name                 = "${azurerm_virtual_network.vnet.name}-containers"
  resource_group_name  =  azurerm_virtual_network.vnet.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [cidrsubnet(local.address_space[0], 7, 1)]
  
  service_endpoints = [ 
    "Microsoft.Storage"
   ]
  
  depends_on = [ azurerm_virtual_network.vnet ]
}






resource "azurerm_subnet" "app_gateway" {
  #Domain controllers and other infrastructure goes here
  name                                           = "agw"
  resource_group_name                            = azurerm_virtual_network.vnet.resource_group_name
  virtual_network_name                           = azurerm_virtual_network.vnet.name
  address_prefixes                               = [cidrsubnet(local.address_space[0], 8, 5)]
  service_endpoints                              = tolist(["Microsoft.KeyVault", "Microsoft.Sql", "Microsoft.Storage", "Microsoft.Web", "Microsoft.EventHub", "Microsoft.AzureCosmosDB", "Microsoft.ServiceBus"])
}