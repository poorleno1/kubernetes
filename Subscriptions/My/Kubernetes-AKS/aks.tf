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