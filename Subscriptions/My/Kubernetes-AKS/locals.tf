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


  acr_name = "acr${replace(local.ClientName,"-","")}"

  app_gateway_name               = "${local.ClientName}-app-gateway"
  app_gateway_pip                           = "${local.ClientName}-app-gateway-pip"
  app_gateway_pip_label                     = local.ClientName
  app_gateway_policy_sentry                        = "${local.ClientName}-app-gateway-policy-sentry"
  app_gateway_policy_msr                        = "${local.ClientName}-app-gateway-policy-msr"
  app_gateway_identity           = "${local.ClientName}-app-gateway-identity"

  rewrite_rule_set_name          = "${local.ClientName}-rewrite-rule-set"
  rewrite_rule_name_remove_headers = "${local.ClientName}-rewrite-rule-remove-headers"
  rewrite_rule_name_remove_headers_xforwarded = "${local.ClientName}-rewrite-rule-remove-headers-xforwarded"
  rewrite_rule_name_hsts          = "${local.ClientName}-rewrite-rule-hsts"
  rewrite_rule_name_add_header_xContent = "${local.ClientName}-rewrite-rule-add-headers-xContent"
  rewrite_rule_name_cache         = "${local.ClientName}-rewrite-rule-cache"
  
  domain_public  = "geloot.com"

  frontend_port_http             = "${local.ClientName}-app-gateway-frontend-port-http"
  frontend_port_https            = "${local.ClientName}-app-gateway-frontend-port-https"
  frontend_ip_configuration_name = "${local.ClientName}-app-gateway-frontend-ip-conf"
  http_setting_name              = "${local.ClientName}-app-gateway-http-settings"

  listener_name_http_example  = "${local.ClientName}-app-gateway-listener-http-example"
  listener_name_https_example = "${local.ClientName}-app-gateway-listener-https-example"
  redirect_configuration_example   = "${local.ClientName}-app-gateway-redirect-example"
  request_routing_rule_example      = "${local.ClientName}-app-gateway-rule-example"
  backend_address_pool_example      = "${local.ClientName}-app-gateway-backend-addr-pool-example"

  web_app_name_gw_example = "example"
  backend_address_pool_backend      = "${local.ClientName}-app-gateway-backend-addr-pool-backend"
  listener_name_http_backend        = "${local.ClientName}-app-gateway-listener-http-backend"
  listener_name_https_backend       = "${local.ClientName}-app-gateway-listener-https-backend"
  
  

  cert_name_example = "ExampleCert"
}

