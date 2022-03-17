resource "azurerm_kubernetes_cluster" "this" {
  name                = "${var.project_name}"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  dns_prefix          = lower(var.project_name)

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "standard_d2as_v5"
  }

  identity {
    type = "SystemAssigned"
  }

  addon_profile {
    http_application_routing {
      enabled = true
    }
  }

  tags = {
    Environment = "Production"
  }
}

resource "azurerm_role_assignment" "example" {
  principal_id                     = azurerm_kubernetes_cluster.this.kubelet_identity[0].object_id
  role_definition_name             = "AcrPull"
  scope                            = azurerm_container_registry.acr.id
  skip_service_principal_aad_check = true
}

