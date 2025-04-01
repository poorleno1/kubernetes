# resource "azapi_resource" "userAssignedIdentity" {
#   type      = "Microsoft.ManagedIdentity/userAssignedIdentities@2024-11-30"
#   parent_id = azapi_resource.resourceGroup.id
#   name      = local.aks_control_plane_userid
#   location  = var.location
#   tags      = local.tags
#   body      = {}
# }


# data "azurerm_role_definition" "contributor" {
#   name = "Managed Identity Operator"
# }

# data "azurerm_subscription" "subscription" {
#   subscription_id = var.SUBSCRIPTION_ID
# }

# resource "azapi_resource" "role_assignment" {
#   type      = "Microsoft.Authorization/roleAssignments@2022-04-01"
#   parent_id = azapi_resource.resourceGroup.id
#   name =   



#   #name      = local.aks_control_plane_userid
#   body      = {
#     properties = {
#       #roleDefinitionId = "${data.azurerm_subscription.subscription.id}${data.azurerm_role_definition.contributor.id}"
#         #roleDefinitionId = data.azurerm_role_definition.contributor.id
#         #roleDefinitionId = "f1a07417-d97a-45cb-824c-7a7467783830"
#      roleDefinitionId = format("%s/providers/Microsoft.Authorization/roleDefinitions/%s",data.azurerm_subscription.subscription.id,data.azurerm_role_definition.contributor.id)
#      principalId      = azapi_resource.userAssignedIdentity.output.properties["principalId"]
#     }
#   }
# }