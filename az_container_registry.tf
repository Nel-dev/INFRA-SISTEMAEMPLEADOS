# see https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry
resource "azurerm_container_registry" "acr" {
  name                = "${var.project_name}Container"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  sku                 = "Premium"
  admin_enabled       = true
}

resource "azurerm_role_assignment" "roles" {
  scope                = azurerm_container_registry.acr.id
  role_definition_name = "AcrPull"
  principal_id         = data.azurerm_user_assigned_identity.agentpool_identity.principal_id
}

resource "azurerm_container_registry_scope_map" "this" {
  name                    = "${var.project_name}ScopeMap"
  container_registry_name = azurerm_container_registry.acr.name
  resource_group_name     = azurerm_resource_group.this.name
  actions = [
    "repositories/repo1/content/read",
    "repositories/repo1/content/write"
  ]
}