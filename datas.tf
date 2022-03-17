data "azurerm_subscription" "current" {}

data "azurerm_role_definition" "contributor" {
  name = "Network Contributor"
}

# This resource is created by the cluster, but not exposed by terraform directly
data "azurerm_user_assigned_identity" "agentpool_identity" {
  name                = "${azurerm_kubernetes_cluster.this.name}-agentpool"
  resource_group_name = azurerm_kubernetes_cluster.this.node_resource_group

  depends_on = [
    azurerm_kubernetes_cluster.this
  ]
}