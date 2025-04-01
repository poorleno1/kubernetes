resource "azurerm_kubernetes_cluster" "aks" {
  name                = local.aks_cluster_name
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name
  dns_prefix          = "aks-dns"
  kubernetes_version  = "1.31"

  default_node_pool {
    name           = "system"
    node_count     = 3
    vm_size        = "Standard_DS2_v2"
    vnet_subnet_id = azurerm_subnet.subnet1.id
    type           = "VirtualMachineScaleSets"
    upgrade_settings {
      drain_timeout_in_minutes = 0
      max_surge = "10%"
      node_soak_duration_in_minutes = 0
    }
  }

  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.ca.id]
  }

  kubelet_identity {
    client_id = azurerm_user_assigned_identity.ca.client_id
    object_id = azurerm_user_assigned_identity.ca.principal_id
    user_assigned_identity_id = azurerm_user_assigned_identity.ca.id
  }

  network_profile {
    network_plugin     = "azure"
    service_cidr       = local.aks_service_cidr
    dns_service_ip     = local.aks_dns_service_ip
    #docker_bridge_cidr = "172.17.0.1/16"
    #max_pods_per_node  = 100
  }

  linux_profile {
    admin_username = "aksadmin"
    ssh_key {
      key_data = local.ssh_public_key
    }
  }

  
  depends_on = [ azurerm_subnet.subnet1 ]
}


resource "azurerm_role_assignment" "acr_pull" {
  principal_id                     = azurerm_user_assigned_identity.ca.client_id
  role_definition_name             = "AcrPull"
  scope                            = azurerm_container_registry.acr.id
  skip_service_principal_aad_check = true
}