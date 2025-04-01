resource "random_string" "random_suffix" {
  length  = 3
  special = false
  upper   = false
}


locals {
  ClientName = "aks-azcli"
  tags = merge(var.tags, tomap({ "ClientName" = local.ClientName, "Environment" = var.Environment }))
  resource_group_name   = lower("rg-application-${local.ClientName==""?"":local.ClientName}-${lower(var.Environment)}")
  network_name        = lower("vnet-${local.ClientName==""?"":local.ClientName}-${lower(var.Environment)}")
  address_space = ["10.0.0.0/8"]
  subnet_name         = "aks-subnet"
  vnet_subnet_prefix = "10.240.0.0/16"
  aks_cluster_name= "aks-cluster-01"
  aks_control_plane_userid ="${local.aks_cluster_name}-usermsi"
  aks_service_cidr = "10.2.0.0/24"
  aks_dns_service_ip = "10.2.0.10"
  ssh_public_key = file("${path.module}/.ssh/id_rsa.pub")
}

