output "client_certificate" {
  value = azurerm_kubernetes_cluster.this.kube_config.0.client_certificate
}

output "kube_config" {
  value = azurerm_kubernetes_cluster.this.kube_config_raw
  sensitive = true
}

output "registry_username" {
  value = azurerm_container_registry.acr.admin_username
}

output "registry_password" {
  value = azurerm_container_registry.acr.admin_password
}