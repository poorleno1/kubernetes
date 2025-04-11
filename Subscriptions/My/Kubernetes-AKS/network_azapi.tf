/*
Note: This is a generated HCL content from the JSON input which is based on the latest API version available.
To import the resource, please run the following command:
terraform import azapi_resource.virtualNetwork /subscriptions/45604fe9-74ee-421a-86ad-86bb3840262b/resourceGroups/aks-rg/providers/Microsoft.Network/virtualNetworks/aks-vnet?api-version=2024-05-01

Or add the below config:
import {
  id = "/subscriptions/45604fe9-74ee-421a-86ad-86bb3840262b/resourceGroups/aks-rg/providers/Microsoft.Network/virtualNetworks/aks-vnet?api-version=2024-05-01"
  to = azapi_resource.virtualNetwork
}
*/

# resource "azapi_resource" "virtualNetwork" {
#   type      = "Microsoft.Network/virtualNetworks@2024-05-01"
#   parent_id = azapi_resource.resourceGroup.id
#   name      = local.network_name
#   location  = var.location
#     tags      = local.tags
#   body = {
#     properties = {
#       addressSpace = {
#         addressPrefixes = ["10.0.0.0/8"]
#       }
#       enableDdosProtection = false
#       subnets = [{
#         id   = "/subscriptions/45604fe9-74ee-421a-86ad-86bb3840262b/resourceGroups/${local.resource_group_name}/providers/Microsoft.Network/virtualNetworks/${local.network_name}/subnets/${local.subnet_name}"
#         name = local.subnet_name
#         properties = {
#           addressPrefix                     =  local.vnet_subnet_prefix
#           delegations                       = []
#           privateEndpointNetworkPolicies    = "Disabled"
#           privateLinkServiceNetworkPolicies = "Enabled"
#         }
#         type = "Microsoft.Network/virtualNetworks/subnets"
#       }]
#       virtualNetworkPeerings = []
#     }
#   }
#}
