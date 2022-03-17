resource "azurerm_kubernetes_cluster" "this" {
  name                = var.project_name
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

  role_based_access_control {
    enabled = true
  }

  tags = {
    Environment = "Production"
  }
}

resource "null_resource" "wait_for_resource_to_be_ready" {
  provisioner "local-exec" {
    command = "sleep 60"
  }
  depends_on = [
    azurerm_kubernetes_cluster.this
  ]
}