
resource "azurerm_public_ip" "app_gateway" {
  name                = local.app_gateway_pip
  resource_group_name = azurerm_resource_group.resource_group.location
  location            = var.location
  domain_name_label   = local.app_gateway_pip_label
  allocation_method   = "Static"
  sku                 = "Standard"
}
