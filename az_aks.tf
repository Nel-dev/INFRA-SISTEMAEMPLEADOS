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

  tags = {
    Environment = "Production"
  }
}

# This resource is created by the cluster, but not exposed by terraform directly
data "azurerm_user_assigned_identity" "agentpool_identity" {
  name                = "${azurerm_kubernetes_cluster.this.name}-agentpool"
  resource_group_name = azurerm_kubernetes_cluster.this.node_resource_group
  depends_on = [
    azurerm_kubernetes_cluster.this
  ]
}