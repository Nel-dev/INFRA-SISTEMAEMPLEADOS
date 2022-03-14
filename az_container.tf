resource "azurerm_container_registry" "acr" {
  name                = "${var.project_name}Container"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  sku                 = "Premium"
  admin_enabled       = false

  georeplications {
    location                = azurerm_resource_group.this.location
    zone_redundancy_enabled = true
    tags                    = {}
  }
}