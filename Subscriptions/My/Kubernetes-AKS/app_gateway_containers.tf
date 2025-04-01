/*
Note: This is a generated HCL content from the JSON input which is based on the latest API version available.
To import the resource, please run the following command:
terraform import azapi_resource.trafficController /subscriptions/45604fe9-74ee-421a-86ad-86bb3840262b/resourcegroups/rg-application-aks-azcli-development/providers/Microsoft.ServiceNetworking/trafficControllers/app-gateway-test01?api-version=2025-01-01

Or add the below config:
import {
  id = "/subscriptions/45604fe9-74ee-421a-86ad-86bb3840262b/resourcegroups/rg-application-aks-azcli-development/providers/Microsoft.ServiceNetworking/trafficControllers/app-gateway-test01?api-version=2025-01-01"
  to = azapi_resource.trafficController
}
*/

resource "azapi_resource" "trafficController" {
  type      = "Microsoft.ServiceNetworking/trafficControllers@2025-01-01"
  parent_id = azurerm_resource_group.resource_group.id
  name      = local.app_gateway_container_name
  location  = azurerm_resource_group.resource_group.location

  body = {
    properties = {}
  }
}

resource "azapi_resource" "symbolicname" {
  type = "Microsoft.ServiceNetworking/trafficControllers/associations@2025-01-01"
  name = "ass2"
  parent_id = azapi_resource.trafficController.id
  location = azurerm_resource_group.resource_group.location
  
  body = {
    properties = {
      associationType = "subnets"
      subnet = {
        id = azurerm_subnet.container.id
      }
    }
  }
}

# resource "azapi_resource" "symbolicname" {
#   schema_validation_enabled = false
#   type = "Microsoft.ServiceNetworking/trafficControllers/associations@2023-11-01"
#   name = "association"
#   parent_id = azapi_resource.trafficController.id
#   location = azurerm_resource_group.resource_group.location
  
#   body = {
#     properties = {
#       associationType = "subnets"
#       subnet = {
#         id = azurerm_subnet.container.id
#       }
#     }
#   }
# }