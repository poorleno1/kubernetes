data "azurerm_subscription" "current" {}
output "current_subscription_display_name" {
  value = data.azurerm_subscription.current.display_name
}
data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "resource_group" {
  name     = local.resource_group_name
  location = var.location
  tags     = local.tags
}

variable "SUBSCRIPTION_ID" {}

provider "azurerm" {
  subscription_id = var.SUBSCRIPTION_ID
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}


terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.88.0"
    }

    azapi = {
      source = "Azure/azapi"
    }
  }

   backend "azurerm" {
    environment          = "public"
    storage_account_name = "tfstatejarek2"
    # Choose a container that is relevant for deployment: test, dev, staging, prod
    container_name = "tfstate"
    # Unique files name in container
    key                 = "azure-aks.tfstate"
    resource_group_name = "terraform"
  }
}


/*
Note: This is a generated HCL content from the JSON input which is based on the latest API version available.
To import the resource, please run the following command:
terraform import azapi_resource.resourceGroup /subscriptions/45604fe9-74ee-421a-86ad-86bb3840262b/resourceGroups/aks-rg?api-version=2024-11-01

Or add the below config:
import {
  id = "/subscriptions/45604fe9-74ee-421a-86ad-86bb3840262b/resourceGroups/aks-rg?api-version=2024-11-01"
  to = azapi_resource.resourceGroup
}
*/

# resource "azapi_resource" "resourceGroup" {
#   type      = "Microsoft.Resources/resourceGroups@2024-07-01"
#   parent_id = "/subscriptions/45604fe9-74ee-421a-86ad-86bb3840262b"
#   name      = local.resource_group_name
#   location  = var.location
#   tags      = local.tags
#   body = {
#     properties = {}
#   }
# }
