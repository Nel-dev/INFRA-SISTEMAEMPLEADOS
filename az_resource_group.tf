resource "azurerm_resource_group" "this" {
  name     = "${var.project_name}ResourceGroup"
  location = var.location
}