resource "azurerm_container_registry" "acr" {
  resource_group_name = azurerm_resource_group.resource_group.name
  location = azurerm_resource_group.resource_group.location
  name = local.acr_name
  sku = "Standard"
}