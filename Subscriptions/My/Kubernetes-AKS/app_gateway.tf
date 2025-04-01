
resource "azurerm_user_assigned_identity" "app_gateway" {
  resource_group_name = azurerm_resource_group.resource_group.name
  location            = azurerm_resource_group.resource_group.location
  name                = local.app_gateway_identity
}



# resource "azurerm_role_assignment" "app_gateway" {
#   scope                = data.azurerm_key_vault.kv.id
#   role_definition_name = "Key Vault Certificate User"
#   principal_id         = azurerm_user_assigned_identity.app_gateway.principal_id
# }




resource "azurerm_application_gateway" "app_gateway" {
  name                = local.app_gateway_name
  resource_group_name = azurerm_resource_group.resource_group.name
  location            = azurerm_resource_group.resource_group.location

  firewall_policy_id = azurerm_web_application_firewall_policy.waf_policy_msr.id

  ssl_policy {
    policy_type = "Predefined"
    policy_name = "AppGwSslPolicy20220101"
  }

  sku {
    name     = "WAF_v2"
    tier     = "WAF_v2"
    capacity = 1
  }

  # ssl_certificate {
  #   name                = local.cert_name_example
  #   key_vault_secret_id = data.azurerm_key_vault_certificate.example_cert.secret_id

  # }

  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.app_gateway.id]
  }

  gateway_ip_configuration {
    name      = "my-gateway-ip-configuration"
    subnet_id = azurerm_subnet.app_gateway.id
  }

  frontend_port {
    name = local.frontend_port_http
    port = 80
  }

  # frontend_port {
  #   name = local.frontend_port_https
  #   port = 443
  # }

  frontend_ip_configuration {
    name                 = local.frontend_ip_configuration_name
    public_ip_address_id = azurerm_public_ip.app_gateway.id
  }


  rewrite_rule_set {
    name = local.rewrite_rule_set_name

    rewrite_rule {
      name          = local.rewrite_rule_name_remove_headers
      rule_sequence = 1

      response_header_configuration {
        header_name  = "Server"
        header_value = ""
      }
    }

    rewrite_rule {
      name          = local.rewrite_rule_name_remove_headers_xforwarded
      rule_sequence = 10

      response_header_configuration {
        header_name  = "X-Powered-By"
        header_value = ""
      }
    }

    rewrite_rule {
      name = local.rewrite_rule_name_hsts
      rule_sequence = 20

      response_header_configuration {
        header_name = "Strict-Transport-Security"
        header_value = "max-age=86400; includeSubDomains"
      }
    }

    rewrite_rule {
      name = local.rewrite_rule_name_add_header_xContent
      rule_sequence = 30

      response_header_configuration {
        header_name = "X-Content-Type-Options"
        header_value = "nosniff"
      }
    }


    rewrite_rule {
      name = local.rewrite_rule_name_cache
      rule_sequence = 40

      condition {
        ignore_case = true
        negate      = false
        pattern = "/.*(css|ttf|woff2)$"
        variable = "var_uri_path"
      }   

      response_header_configuration {
        header_name = "Cache-Control"
        header_value = "public, max-age=15552000"
      }
    }

    
  }

  backend_http_settings {
    name                  = local.http_setting_name
    cookie_based_affinity = "Disabled"
    path                  = "/"
    port                  = 443
    protocol              = "Https"
    request_timeout       = 3600
    pick_host_name_from_backend_address = true
  }



  http_listener {
    name                           = local.listener_name_http_example
    frontend_ip_configuration_name = local.frontend_ip_configuration_name
    frontend_port_name             = local.frontend_port_http
    protocol                       = "Http"
    host_name                      = "${local.web_app_name_gw_example}.${local.domain_public}"
  }

  # http_listener {
  #   name                           = local.listener_name_https_example
  #   frontend_ip_configuration_name = local.frontend_ip_configuration_name
  #   frontend_port_name             = local.frontend_port_https
  #   protocol                       = "Https"
  #   ssl_certificate_name           = local.cert_name_example
  #   host_name                      = "${local.web_app_name_gw_example}.${local.domain_public}"
  # }

  backend_address_pool {
    name = local.backend_address_pool_example
    ip_addresses = [ "1.1.1.1" ]
    #fqdns = ["${local.web_app_name_backend}.${local.domain_suffix}"]
  }
    

  # redirect_configuration {
  #   name                 = local.redirect_configuration_example
  #   redirect_type        = "Permanent"
  #   target_listener_name = local.listener_name_https_example
  # }

  request_routing_rule {
    name                       = local.request_routing_rule_example
    priority                   = 9
    rule_type                  = "Basic"
    http_listener_name         = local.listener_name_http_example
    backend_address_pool_name  = local.backend_address_pool_example
    backend_http_settings_name = local.http_setting_name
    #rewrite_rule_set_name = local.rewrite_rule_set_name
  }




}



