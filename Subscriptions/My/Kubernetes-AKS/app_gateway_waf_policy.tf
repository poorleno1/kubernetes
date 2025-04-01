resource "azurerm_web_application_firewall_policy" "waf_policy_sentry" {
  name                = local.app_gateway_policy_sentry
  resource_group_name = azurerm_resource_group.resource_group.location
  location            = var.location

  #   custom_rules {
  #     name      = "OnlyUSandCanada"
  #     priority  = 1
  #     rule_type = "MatchRule"

  #     match_conditions {
  #       match_variables {
  #         variable_name = "RemoteAddr"
  #       }
  #       operator           = "GeoMatch"
  #       negation_condition = true
  #       match_values       = ["CA", "US"]
  #     }
  #     action = "Block"
  #   }

  policy_settings {
    enabled = true
    mode    = "Prevention"
    # Global parameters
    request_body_check          = true
    max_request_body_size_in_kb = 512
    request_body_inspect_limit_in_kb = 512
    file_upload_limit_in_mb     = 100
  }

  managed_rules {
    exclusion {
      match_variable          = "RequestHeaderNames"
      selector                = "x-company-secret-header"
      selector_match_operator = "Equals"
    }
    exclusion {
      match_variable          = "RequestCookieNames"
      selector                = "too-tasty"
      selector_match_operator = "EndsWith"
    }

    managed_rule_set {
      type    = "OWASP"
      version = "3.2"

    #   rule_group_override {
    #     rule_group_name = "REQUEST-942-APPLICATION-ATTACK-SQLI"
    #     rule {
    #       id      = "942370"
    #       enabled = false
    #       action  = "Log"
    #     }
    #   }



   

    #   rule_group_override {
    #     rule_group_name = "REQUEST-933-APPLICATION-ATTACK-PHP"
    #     rule {
    #       id      = "933210"
    #       enabled = false
    #       action  = "Log"
    #     }

    #   }

      rule_group_override {
        rule_group_name = "REQUEST-920-PROTOCOL-ENFORCEMENT"
        
        rule {
          id      = "920420"
          enabled = false
          action  = "Log"
        }
      }

    #   rule_group_override {
    #     rule_group_name = "REQUEST-941-APPLICATION-ATTACK-XSS"
        
    #     rule {
    #       id      = "941320"
    #       enabled = false
    #       action  = "Log"
    #     }

    #   }

    #   rule_group_override {
    #     rule_group_name = "REQUEST-932-APPLICATION-ATTACK-RCE"
        
    #     rule {
    #       id = "932100"
    #       enabled = false
    #       action = "Log"
    #     }

    #   }

    #   rule_group_override {
    #     rule_group_name = "REQUEST-931-APPLICATION-ATTACK-RFI"
    #     rule {
    #       id = "931130"
    #       enabled = false
    #       action = "Log"
    #     }
    #   }

    }
  }
}


