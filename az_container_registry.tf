# see https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry
resource "azurerm_container_registry" "acr" {
  name                = "${var.project_name}Container"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  sku                 = "Premium"
  admin_enabled       = true
}

resource "azurerm_role_definition" "role_assignment_contributor" {
  name        = "Role Assignment Owner"
  scope       = azurerm_management_group.root.id
  description = "A role designed for writing and deleting role assignments"

  permissions {
    actions = [
      "Microsoft.Authorization/roleAssignments/write",
      "Microsoft.Authorization/roleAssignments/delete",
    ]
    not_actions = []
  }

  assignable_scopes = [
    azurerm_management_group.root.id
  ]
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

resource "azurerm_role_assignment" "roles" {
  # Giving access to AKS SP identity created to akssubnet by assigning it
  # a Network Contributor role
  # name                 = azurerm_kubernetes_cluster.this.name
  # scope                =  var.aks_subnet_name # azurerm_subnet.aks.id  var.aks_subnet
  scope = data.azurerm_subscription.current.id
  #role_definition_name = "Network Contributor"
  role_definition_id = "${data.azurerm_subscription.current.id}${data.azurerm_role_definition.contributor.id}"
  # principal_id         = azurerm_kubernetes_cluster.this.identity[0].principal_id
  # principal_id = azu rerm_kubernetes_cluster.aks_main.kubelet_identity[0].object_id
  principal_id                     = data.azurerm_user_assigned_identity.agentpool_identity.principal_id
  skip_service_principal_aad_check = true

  depends_on = [
    null_resource.wait_for_resource_to_be_ready
  ]
}