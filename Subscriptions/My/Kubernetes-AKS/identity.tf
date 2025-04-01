
resource "azurerm_user_assigned_identity" "ca" {
  resource_group_name = azurerm_resource_group.resource_group.name
  location            = azurerm_resource_group.resource_group.location
  name                = local.aks_control_plane_userid
  tags                = local.tags
}


resource "azurerm_role_assignment" "resource_group_msi" {
  scope                = azurerm_resource_group.resource_group.id
  role_definition_name = "Managed Identity Operator"
  principal_id         = azurerm_user_assigned_identity.ca.principal_id
  depends_on = [
    azurerm_user_assigned_identity.ca
  ]
}