resource "azurerm_web_application_firewall_policy" "waf_policy_msr" {
  name                = local.app_gateway_policy_msr
  resource_group_name = azurerm_resource_group.resource_group.location
  location            = var.location

  #   custom_rules {
  #     name      = "OnlyUSandCanada"
  #     priority  = 1
  #     rule_type = "MatchRule"

  #     match_conditions {
  #       match_variables {
  #         variable_name = "RemoteAddr"
  #       }
  #       operator           = "GeoMatch"
  #       negation_condition = true
  #       match_values       = ["CA", "US"]
  #     }
  #     action = "Block"
  #   }

  policy_settings {
    enabled = true
    mode    = "Prevention"
    # Global parameters
    request_body_check          = true
    max_request_body_size_in_kb = 512
    request_body_inspect_limit_in_kb = 512
    file_upload_limit_in_mb     = 100
  }

  managed_rules {
    exclusion {
      match_variable          = "RequestHeaderNames"
      selector                = "x-company-secret-header"
      selector_match_operator = "Equals"
    }
    exclusion {
      match_variable          = "RequestCookieNames"
      selector                = "too-tasty"
      selector_match_operator = "EndsWith"
    }

    managed_rule_set {
      type    = "OWASP"
      version = "3.2"

      rule_group_override {
        rule_group_name = "REQUEST-942-APPLICATION-ATTACK-SQLI"
        rule {
          id      = "942430"
          enabled = false
          action  = "Log"
        }

        rule {
          id      = "942440"
          enabled = false
          action  = "Log"
        }
      }

    #     rule {
    #       id      = "942260"
    #       enabled = false
    #       action  = "Log"
    #     }
        
    #     rule {
    #       id      = "942200"
    #       enabled = false
    #       action  = "Log"
    #     }

    #     rule {
    #       id      = "942430"
    #       enabled = false
    #       action  = "Log"
    #     }

    #     rule {
    #       id      = "942400"
    #       enabled = false
    #       action  = "Log"
    #     }

    #     rule {
    #       id      = "942390"
    #       enabled = false
    #       action  = "Log"
    #     }

    #     rule {
    #       id      = "942130"
    #       enabled = false
    #       action  = "Log"
    #     }

    #     rule {
    #       id      = "942150"
    #       enabled = false
    #       action  = "Log"
    #     }

    #     rule {
    #       id      = "942410"
    #       enabled = false
    #       action  = "Log"
    #     }

    #     rule {
    #       id      = "942210"
    #       enabled = false
    #       action  = "Log"
    #     }

    #     rule {
    #       id      = "942380"
    #       enabled = false
    #       action  = "Log"
    #     }

    #     rule {
    #       id      = "942440"
    #       enabled = false
    #       action  = "Log"
    #     }

    #     rule {
    #       id      = "942300"
    #       enabled = false
    #       action  = "Log"
    #     }

    #     rule {
    #       id      = "942180"
    #       enabled = false
    #       action  = "Log"
    #     }

    #     rule {
    #       id      = "942110"
    #       enabled = false
    #       action  = "Log"
    #     }

    #     rule {
    #       id      = "942100"
    #       enabled = false
    #       action  = "Log"
    #     }

    #     rule {
    #       id      = "942330"
    #       enabled = false
    #       action  = "Log"
    #     }

        

    #   }

    #   rule_group_override {
    #     rule_group_name = "REQUEST-933-APPLICATION-ATTACK-PHP"
    #     rule {
    #       id      = "933210"
    #       enabled = false
    #       action  = "Log"
    #     }

    #     rule {
    #       id      = "933160"
    #       enabled = false
    #       action  = "Log"
    #     }
    #   }

      rule_group_override {
        rule_group_name = "REQUEST-920-PROTOCOL-ENFORCEMENT"
        
        rule {
          id      = "920230"
          enabled = false
          action  = "Log"
        }

        rule {
          id      = "920420"
          enabled = false
          action  = "Log"
        }
         rule {
          id      = "920450"
          enabled = false
          action  = "Log"
        }
      }

    #   rule_group_override {
    #     rule_group_name = "REQUEST-941-APPLICATION-ATTACK-XSS"
        
    #     rule {
    #       id      = "941320"
    #       enabled = false
    #       action  = "Log"
    #     }

    #     rule {
    #       id      = "941340"
    #       enabled = false
    #       action  = "Log"
    #     }

    #     rule {
    #       id      = "941160"
    #       enabled = false
    #       action  = "Log"
    #     }


    #   }

    #   rule_group_override {
    #     rule_group_name = "REQUEST-932-APPLICATION-ATTACK-RCE"
        
    #     rule {
    #       id = "932100"
    #       enabled = false
    #       action = "Log"
    #     }

    #     rule {
    #       id = "932110"
    #       enabled = false
    #       action = "Log"
    #     }
    #   }

    #   rule_group_override {
    #     rule_group_name = "REQUEST-931-APPLICATION-ATTACK-RFI"
    #     rule {
    #       id = "931130"
    #       enabled = false
    #       action = "Log"
    #     }
    #   }

    }
  }
}